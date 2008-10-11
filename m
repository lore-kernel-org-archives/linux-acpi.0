From: Len Brown <lenb@kernel.org>
Subject: [PATCH 06/85] ACPI: Add DMI check to disable power state check in
 power transition
Date: Sat, 11 Oct 2008 02:35:26 -0400
Message-ID: <2f76f1bd9b3ed0992b987d0b3a9b60ee698467d4.1223706853.git.len.brown@intel.com>
References: <1223707005-26864-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:40791 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029AbYJKGg6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Oct 2008 02:36:58 -0400
In-reply-to: <1223707005-26864-1-git-send-email-lenb@kernel.org>
In-reply-to: <1d80ebdb81444701024ad9b9f026516561496a43.1223706853.git.len.brown@intel.com>
References: <1d80ebdb81444701024ad9b9f026516561496a43.1223706853.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Li Shaohua <shaohua.li@intel.com>, Andi Kleen <ak@linux.intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

Add the DMI check to disable power check in the course of device power
transistion.

http://bugzilla.kernel.org/show_bug.cgi?id=11000

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Li Shaohua <shaohua.li@intel.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 drivers/acpi/bus.c |   23 ++++++++++++++++++++++-
 1 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 91bdeb3..945cd2f 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -48,6 +48,23 @@ EXPORT_SYMBOL(acpi_root_dir);
 
 #define STRUCT_TO_INT(s)	(*((int*)&s))
 
+static int set_power_nocheck(const struct dmi_system_id *id)
+{
+	printk(KERN_NOTICE PREFIX "%s detected - "
+		"disable power check in power transistion\n", id->ident);
+	acpi_power_nocheck = 1;
+	return 0;
+}
+static struct dmi_system_id __cpuinitdata power_nocheck_dmi_table[] = {
+	{
+	set_power_nocheck, "HP Pavilion 05", {
+	DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+	DMI_MATCH(DMI_SYS_VENDOR, "HP Pavilion 05"),
+	DMI_MATCH(DMI_PRODUCT_VERSION, "2001211RE101GLEND") }, NULL},
+	{},
+};
+
+
 /* --------------------------------------------------------------------------
                                 Device Management
    -------------------------------------------------------------------------- */
@@ -830,7 +847,11 @@ static int __init acpi_init(void)
 		}
 	} else
 		disable_acpi();
-
+	/*
+	 * If the laptop falls into the DMI check table, the power state check
+	 * will be disabled in the course of device power transistion.
+	 */
+	dmi_check_system(power_nocheck_dmi_table);
 	return result;
 }
 
-- 
1.5.5.1

