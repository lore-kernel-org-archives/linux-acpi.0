From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH v2 4/4] acpi: Move the verification of duplicate proc_id from booting time to hot-plug time
Date: Mon, 20 Feb 2017 16:47:51 +0800
Message-ID: <1487580471-17665-5-git-send-email-douly.fnst@cn.fujitsu.com>
References: <1487580471-17665-1-git-send-email-douly.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1487580471-17665-1-git-send-email-douly.fnst@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@kernel.org, tglx@linutronix.de, peterz@infradead.org, rjw@rjwysocki.net, hpa@zytor.com, rafael@kernel.org, cl@linux.com, tj@kernel.org, akpm@linux-foundation.org, rafael.j.wysocki@intel.com, len.brown@intel.com, izumi.taku@jp.fujitsu.com, xiaolong.ye@intel.com
Cc: x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Dou Liyang <douly.fnst@cn.fujitsu.com>
List-Id: linux-acpi@vger.kernel.org

After we revert the the mapping of "cpuid <-> nodeid" fixed at the
booting time. and do it at the hot-plug time. we should also do the
verification of duplicate proc_id at the time.

The patch rename the verfication function and move it to
drivers/acpi::acpi_processor_get_info.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
 drivers/acpi/acpi_processor.c | 13 ++++++++++---
 include/linux/acpi.h          |  2 +-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index eb500e1..2483383 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -280,6 +280,13 @@ static int acpi_processor_get_info(struct acpi_device *device)
 		pr->acpi_id = value;
 	}
 
+	if(duplicate_processor_id(pr->acpi_id)) {
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
 
@@ -672,7 +679,7 @@ void __init acpi_processor_check_duplicates(void)
 						NULL, NULL);
 }
 
-bool __init acpi_processor_validate_proc_id(int proc_id)
+bool duplicate_processor_id(int proc_id)
 {
 	int i;
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index d180cbd..b692a70 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -287,7 +287,7 @@ static inline bool invalid_phys_cpuid(phys_cpuid_t phys_id)
 }
 
 /* Validate the processor object's proc_id */
-bool acpi_processor_validate_proc_id(int proc_id);
+bool duplicate_processor_id(int proc_id);
 
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
 /* Arch dependent functions for cpu hotplug support */
-- 
2.5.5
