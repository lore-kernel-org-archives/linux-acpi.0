From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 1/9] ACPI cm_sbs: Debug interface used for error message cleanup
Date: Wed, 30 Jul 2008 22:22:14 +0200
Message-ID: <1217449342-20312-2-git-send-email-trenn@suse.de>
References: <1217449342-20312-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:48270 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756302AbYG3UWY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Jul 2008 16:22:24 -0400
In-Reply-To: <1217449342-20312-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ak@linux.intel.com
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, robert.moore@intel.com, Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 drivers/acpi/cm_sbs.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/cm_sbs.c b/drivers/acpi/cm_sbs.c
index f9db4f4..58dc367 100644
--- a/drivers/acpi/cm_sbs.c
+++ b/drivers/acpi/cm_sbs.c
@@ -52,8 +52,7 @@ struct proc_dir_entry *acpi_lock_ac_dir(void)
 	if (acpi_ac_dir) {
 		lock_ac_dir_cnt++;
 	} else {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Cannot create %s\n", ACPI_AC_CLASS));
+		printk(KERN_ERR "Cannot create %s\n", ACPI_AC_CLASS);
 	}
 	mutex_unlock(&cm_sbs_mutex);
 	return acpi_ac_dir;
@@ -83,8 +82,7 @@ struct proc_dir_entry *acpi_lock_battery_dir(void)
 	if (acpi_battery_dir) {
 		lock_battery_dir_cnt++;
 	} else {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Cannot create %s\n", ACPI_BATTERY_CLASS));
+		printk(KERN_ERR "Cannot create %s\n", ACPI_BATTERY_CLASS);
 	}
 	mutex_unlock(&cm_sbs_mutex);
 	return acpi_battery_dir;
-- 
1.5.4.5

