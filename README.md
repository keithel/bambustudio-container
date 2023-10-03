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

20231003 - Nvidia support - closer to working:
I am testing this on Rocky 8 using Podman. Following this Nvidia guide doesn't
allow Bambu Studio to work, but it changes the behavior, and I no longer see
error messages indicating errors trying to access dri.
https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/cdi-support.html

Bambu Studio now crashes with 3 log blocks indicating WebKitWebProcess
receiving an X window system error:
```
(WebKitWebProcess:95): Gdk-ERROR **: 04:05:03.039: The program 'WebKitWebProcess' received an X Window System error.
This probably reflects a bug in the program.
The error was 'BadValue (integer parameter out of range for operation)'.
  (Details: serial 220 error_code 2 request_code 152 (GLX) minor_code 34)
  (Note to programmers: normally, X errors are reported asynchronously;
   that is, you will receive the error a while after causing it.
   To debug your program, run it with the GDK_SYNCHRONIZE environment
   variable to change this behavior. You can then get a meaningful
   backtrace from your debugger if you break on the gdk_x_error() function.)
```
I also see many gtk_widget, gtk_window, g_signal_connect_data critical error messages.
The prior behavior had the Bambu Studio window coming up, but some content not
being rendered (the content rendered with OpenGL I think).

## Useful links
* https://docs.docker.com/compose/compose-file/compose-file-v3
* https://askubuntu.com/questions/1201103/docker-x11-fails-to-open-display
* https://stackoverflow.com/questions/46053672/set-secomp-to-unconfined-in-docker-compose
* https://github.com/containers/podman/issues/14402
* https://www.redhat.com/sysadmin/container-permission-denied-errors
  This one warrants further attention to do some hardening of the container,
  rather than just running it as a privileged container.

## Commands
$ podman-compose build && podman-compose up && podman rm bambustudio_app_1
$ podman run --rm -it --device /dev/fuse --cap-add SYS_ADMIN -e DISPLAY --net=host bambustudio:latest

With Nvidia cdi support, podman run command changes to:
$ podman run --rm -it --device /dev/fuse --device nvidia.com/gpu=all --cap-add SYS_ADMIN -e DISPLAY --net=host --gpus all bambustudio:latest
