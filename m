From: Len Brown <len.brown@intel.com>
Subject: [PATCH 02/12] sony-laptop: restore the last user requested brightness level on resume.
Date: Fri,  3 Aug 2007 18:33:35 -0400
Message-ID: <11861804262966-git-send-email-len.brown@intel.com>
References: <11861804251625-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:12458 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763672AbXHCWds (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 3 Aug 2007 18:33:48 -0400
In-Reply-To: <11861804251625-git-send-email-len.brown@intel.com>
Message-Id: <e84a02ba0b33a97a8486f3248fd45f50b1a1c014.1186180370.git.len.brown@intel.com>
In-Reply-To: <67effe8fff32f60bdf51cba484766ba6003005bb.1186180370.git.len.brown@intel.com>
References: <67effe8fff32f60bdf51cba484766ba6003005bb.1186180370.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Mattia Dongili <malattia@linux.it>, Len Brown <len.brown@intel.com>

From: Mattia Dongili <malattia@linux.it>

Signed-off-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/sony-laptop.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index 14ee06c..9a803e1 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -942,6 +942,11 @@ static int sony_nc_resume(struct acpi_device *device)
 		}
 	}
 
+	/* set the last requested brightness level */
+	if (sony_backlight_device &&
+			!sony_backlight_update_status(sony_backlight_device))
+		printk(KERN_WARNING DRV_PFX "unable to restore brightness level");
+
 	/* re-initialize models with specific requirements */
 	dmi_check_system(sony_nc_ids);
 
-- 
1.5.3.rc3.7.gd58e
