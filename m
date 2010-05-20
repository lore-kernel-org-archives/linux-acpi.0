From: Len Brown <lenb@kernel.org>
Subject: [PATCH 22/22] ACPI: fix early DSDT dmi check warnings on ia64
Date: Thu, 20 May 2010 01:18:50 -0400
Message-ID: <cce4f632db200aef147c59084437168174b23f11.1274332658.git.len.brown@intel.com>
References: <1274332730-27370-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:36044 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752345Ab0ETGPb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 May 2010 02:15:31 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L2P007GDG0X9AM5@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 20 May 2010 01:14:58 -0500 (CDT)
In-reply-to: <1274332730-27370-1-git-send-email-lenb@kernel.org>
In-reply-to: <4cdf1a562bfb5852954aadbe8515557b8acc8168.1274332657.git.len.brown@intel.com>
References: <4cdf1a562bfb5852954aadbe8515557b8acc8168.1274332657.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

WARNING: at drivers/firmware/dmi_scan.c:423 dmi_matches+0x70/0x160()
dmi check: not initialized yet.

This is caused by commit aa2110c
(ACPI: add boot option acpi=copy_dsdt to fix corrupt DSDT).
DMI is not initialized yet in acpi_early_init on ia64.

The DSDT DMI check table is x86 specific, so make it empty on other archs.
And this fixes the warnings on ia64.

Reported-and-tested-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bus.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 49af19b..e1bfe71 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -69,6 +69,7 @@ static struct dmi_system_id __cpuinitdata power_nocheck_dmi_table[] = {
 };
 
 
+#ifdef CONFIG_X86
 static int set_copy_dsdt(const struct dmi_system_id *id)
 {
 	printk(KERN_NOTICE "%s detected - "
@@ -97,8 +98,14 @@ static struct dmi_system_id dsdt_dmi_table[] __initdata = {
 		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Satellite L505D"),
 		},
-	}
+	},
+	{}
 };
+#else
+static struct dmi_system_id dsdt_dmi_table[] __initdata = {
+	{}
+};
+#endif
 
 /* --------------------------------------------------------------------------
                                 Device Management
-- 
1.6.0.6

