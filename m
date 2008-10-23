From: Len Brown <lenb@kernel.org>
Subject: [PATCH 073/122] ACPI: Add DMI check to disable power state check in
 power transition
Date: Thu, 23 Oct 2008 02:38:47 -0400
Message-ID: <6415e12ba0f92a54f02d9c4ecaa3c82f35f3d335.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:37959 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755230AbYJWGkK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:40:10 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9600KGNIIW3PW1@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:40:09 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Li Shaohua <shaohua.li@intel.com>, Andi Kleen <ak@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

Add the DMI check to disable power check in the course of device power
transistion.

http://bugzilla.kernel.org/show_bug.cgi?id=11000

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Li Shaohua <shaohua.li@intel.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
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

