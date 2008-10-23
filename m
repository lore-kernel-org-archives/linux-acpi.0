From: Len Brown <lenb@kernel.org>
Subject: [PATCH 048/122] sony-laptop: newline-terminate the printk for
 backlight change failure
Date: Thu, 23 Oct 2008 02:38:22 -0400
Message-ID: <0ef9cff15d47b296d4a7feecf36e7989cebf9a33.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:37899 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754870AbYJWGkB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:40:01 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9600ES4IIOQ4G7@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:40:00 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Adam Jackson <ajax@redhat.com>, Len Brown <len.brown@intel.com>

From: Adam Jackson <ajax@redhat.com>

Signed-off-by: Adam Jackson <ajax@redhat.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/sony-laptop.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index 60775be..5a97d3a 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -970,7 +970,7 @@ static int sony_nc_resume(struct acpi_device *device)
 	/* set the last requested brightness level */
 	if (sony_backlight_device &&
 			!sony_backlight_update_status(sony_backlight_device))
-		printk(KERN_WARNING DRV_PFX "unable to restore brightness level");
+		printk(KERN_WARNING DRV_PFX "unable to restore brightness level\n");
 
 	/* re-initialize models with specific requirements */
 	dmi_check_system(sony_nc_ids);
-- 
1.5.5.1

