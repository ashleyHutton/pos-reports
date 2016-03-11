require 'prawn'
require 'prawn/table'

Prawn::Document::generate("Generated\ PDFs/practiceStoreReport.pdf") do 

	stroke_axis

	# create outer bounding box
	bounding_box([0,cursor], :width => 550) do

		# elements of checkbox questions including answer and box
		subTable = [ 
					#["Box1", "Possible checkbox answer 1."],
					["1", "answer"],
					#["Box2", "Possible checkbox answer 2."],
					["1", "answer"],
					#["Box3", "Possible checkbox answer 3. This answer is really loooooooooooooooooooooooooooooong. What will this look like?"],
					["1", "answer"],
					#["Box4", "Possible checkbox answer 4."]
					]

		# elements of the table in the format [[r1c1,r1c2],[r2c1,r2c2],...]
		data = 	[
				# Header
				[{:content => "Header 1", :colspan => 4, :rowspan => 2}, {:content => "Score1", :rowspan => 2}],
				# Description
				[{:content => "Question description goes here.", :colspan => 5}],
				# Questions and answers
				["Q1", "Basic Question", "", {:content => "First Answer", :colspan => 2}],
				["Q2", "Checkbox", {:content => subTable, :colspan => 2}],
				["Q3", "Basic Question", "", {:content => "Second Answer", :colspan => 2}],
				["Q4", "Basic Question", "", {:content => "Third Answer", :colspan => 2}]
				]

		# create table with alternating row colors
		table(
				data, 
				:row_colors => ['f3f9fd','FFFFFF'], 
				:width => 550,
				#:column_widths => [15, 150, 15, 320, 30]
			) do

			# remove table borders
			#cells.borders = []

			# align right column to the right
			row(0).column(1).align = :right
			# set the first row colors
			row(0).background_color = '30abdf'

			# set column widths
			# first column: 20

			# second column: 150

			# third column: 20

			# fourth column: 320

			# fifth column: 40


		end

		transparent(0.5) { stroke_bounds }

	end

end

# To Do:
#
# [] figure out how to get the check boxes in a "checked" and "unchecked" state
# [] make heading bigger with bigger text
# [] make column for Q1, Q2, etc. smaller and adjust other column sizes accordinly
# [] multiple answers for one question in the same row?
# [done] description should span 4 columns but it looks like it is only spanning 3
# 