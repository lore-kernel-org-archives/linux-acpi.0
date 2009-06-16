From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 06/15] acpi4asus: update MAINTAINER and KConfig links
Date: Tue, 16 Jun 2009 21:28:47 +0200
Message-ID: <1245180536-28009-7-git-send-email-corentincj@iksaif.net>
References: <1245180536-28009-1-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-2-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-3-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-4-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-5-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-6-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:60975 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754076AbZFPTbZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Jun 2009 15:31:25 -0400
In-Reply-To: <1245180536-28009-6-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Corentin Chary <corentincj@iksaif.net>

The bug tracker have moved from sourceforge to
http://dev.iksaif.net . The homepage of the project
is now http://acpi4asus.sf.net with links to the new
bug tracker. No change for the mailing list.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 MAINTAINERS                  |    8 +++-----
 drivers/platform/x86/Kconfig |   11 +++++++----
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 41c6605..7d2cc15 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -874,8 +874,7 @@ M:	corentincj@iksaif.net
 P:	Karol Kozimor
 M:	sziwan@users.sourceforge.net
 L:	acpi4asus-user@lists.sourceforge.net
-W:	http://sourceforge.net/projects/acpi4asus
-W:	http://xf.iksaif.net/acpi4asus
+W:	http://acpi4asus.sf.net
 S:	Maintained
 F:	arch/x86/kernel/acpi/boot.c
 F:	drivers/platform/x86/asus_acpi.c
@@ -891,8 +890,7 @@ ASUS LAPTOP EXTRAS DRIVER
 P:	Corentin Chary
 M:	corentincj@iksaif.net
 L:	acpi4asus-user@lists.sourceforge.net
-W:	http://sourceforge.net/projects/acpi4asus
-W:	http://xf.iksaif.net/acpi4asus
+W:	http://acpi4asus.sf.net
 S:	Maintained
 F:	drivers/platform/x86/asus-laptop.c
 
@@ -2049,7 +2047,7 @@ EEEPC LAPTOP EXTRAS DRIVER
 P:	Corentin Chary
 M:	corentincj@iksaif.net
 L:	acpi4asus-user@lists.sourceforge.net
-W:	http://sourceforge.net/projects/acpi4asus
+W:	http://acpi4asus.sf.net
 S:	Maintained
 F:	drivers/platform/x86/eeepc-laptop.c
 
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 284ebac..a5386b2 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -45,12 +45,12 @@ config ASUS_LAPTOP
 	---help---
 	  This is the new Linux driver for Asus laptops. It may also support some
 	  MEDION, JVC or VICTOR laptops. It makes all the extra buttons generate
-	  standard ACPI events that go through /proc/acpi/events. It also adds
+	  standard ACPI events and input events. It also adds
 	  support for video output switching, LCD backlight control, Bluetooth and
 	  Wlan control, and most importantly, allows you to blink those fancy LEDs.
 
 	  For more information and a userspace daemon for handling the extra
-	  buttons see <http://acpi4asus.sf.net/>.
+	  buttons see <http://acpi4asus.sf.net>.
 
 	  If you have an ACPI-compatible ASUS laptop, say Y or M here.
 
@@ -343,7 +343,10 @@ config EEEPC_LAPTOP
 	select RFKILL
 	---help---
 	  This driver supports the Fn-Fx keys on Eee PC laptops.
-	  It also adds the ability to switch camera/wlan on/off.
+
+	  It  also gives access to some extra laptop functionalities like
+	  Bluetooth, backlight and allows powering on/off some other
+	  devices.
 
 	  If you have an Eee PC laptop, say Y or M here.
 
@@ -391,7 +394,7 @@ config ACPI_ASUS
 	  parameters.
 
 	  More information and a userspace daemon for handling the extra buttons
-	  at <http://sourceforge.net/projects/acpi4asus/>.
+	  at <http://acpi4asus.sf.net>.
 
 	  If you have an ACPI-compatible ASUS laptop, say Y or M here. This
 	  driver is still under development, so if your laptop is unsupported or
-- 
1.6.3.1

