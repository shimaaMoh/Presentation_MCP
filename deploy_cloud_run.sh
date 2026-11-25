#!/usr/bin/env bash
set -e

PROJECT_ID="${1:-$(gcloud config get-value project 2>/dev/null)}"
REGION="${2:-me-central2}"
SERVICE_NAME="${3:-rcmc-presentation-mcp}"

if [ -z "$PROJECT_ID" ]; then
  read -p "Enter your Google Cloud Project ID: " PROJECT_ID
fi

echo "===================================================="
echo "   🚀 Deploying RCMC Presentation MCP to Cloud Run"
echo "===================================================="
echo "Project ID : $PROJECT_ID"
echo "Region     : $REGION"
echo "Service    : $SERVICE_NAME"
echo "----------------------------------------------------"

echo "Enabling Cloud Run and Cloud Build APIs..."
gcloud services enable run.googleapis.com cloudbuild.googleapis.com artifactregistry.googleapis.com --project "$PROJECT_ID"

echo "Building container and deploying to Cloud Run..."
gcloud run deploy "$SERVICE_NAME" \
    --source . \
    --platform managed \
    --region "$REGION" \
    --project "$PROJECT_ID" \
    --allow-unauthenticated \
    --memory 1Gi \
    --cpu 1 \
    --min-instances 0 \
    --max-instances 5 \
    --timeout 300

SERVICE_URL=$(gcloud run services describe "$SERVICE_NAME" --platform managed --region "$REGION" --project "$PROJECT_ID" --format "value(status.url)")

echo ""
echo "===================================================="
echo "   ✅ Deployment Succeeded!"
echo "===================================================="
echo "Service URL: $SERVICE_URL"
echo ""
echo "Endpoints for Gemini Enterprise & Users:"
echo "  • MCP JSON-RPC Endpoint: $SERVICE_URL/mcp"
echo "  • SSE Stream Endpoint  : $SERVICE_URL/sse"
echo "  • Live Canvas Preview  : $SERVICE_URL/canvas/{presentation_id}"
echo "  • PPTX Download Link   : $SERVICE_URL/download/{filename}.pptx"
