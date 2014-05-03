class Minesweeper
  attr_accessor :hidden_mines,:n,:squares,:visible_mines,:detected
  def bombs
  	@visible_mines=Array.new(@n){Array.new(@n){"*"}}
  	@squares=Array.new(@n){Array.new(@n){0}}
  	@hidden_mines=Array.new
      puts @n*@n/6
      boxes=@n*@n/6
      @mines=Random.new
      (1..boxes).each do |i|
      	bomb_logic
      end
  end
  def bomb_logic
  	bomb=@mines.rand(@n*@n)
  	if @hidden_mines.include?(bomb) || bomb==0
  		bomb_logic
    else
      @hidden_mines.push(bomb)
      if bomb % @n ==0
      	neighbours((bomb/@n)-1,@n-1)
      else
        neighbours((bomb/@n),(bomb% @n)-1)
      end
    end
  end
  def play
  	puts "Enter dimention:"
  	print "n="
  	@n=gets.to_i
  	if @n<=2
  		puts "n value should be greater than 2"
  		play
  	end
  	bombs
  	@detected=0
  	while @detected < @n*@n/6 do
  		puts "Predict"
  		predict=gets.to_i
        begin
          puts "Boxes looked like :"
          if predict % @n ==0
          	@visible_mines[(predict/@n)-1][@n-1]=@squares[(predict/@n)-1][@n-1].to_s
          else
          	@visible_mines[predict/@n][(predict% @n)-1]=@squares[predict/@n][(predict% @n)-1].to_s
          end
  		  
          @visible_mines.each do |square|
          	square.each do |box|
          	   print box
          	   print "\t"
              end
              puts ""
          end
  		  if @squares[predict/@n][(predict% @n)-1] >=1000
  		  	puts "You Lost Game Over"
  		  	@detected =@n*@n
  		  	break
  		  end
  		rescue
  			puts "Not a valid Entry"
  		end
  	end
  end
  def neighbours(d1,d2)
  	@squares[d1][d2]=1000
  	if d2-1>=0
  		@squares[d1][d2-1] += 1 
  	end
  	if d2+1<@n
  		@squares[d1][d2+1] += 1
  	end
  	if d1-1>=0
  		if d2-1>=0
  	       @squares[d1-1][d2-1] += 1
  	    end
  	    @squares[d1-1][d2] += 1
  	    if d2+1<@n
  	       @squares[d1-1][d2+1] += 1
  	    end
    end
  	if d1+1<@n
  		if d2-1>=0
  		   @squares[d1+1][d2-1] += 1
  		end
  		@squares[d1+1][d2] += 1
  		if d2+1<@n
  		   @squares[d1+1][d2+1] += 1
  		end
    end
  end
  def show
  	puts "Mines were at :"
  	@hidden_mines.each do |bom|
    	puts bom
    end
    puts "Boxes looked like :"
    @squares.each do |square|
    	square.each do |box|
    	   print box
    	   print "\t"
        end
        puts ""
    end
  end
end  
m=Minesweeper.new
m.play
m.show