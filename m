From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 12/24] video/backlight: document sysfs interface
Date: Fri, 28 Aug 2009 14:56:43 +0200
Message-ID: <1251464215-6540-13-git-send-email-corentincj@iksaif.net>
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
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp22.services.sfr.fr ([93.17.128.12]:61345 "EHLO
	smtp22.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbZH1NDm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Aug 2009 09:03:42 -0400
Received: from smtp22.services.sfr.fr (msfrf2206 [10.18.26.20])
	by msfrf2210.sfr.fr (SMTP Server) with ESMTP id 1EB4B7002538
	for <linux-acpi@vger.kernel.org>; Fri, 28 Aug 2009 15:03:43 +0200 (CEST)
In-Reply-To: <1251464215-6540-12-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, alan-jenkins@tuffmail.co.uk, Corentin Chary <corentincj@iksaif.net>

Date and KernelVersion may be wrong because the backlight
interface was introduced before git initial import.

Cc:Richard Purdie <rpurdie@rpsys.net>
Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 Documentation/ABI/stable/sysfs-class-backlight |   36 ++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-class-backlight

diff --git a/Documentation/ABI/stable/sysfs-class-backlight b/Documentation/ABI/stable/sysfs-class-backlight
new file mode 100644
index 0000000..4d637e1
--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-class-backlight
@@ -0,0 +1,36 @@
+What:		/sys/class/backlight/<backlight>/bl_power
+Date:		April 2005
+KernelVersion:	2.6.12
+Contact:	Richard Purdie <rpurdie@rpsys.net>
+Description:
+		Control BACKLIGHT power, values are FB_BLANK_* from fb.h
+		 - FB_BLANK_UNBLANK (0)   : power on.
+		 - FB_BLANK_POWERDOWN (4) : power off
+Users:		HAL
+
+What:		/sys/class/backlight/<backlight>/brightness
+Date:		April 2005
+KernelVersion:	2.6.12
+Contact:	Richard Purdie <rpurdie@rpsys.net>
+Description:
+		Control the brightness for this <backlight>. Values
+		are between 0 and max_brightness. This file will also
+		show the brightness level stored in the driver, which
+		may not be the actual brightness (see actual_brightness).
+Users:		HAL
+
+What:		/sys/class/backlight/<backlight>/actual_brightness
+Date:		March 2006
+KernelVersion:	2.6.17
+Contact:	Richard Purdie <rpurdie@rpsys.net>
+Description:
+		Show the actual brightness by querying the hardware.
+Users:		HAL
+
+What:		/sys/class/backlight/<backlight>/max_brightness
+Date:		April 2005
+KernelVersion:	2.6.12
+Contact:	Richard Purdie <rpurdie@rpsys.net>
+Description:
+		Maximum brightness for <backlight>.
+Users:		HAL
-- 
1.6.4


