from pathlib import Path
import os
import tempfile

import meshio
import ofiz.plot as ofiz

THIS_PATH = Path(os.path.dirname(os.path.realpath(__file__)))
ROOT = THIS_PATH / ".."

def test_plot():

    vtk_path = ROOT / "experiments/cavity/VTK/cavity_2000.vtk"

    mesh = meshio.read(vtk_path)

    ofiz.plot_heatmap(mesh=mesh, field=mesh.point_data["p"], resolution=(128, 128, 2), sigma=2.5)

    with tempfile.TemporaryDirectory() as tmp_dir:

        tmp_dir = Path(tmp_dir)

        vtk_root = ROOT / "experiments/cavity/VTK"

        def plot_fn(mesh, ax):
            mesh = ofiz.MeshGraphics(mesh)
            mesh.plot_heatmap(field_name="p", field_type="point", resolution=(16, 16, 2), sigma=2.5, ax=ax)

        ofiz.animate(vtk_root, plot_fn, gif_path=tmp_dir / "hm.gif", fps=10)

        ofiz.plot_quiver(mesh, field=mesh.point_data["U"])

        def plot_fn(mesh, ax):
            mesh = ofiz.MeshGraphics(mesh)
            mesh.plot_quiver(field_name="U", field_type="point", ax=ax)

        ofiz.animate(vtk_root, plot_fn, gif_path=tmp_dir / "q.gif", fps=10)