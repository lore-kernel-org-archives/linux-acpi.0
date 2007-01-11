From: Len Brown <len.brown@intel.com>
Subject: [PATCH 4/7] ACPI: delete two spurious ACPI messages
Date: Thu, 11 Jan 2007 04:11:45 -0500
Message-ID: <11685067121393-git-send-email-len.brown@intel.com>
References: <11685067081383-git-send-email-len.brown@intel.com> <11685067091916-git-send-email-len.brown@intel.com> <11685067101245-git-send-email-len.brown@intel.com> <11685067113037-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:13149 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030245AbXAKJLy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Jan 2007 04:11:54 -0500
In-Reply-To: <11685067113037-git-send-email-len.brown@intel.com>
Message-Id: <d6637b28ffb38f207015c990e481fde5bba233d7.1168506584.git.len.brown@intel.com>
In-Reply-To: <3948ec9406f9a60a43d63f23f6f5284db6529b9c.1168506584.git.len.brown@intel.com>
References: <3948ec9406f9a60a43d63f23f6f5284db6529b9c.1168506584.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, Len Brown <len.brown@intel.com>

From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

ACPI: Getting cpuindex for acpiid 0x4

acpi_processor-0742 [00] processor_preregister_: Error while parsing _PSD domain information. Assuming no coordination

http://bugzilla.kernel.org/show_bug.cgi?id=7286

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_core.c    |    3 ---
 drivers/acpi/processor_perflib.c |    4 ----
 2 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 25718fe..5f9496d 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -476,9 +476,6 @@ static int acpi_processor_get_info(struct acpi_processor *pr)
 	if (cpu_index == -1) {
 		if (ACPI_FAILURE
 		    (acpi_processor_hotadd_init(pr->handle, &pr->id))) {
-			printk(KERN_ERR PREFIX
-				    "Getting cpuindex for acpiid 0x%x\n",
-				    pr->acpi_id);
 			return -ENODEV;
 		}
 	}
diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 0e60382..5207f9e 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -736,10 +736,6 @@ int acpi_processor_preregister_performance(
 	}
 
 err_ret:
-	if (retval) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error while parsing _PSD domain information. Assuming no coordination\n"));
-	}
-
 	for_each_possible_cpu(i) {
 		pr = processors[i];
 		if (!pr || !pr->performance)
-- 
1.4.4.4.ge05d
