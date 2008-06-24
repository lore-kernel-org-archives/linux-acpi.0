From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC] [PATCH 1/3] ACPI: save/restore ACPI NVS memory during
	hibernation
Date: Tue, 24 Jun 2008 15:43:03 +0800
Message-ID: <1214293383.3001.108.camel@rzhang-dt.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:50858 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750766AbYFXHmY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Jun 2008 03:42:24 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-power-mgmt <linux-power-mgmt@linux.intel.com>, linux-acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "Zhang, Rui" <rui.zhang@intel.com>, "Li, Shaohua" <shaohua.li@intel.com>

According to the ACPI spec, ACPI NVS memory region is required to be
saved/restored by OS during hibernation.

Section 15.3.2 ACPI Spec 3.0b,
"OSPM will call the _PTS control method some time before entering a sle=
eping state,
to allow the platform=E2=80=99s AML code to update this memory image be=
fore entering the
sleeping state. After the system awakes from an S4 state, OSPM will res=
tore this memory
area and call the _WAK control method to enable the BIOS to reclaim its=
 memory image."

Add the mechanism to save/restore ACPI NVS memory during hibernation.

Note: now Linux save ACPI NVS memory in acpi_hibernation_pre_snapshot, =
and restore it in
	acpi_hibernation_leave. Both of these functions will be invoked only o=
nce during
	the hibernate and resume.
Note: in Section 14.3 ACPI spec 3.0b, I only get
	"EfiACPIMemoryNVS: The OS and loader must preserve this memory range i=
n
	the working and ACPI S1=E2=80=93S3 states."
	whether we should save/restore this piece of memory is not cleared.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/sleep/main.c |  122 +++++++++++++++++++++++++++++++++++++=
++++++++-
 include/linux/acpi.h      |    3 +
 2 files changed, 124 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/sleep/main.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/acpi/sleep/main.c	2008-06-20 09:27:00.000000=
000 +0800
+++ linux-2.6/drivers/acpi/sleep/main.c	2008-06-24 14:51:20.000000000 +=
0800
@@ -15,6 +15,7 @@
 #include <linux/dmi.h>
 #include <linux/device.h>
 #include <linux/suspend.h>
+#include <linux/highmem.h>
=20
 #include <asm/io.h>
=20
@@ -255,6 +256,109 @@
 #endif /* CONFIG_SUSPEND */
=20
 #ifdef CONFIG_HIBERNATION
+
+/* ACPI NVS memory need to be saved/stored during hibernation */
+struct nvs_page {
+	unsigned long pfn;
+	void *data;
+	struct nvs_page *next;
+};
+static struct nvs_page *nvs_pages;
+
+int acpi_mark_nvs_region(unsigned long start, unsigned long end)
+{
+	struct nvs_page *tmp;
+
+	while (start <=3D end) {
+		tmp =3D kzalloc(sizeof(struct nvs_page), GFP_KERNEL);
+		if (!tmp)
+			return -ENOMEM;
+		tmp->pfn =3D start;
+		tmp->next =3D nvs_pages;
+		start++;
+		nvs_pages =3D tmp;
+	}
+	return 0;
+}
+
+static int acpi_hibernation_allocate_nvs_pages(void)
+{
+	struct nvs_page *tmp =3D nvs_pages;
+
+	while (tmp) {
+		tmp->data =3D (void *)__get_free_page(GFP_KERNEL);
+		if (!tmp->data)
+			return -ENOMEM;
+		tmp =3D tmp->next;
+	}
+	return 0;
+}
+
+static int acpi_hibernation_free_nvs_pages(void)
+{
+	struct nvs_page *tmp =3D nvs_pages;
+
+	while (tmp) {
+		if (tmp->data) {
+			free_page((long)tmp->data);
+			tmp->data =3D NULL;
+		}
+		tmp =3D tmp->next;
+	}
+	return 0;
+}
+
+static int
+acpi_hibernation_notifier_cb(struct notifier_block *nb,
+			unsigned long val, void *data)
+{
+	int result =3D 0;
+
+	switch (val) {
+	case PM_HIBERNATION_PREPARE:
+		result =3D acpi_hibernation_allocate_nvs_pages();
+		break;
+	case PM_POST_RESTORE: /* Failed */
+	case PM_POST_HIBERNATION:
+		acpi_hibernation_free_nvs_pages();
+	}
+	return result;
+}
+
+struct notifier_block acpi_hibernation_nb =3D {
+	.notifier_call =3D acpi_hibernation_notifier_cb,
+};
+
+static void acpi_save_nvs_memory(void)
+{
+	void *kaddr;
+	struct nvs_page *tmp =3D nvs_pages;
+
+	pr_debug("ACPI: Saving ACPI NVS memory\n");
+	while (tmp) {
+		/* nvs page might not have a 'struct page' */
+		kaddr =3D kmap_atomic_pfn(tmp->pfn, KM_USER0);
+		copy_page(tmp->data, kaddr);
+		kunmap_atomic(kaddr, KM_USER0);
+		tmp =3D tmp->next;
+	}
+	return;
+}
+
+static void acpi_restore_nvs_memory(void)
+{
+	void *kaddr;
+	struct nvs_page *tmp =3D nvs_pages;
+
+	pr_debug("ACPI: Restoring ACPI NVS memory\n");
+	while (tmp) {
+		kaddr =3D kmap_atomic_pfn(tmp->pfn, KM_USER0);
+		copy_page(kaddr, tmp->data);
+		kunmap_atomic(kaddr, KM_USER0);
+		tmp =3D tmp->next;
+	}
+}
+
 static int acpi_hibernation_begin(void)
 {
 	acpi_target_sleep_state =3D ACPI_STATE_S4;
@@ -274,6 +378,20 @@
 	return ACPI_SUCCESS(acpi_hw_disable_all_gpes()) ? 0 : -EFAULT;
 }
=20
+static int acpi_hibernation_pre_snapshot(void)
+{
+	int error =3D acpi_sleep_prepare(ACPI_STATE_S4);
+
+	if (error) {
+		acpi_target_sleep_state =3D ACPI_STATE_S0;
+		return error;
+	}
+
+	acpi_save_nvs_memory();
+
+	return ACPI_SUCCESS(acpi_hw_disable_all_gpes()) ? 0 : -EFAULT;
+}
+
 static int acpi_hibernation_enter(void)
 {
 	acpi_status status =3D AE_OK;
@@ -301,6 +419,7 @@
 	acpi_enable();
 	/* Reprogram control registers and execute _BFS */
 	acpi_leave_sleep_state_prep(ACPI_STATE_S4);
+	acpi_restore_nvs_memory();
 }
=20
 static void acpi_hibernation_finish(void)
@@ -340,7 +459,7 @@
 static struct platform_hibernation_ops acpi_hibernation_ops =3D {
 	.begin =3D acpi_hibernation_begin,
 	.end =3D acpi_hibernation_end,
-	.pre_snapshot =3D acpi_hibernation_prepare,
+	.pre_snapshot =3D acpi_hibernation_pre_snapshot,
 	.finish =3D acpi_hibernation_finish,
 	.prepare =3D acpi_hibernation_prepare,
 	.enter =3D acpi_hibernation_enter,
@@ -498,6 +617,7 @@
 #ifdef CONFIG_HIBERNATION
 	status =3D acpi_get_sleep_type_data(ACPI_STATE_S4, &type_a, &type_b);
 	if (ACPI_SUCCESS(status)) {
+		register_pm_notifier(&acpi_hibernation_nb);
 		hibernation_set_ops(&acpi_hibernation_ops);
 		sleep_states[ACPI_STATE_S4] =3D 1;
 		printk(" S4");
Index: linux-2.6/include/linux/acpi.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/include/linux/acpi.h	2008-06-20 09:27:00.000000000 +=
0800
+++ linux-2.6/include/linux/acpi.h	2008-06-24 11:11:03.000000000 +0800
@@ -106,6 +106,9 @@
 void acpi_numa_arch_fixup(void);
 #endif
=20
+#ifdef CONFIG_HIBERNATION
+int acpi_mark_nvs_region(unsigned long, unsigned long);
+#endif
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
 /* Arch dependent functions for cpu hotplug support */
 int acpi_map_lsapic(acpi_handle handle, int *pcpu);


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
