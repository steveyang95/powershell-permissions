 
#########
# Login #
#########

# Login-AzureRmAccount

$user = Get-AzureRmSubscription

Connect-AzureAD -TenantId $user.TenantId

# $requiredResourceAccess = { RequiredResourceAccess {
#         ResourceAppId: 00000002-0000-0000-c000-000000000000
#         ResourceAccess: System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.ResourceAccess]
#     }, RequiredResourceAccess {
#         ResourceAppId: 797f4846-ba00-4fd7-ba43-dac1f8f63013
#         ResourceAccess: System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.ResourceAccess]
#     }
# }

$reqGraph = New-Object -TypeName "Microsoft.Open.AzureAD.Model.RequiredResourceAccess"
$reqGraph.ResourceAppId = "00000002-0000-0000-c000-000000000000"

$delPermission1 = New-Object -TypeName "Microsoft.Open.AzureAD.Model.ResourceAccess" -ArgumentList "a42657d6-7f20-40e3-b6f0-cee03008a62a","Scope" #Access Directory as the signed in user
$delPermission2 = New-Object -TypeName "Microsoft.Open.AzureAD.Model.ResourceAccess" -ArgumentList "cba73afc-7f69-4d86-8450-4978e04ecd1a","Scope"
$delPermission3 = New-Object -TypeName "Microsoft.Open.AzureAD.Model.ResourceAccess" -ArgumentList "311a71cc-e848-46a1-bdf8-97ff7156d8e6","Scope"

$reqGraph.ResourceAccess = $delPermission1, $delPermission2, $delPermission3

$reqGraphTwo = New-Object -TypeName "Microsoft.Open.AzureAD.Model.RequiredResourceAccess"
$reqGraphTWo.ResourceAppId = "797f4846-ba00-4fd7-ba43-dac1f8f63013"

$appPermission1 = New-Object -TypeName "Microsoft.Open.AzureAD.Model.ResourceAccess" -ArgumentList "41094075-9dad-400e-a0bd-54e686782033","Scope"

$reqGraphTwo.ResourceAccess = $appPermission1

$permissions = New-Object 'System.Collections.Generic.List[[Microsoft.Open.AzureAD.Model.RequiredResourceAccess, Microsoft.Open.AzureAD16.Graph.Client, Version=2.0.0.0, Culture=neutral, PublicKey
Token=null]]'

$permissions.Add($reqGraph)
$permissions.Add($reqGraphTwo)

　
$requiredResourceAccess = { RequiredResourceAccess {
        ResourceAppId: 00000002-0000-0000-c000-000000000000
        ResourceAccess: { ResourceAccess {
                   Id: a42657d6-7f20-40e3-b6f0-cee03008a62a
                   Type: Scope
                 }, ResourceAccess {
                   Id: cba73afc-7f69-4d86-8450-4978e04ecd1a
                   Type: Scope
                 }, ResourceAccess {
                   Id: 311a71cc-e848-46a1-bdf8-97ff7156d8e6
                   Type: Scope
                 }
                 }
    }, RequiredResourceAccess {
        ResourceAppId: 797f4846-ba00-4fd7-ba43-dac1f8f63013
        ResourceAccess: { ResourceAccess {
                   Id: 41094075-9dad-400e-a0bd-54e686782033
                   Type: Scope
                 }
                 }
    }
}

Write-Output "created Required Resource Access"
Write-Output $requiredResourceAccess

Write-Output "Make sure to have downloaded the correct dependencies and modules"
# $controllerAddress = Read-Host -Prompt "Input controller address. Please include port if one exists. Example: 127.0.0.1:8000"

Write-Output "Using Service Principal ObjectID is $appObjectId"

$app = Get-AzureADApplication -ObjectId $appObjectId

$app | Select-Object -Property *

Write-Output "Writing the app requiredresourceaccess"
Write-Output $app.RequiredResourceAccess

Write-Output "This is the type of requiredresourceaccess"
Write-Output $app.RequiredResourceAccess.GetType().fullname

# $arraysMatch = @(Compare-Object $app.RequiredResourceAccess $requiredResourceAccess).Length -eq 0
# Write-Output "Does the requiredResourceAccess Match? $arraysMatch"

##############
# Reply URLs #
##############

# $newReplyUrl = "http://$controllerAddress/callback"
# $replyUrls = $app.ReplyUrls;

# Write-Output $replyUrls
# Add Reply URL if not already in the list
# if ($replyUrls -NotContains $newReplyUrl) {
#     $replyUrls.Add($newReplyUrl)
#     Set-AzureADApplication -ObjectId $app.ObjectId -ReplyUrls $replyUrls
# }

　
########################
# Configure Controller #
########################

# Curl commands

　
 
