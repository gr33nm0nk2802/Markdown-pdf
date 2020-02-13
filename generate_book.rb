#!/usr/bin/env ruby

templates = [
    name: 'book',
    path: 'src/book.md'
]

# Choose template
puts 'Choose a template:'
templates.each_with_index do |t,i|
  puts "#{i}. #{t[:name]}"
end
choice = gets.chomp
src = templates[choice.to_i][:path]


# Choose syntax highlight style
style = 'breezedark'
puts "Choose syntax highlight style [#{style}]"
choice = gets.chomp
style = choice unless choice.empty?
puts style

# Generating report
puts 'Generating book...'
pdf = "output/book.pdf"
%x(pandoc #{src} -o #{pdf} \
  --from markdown+yaml_metadata_block+raw_html \
  --template eisvogel \
  --table-of-contents \
  --toc-depth 6 \
  --number-sections \
  --top-level-division=chapter \
  --highlight-style #{style}
)

