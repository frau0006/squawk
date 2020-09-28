# Create output sting and title card
$output = "<!--spekk.xyz, built by script on " + $(Get-Date) + "-->`n"

# Add the index <head> to the output
$output += $(Get-Content .\index_head_stub.html -Raw)

# Define the header text
$header = "<div class=header><h1>spekk's squawk box</h1><h2>the cool and good website</h2></div>"

# Add the innards, surrounded by <body> tags
$output += "`n<body>`n"
$output += $header + "`n"
$output += $(Get-Content .\index_main_stub.html -Raw) + "`n"

# Generate the footer
$footer = "<div class=footer><p>spekkboy's pages, 2020-" + $(Get-Date -Format "yyyy") + "</p><p>last updated "
$footer += $(Get-Date -Format "yyyy-MM-dd HH:mm") + "</p></div>"

# Add the footer to output
$output += $footer + "`n</body>"

# Write output to index.html
Clear-Content .\index.html
$output | Set-Content .\index.html