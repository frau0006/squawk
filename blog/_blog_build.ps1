# Add the html header
$blogIndexOutput = "<!--spekk.xyz/blog, built by script on " + $(Get-Date) + "-->`n<html>`n"
$blogIndexOutput += $(Get-Content _blog_head_stub.html -Raw)
$blogIndexOutput += $header

# Add blog page main header thing whatever
$blogIndexOutput += $(Get-Content _blog_index_stub.html -Raw)

# Build the blog list
$blogIndexOutput += "`n<div class=header><h1>latest blog</h1></div>`n"

Set-Location ./content
$blogIndexOutput += $(Get-Content -Raw (Get-ChildItem | Sort-Object -Descending -Property name)[0]) + "`n"
$blogIndexOutput += "`n<div class=header><h1>blog listing</h1></div>`n"
$blogIndexOutput += "<div class=main>`n"

Get-ChildItem | Sort-Object -Descending | ForEach-Object {
    $blogIndexOutput += $($((Get-Content -Path $("./" + $_.Name))[1]) -replace "h1", "h3")
    $blogIndexOutput += $($((Get-Content -Path $("./" + $_.Name))[2]) -replace "h2", "h4")
    $blogIndexOutput += " <a href=`"./pages/" + $_.Name + "`">" + $_.Name + "</a><br>`n"
}
Set-Location ..

$blogIndexOutput += "`n</div>"
$blogIndexOutput += $footer
$blogIndexOutput += "`n</html>"
Clear-Content blog_index.html
$blogIndexOutput | Set-Content blog_index.html

# Create the standalone blog pages
Get-ChildItem -Path ./content | ForEach-Object {
    New-Item -Path ./pages -Name $_.Name -ItemType file -Force
    $blogFileOutput = "<!--spekk.xyz/blog, built by script on " + $(Get-Date) + "-->`n<html>`n"
    $blogFileOutput += $(Get-Content ./pages/_blog_pages_head_stub.html -Raw)
    $blogFileOutput += $header
    $blogFileOutput += $(Get-Content -Raw -Path $("./content/" + $_.Name))
    $blogFileOutput += "`n</div>"
    $blogFileOutput += $footer
    $blogFileOutput += "`n</html>"
    $blogFileOutput | Set-Content -Path $("./pages/" + $_.Name)
}
