From: Len Brown <len.brown@intel.com>
Subject: [PATCH 22/28] ACPI: fix section for CPU init functions
Date: Sat, 14 Oct 2006 04:06:03 -0400
Message-ID: <1160813198620-git-send-email-len.brown@intel.com>
References: <11608131691346-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:15632 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1752142AbWJNIDR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 14 Oct 2006 04:03:17 -0400
In-Reply-To: <11608131691346-git-send-email-len.brown@intel.com>
Message-Id: <7af8b66004fa827958b4871112e59a07db5b3f6b.1160812999.git.len.brown@intel.com>
In-Reply-To: <288f3ad406460f03642a41bb945826891a7b866f.1160812999.git.len.brown@intel.com>
References: <288f3ad406460f03642a41bb945826891a7b866f.1160812999.git.len.brown@intel.com>
Date: Tue, 10 Oct 2006 14:20:31 -0700
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Pierre Ossman <drzeus@drzeus.cx>, Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>

From: Pierre Ossman <drzeus@drzeus.cx>

The ACPI processor init functions should be marked as __cpuinit as they use
structures marked with __cpuinitdata.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_core.c |    2 +-
 drivers/acpi/processor_idle.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index b13d644..1908e0d 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -519,7 +519,7 @@ #endif
 
 static void *processor_device_array[NR_CPUS];
 
-static int acpi_processor_start(struct acpi_device *device)
+static int __cpuinit acpi_processor_start(struct acpi_device *device)
 {
 	int result = 0;
 	acpi_status status = AE_OK;
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 0a395fc..8537c42 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1105,7 +1105,7 @@ static struct notifier_block acpi_proces
 	.notifier_call = acpi_processor_latency_notify,
 };
 
-int acpi_processor_power_init(struct acpi_processor *pr,
+int __cpuinit acpi_processor_power_init(struct acpi_processor *pr,
 			      struct acpi_device *device)
 {
 	acpi_status status = 0;
-- 
1.4.3.rc2.g23bed-dirty
