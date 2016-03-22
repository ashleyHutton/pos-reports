require 'prawn'
require 'prawn/table'

Prawn::Font::AFM.hide_m17n_warning = true

Prawn::Document::generate("generatedPracticeStoreReport.pdf") do 

	stroke_axis

	unfilled_box = "/Users/ashleyhutton/Documents/Brand New Box/pos-reports/unfilled_box.png"
	filled_box = "/Users/ashleyhutton/Documents/Brand New Box/pos-reports/filled_box.png"

	sizeOfBox = 12;

    descriptiveQuestion = "Please describe the following:
	• How the salesperson responded when you stated your interest in a tablet.
	• What questions they asked to understand your needs.
	• Please note if the salesperson led the interaction, or if you had to volunteer information to keep the conversation going.\n
When I arrived to the store I saw two sales people, one was serving a customer and the other was behind the counter. I was not quite sure if they were doing paperwork or if the salesperson thought that I did not need help. Then the salesperson approached me after waiting for some minutes, they asked me what I was looking for. I explained them that I was looking for a tablet and the salesperson indicated me where the tablets were, so I had to ask some questions to keep the conversation going; I told them that I was looking for something light and with Internet access, so salesperson asked me about the usage I would give to the device and asked me if I would search on the Internet, read emails and share information on the social networks. Apart from that that salesperson did not make further questions. I had to lead the whole interaction.\n"

	checkboxAnswer = [	
						"This is the first option",
						"This is the second option. It is really looooooooooooooooooooooooooooooog",
						"This is the third option",
						"This is the fourth option"
					 ]

	#answer = "This is the second option. It is really loooooooooooooooooooooooooooo\noong. What will happen?"

	# create outer bounding box
	bounding_box([0,cursor], :width => 550) do

		@qFont = 10

		# elements of checkbox questions including answer and box
		subTable = [ 
					#["Box1", "Possible checkbox answer 1."],
					# specifying the width here make all rows in this column this width -- why?
					# making checkboxes hardcoded either filled or unfilled for now
					[{:image => unfilled_box, :fit => [sizeOfBox, sizeOfBox], :width => 25}, {:content => checkboxAnswer[0]}],
					#["Box2", "Possible checkbox answer 2."],
					[{:image => filled_box, :fit => [sizeOfBox,sizeOfBox]}, {:content => checkboxAnswer[1]}],
					# throwing an error even though we are wrapping text -- why?
					#["1", {:content => "Possible checkbox answer 3. This answer is really loooooooooooooooooooooooooooooong.", :overflow => :shrink_to_fit}],
					[{:image => unfilled_box, :fit => [sizeOfBox, sizeOfBox]}, {:content => checkboxAnswer[2]}]
					#["Box4", "Possible checkbox answer 4."]
					]

		# elements of the table in the format [[r1c1,r1c2],[r2c1,r2c2],...]
		data = 	[
				# Header
				[{:content => "Header 1", :colspan => 4, :size => 30}, "Score1"],
				# Description
				[{:content => "Question description goes here.", :colspan => 5}],
				# Questions and answers
				[{:content => "Q1", :size => @qFont}, "Basic Question", {:content => "", :width => 25}, {:content => "First Answer", :colspan => 2}],
				# Checkbox questions
				[{:content => "Q2", :size => @qFont}, "Checkbox", {:content => subTable, :colspan => 3}],
				
				# when I uncomment this it makes the basic question empty column really big
				# when I comment it, it makes the subtable second column really big
				[{:content => "Q3", :size => @qFont}, {:content => descriptiveQuestion, :colspan => 4}]
				#["Q3", "Basic Question", "", {:content => "Second Answer", :colspan => 2}],
				#["Q4", "Basic Question", "", {:content => "Third Answer", :colspan => 2}]
				]

		# create table with alternating row colors
		table(
				data, 
				:row_colors => ['f3f9fd','FFFFFF'], 
				:width => 550,
				# Desired Column Widths:
				# Col 1: 25
				# Col 2: ?
				# Col 3: 25
				# Col 4: ?
				# Col 5: idk
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
# [done] figure out how to get the check boxes in a "checked" and "unchecked" state
# [done] make heading bigger with bigger text
# [done] make column for Q1, Q2, etc. smaller and adjust other column sizes accordinly
# [done] multiple answers for one question in the same row?
# [done] description should span 4 columns but it looks like it is only spanning 3
# [] text wrapping in subtables!
# 
