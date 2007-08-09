From: Len Brown <len.brown@intel.com>
Subject: [PATCH 1/6] ACPI: thermal: "thermal.off=1" disables ACPI thermal support
Date: Thu,  9 Aug 2007 01:58:51 -0400
Message-ID: <11866391373567-git-send-email-len.brown@intel.com>
References: 11866388361593-git-send-email-len.brown@intel.com
 <11866391363162-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:23487 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755352AbXHIF66 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Aug 2007 01:58:58 -0400
In-Reply-To: <11866391363162-git-send-email-len.brown@intel.com>
Message-Id: <c405f58ecf5ebf0ba3752cb24a7cd0cc5075646d.1186638234.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

"thermal.off=1" disables all ACPI thermal support at boot time,
just as CONFIG_ACPI_THERMAL=n does at build time.

This bootparam is for users who run pre-compiled kernels, but
have some intractable issue with ACPI thermal control.

Note that on some systems, disabling ACPI thermal support
will cause the system to run hotter and reduce the
lifetime of the hardware.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/kernel-parameters.txt |    3 +++
 drivers/acpi/thermal.c              |    9 ++++++++-
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index efdb42f..464aea1 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1820,6 +1820,9 @@ and is between 256 and 4096 characters. It is defined in the file
 	thash_entries=	[KNL,NET]
 			Set number of hash buckets for TCP connection
 
+	thermal.off=	[HW,ACPI]
+			1: disable ACPI thermal control
+
 	time		Show timing data prefixed to each printk message line
 			[deprecated, see 'printk.time']
 
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 5a62de1..61337d9 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -78,6 +78,10 @@ static int tzp;
 module_param(tzp, int, 0);
 MODULE_PARM_DESC(tzp, "Thermal zone polling frequency, in 1/10 seconds.\n");
 
+static int off;
+module_param(off, int, 0);
+MODULE_PARM_DESC(off, "Set to disable ACPI thermal support.\n");
+
 static int acpi_thermal_add(struct acpi_device *device);
 static int acpi_thermal_remove(struct acpi_device *device, int type);
 static int acpi_thermal_resume(struct acpi_device *device);
@@ -1285,7 +1289,10 @@ static int __init acpi_thermal_init(void)
 {
 	int result = 0;
 
-
+	if (off) {
+		printk(KERN_NOTICE "ACPI: thermal control disabled\n");
+		return -ENODEV;
+	}
 	acpi_thermal_dir = proc_mkdir(ACPI_THERMAL_CLASS, acpi_root_dir);
 	if (!acpi_thermal_dir)
 		return -ENODEV;
-- 
1.5.3.rc4.29.g74276
