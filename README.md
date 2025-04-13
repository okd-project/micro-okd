# μOKD (Micro OKD)

μOKD is a lightweight, single-node OKD cluster designed for edge deployment. It is built on top of the OKD 4.x distribution and is optimized for low-resource environments. μOKD is ideal for developers and teams looking to run OKD on resource-constrained devices, in development environments, or home labs.


## Installation

Pre-built RPM packages can be found on [COPR](https://copr.fedorainfracloud.org/coprs/owenh/micro-okd/).

### Enabling this COPR repo on Fedora 40+ or Centos Stream 9/10
 - Run `dnf copr enable owenh/micro-okd` (if you receive an unknown subcommand error, it can be fixed with `dnf install dnf-plugins-core`)
 - Install main package `dnf install microshift`

### Starting μOKD
 - Configure minimum firewall requirements
   - `sudo firewall-cmd --permanent --zone=trusted --add-source=10.42.0.0/16`
   - `sudo firewall-cmd --permanent --zone=trusted --add-source=169.254.169.1`
   - `sudo firewall-cmd --reload`
 - Start the service with `systemctl start microshift`
 - Enable the service to start on boot with `systemctl enable microshift`

### Optional Packages
- `microshift-olm` - Adds operator lifecycle manager support to enable installation of operators
- `microshift-low-latency` - Tunes use for faster responses to external events
- `microshift-multus` - A default configuration for CRI-O to enable Multus CNI in MicrOKD
- `microshift-greenboot` - A systemd healthcheck service intended for RPM-OSTree based systems

## Documentation
There currently isn't any documentation located on okd.io for μOKD

You can refer to the [Red Hat docs for now.](https://docs.redhat.com/en/documentation/red_hat_build_of_microshift/4.18)

## Building

 - `make patch` - Applies patches and rebases onto OKD
 - `make srpm` - Builds the SRPM package found at `upstream/_output/rpmbuild/SRPMS`