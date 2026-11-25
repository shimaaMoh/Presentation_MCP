param(
    [Parameter(Mandatory=$false)][string]$ProjectId = "rcmc-prod-gemini-enterprise-01",
    [Parameter(Mandatory=$false)][string]$Region = "me-central2",
    [Parameter(Mandatory=$false)][string]$ServiceName = "rcmc-presentation-mcp"
)

$ErrorActionPreference = "Stop"

Write-Host "====================================================" -ForegroundColor Cyan
Write-Host "   🚀 Deploying RCMC Presentation MCP to Cloud Run" -ForegroundColor Cyan
Write-Host "====================================================" -ForegroundColor Cyan

if (-not $ProjectId) {
    $ProjectId = (gcloud config get-value project 2>$null)
    if (-not $ProjectId) {
        $ProjectId = Read-Host "Enter your Google Cloud Project ID"
    }
}

Write-Host "Project ID : $ProjectId" -ForegroundColor Yellow
Write-Host "Region     : $Region (Saudi Arabia / Dammam)" -ForegroundColor Yellow
Write-Host "Service    : $ServiceName" -ForegroundColor Yellow
Write-Host "----------------------------------------------------"

# 1. Enable required APIs
Write-Host "Enabling Cloud Run and Cloud Build APIs..." -ForegroundColor Green
gcloud services enable run.googleapis.com cloudbuild.googleapis.com artifactregistry.googleapis.com --project $ProjectId

# 2. Deploy directly from source via Cloud Build
Write-Host "Building container and deploying to Cloud Run..." -ForegroundColor Green
gcloud run deploy $ServiceName `
    --source . `
    --platform managed `
    --region $Region `
    --project $ProjectId `
    --allow-unauthenticated `
    --memory 1Gi `
    --cpu 1 `
    --min-instances 0 `
    --max-instances 5 `
    --timeout 300

$serviceUrl = (gcloud run services describe $ServiceName --platform managed --region $Region --project $ProjectId --format "value(status.url)")

Write-Host ""
Write-Host "====================================================" -ForegroundColor Green
Write-Host "   ✅ Deployment Succeeded!" -ForegroundColor Green
Write-Host "====================================================" -ForegroundColor Green
Write-Host "Service URL: $serviceUrl" -ForegroundColor Cyan
Write-Host ""
Write-Host "Endpoints for Gemini Enterprise & Users:"
Write-Host "  • MCP JSON-RPC Endpoint: $serviceUrl/mcp"
Write-Host "  • SSE Stream Endpoint  : $serviceUrl/sse"
Write-Host "  • Live Canvas Preview  : $serviceUrl/canvas/{presentation_id}"
Write-Host "  • PPTX Download Link   : $serviceUrl/download/{filename}.pptx"
Write-Host "  • Healthcheck          : $serviceUrl/health"
