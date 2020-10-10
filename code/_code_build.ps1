# Add the html header
$codeIndexOutput = "<!--spekk.xyz/code, built by script on " + $(Get-Date) + "-->`n<html>`n"
$codeIndexOutput += $(Get-Content _code_head_stub.html -Raw)
$codeIndexOutput += $header

# Add code page main header thing whatever
$codeIndexOutput += $(Get-Content _code_index_stub.html -Raw)

# Build the code list
$codeIndexOutput += "`n<div class=header><h1>latest codework</h1></div>`n"

Set-Location ./content
$codeIndexOutput += $(Get-Content -Raw (Get-ChildItem | Sort-Object -Descending -Property name)[0]) + "`n"
$codeIndexOutput += "`n<div class=header><h1>codeworks listing</h1></div>`n"
$codeIndexOutput += "<div class=main>`n"

Get-ChildItem | Sort-Object -Descending | ForEach-Object {
    $codeIndexOutput += $($((Get-Content -Path $("./" + $_.Name))[1]) -replace "h1", "h3")
    $codeIndexOutput += $($((Get-Content -Path $("./" + $_.Name))[2]) -replace "h2", "h4")
    $codeIndexOutput += " <a href=`"" + $_.Name + "`">" + $_.Name + "</a><br>`n"
}
Set-Location ..

$codeIndexOutput += "`n</div>"
$codeIndexOutput += $footer
$codeIndexOutput += "`n</html>"
Clear-Content _code_index.html
$codeIndexOutput | Set-Content _code_index.html

# Create the standalone code pages
Get-ChildItem -Path ./content | ForEach-Object {
    New-Item -Path . -Name $_.Name -ItemType file -Force
    $codeFileOutput = "<!--spekk.xyz/code, built by script on " + $(Get-Date) + "-->`n<html>`n"
    $codeFileOutput += $(Get-Content _code_head_stub.html -Raw)
    $codeFileOutput += $header
    $codeFileOutput += $(Get-Content -Raw -Path $("./content/" + $_.Name))
    $codeFileOutput += "`n</div>"
    $codeFileOutput += $footer
    $codeFileOutput += "`n</html>"
    $codeFileOutput | Set-Content -Path $("./" + $_.Name)
}
