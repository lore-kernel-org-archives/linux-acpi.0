From: akpm@osdl.org
Subject: [patch 01/10] acpi: fix section for CPU init functions
Date: Mon, 25 Sep 2006 16:28:06 -0700
Message-ID: <200609252328.k8PNS6DF002167@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:3245 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751665AbWIYX2Z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Sep 2006 19:28:25 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, drzeus@drzeus.cx

From: Pierre Ossman <drzeus@drzeus.cx>

The ACPI processor init functions should be marked as __cpuinit as they use
structures marked with __cpuinitdata.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/processor_core.c |    2 +-
 drivers/acpi/processor_idle.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/acpi/processor_core.c~acpi-fix-section-for-cpu-init-functions drivers/acpi/processor_core.c
--- a/drivers/acpi/processor_core.c~acpi-fix-section-for-cpu-init-functions
+++ a/drivers/acpi/processor_core.c
@@ -519,7 +519,7 @@ static int acpi_processor_get_info(struc
 
 static void *processor_device_array[NR_CPUS];
 
-static int acpi_processor_start(struct acpi_device *device)
+static int __cpuinit acpi_processor_start(struct acpi_device *device)
 {
 	int result = 0;
 	acpi_status status = AE_OK;
diff -puN drivers/acpi/processor_idle.c~acpi-fix-section-for-cpu-init-functions drivers/acpi/processor_idle.c
--- a/drivers/acpi/processor_idle.c~acpi-fix-section-for-cpu-init-functions
+++ a/drivers/acpi/processor_idle.c
@@ -1077,7 +1077,7 @@ static const struct file_operations acpi
 	.release = single_release,
 };
 
-int acpi_processor_power_init(struct acpi_processor *pr,
+int __cpuinit acpi_processor_power_init(struct acpi_processor *pr,
 			      struct acpi_device *device)
 {
 	acpi_status status = 0;
_
