```python
import itertools
import glob
import os
from pathlib import Path

import meshio
import numpy as np
import matplotlib.pyplot as plt
import scipy as sp
from celluloid import Camera
from IPython.display import HTML, Image

import ofiz.plot as ofiz

ROOT = Path("./assets/img/")

if not os.path.exists(ROOT):
    os.makedirs(ROOT)
```

# Dye


```python
def plot_fn(mesh, ax):
    mesh = ofiz.MeshGraphics(mesh)
    mesh.plot_heatmap(field_name="C", field_type="point", resolution=(128, 128, 2), sigma=2.5, ax=ax)

ofiz.animate("./VTK", plot_fn, gif_path=ROOT / "c_heatmap.gif", fps=10, start=2000)
```




<img src="assets/img/c_heatmap.gif"/>


