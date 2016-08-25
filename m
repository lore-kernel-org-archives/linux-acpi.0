From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH v12 7/7] acpi: Provide the interface to validate the proc_id
Date: Thu, 25 Aug 2016 16:35:20 +0800
Message-ID: <1472114120-3281-8-git-send-email-douly.fnst@cn.fujitsu.com>
References: <1472114120-3281-1-git-send-email-douly.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1472114120-3281-1-git-send-email-douly.fnst@cn.fujitsu.com>
Sender: owner-linux-mm@kvack.org
To: cl@linux.com, tj@kernel.org, mika.j.penttila@gmail.com, mingo@redhat.com, akpm@linux-foundation.org, rjw@rjwysocki.net, hpa@zytor.com, yasu.isimatu@gmail.com, isimatu.yasuaki@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, gongzhaogang@inspur.com, len.brown@intel.com, lenb@kernel.org, tglx@linutronix.de, chen.tang@easystack.cn, rafael@kernel.org
Cc: x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Dou Liyang <douly.fnst@cn.fujitsu.com>
List-Id: linux-acpi@vger.kernel.org

When we want to identify whether the proc_id is unreasonable or not, we
can call the "acpi_processor_validate_proc_id" function. It will search
in the duplicate IDs. If we find the proc_id in the IDs, we return true
to the call function. Conversely, the false represents available.

When we establish all possible cpuid <-> nodeid mapping to handle the
cpu hotplugs, we will use the proc_id from ACPI table.

We do validation when we get the proc_id. If the result is true, we
will stop the mapping.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
 drivers/acpi/acpi_processor.c | 16 ++++++++++++++++
 drivers/acpi/processor_core.c |  4 ++++
 include/linux/acpi.h          |  3 +++
 3 files changed, 23 insertions(+)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 346fbfc..ae6dae9 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -659,6 +659,22 @@ static void acpi_processor_duplication_valiate(void)
 						NULL, NULL, NULL);
 }
 
+bool acpi_processor_validate_proc_id(int proc_id)
+{
+	int i;
+
+	/*
+	 * compare the proc_id with duplicate IDs, if the proc_id is already
+	 * in the duplicate IDs, return true, otherwise, return false.
+	 */
+	for (i = 0; i < nr_duplicate_ids; i++) {
+		if (duplicate_processor_ids[i] == proc_id)
+			return true;
+	}
+
+	return false;
+}
+
 void __init acpi_processor_init(void)
 {
 	acpi_processor_duplication_valiate();
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 7827c71..bf72097 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -301,6 +301,10 @@ static bool map_processor(acpi_handle handle, phys_cpuid_t *phys_id, int *cpuid)
 		if (ACPI_FAILURE(status))
 			return false;
 		acpi_id = object.processor.proc_id;
+
+		/* validate the acpi_id */
+		if(acpi_processor_validate_proc_id(acpi_id))
+			return false;
 		break;
 	case ACPI_TYPE_DEVICE:
 		status = acpi_evaluate_integer(handle, "_UID", NULL, &tmp);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index ea67776..929ff8f 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -267,6 +267,9 @@ static inline bool invalid_phys_cpuid(phys_cpuid_t phys_id)
 	return phys_id == PHYS_CPUID_INVALID;
 }
 
+/* Validate the processor object's proc_id */
+bool acpi_processor_validate_proc_id(int proc_id);
+
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
 /* Arch dependent functions for cpu hotplug support */
 int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, int *pcpu);
-- 
2.5.5



--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
