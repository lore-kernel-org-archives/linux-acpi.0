From: Len Brown <lenb@kernel.org>
Subject: [PATCH 15/29] sony-laptop: fix bogus error message display on resume
Date: Thu, 23 Apr 2009 02:23:37 -0400
Message-ID: <9506d0d7e7d73b0d3f144023cbb28a9a329c59fa.1240467664.git.len.brown@intel.com>
References: <1240467831-32613-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:23372 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753728AbZDWGYE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Apr 2009 02:24:04 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KIJ00MN6J43PXR1@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Apr 2009 01:24:04 -0500 (CDT)
In-reply-to: <1240467831-32613-1-git-send-email-lenb@kernel.org>
In-reply-to: <50a4da890102a455e5cd3dd358c38650d07178d3.1240467664.git.len.brown@intel.com>
References: <50a4da890102a455e5cd3dd358c38650d07178d3.1240467664.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Mattia Dongili <malattia@linux.it>, Len Brown <len.brown@intel.com>

From: Mattia Dongili <malattia@linux.it>

sony_backlight_update_status returns 0 on success -1 on failure (i.e.: the
return value from acpi_callsetfunc. The return value in the resume path
was broken and thus always displaying a bogus warning about not being able
to restore the brightness level.

Signed-off-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/sony-laptop.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 3541ca0..d93cff6 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -1041,7 +1041,7 @@ static int sony_nc_resume(struct acpi_device *device)
 
 	/* set the last requested brightness level */
 	if (sony_backlight_device &&
-			!sony_backlight_update_status(sony_backlight_device))
+			sony_backlight_update_status(sony_backlight_device) < 0)
 		printk(KERN_WARNING DRV_PFX "unable to restore brightness level\n");
 
 	return 0;
-- 
1.6.0.6

