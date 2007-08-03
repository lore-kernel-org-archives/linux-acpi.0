From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 1/3] sony-laptop: restore the last user requested brightness level on resume.
Date: Sat,  4 Aug 2007 00:22:30 +0900
Message-ID: <1186154552588-git-send-email-malattia@linux.it>
References: <118615455219-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi13.ns.itscom.net ([219.110.2.183]:60996 "EHLO
	mtoichi13.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760833AbXHCPWw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Aug 2007 11:22:52 -0400
In-Reply-To: <118615455219-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>, Mattia Dongili <malattia@linux.it>

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/misc/sony-laptop.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index 303e48c..a1be82e 100644
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
1.5.2.4

