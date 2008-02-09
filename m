From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 4/5] sonypi - Move sonypi.txt to Documentation/laptops
Date: Sat, 09 Feb 2008 01:32:19 +0000
Message-ID: <20080209013219.4895.51729.stgit@pacifica>
References: <20080209013157.4895.70128.stgit@pacifica>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:57981 "EHLO
	pacifica" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755446AbYBIBct (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Feb 2008 20:32:49 -0500
In-Reply-To: <20080209013157.4895.70128.stgit@pacifica>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, Randy Dunlap <randy.dunlap@oracle.com>, Mattia Dongili <malattia@linux.it>, Len Brown <lenb@kernel.org>

Also update references to sonypi.txt in Kconfig.

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
CC: Randy Dunlap <randy.dunlap@oracle.com>
CC: Mattia Dongili <malattia@linux.it>
CC: Len Brown <lenb@kernel.org>
---

 Documentation/00-INDEX           |    2 -
 Documentation/laptops/00-INDEX   |    2 +
 Documentation/laptops/sonypi.txt |  152 ++++++++++++++++++++++++++++++=
++++++++
 Documentation/sonypi.txt         |  152 ------------------------------=
--------
 drivers/char/Kconfig             |    2 -
 5 files changed, 155 insertions(+), 155 deletions(-)
 create mode 100644 Documentation/laptops/sonypi.txt
 delete mode 100644 Documentation/sonypi.txt


diff --git a/Documentation/00-INDEX b/Documentation/00-INDEX
index 012ef98..8d55670 100644
--- a/Documentation/00-INDEX
+++ b/Documentation/00-INDEX
@@ -353,8 +353,6 @@ sh/
 	- directory with info on porting Linux to a new architecture.
 smart-config.txt
 	- description of the Smart Config makefile feature.
-sonypi.txt
-	- info on Linux Sony Programmable I/O Device support.
 sound/
 	- directory with info on sound card support.
 sparc/
diff --git a/Documentation/laptops/00-INDEX b/Documentation/laptops/00-=
INDEX
index c5bac77..dbe1759 100644
--- a/Documentation/laptops/00-INDEX
+++ b/Documentation/laptops/00-INDEX
@@ -2,5 +2,7 @@
 	- This file
 sony-laptop.txt
 	- Sony Notebook Control Driver (SNC) Readme.
+sonypi.txt
+	- info on Linux Sony Programmable I/O Device support.
 thinkpad-acpi.txt
 	- information on the (IBM and Lenovo) ThinkPad ACPI Extras driver.
diff --git a/Documentation/laptops/sonypi.txt b/Documentation/laptops/s=
onypi.txt
new file mode 100644
index 0000000..4857acf
--- /dev/null
+++ b/Documentation/laptops/sonypi.txt
@@ -0,0 +1,152 @@
+Sony Programmable I/O Control Device Driver Readme
+--------------------------------------------------
+	Copyright (C) 2001-2004 Stelian Pop <stelian@popies.net>
+	Copyright (C) 2001-2002 Alc=C3=B4ve <www.alcove.com>
+	Copyright (C) 2001 Michael Ashley <m.ashley@unsw.edu.au>
+	Copyright (C) 2001 Junichi Morita <jun1m@mars.dti.ne.jp>
+	Copyright (C) 2000 Takaya Kinjo <t-kinjo@tc4.so-net.ne.jp>
+	Copyright (C) 2000 Andrew Tridgell <tridge@samba.org>
+
+This driver enables access to the Sony Programmable I/O Control Device=
 which
+can be found in many Sony Vaio laptops. Some newer Sony laptops (seems=
 to be
+limited to new FX series laptops, at least the FX501 and the FX702) la=
ck a
+sonypi device and are not supported at all by this driver.
+
+It will give access (through a user space utility) to some events thos=
e laptops
+generate, like:
+	- jogdial events (the small wheel on the side of Vaios)
+	- capture button events (only on Vaio Picturebook series)
+	- Fn keys
+	- bluetooth button (only on C1VR model)
+	- programmable keys, back, help, zoom, thumbphrase buttons, etc.
+	  (when available)
+
+Those events (see linux/sonypi.h) can be polled using the character de=
vice node
+/dev/sonypi (major 10, minor auto allocated or specified as a option).
+A simple daemon which translates the jogdial movements into mouse whee=
l events
+can be downloaded at: <http://popies.net/sonypi/>
+
+Another option to intercept the events is to get them directly through=
 the
+input layer.
+
+This driver supports also some ioctl commands for setting the LCD scre=
en
+brightness and querying the batteries charge information (some more
+commands may be added in the future).
+
+This driver can also be used to set the camera controls on Picturebook=
 series
+(brightness, contrast etc), and is used by the video4linux driver for =
the
+Motion Eye camera.
+
+Please note that this driver was created by reverse engineering the Wi=
ndows
+driver and the ACPI BIOS, because Sony doesn't agree to release any pr=
ogramming
+specs for its laptops. If someone convinces them to do so, drop me a n=
ote.
+
+Driver options:
+---------------
+
+Several options can be passed to the sonypi driver using the standard
+module argument syntax (<param>=3D<value> when passing the option to t=
he
+module or sonypi.<param>=3D<value> on the kernel boot line when sonypi=
 is
+statically linked into the kernel). Those options are:
+
+	minor: 		minor number of the misc device /dev/sonypi,
+			default is -1 (automatic allocation, see /proc/misc
+			or kernel logs)
+
+	camera:		if you have a PictureBook series Vaio (with the
+			integrated MotionEye camera), set this parameter to 1
+			in order to let the driver access to the camera
+
+	fnkeyinit:	on some Vaios (C1VE, C1VR etc), the Fn key events don't
+			get enabled unless you set this parameter to 1.
+			Do not use this option unless it's actually necessary,
+			some Vaio models don't deal well with this option.
+			This option is available only if the kernel is
+			compiled without ACPI support (since it conflicts
+			with it and it shouldn't be required anyway if
+			ACPI is already enabled).
+
+	verbose:	set to 1 to print unknown events received from the
+			sonypi device.
+			set to 2 to print all events received from the
+			sonypi device.
+
+	compat:		uses some compatibility code for enabling the sonypi
+			events. If the driver worked for you in the past
+			(prior to version 1.5) and does not work anymore,
+			add this option and report to the author.
+
+	mask:		event mask telling the driver what events will be
+			reported to the user. This parameter is required for
+			some Vaio models where the hardware reuses values
+			used in other Vaio models (like the FX series who does
+			not have a jogdial but reuses the jogdial events for
+			programmable keys events). The default event mask is
+			set to 0xffffffff, meaning that all possible events
+			will be tried. You can use the following bits to
+			construct your own event mask (from
+			drivers/char/sonypi.h):
+				SONYPI_JOGGER_MASK 		0x0001
+				SONYPI_CAPTURE_MASK 		0x0002
+				SONYPI_FNKEY_MASK 		0x0004
+				SONYPI_BLUETOOTH_MASK 		0x0008
+				SONYPI_PKEY_MASK 		0x0010
+				SONYPI_BACK_MASK 		0x0020
+				SONYPI_HELP_MASK 		0x0040
+				SONYPI_LID_MASK 		0x0080
+				SONYPI_ZOOM_MASK 		0x0100
+				SONYPI_THUMBPHRASE_MASK 	0x0200
+				SONYPI_MEYE_MASK		0x0400
+				SONYPI_MEMORYSTICK_MASK		0x0800
+				SONYPI_BATTERY_MASK		0x1000
+				SONYPI_WIRELESS_MASK		0x2000
+
+	useinput:	if set (which is the default) two input devices are
+			created, one which interprets the jogdial events as
+			mouse events, the other one which acts like a
+			keyboard reporting the pressing of the special keys.
+
+Module use:
+-----------
+
+In order to automatically load the sonypi module on use, you can put t=
hose
+lines in your /etc/modprobe.conf file:
+
+	alias char-major-10-250 sonypi
+	options sonypi minor=3D250
+
+This supposes the use of minor 250 for the sonypi device:
+
+	# mknod /dev/sonypi c 10 250
+
+Bugs:
+-----
+
+	- several users reported that this driver disables the BIOS-managed
+	  Fn-keys which put the laptop in sleeping state, or switch the
+	  external monitor on/off. There is no workaround yet, since this
+	  driver disables all APM management for those keys, by enabling the
+	  ACPI management (and the ACPI core stuff is not complete yet). If
+	  you have one of those laptops with working Fn keys and want to
+	  continue to use them, don't use this driver.
+
+	- some users reported that the laptop speed is lower (dhrystone
+	  tested) when using the driver with the fnkeyinit parameter. I canno=
t
+	  reproduce it on my laptop and not all users have this problem.
+	  This happens because the fnkeyinit parameter enables the ACPI
+	  mode (but without additional ACPI control, like processor
+	  speed handling etc). Use ACPI instead of APM if it works on your
+	  laptop.
+
+	- sonypi lacks the ability to distinguish between certain key
+	  events on some models.
+
+	- some models with the nvidia card (geforce go 6200 tc) uses a
+	  different way to adjust the backlighting of the screen. There
+	  is a userspace utility to adjust the brightness on those models,
+	  which can be downloaded from
+	  http://www.acc.umu.se/~erikw/program/smartdimmer-0.1.tar.bz2
+
+	- since all development was done by reverse engineering, there is
+	  _absolutely no guarantee_ that this driver will not crash your
+	  laptop. Permanently.
diff --git a/Documentation/sonypi.txt b/Documentation/sonypi.txt
deleted file mode 100644
index 4857acf..0000000
--- a/Documentation/sonypi.txt
+++ /dev/null
@@ -1,152 +0,0 @@
-Sony Programmable I/O Control Device Driver Readme
---------------------------------------------------
-	Copyright (C) 2001-2004 Stelian Pop <stelian@popies.net>
-	Copyright (C) 2001-2002 Alc=C3=B4ve <www.alcove.com>
-	Copyright (C) 2001 Michael Ashley <m.ashley@unsw.edu.au>
-	Copyright (C) 2001 Junichi Morita <jun1m@mars.dti.ne.jp>
-	Copyright (C) 2000 Takaya Kinjo <t-kinjo@tc4.so-net.ne.jp>
-	Copyright (C) 2000 Andrew Tridgell <tridge@samba.org>
-
-This driver enables access to the Sony Programmable I/O Control Device=
 which
-can be found in many Sony Vaio laptops. Some newer Sony laptops (seems=
 to be
-limited to new FX series laptops, at least the FX501 and the FX702) la=
ck a
-sonypi device and are not supported at all by this driver.
-
-It will give access (through a user space utility) to some events thos=
e laptops
-generate, like:
-	- jogdial events (the small wheel on the side of Vaios)
-	- capture button events (only on Vaio Picturebook series)
-	- Fn keys
-	- bluetooth button (only on C1VR model)
-	- programmable keys, back, help, zoom, thumbphrase buttons, etc.
-	  (when available)
-
-Those events (see linux/sonypi.h) can be polled using the character de=
vice node
-/dev/sonypi (major 10, minor auto allocated or specified as a option).
-A simple daemon which translates the jogdial movements into mouse whee=
l events
-can be downloaded at: <http://popies.net/sonypi/>
-
-Another option to intercept the events is to get them directly through=
 the
-input layer.
-
-This driver supports also some ioctl commands for setting the LCD scre=
en
-brightness and querying the batteries charge information (some more
-commands may be added in the future).
-
-This driver can also be used to set the camera controls on Picturebook=
 series
-(brightness, contrast etc), and is used by the video4linux driver for =
the
-Motion Eye camera.
-
-Please note that this driver was created by reverse engineering the Wi=
ndows
-driver and the ACPI BIOS, because Sony doesn't agree to release any pr=
ogramming
-specs for its laptops. If someone convinces them to do so, drop me a n=
ote.
-
-Driver options:
----------------
-
-Several options can be passed to the sonypi driver using the standard
-module argument syntax (<param>=3D<value> when passing the option to t=
he
-module or sonypi.<param>=3D<value> on the kernel boot line when sonypi=
 is
-statically linked into the kernel). Those options are:
-
-	minor: 		minor number of the misc device /dev/sonypi,
-			default is -1 (automatic allocation, see /proc/misc
-			or kernel logs)
-
-	camera:		if you have a PictureBook series Vaio (with the
-			integrated MotionEye camera), set this parameter to 1
-			in order to let the driver access to the camera
-
-	fnkeyinit:	on some Vaios (C1VE, C1VR etc), the Fn key events don't
-			get enabled unless you set this parameter to 1.
-			Do not use this option unless it's actually necessary,
-			some Vaio models don't deal well with this option.
-			This option is available only if the kernel is
-			compiled without ACPI support (since it conflicts
-			with it and it shouldn't be required anyway if
-			ACPI is already enabled).
-
-	verbose:	set to 1 to print unknown events received from the
-			sonypi device.
-			set to 2 to print all events received from the
-			sonypi device.
-
-	compat:		uses some compatibility code for enabling the sonypi
-			events. If the driver worked for you in the past
-			(prior to version 1.5) and does not work anymore,
-			add this option and report to the author.
-
-	mask:		event mask telling the driver what events will be
-			reported to the user. This parameter is required for
-			some Vaio models where the hardware reuses values
-			used in other Vaio models (like the FX series who does
-			not have a jogdial but reuses the jogdial events for
-			programmable keys events). The default event mask is
-			set to 0xffffffff, meaning that all possible events
-			will be tried. You can use the following bits to
-			construct your own event mask (from
-			drivers/char/sonypi.h):
-				SONYPI_JOGGER_MASK 		0x0001
-				SONYPI_CAPTURE_MASK 		0x0002
-				SONYPI_FNKEY_MASK 		0x0004
-				SONYPI_BLUETOOTH_MASK 		0x0008
-				SONYPI_PKEY_MASK 		0x0010
-				SONYPI_BACK_MASK 		0x0020
-				SONYPI_HELP_MASK 		0x0040
-				SONYPI_LID_MASK 		0x0080
-				SONYPI_ZOOM_MASK 		0x0100
-				SONYPI_THUMBPHRASE_MASK 	0x0200
-				SONYPI_MEYE_MASK		0x0400
-				SONYPI_MEMORYSTICK_MASK		0x0800
-				SONYPI_BATTERY_MASK		0x1000
-				SONYPI_WIRELESS_MASK		0x2000
-
-	useinput:	if set (which is the default) two input devices are
-			created, one which interprets the jogdial events as
-			mouse events, the other one which acts like a
-			keyboard reporting the pressing of the special keys.
-
-Module use:
------------
-
-In order to automatically load the sonypi module on use, you can put t=
hose
-lines in your /etc/modprobe.conf file:
-
-	alias char-major-10-250 sonypi
-	options sonypi minor=3D250
-
-This supposes the use of minor 250 for the sonypi device:
-
-	# mknod /dev/sonypi c 10 250
-
-Bugs:
------
-
-	- several users reported that this driver disables the BIOS-managed
-	  Fn-keys which put the laptop in sleeping state, or switch the
-	  external monitor on/off. There is no workaround yet, since this
-	  driver disables all APM management for those keys, by enabling the
-	  ACPI management (and the ACPI core stuff is not complete yet). If
-	  you have one of those laptops with working Fn keys and want to
-	  continue to use them, don't use this driver.
-
-	- some users reported that the laptop speed is lower (dhrystone
-	  tested) when using the driver with the fnkeyinit parameter. I canno=
t
-	  reproduce it on my laptop and not all users have this problem.
-	  This happens because the fnkeyinit parameter enables the ACPI
-	  mode (but without additional ACPI control, like processor
-	  speed handling etc). Use ACPI instead of APM if it works on your
-	  laptop.
-
-	- sonypi lacks the ability to distinguish between certain key
-	  events on some models.
-
-	- some models with the nvidia card (geforce go 6200 tc) uses a
-	  different way to adjust the backlighting of the screen. There
-	  is a userspace utility to adjust the brightness on those models,
-	  which can be downloaded from
-	  http://www.acc.umu.se/~erikw/program/smartdimmer-0.1.tar.bz2
-
-	- since all development was done by reverse engineering, there is
-	  _absolutely no guarantee_ that this driver will not crash your
-	  laptop. Permanently.
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index f01ac9a..47c6be8 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -875,7 +875,7 @@ config SONYPI
 	  Device which can be found in many (all ?) Sony Vaio laptops.
=20
 	  If you have one of those laptops, read
-	  <file:Documentation/sonypi.txt>, and say Y or M here.
+	  <file:Documentation/laptops/sonypi.txt>, and say Y or M here.
=20
 	  To compile this driver as a module, choose M here: the
 	  module will be called sonypi.

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
