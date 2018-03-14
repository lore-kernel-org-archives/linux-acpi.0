From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [RFC PATCH] ACPI / processor: Get accurate possible CPU count
Date: Wed, 14 Mar 2018 18:28:47 +0800
Message-ID: <20180314102847.30459-1-douly.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, tglx@linutronix.de, rafael@kernel.org, dedekind1@gmail.com, ming.lei@redhat.com, Dou Liyang <douly.fnst@cn.fujitsu.com>
List-Id: linux-acpi@vger.kernel.org

Rafael J told me in order for the ACPI-based physical CPU hotplug to work,
there have to be objects in the ACPI namespace corresponding to all of the
processors in question. If they are not present, there is no way to signal
insertion and eject the processors safely.

But, Kernel calculates the possible CPU count from the number of Local APIC
entries in ACPI MADT. It doesn't consider with the ACPI namespace and
reports unrealistically high numbers.

Depth-first search the namespace tree, check and collect the correct CPUs
and update the possible map

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
 drivers/acpi/acpi_processor.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 449d86d39965..ca4fa95e0515 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -671,6 +671,23 @@ static acpi_status __init acpi_processor_ids_walk(acpi_handle handle,
 
 }
 
+static void __init acpi_update_possible_map(void)
+{
+	unsigned int cpu, nr = 0;
+
+	if (nr_cpu_ids <= nr_unique_ids)
+		return;
+
+	for_each_possible_cpu(cpu) {
+		if (nr >= nr_unique_ids)
+			set_cpu_possible(cpu, false);
+		nr++;
+	}
+
+	nr_cpu_ids = nr_unique_ids;
+	pr_info("Allowing %d possible CPUs\n", nr_cpu_ids);
+}
+
 static void __init acpi_processor_check_duplicates(void)
 {
 	/* check the correctness for all processors in ACPI namespace */
@@ -680,6 +697,9 @@ static void __init acpi_processor_check_duplicates(void)
 						NULL, NULL, NULL);
 	acpi_get_devices(ACPI_PROCESSOR_DEVICE_HID, acpi_processor_ids_walk,
 						NULL, NULL);
+
+	/* make possible CPU count more realistic */
+	acpi_update_possible_map();
 }
 
 bool acpi_duplicate_processor_id(int proc_id)
-- 
2.14.3
