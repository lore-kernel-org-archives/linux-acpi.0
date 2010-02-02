From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 02/28] asus-laptop: set the right paths in the documentation
Date: Tue,  2 Feb 2010 08:38:45 +0100
Message-ID: <1265096351-15239-3-git-send-email-corentincj@iksaif.net>
References: <1265096351-15239-1-git-send-email-corentincj@iksaif.net>
 <1265096351-15239-2-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:51573 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755370Ab0BBHjQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Feb 2010 02:39:16 -0500
In-Reply-To: <1265096351-15239-2-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Corentin Chary <corentincj@iksaif.net>

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 .../ABI/testing/sysfs-platform-asus-laptop         |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-platform-asus-laptop b/Documentation/ABI/testing/sysfs-platform-asus-laptop
index a1cb660..1d77539 100644
--- a/Documentation/ABI/testing/sysfs-platform-asus-laptop
+++ b/Documentation/ABI/testing/sysfs-platform-asus-laptop
@@ -1,4 +1,4 @@
-What:		/sys/devices/platform/asus-laptop/display
+What:		/sys/devices/platform/asus_laptop/display
 Date:		January 2007
 KernelVersion:	2.6.20
 Contact:	"Corentin Chary" <corentincj@iksaif.net>
@@ -13,7 +13,7 @@ Description:
 		Ex: - 0 (0000b) means no display
 		    - 3 (0011b) CRT+LCD.
 
-What:		/sys/devices/platform/asus-laptop/gps
+What:		/sys/devices/platform/asus_laptop/gps
 Date:		January 2007
 KernelVersion:	2.6.20
 Contact:	"Corentin Chary" <corentincj@iksaif.net>
@@ -21,7 +21,7 @@ Description:
 		Control the gps device. 1 means on, 0 means off.
 Users:		Lapsus
 
-What:		/sys/devices/platform/asus-laptop/ledd
+What:		/sys/devices/platform/asus_laptop/ledd
 Date:		January 2007
 KernelVersion:	2.6.20
 Contact:	"Corentin Chary" <corentincj@iksaif.net>
@@ -29,11 +29,11 @@ Description:
 		Some models like the W1N have a LED display that can be
 		used to display several informations.
 		To control the LED display, use the following :
-		    echo 0x0T000DDD > /sys/devices/platform/asus-laptop/
+		    echo 0x0T000DDD > /sys/devices/platform/asus_laptop/
 		where T control the 3 letters display, and DDD the 3 digits display.
 		The DDD table can be found in Documentation/laptops/asus-laptop.txt
 
-What:		/sys/devices/platform/asus-laptop/bluetooth
+What:		/sys/devices/platform/asus_laptop/bluetooth
 Date:		January 2007
 KernelVersion:	2.6.20
 Contact:	"Corentin Chary" <corentincj@iksaif.net>
@@ -42,7 +42,7 @@ Description:
 		This may control the led, the device or both.
 Users:		Lapsus
 
-What:		/sys/devices/platform/asus-laptop/wlan
+What:		/sys/devices/platform/asus_laptop/wlan
 Date:		January 2007
 KernelVersion:	2.6.20
 Contact:	"Corentin Chary" <corentincj@iksaif.net>
-- 
1.6.6.1

