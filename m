From: Len Brown <lenb@kernel.org>
Subject: [PATCH 73/85] ACPI cm_sbs: Debug interface used for error message
 cleanup
Date: Sat, 11 Oct 2008 02:36:33 -0400
Message-ID: <d66064cea3b00545964811a1f3d9772d1a11cae0.1223706853.git.len.brown@intel.com>
References: <1223707005-26864-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:39166 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753813AbYJKGhQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Oct 2008 02:37:16 -0400
In-reply-to: <1223707005-26864-1-git-send-email-lenb@kernel.org>
In-reply-to: <1d80ebdb81444701024ad9b9f026516561496a43.1223706853.git.len.brown@intel.com>
References: <1d80ebdb81444701024ad9b9f026516561496a43.1223706853.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Andi Kleen <ak@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.5.5.1

