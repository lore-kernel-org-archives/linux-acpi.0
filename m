From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 24/24] asus-laptop: document sysfs interface
Date: Fri, 28 Aug 2009 14:56:55 +0200
Message-ID: <1251464215-6540-25-git-send-email-corentincj@iksaif.net>
References: <1251464215-6540-1-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-2-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-3-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-4-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-5-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-6-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-7-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-8-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-9-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-10-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-11-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-12-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-13-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-14-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-15-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-16-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-17-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-18-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-19-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-20-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-21-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-22-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-23-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-24-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp22.services.sfr.fr ([93.17.128.11]:60915 "EHLO
	smtp22.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090AbZH1NDl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Aug 2009 09:03:41 -0400
In-Reply-To: <1251464215-6540-24-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, alan-jenkins@tuffmail.co.uk, Corentin Chary <corentincj@iksaif.net>

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 .../ABI/testing/sysfs-platform-asus-laptop         |   52 ++++++++++++++++++++
 1 files changed, 52 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-asus-laptop

diff --git a/Documentation/ABI/testing/sysfs-platform-asus-laptop b/Documentation/ABI/testing/sysfs-platform-asus-laptop
new file mode 100644
index 0000000..a1cb660
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-asus-laptop
@@ -0,0 +1,52 @@
+What:		/sys/devices/platform/asus-laptop/display
+Date:		January 2007
+KernelVersion:	2.6.20
+Contact:	"Corentin Chary" <corentincj@iksaif.net>
+Description:
+		This file allows display switching. The value
+		is composed by 4 bits and defined as follow:
+		4321
+		|||`- LCD
+		||`-- CRT
+		|`--- TV
+		`---- DVI
+		Ex: - 0 (0000b) means no display
+		    - 3 (0011b) CRT+LCD.
+
+What:		/sys/devices/platform/asus-laptop/gps
+Date:		January 2007
+KernelVersion:	2.6.20
+Contact:	"Corentin Chary" <corentincj@iksaif.net>
+Description:
+		Control the gps device. 1 means on, 0 means off.
+Users:		Lapsus
+
+What:		/sys/devices/platform/asus-laptop/ledd
+Date:		January 2007
+KernelVersion:	2.6.20
+Contact:	"Corentin Chary" <corentincj@iksaif.net>
+Description:
+		Some models like the W1N have a LED display that can be
+		used to display several informations.
+		To control the LED display, use the following :
+		    echo 0x0T000DDD > /sys/devices/platform/asus-laptop/
+		where T control the 3 letters display, and DDD the 3 digits display.
+		The DDD table can be found in Documentation/laptops/asus-laptop.txt
+
+What:		/sys/devices/platform/asus-laptop/bluetooth
+Date:		January 2007
+KernelVersion:	2.6.20
+Contact:	"Corentin Chary" <corentincj@iksaif.net>
+Description:
+		Control the bluetooth device. 1 means on, 0 means off.
+		This may control the led, the device or both.
+Users:		Lapsus
+
+What:		/sys/devices/platform/asus-laptop/wlan
+Date:		January 2007
+KernelVersion:	2.6.20
+Contact:	"Corentin Chary" <corentincj@iksaif.net>
+Description:
+		Control the bluetooth device. 1 means on, 0 means off.
+		This may control the led, the device or both.
+Users:		Lapsus
-- 
1.6.4


