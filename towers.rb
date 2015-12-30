

class TowerOfHanoi
    def initialize( n )
        @n = n
        @peg1 = []
        @peg2 = []
        @peg3 = []
        @winner_peg = []

        for i in @n.downto 1 do
            @peg1 << i
            @winner_peg << i
        end

        @peg_hash = { 1 =>@peg1, 2=>@peg2, 3=>@peg3 }
    end

    def move( from, to )
        from_peg = @peg_hash[from]
        to_peg = @peg_hash[to]
        b__move = false
        b_illegal_move = true if from_peg == []
        b_illegal_move = true if to_peg[-1] != nil and from_peg[-1] > to_peg[-1]
        to_peg << from_peg.pop if !b_illegal_move
        #show_state
        render
        b_illegal_move
    end

    def check_winner
        if @peg3 == @winner_peg && @peg1 == [] && @peg2 == []
            true
        else
            false
        end
    end

    def show_state
        print "peg1: "
        @peg1.each { |elt|  print elt }
        puts

        print "peg2: "
        @peg2.each { |elt| print elt}
        puts

        print "peg3: "
        @peg3.each { |elt| print elt}
        puts
    end

    def render
        peg_buffer_width = @n/2 + 1
        buffer_string = " "* peg_buffer_width
        column_width = 2*peg_buffer_width + 1
        tallest_peg_size = [ @peg1.length, @peg2.length, @peg3.length ].max
        base_string = buffer_string + "1" + buffer_string +  buffer_string + "2" + buffer_string +  buffer_string + "3"

        row_strings = []
        i = 0

        while i < tallest_peg_size do
            if @peg1[i] != nil
                column_1_string = " " * ((column_width - @peg1[i]) / 2) +"o" * @peg1[i] + " " * ( column_width - @peg1[i] - (column_width - @peg1[i]) / 2 )
            else
                column_1_string = " " * column_width
            end

            if @peg2[i] != nil
                column_2_string =  " " * ((column_width - @peg2[i]) / 2) + "o" * @peg2[i] + " " * ( column_width - @peg2[i] - (column_width - @peg2[i]) / 2 )
            else
                column_2_string = " " * column_width
            end

            if @peg3[i] != nil
                column_3_string = " " * ((column_width - @peg3[i]) / 2) +"o" * @peg3[i]  + " " * ( column_width - @peg3[i] - (column_width - @peg3[i]) / 2 )
            else
                column_3_string = " " * column_width
            end

            row_strings << ( column_1_string + column_2_string + column_3_string )
            i += 1
        end

        for i in (row_strings.length-1).downto 0 
            puts row_strings[i]
        end
        puts base_string
    end

end

def play
    puts "How many disks?"
    print "> "
    n = gets.chomp.to_i
    t = TowerOfHanoi.new( n )
    t.render

    while true do
        b_illegal_move = false
        puts "Enter move ( [from, to] ), or 'q' to quit"
        print "> "
        arr_str = gets.chomp
        break if arr_str == "q"
        arr = arr_str[1..-2].split(',').collect! {|n| n.to_i}
        if arr[0] < 1 || arr[0] > 3 || arr[1] < 1 || arr[1] > 3
            puts "bad input, try again"
            next
        end
        b_illegal_move = t.move( arr[0], arr[1] )
        if t.check_winner
            puts "congratulations, you win!"
            break
        end
        puts "illegal move, try again" if b_illegal_move
    end
end

play

