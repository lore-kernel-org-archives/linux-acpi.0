From: Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [gpm] Untangling the sleep hotkey mess
Date: Mon, 09 Jan 2006 01:14:54 +0000
Message-ID: <1136769294.3059.12.camel@localhost>
References: <20060107172446.GA3092@srcf.ucam.org>
	 <1136725124.2444.26.camel@localhost> <20060108134744.GA21538@srcf.ucam.org>
	 <1136729632.2444.36.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-Tj2cVWEir2MwRtxqFBke"
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1136729632.2444.36.camel@localhost>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gnome-power-manager-list-rDKQcyrBJuzYtjvyW6yDsg@public.gmane.org, hal-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, desktop_portables-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-Tj2cVWEir2MwRtxqFBke
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2006-01-08 at 14:13 +0000, Richard Hughes wrote:
> On Sun, 2006-01-08 at 13:47 +0000, Matthew Garrett wrote:
> > On Sun, Jan 08, 2006 at 12:58:44PM +0000, Richard Hughes wrote:
> > 
> > > Can we not go further and define Dock/UnDock,
> > > BrightnessUp/BrightnessDown, Hibernate, etc?
> > 
> > BrightnessUp/BrightnessDown have keycodes defined in 
> > /usr/src/linux/input.h, so that shouldn't be a problem. I suggested a 
> > keycode for hibernate (KEY_SUSPEND, with suspend to RAM on KEY_SLEEP). 
> 
> Okay, that's good for me.
> 
> > I'm less convinced about Dock/Undock - that's a problem that's so far 
> > from being solved I've no idea what sort of things userspace wants to 
> > know :)
> 
> Sure, just an example of "other stuff". Lock is maybe a better example
> as gnome-screensaver (or equiv) can respond to this.
> 
> The main problem now is implementation.

Further to the conversation on IRC, I've attached two ACPI patches to
provoke discussion.

The first creates the /org/freedesktop/Hal/devices/acpi_uinput like I
did for the toshiba specific HAL addon.
The second uses the acpi events for creating uinput events that can be
captured using gnome-keybindings, and also creates HAL ButtonPressed
events so that DBUS aware applications (like g-v-m and g-p-m) can
monitor the events.

To use this on toshiba, you have to use the kernel patch:
http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-2.6.git;a=commitdiff;h=84bd08e019f34628e6e5c276115db5baa46ea824;hp=cfed69e108d0ff7e3cc1e9330f662a1e758eb04d
which may be upstreamed soon. Plus you'll need 
"options toshiba_acpi hotkeys_over_acpi=1" in /etc/modprobe.conf to
enable the new stuff.

Also, to create the input events, you have to "modprobe uinput" and then
restart haldaemon -- so you could say this patch is rough and ready. :-)

Adding other id's (for example for IBM), the keys will just work with no
kernel patches required. Toshiba is special as the interface is unique
(and broken), so that's why we need the patch. Thanks to Matthew for the
pointer to the patch.

This 30 minute hack works for me, but has had little real-world testing.

Comments please.

Richard.

--=-Tj2cVWEir2MwRtxqFBke
Content-Disposition: attachment; filename=hal-add-vbutton.patch
Content-Type: text/x-patch; name=hal-add-vbutton.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: hald/linux2/acpi.c
===================================================================
RCS file: /cvs/hal/hal/hald/linux2/acpi.c,v
retrieving revision 1.43
diff -u -r1.43 acpi.c
--- hald/linux2/acpi.c	2 Dec 2005 17:11:00 -0000	1.43
+++ hald/linux2/acpi.c	2 Dec 2005 18:09:30 -0000
@@ -47,6 +47,7 @@
 	ACPI_TYPE_IBM_DISPLAY,
 	ACPI_TYPE_PANASONIC_DISPLAY,
 	ACPI_TYPE_SONY_DISPLAY,
+	ACPI_TYPE_VBUTTON,
 	ACPI_TYPE_BUTTON
 };
 
@@ -375,6 +376,27 @@
 	return TRUE;
 }
 
+static gboolean
+vbutton_refresh (HalDevice *d, ACPIDevHandler *handler)
+{
+	const char *path;
+	path = hal_device_property_get_string (d, "linux.acpi_path");
+	if (path == NULL)
+		return FALSE;
+
+	/* only set up device new if really needed */
+	if (!hal_device_has_capability (d, "button")){
+		device_property_atomic_update_begin ();
+		hal_device_property_set_string (d, "info.product", "Virtual Button");
+		hal_device_property_set_string (d, "info.category", "button");
+		hal_device_property_set_string (d, "button.type", "virtual");
+		hal_device_property_set_bool (d, "button.has_state", FALSE);
+		hal_device_add_capability (d, "button");
+		device_property_atomic_update_end ();
+	}
+	return TRUE;
+}
+
 /** Removes all the possible battery.* keys.
  *
  *  @param	d		Valid battery HalDevice
@@ -880,6 +902,10 @@
 	snprintf (path, sizeof (path), "%s/acpi/button/sleep", get_hal_proc_path ());
 	acpi_synthesize (path, ACPI_TYPE_BUTTON);
 
+	/* create the extra vbutton button */
+	snprintf (path, sizeof (path), "/dev/uinput");
+	acpi_synthesize_item (path, ACPI_TYPE_VBUTTON);
+
 	/*
 	 * Collect video adaptors (from vendor added modules)
 	 * I *know* we should use the /proc/acpi/video/LCD method, but this
@@ -1022,12 +1048,21 @@
 	.remove      = acpi_generic_remove
 };
 
+static ACPIDevHandler acpidev_handler_vbutton = {
+	.acpi_type   = ACPI_TYPE_VBUTTON,
+	.add         = acpi_generic_add,
+	.compute_udi = acpi_generic_compute_udi,
+	.refresh     = vbutton_refresh,
+	.remove      = acpi_generic_remove
+};
+
 static ACPIDevHandler *acpi_handlers[] = {
 	&acpidev_handler_battery,
 	&acpidev_handler_processor,
 	&acpidev_handler_fan,
 	&acpidev_handler_button,
 	&acpidev_handler_ac_adapter,
+	&acpidev_handler_vbutton,
 	&acpidev_handler_laptop_panel_toshiba,
 	&acpidev_handler_laptop_panel_ibm,
 	&acpidev_handler_laptop_panel_panasonic,

--=-Tj2cVWEir2MwRtxqFBke
Content-Disposition: attachment; filename=hal-uinput-new_part.patch
Content-Type: text/x-patch; name=hal-uinput-new_part.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: hald/linux2/addons/addon-acpi.c
===================================================================
RCS file: /cvs/hal/hal/hald/linux2/addons/addon-acpi.c,v
retrieving revision 1.13
diff -u -r1.13 addon-acpi.c
--- hald/linux2/addons/addon-acpi.c	9 Nov 2005 21:13:30 -0000	1.13
+++ hald/linux2/addons/addon-acpi.c	9 Jan 2006 00:38:27 -0000
@@ -5,6 +5,7 @@
  *
  * Copyright (C) 2005 David Zeuthen, <david-o55+BOBDEFg@public.gmane.org>
  * Copyright (C) 2005 Ryan Lortie <desrt-0xnayjDhYQY@public.gmane.org>
+ * Copyright (C) 2006 Richard Hughes <richard-DRAXeJJ+PL1BDgjK7y7TUQ@public.gmane.org>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -26,6 +27,8 @@
 #  include <config.h>
 #endif
 
+#define	ACPI_UINPUT
+
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
@@ -37,10 +40,22 @@
 #include <sys/un.h>
 #include <fcntl.h>
 
+#ifdef ACPI_UINPUT
+#include <linux/input.h>
+#include <linux/uinput.h>
+#endif
+
 #include "libhal/libhal.h"
 
 #include "../probing/shared.h"
 
+#ifdef ACPI_UINPUT
+static int out_fd = -1;
+static int uinput_open (void);
+static int uinput_event (unsigned int key);
+static int uinput_close (void);
+#endif
+
 #ifdef ACPI_PROC
 static FILE *
 acpi_get_event_fp_kernel (void)
@@ -91,6 +106,142 @@
 }
 #endif
 
+#ifdef ACPI_UINPUT
+/** Opens the kernel uinput device
+ *  @return			Success
+ */
+static int
+uinput_open (void)
+{
+	int j, i;
+	struct uinput_user_dev udev_spec = { .name = "Virtual ACPI Keyboard" };
+
+	/* try to open uinput from all the different places it could be */
+	out_fd = open ("/dev/uinput", O_WRONLY | O_NDELAY);
+	if (out_fd < 0)		/* try harder */
+		out_fd = open ("/dev/input/uinput", O_WRONLY | O_NDELAY);
+	if (out_fd < 0)		/* try harder */
+		out_fd = open ("/dev/misc/uinput", O_WRONLY | O_NDELAY);
+	if (out_fd < 0) {	/* try harder */
+		printf ("Cannot open uinput (maybe not root?)\n");
+		return FALSE;
+	}
+
+	/* inform that we'll generate key events */
+	j  = ioctl (out_fd, UI_SET_EVBIT, EV_KEY) < 0;
+	j |= ioctl (out_fd, UI_SET_EVBIT, EV_REP) < 0;
+
+	/* set key events we can generate (in this case, all) */
+	for (i = KEY_RESERVED; i < BTN_MISC; i++)
+		j |= ioctl (out_fd, UI_SET_KEYBIT, i) < 0;
+	if (j) {
+		printf ("error setting up keyboard input device (maybe not root?)\n");
+		return FALSE;
+	}
+	/* write down information for creating a new device */
+	if (write (out_fd, &udev_spec, sizeof udev_spec) != sizeof udev_spec) {
+		printf ("error writing input device spec\n");
+		return FALSE;
+	}
+	/* create, and check */
+	if (ioctl (out_fd, UI_DEV_CREATE, 0) < 0) {
+		printf ("error creating input device\n");
+		return FALSE;
+	}
+	return TRUE;
+}
+#endif
+
+/** Writes to the /dev/uinput device a keypress, i.e. down then up
+ *
+ *  @param	key		The event, e.g KEY_BRIGHTNESSUP
+ *  @return			Success
+ */
+static int
+uinput_event (unsigned int key)
+{
+#ifdef ACPI_UINPUT
+	struct input_event event;
+	event.type = EV_KEY;
+	event.code = key;
+	event.value = 1;
+	if (write (out_fd, &event, sizeof event) != sizeof event) {
+		printf ("error writing down %d/%d/%d to device", EV_KEY, event.value, 1);
+		return FALSE;
+	}
+	event.value = 0;
+	if (write (out_fd, &event, sizeof event) != sizeof event) {
+		printf ("error writing up %d/%d/%d to device", EV_KEY, event.value, 0);
+		return FALSE;
+	}
+	return TRUE;
+#endif
+}
+
+#ifdef ACPI_UINPUT
+/** Closes the /dev/uinput device
+ *
+ *  @return			Success
+ */
+static int
+uinput_close (void)
+{
+	static struct input_event event = {
+		.type = EV_SYN,
+		.code = SYN_REPORT
+	};
+	if (!out_fd)
+		return FALSE;
+	write (out_fd, &event, sizeof event);
+	return TRUE;
+}
+#endif
+
+/** If found, does a uinput event and returns the condition name
+ *
+ *  @param	event		The acpi event
+ *  @return			The ButtonPressed condition
+ */
+static char *
+do_hkey_event (unsigned int event)
+{
+	/* Toshiba FnESC */
+	if (event == 0x101) {
+		uinput_event (KEY_MUTE);
+		return "Mute";
+	}
+	/* Toshiba FnF1 */
+	if (event == 0x13b) {
+		uinput_event (KEY_EXIT); /* need KEY_LOCK */
+		return "Lock";
+	}
+	/* Toshiba FnF2 */
+	if (event == 0x13c) {
+		uinput_event (KEY_SEARCH);
+		return "Search";
+	}
+	/* Toshiba FnF3 */
+	if (event == 0x13d) {
+		uinput_event (KEY_SUSPEND);
+		return "Suspend";
+	}
+	/* Toshiba FnF4 */
+	if (event == 0x13e) {
+		uinput_event (KEY_SLEEP);
+		return "Hibernate";
+	}
+	/* Toshiba FnF6 */
+	if (event == 0x140) {
+		uinput_event (KEY_BRIGHTNESSDOWN);
+		return "BrightnessDown";
+	}
+	/* Toshiba FnF7 */
+	if (event == 0x141) {
+		uinput_event (KEY_BRIGHTNESSUP);
+		return "BrightnessUp";
+	}
+	return NULL;
+}
 
 static void
 main_loop (LibHalContext *ctx, FILE *eventfp)
@@ -127,8 +278,18 @@
 			} else if (strncmp (acpi_path, "battery", sizeof ("battery") - 1) == 0) {
 				dbg ("battery event");
 				libhal_device_rescan (ctx, udi, &error);
+			} else if (strncmp (acpi_path, "hkey", sizeof ("hkey") - 1) == 0) {
+				dbg ("hotkey event; acpi_name=%s, acpi_num1=%i, acpi_num2=%i", acpi_name, acpi_num1, acpi_num2);
+				/* we only do events when the button is pressed, not released */
+				if (acpi_num1 == 1) {
+					char *desc;
+					const char *uinput_udi = "/org/freedesktop/Hal/devices/acpi_uinput";
+					desc = do_hkey_event (acpi_num2);
+					if (desc)
+						libhal_device_emit_condition (ctx, 
+							uinput_udi, "ButtonPressed", desc, &error);
+				}
 			}
-
 		} else {
 			dbg ("cannot parse event");
 		}
@@ -156,6 +317,10 @@
 		return 1;
 	}
 
+#ifdef ACPI_UINPUT
+	uinput_open ();
+#endif
+
 	while (1)
 	{
 #ifdef ACPI_PROC
@@ -178,6 +343,10 @@
 		sleep (5);
 	}
 
+#ifdef ACPI_UINPUT
+	uinput_close ();
+#endif
+
 	return 1;
 }
 

--=-Tj2cVWEir2MwRtxqFBke--

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
