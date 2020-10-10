# Create output sting and title card
$output = "<!--spekk.xyz, built by script on " + $(Get-Date) + "-->`n<html>`n"

# Add the index <head> to the output
$output += $(Get-Content .\_index_head_stub.html -Raw)

# Define the header text
$header = "<div class=header><h1 style=`"font-size:48px`">spekk's squawk box</h1><h2>the cool and good website</h2></div>"

# Generate the footer
$footer = "<div class=footer><p>spekkboy's pages, 2020-" + $(Get-Date -Format "yyyy") + "</p><p>last updated "
$footer += $(Get-Date -Format "yyyy-MM-dd HH:mm") + "</p></div>"

# Add the innards, surrounded by <body> tags
$output += "`n<body>`n"
$output += $header + "`n"
$output += $(Get-Content .\_index_main_stub.html -Raw) + "`n"

# Grab the latest blog and put it here
Set-Location ./blog/content
$output += "<div class=header><h1>latest from blogs</h1></div>" + "`n"
$output += $(Get-Content -Raw (Get-ChildItem | Sort-Object -Descending -Property name)[0]) + "`n"
Set-Location ..

# Generate the blog index page
./_blog_build.ps1
Set-Location ..

# Grab the latest blog and put it here
Set-Location ./code/content
$output += "<div class=header><h1>latest from codeworks</h1></div>" + "`n"
$output += $(Get-Content -Raw (Get-ChildItem | Sort-Object -Descending -Property name)[0]) + "`n"
Set-Location ..

# Generate the blog index page
./_code_build.ps1
Set-Location ..

# Add the footer to output
$output += $footer + "`n</body>`n</html>"

# Write output to index.html
Clear-Content .\index.html
$output | Set-Content .\index.html