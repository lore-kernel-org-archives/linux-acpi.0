From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH v3 5/5] acpi/processor: Check for duplicate processor ids at hotplug time
Date: Fri, 3 Mar 2017 16:02:27 +0800
Message-ID: <1488528147-2279-6-git-send-email-douly.fnst@cn.fujitsu.com>
References: <1488528147-2279-1-git-send-email-douly.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:22579 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751323AbdCCIPJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Mar 2017 03:15:09 -0500
In-Reply-To: <1488528147-2279-1-git-send-email-douly.fnst@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com, rjw@rjwysocki.net, lenb@kernel.org, xiaolong.ye@intel.com, guzheng1@huawei.com, izumi.taku@jp.fujitsu.com
Cc: x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Dou Liyang <douly.fnst@cn.fujitsu.com>

The check for duplicate processor ids happens at boot time based on the
ACPI table contents, but the final sanity checks for a processor happen
at hotplug time.

At hotplug time, where the physical information is available, which might
differ from the ACPI table information, a check for duplicate processor
ids is missing.

Add it to the hotplug checks and rename the function so it better
reflects its purpose.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Tested-by: Xiaolong Ye <xiaolong.ye@intel.com>
---
 drivers/acpi/acpi_processor.c | 13 ++++++++++---
 include/linux/acpi.h          |  2 +-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 9a98d7e..3ce2e9e 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -280,6 +280,13 @@ static int acpi_processor_get_info(struct acpi_device *device)
 		pr->acpi_id = value;
 	}
 
+	if (acpi_duplicate_processor_id(pr->acpi_id)) {
+		dev_err(&device->dev,
+			"Failed to get unique processor _UID (0x%x)\n",
+			pr->acpi_id);
+		return -ENODEV;
+	}
+
 	pr->phys_id = acpi_get_phys_id(pr->handle, device_declaration,
 					pr->acpi_id);
 	if (invalid_phys_cpuid(pr->phys_id))
@@ -580,7 +587,7 @@ static struct acpi_scan_handler processor_container_handler = {
 static int nr_unique_ids __initdata;
 
 /* The number of the duplicate processor IDs */
-static int nr_duplicate_ids __initdata;
+static int nr_duplicate_ids;
 
 /* Used to store the unique processor IDs */
 static int unique_processor_ids[] __initdata = {
@@ -588,7 +595,7 @@ static int unique_processor_ids[] __initdata = {
 };
 
 /* Used to store the duplicate processor IDs */
-static int duplicate_processor_ids[] __initdata = {
+static int duplicate_processor_ids[] = {
 	[0 ... NR_CPUS - 1] = -1,
 };
 
@@ -679,7 +686,7 @@ void __init acpi_processor_check_duplicates(void)
 						NULL, NULL);
 }
 
-bool __init acpi_processor_validate_proc_id(int proc_id)
+bool acpi_duplicate_processor_id(int proc_id)
 {
 	int i;
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 63a7519..9b05886 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -287,7 +287,7 @@ static inline bool invalid_phys_cpuid(phys_cpuid_t phys_id)
 }
 
 /* Validate the processor object's proc_id */
-bool acpi_processor_validate_proc_id(int proc_id);
+bool acpi_duplicate_processor_id(int proc_id);
 
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
 /* Arch dependent functions for cpu hotplug support */
-- 
2.5.5



