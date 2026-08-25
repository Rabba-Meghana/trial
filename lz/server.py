from pathlib import Path

from fastapi.responses import FileResponse, RedirectResponse
from fastapi.staticfiles import StaticFiles

from .api import app

WEB_ROOT = Path(__file__).resolve().parent.parent / "web"

app.mount("/ui/assets", StaticFiles(directory=WEB_ROOT), name="ui-assets")


@app.get("/", include_in_schema=False)
def root() -> RedirectResponse:
    return RedirectResponse(url="/ui")


@app.get("/ui", include_in_schema=False)
def control_plane() -> FileResponse:
    return FileResponse(WEB_ROOT / "index.html")
