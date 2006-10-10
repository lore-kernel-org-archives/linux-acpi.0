From: akpm@osdl.org
Subject: [patch 01/12] acpi: fix section for CPU init functions
Date: Tue, 10 Oct 2006 14:20:31 -0700
Message-ID: <200610102120.k9ALKVwM024266@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:1685 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030425AbWJJVV6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Oct 2006 17:21:58 -0400
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
@@ -1130,7 +1130,7 @@ static struct notifier_block acpi_proces
 	.notifier_call = acpi_processor_latency_notify,
 };
 
-int acpi_processor_power_init(struct acpi_processor *pr,
+int __cpuinit acpi_processor_power_init(struct acpi_processor *pr,
 			      struct acpi_device *device)
 {
 	acpi_status status = 0;
_
