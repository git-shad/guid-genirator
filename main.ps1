Add-Type -AssemblyName PresentationFramework
[xml]$xaml = [io.file]::readalltext("style.xaml")

$reader = (new-object system.xml.xmlnodereader $xaml)

try{ $psgui = [system.windows.markup.xamlreader]::Load($reader) }
catch{ write-warning $_.exception;throw}

$xaml.SelectNodes("//*[@Name]") | foreach-object{
    try{set-variable -Name "_$($_.Name)" -value $psgui.findname($_.Name) -ErrorAction stop }
    catch{ throw; }
}

Get-Variable _*

$guid = [guid]::Empty

$_new.add_mousedown({
    $global:guid = [guid]::newguid()
    
    if($_none.IsChecked){
        $_display.Text = $guid.ToString("N")
    }elseif($_hyphens.IsChecked){
        $_display.Text = $guid.ToString("D")
    }elseif($_breaces.IsChecked){
        $_display.Text = $guid.ToString("B")
    }elseif($_parentheses.IsChecked){
        $_display.Text = $guid.ToString("P")
    }elseif($_hex.IsChecked){
        $_display.Text = $guid.ToString("X")
    }else{
        $_display.Text = $guid
    }
})

$_new.add_mouseenter({ $_text_new.foreground = "#FFC6F5F5" })
$_new.add_mouseleave({ $_text_new.foreground = "#FF000606" })

$_none.add_checked({
    $_none.IsChecked = $true
    $_hyphens.isChecked = $false
    $_breaces.IsChecked = $false
    $_parentheses.IsChecked = $false
    $_hex.IsChecked = $false
    
    $_display.Text = $guid.ToString("N")
})

$_hyphens.add_checked({
    $_none.IsChecked = $false
    $_hyphens.isChecked = $true
    $_breaces.IsChecked = $false
    $_parentheses.IsChecked = $false
    $_hex.IsChecked = $false
    
    $_display.Text = $guid.ToString("D")
})

$_breaces.add_checked({
    $_none.IsChecked = $false
    $_hyphens.isChecked = $false
    $_breaces.IsChecked = $true
    $_parentheses.IsChecked = $false
    $_hex.IsChecked = $false
    
    $_display.Text = $guid.ToString("B")
})

$_parentheses.add_checked({
    $_none.IsChecked = $false
    $_hyphens.isChecked = $false
    $_breaces.IsChecked = $false
    $_parentheses.IsChecked = $true
    $_hex.IsChecked = $false
    
    $_display.Text = $guid.ToString("P")
})

$_hex.add_checked({
    $_none.IsChecked = $false
    $_hyphens.isChecked = $false
    $_breaces.IsChecked = $false
    $_parentheses.IsChecked = $false
    $_hex.IsChecked = $true
    
    $_display.Text = $guid.ToString("X")
})

$psgui.ShowDialog() | Out-Null
