require 'prawn'
require 'prawn/table'

Prawn::Document::generate("generatedPracticeStoreReport.pdf") do 

	stroke_axis

	# create outer bounding box
	bounding_box([0,cursor], :width => 550) do

		@qFont = 10

		# elements of checkbox questions including answer and box
		subTable = [ 
					#["Box1", "Possible checkbox answer 1."],
					# specifying the width here make all columns this width -- why?
					[{:content => "1", :width => 25}, {:content => "answer", :overflow => :shrink_to_fit}],
					#["Box2", "Possible checkbox answer 2."],
					["1", "answer"],
					# throwing an error even though we are wrapping text -- why?
					#["1", {:content => "Possible checkbox answer 3. This answer is really loooooooooooooooooooooooooooooong.", :overflow => :shrink_to_fit}],
					["1", "answer"],
					#["Box4", "Possible checkbox answer 4."]
					]

		# elements of the table in the format [[r1c1,r1c2],[r2c1,r2c2],...]
		data = 	[
				# Header
				[{:content => "Header 1", :colspan => 4, :size => 30}, "Score1"],
				# Description
				[{:content => "Question description goes here.", :colspan => 5}],
				# Questions and answers
				[{:content => "Q1", :size => @qFont}, "Basic Question", "", {:content => "First Answer", :colspan => 2}],
				[{:content => "Q2", :size => @qFont}, "Checkbox", {:content => subTable, :colspan => 3}],
				#["Q3", "Basic Question", "", {:content => "Second Answer", :colspan => 2}],
				#["Q4", "Basic Question", "", {:content => "Third Answer", :colspan => 2}]
				]

		# create table with alternating row colors
		table(
				data, 
				:row_colors => ['f3f9fd','FFFFFF'], 
				:width => 550,
				# Desired Column Widths:
				# Col 1: 20
				# Col 2: 150
				# Col 3: 20
				# Col 4: 320
				# Col 5: 40
				:column_widths => {0 => 25, 2 => 25}
				#:column_widths => [15, 150, 15, 320, 30]
			) do

			# remove table borders
			#cells.borders = []

			# align right column to the right
			row(0).column(1).align = :right
			# set the first row colors
			row(0).background_color = '30abdf'




		end

		transparent(0.5) { stroke_bounds }

	end

end

# To Do:
#
# [] figure out how to get the check boxes in a "checked" and "unchecked" state
# [done] make heading bigger with bigger text
# [done] make column for Q1, Q2, etc. smaller and adjust other column sizes accordinly
# [done] multiple answers for one question in the same row?
# [done] description should span 4 columns but it looks like it is only spanning 3
# [] text wrapping!
# 
