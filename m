From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 13/24] video/lcd: document sysfs interface
Date: Fri, 28 Aug 2009 14:56:44 +0200
Message-ID: <1251464215-6540-14-git-send-email-corentincj@iksaif.net>
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
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp22.services.sfr.fr ([93.17.128.12]:61358 "EHLO
	smtp22.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbZH1NDm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Aug 2009 09:03:42 -0400
Received: from smtp22.services.sfr.fr (msfrf2206 [10.18.26.20])
	by msfrf2210.sfr.fr (SMTP Server) with ESMTP id 6B2597002561
	for <linux-acpi@vger.kernel.org>; Fri, 28 Aug 2009 15:03:43 +0200 (CEST)
In-Reply-To: <1251464215-6540-13-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, alan-jenkins@tuffmail.co.uk, Corentin Chary <corentincj@iksaif.net>, Richard Purdie <rpurdie@rpsys.net>

Date and KernelVersion may be wrong because the lcd
interface was introduced before git initial import.

Cc: Richard Purdie <rpurdie@rpsys.net>
Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 Documentation/ABI/testing/sysfs-class-lcd |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-lcd

diff --git a/Documentation/ABI/testing/sysfs-class-lcd b/Documentation/ABI/testing/sysfs-class-lcd
new file mode 100644
index 0000000..35906bf
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-lcd
@@ -0,0 +1,23 @@
+What:		/sys/class/lcd/<lcd>/lcd_power
+Date:		April 2005
+KernelVersion:	2.6.12
+Contact:	Richard Purdie <rpurdie@rpsys.net>
+Description:
+		Control LCD power, values are FB_BLANK_* from fb.h
+		 - FB_BLANK_UNBLANK (0)   : power on.
+		 - FB_BLANK_POWERDOWN (4) : power off
+
+What:		/sys/class/lcd/<lcd>/contrast
+Date:		April 2005
+KernelVersion:	2.6.12
+Contact:	Richard Purdie <rpurdie@rpsys.net>
+Description:
+		Current contrast of this LCD device. Value is between 0 and
+		/sys/class/lcd/<lcd>/max_contrast.
+
+What:		/sys/class/lcd/<lcd>/max_contrast
+Date:		April 2005
+KernelVersion:	2.6.12
+Contact:	Richard Purdie <rpurdie@rpsys.net>
+Description:
+		Maximum contrast for this LCD device.
-- 
1.6.4


