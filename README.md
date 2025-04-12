# μOKD (Micro OKD)

μOKD is a lightweight, single-node OKD cluster designed for edge deployment. It is built on top of the OKD 4.x distribution and is optimized for low-resource environments. μOKD is ideal for developers and teams looking to run OKD on resource-constrained devices, in development environments, or home labs.


## Building

 - `make patch` - Applies patches and rebases onto OKD
 - `make srpm` - Builds the SRPM package found at `upstream/_output/rpmbuild/SRPMS`