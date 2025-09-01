# Container Image Cleanup Workflow

This repository includes an automated cleanup workflow that removes old untagged container images from the GitHub Container Registry (GHCR).

## How it works

The workflow (`.github/workflows/cleanup-images.yaml`) automatically:
- Runs monthly on the 15th at 2 AM UTC
- Identifies untagged container images older than 3 months (90 days)
- Deletes those images to save storage space
- Preserves all tagged images (latest, stable, version numbers, etc.)

## Safety features

- **Dry run by default**: Manual triggers default to dry-run mode
- **Safety limit**: Won't delete more than 50 images in a single run
- **Detailed logging**: Shows what would be or was deleted
- **Error handling**: Continues processing even if some deletions fail

## Manual usage

You can manually trigger the cleanup workflow:

1. Go to the Actions tab in GitHub
2. Select "Cleanup old untagged images"
3. Click "Run workflow"
4. Choose whether to run in dry-run mode (recommended for first use)

## Customization

To modify the cleanup behavior, edit `.github/workflows/cleanup-images.yaml`:

- Change `cron: "0 2 15 * *"` to modify the schedule
- Change `MAX_DELETE_COUNT: 50` to adjust the safety limit
- Change `date -d '90 days ago'` to modify the age threshold

## What gets deleted

✅ **Will be deleted**:
- Untagged images older than 90 days
- Build artifacts from failed or intermediate builds
- Images that were temporarily created during CI/CD

❌ **Will NOT be deleted**:
- Any tagged images (latest, stable, version numbers)
- Recent untagged images (less than 90 days old)
- Images when more than 50 would be deleted (safety check)