From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 11/24] eeepc-laptop: document sysfs interface
Date: Fri, 28 Aug 2009 14:56:42 +0200
Message-ID: <1251464215-6540-12-git-send-email-corentincj@iksaif.net>
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
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp22.services.sfr.fr ([93.17.128.12]:61314 "EHLO
	smtp22.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107AbZH1NDl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Aug 2009 09:03:41 -0400
Received: from smtp22.services.sfr.fr (msfrf2206 [10.18.26.20])
	by msfrf2210.sfr.fr (SMTP Server) with ESMTP id 1A187700252D
	for <linux-acpi@vger.kernel.org>; Fri, 28 Aug 2009 15:03:43 +0200 (CEST)
In-Reply-To: <1251464215-6540-11-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, alan-jenkins@tuffmail.co.uk, Corentin Chary <corentincj@iksaif.net>

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 .../ABI/testing/sysfs-platform-eeepc-laptop        |   50 ++++++++++++++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-eeepc-laptop

diff --git a/Documentation/ABI/testing/sysfs-platform-eeepc-laptop b/Documentation/ABI/testing/sysfs-platform-eeepc-laptop
new file mode 100644
index 0000000..7445dfb
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-eeepc-laptop
@@ -0,0 +1,50 @@
+What:		/sys/devices/platform/eeepc-laptop/disp
+Date:		May 2008
+KernelVersion:	2.6.26
+Contact:	"Corentin Chary" <corentincj@iksaif.net>
+Description:
+		This file allows display switching.
+		- 1 = LCD
+		- 2 = CRT
+		- 3 = LCD+CRT
+		If you run X11, you should use xrandr instead.
+
+What:		/sys/devices/platform/eeepc-laptop/camera
+Date:		May 2008
+KernelVersion:	2.6.26
+Contact:	"Corentin Chary" <corentincj@iksaif.net>
+Description:
+		Control the camera. 1 means on, 0 means off.
+
+What:		/sys/devices/platform/eeepc-laptop/cardr
+Date:		May 2008
+KernelVersion:	2.6.26
+Contact:	"Corentin Chary" <corentincj@iksaif.net>
+Description:
+		Control the card reader. 1 means on, 0 means off.
+
+What:		/sys/devices/platform/eeepc-laptop/cpufv
+Date:		Jun 2009
+KernelVersion:	2.6.31
+Contact:	"Corentin Chary" <corentincj@iksaif.net>
+Description:
+		Change CPU clock configuration.
+		On the Eee PC 1000H there are three available clock configuration:
+		    * 0 -> Super Performance Mode
+		    * 1 -> High Performance Mode
+		    * 2 -> Power Saving Mode
+		On Eee PC 701 there is only 2 available clock configurations.
+		Available configuration are listed in available_cpufv file.
+		Reading this file will show the raw hexadecimal value which
+		is defined as follow:
+		| 8 bit | 8 bit |
+		    |       `---- Current mode
+		    `------------ Availables modes
+		For example, 0x301 means: mode 1 selected, 3 available modes.
+
+What:		/sys/devices/platform/eeepc-laptop/available_cpufv
+Date:		Jun 2009
+KernelVersion:	2.6.31
+Contact:	"Corentin Chary" <corentincj@iksaif.net>
+Description:
+		List available cpufv modes.
-- 
1.6.4


