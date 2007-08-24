From: Len Brown <len.brown@intel.com>
Subject: [PATCH 04/25] ACPI: thermal: set "thermal.nocrt" via DMI on Gigabyte GA-7ZX
Date: Fri, 24 Aug 2007 03:20:51 -0400
Message-ID: <11879400794174-git-send-email-len.brown@intel.com>
References: <11879400723077-git-send-email-len.brown@intel.com>
 <11879400762710-git-send-email-len.brown@intel.com>
 <11879400782033-git-send-email-len.brown@intel.com>
 <11879400793131-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:56620 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762667AbXHXHVV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Aug 2007 03:21:21 -0400
In-Reply-To: <11879400793131-git-send-email-len.brown@intel.com>
Message-Id: <8c99fdce30787b0d1fc00b907d4cd55a714e4cdd.1187939442.git.len.brown@intel.com>
In-Reply-To: <3c1d36da1d5ed36979340efd233ddaacc45b0a02.1187939442.git.len.brown@intel.com>
References: <3c1d36da1d5ed36979340efd233ddaacc45b0a02.1187939442.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

This system BIOS sets a critical temperature to 65C,
which is too low.

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=155496

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/thermal.c |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 4c420fe..39479b0 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -89,7 +89,7 @@ MODULE_PARM_DESC(tzp, "Thermal zone polling frequency, in 1/10 seconds.");
 
 static int nocrt;
 module_param(nocrt, int, 0);
-MODULE_PARM_DESC(nocrt, "Set to disable action on ACPI thermal zone critical and hot trips.");
+MODULE_PARM_DESC(nocrt, "Set to take no action upon ACPI thermal zone critical trips points.");
 
 static int off;
 module_param(off, int, 0);
@@ -1357,6 +1357,13 @@ static int thermal_act(struct dmi_system_id *d) {
 	}
 	return 0;
 }
+static int thermal_nocrt(struct dmi_system_id *d) {
+
+	printk(KERN_NOTICE "ACPI: %s detected: "
+		"disabling all critical thermal trip point actions.\n", d->ident);
+	nocrt = 1;
+	return 0;
+}
 static int thermal_tzp(struct dmi_system_id *d) {
 
 	if (tzp == 0) {
@@ -1405,6 +1412,14 @@ static struct dmi_system_id thermal_dmi_table[] __initdata = {
 		DMI_MATCH(DMI_BOARD_NAME, "i915GMm-HFS"),
 		},
 	},
+	{
+	 .callback = thermal_nocrt,
+	 .ident = "Gigabyte GA-7ZX",
+	 .matches = {
+		DMI_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co., Ltd."),
+		DMI_MATCH(DMI_BOARD_NAME, "7ZX"),
+		},
+	},
 	{}
 };
 #endif /* CONFIG_DMI */
-- 
1.5.3.rc6.17.g1911
