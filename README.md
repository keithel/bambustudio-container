# Bambu Studio docker-compose configuration

This provides a containerized means of running Bambu Studio - a 3D print slicer
derived from PrusaSlicer.

## Current status

This is a work in progress.

Right now this does not fully function.
In its current state, it should bring up a dialog about using the default
certificate store. If you confirm this, the main UI will come up, but it is not
painting correctly. This, I'm quite sure, is because the necessary permissions
to talk to the GPU are not present yet.

## Useful links
* https://docs.docker.com/compose/compose-file/compose-file-v3
* https://askubuntu.com/questions/1201103/docker-x11-fails-to-open-display
* https://stackoverflow.com/questions/46053672/set-secomp-to-unconfined-in-docker-compose
* https://github.com/containers/podman/issues/14402
* https://www.redhat.com/sysadmin/container-permission-denied-errors
  This one warrants further attention to do some hardening of the container,
  rather than just running it as a privileged container.
