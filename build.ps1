# Create output sting and title card
$output = "<!--spekk.xyz, built by script on " + $(Get-Date) + "-->`n<html>`n"

# Add the index <head> to the output
$output += $(Get-Content .\index_head_stub.html -Raw)

# Define the header text
$header = "<div class=header><h1 style=`"font-size:48px`">spekk's squawk box</h1><h2>the cool and good website</h2></div>"

# Generate the footer
$footer = "<div class=footer><p>spekkboy's pages, 2020-" + $(Get-Date -Format "yyyy") + "</p><p>last updated "
$footer += $(Get-Date -Format "yyyy-MM-dd HH:mm") + "</p></div>"

# Add the innards, surrounded by <body> tags
$output += "`n<body>`n"
$output += $header + "`n"
$output += $(Get-Content .\index_main_stub.html -Raw) + "`n"

# Grab the latest blog and put it here
Set-Location .\blog
$output += "<div class=header><h1>latest from blogs</h1></div>" + "`n"
$output += $(Get-Content -Raw (Get-ChildItem | Sort-Object -Descending -Property name)[0]) + "`n"

# Generate the blog index page
$blogIndexOutput = "<!--spekk.xyz/blog, built by script on " + $(Get-Date) + "-->`n<html>`n"
$blogIndexOutput += "<!DOCTYPE html>`n<head>`n<Title>Spekk's Squawk Box</Title>`n<link rel=`"stylesheet`" href=`"../style.css`">`n"
$blogIndexOutput += "<link rel=`"icon`" type=`"image/png`" sizes=`"32x32`" href=`"../favicon-32x32.png`">`n"
$blogIndexOutput += "<link rel=`"icon`" type=`"image/png`" sizes=`"16x16`" href=`"../favicon-16x16.png`">`n"
$blogIndexOutput += "</head>`n"
$blogIndexOutput += $header
$blogIndexOutput += "`n<div class=header><h1>latest blog</h1></div>`n"
$blogIndexOutput += $(Get-Content -Raw (Get-ChildItem | Sort-Object -Descending -Property name)[0]) + "`n"
$blogIndexOutput += "`n<div class=header><h1>blog listing</h1></div>`n"
$blogIndexOutput += "<div class=main>`n"

Get-ChildItem | Sort-Object -Descending | ForEach-Object {
    $blogIndexOutput += "<a href=`"" + $_.Name + "`">" + $_.BaseName + "</a><br>`n"
}

$blogIndexOutput += "`n</div>"
$blogIndexOutput += $footer
$blogIndexOutput += "`n</html>"
Clear-Content _blog_index.html
$blogIndexOutput | Set-Content _blog_index.html
Set-Location ..

# Grab the latest codeworks and put it here
Set-Location .\code
$output += "<div class=header><h1>latest from codeworks</h1></div>" + "`n"
$output += $(Get-Content -Raw (Get-ChildItem | Sort-Object -Descending -Property name)[0]) + "`n"

# Generate the codeworks index page
$codeIndexOutput = "<!--spekk.xyz/code, built by script on " + $(Get-Date) + "-->`n<html>`n"
$codeIndexOutput += "<!DOCTYPE html>`n<head>`n<Title>Spekk's Squawk Box</Title>`n<link rel=`"stylesheet`" href=`"../style.css`">`n"
$codeIndexOutput += "<link rel=`"icon`" type=`"image/png`" sizes=`"32x32`" href=`"../favicon-32x32.png`">`n"
$codeIndexOutput += "<link rel=`"icon`" type=`"image/png`" sizes=`"16x16`" href=`"../favicon-16x16.png`">`n"
$codeIndexOutput += "</head>`n"
$codeIndexOutput += $header
$codeIndexOutput += "`n<div class=header><h1>latest codework</h1></div>`n"
$codeIndexOutput += $(Get-Content -Raw (Get-ChildItem | Sort-Object -Descending -Property name)[0]) + "`n"
$codeIndexOutput += "`n<div class=header><h1>codeworks listing</h1></div>`n"
$codeIndexOutput += "<div class=main>`n"

Get-ChildItem | Sort-Object -Descending | ForEach-Object {
    $codeIndexOutput += "<a href=`"" + $_.Name + "`">" + $_.BaseName + "</a><br>`n"
}

$codeIndexOutput += "`n</div>"
$codeIndexOutput += $footer
$codeIndexOutput += "`n</html>"
Clear-Content _code_index.html
$codeIndexOutput | Set-Content _code_index.html
Set-Location ..

# Add the footer to output
$output += $footer + "`n</body>`n</html>"

# Write output to index.html
Clear-Content .\index.html
$output | Set-Content .\index.html