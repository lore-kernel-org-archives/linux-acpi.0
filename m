From: Zhang Rui <rui.zhang@intel.com>
Subject: [linux-next] [PATCH V2 2/4] ACPI: introduce new mechanism to
	save/restore ACPI NVS memory
Date: Fri, 11 Jul 2008 13:29:10 +0800
Message-ID: <1215754150.1617.59.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:8908 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754803AbYGKFaB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Jul 2008 01:30:01 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@suse.cz>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Andi Kleen <andi@firstfloor.org>, Ingo Molnar <mingo@elte.hu>

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
 drivers/acpi/sleep/main.c |  126 +++++++++++++++++++++++++++++++++++++=
++++++---
 include/linux/acpi.h      |    3 +
 2 files changed, 122 insertions(+), 7 deletions(-)

Index: linux-next/drivers/acpi/sleep/main.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-next.orig/drivers/acpi/sleep/main.c	2008-07-11 08:47:33.00000=
0000 +0800
+++ linux-next/drivers/acpi/sleep/main.c	2008-07-11 09:06:12.000000000 =
+0800
@@ -15,6 +15,7 @@
 #include <linux/dmi.h>
 #include <linux/device.h>
 #include <linux/suspend.h>
+#include <linux/highmem.h>
=20
 #include <asm/io.h>
=20
@@ -283,10 +284,105 @@
 #endif /* CONFIG_SUSPEND */
=20
 #ifdef CONFIG_HIBERNATION
+
+/* ACPI NVS memory need to be saved/stored during hibernation */
+struct nvs_page {
+	unsigned long pfn;
+	void *data;
+	struct list_head node;
+};
+static LIST_HEAD(nvs_pages_list);
+
+int acpi_mark_nvs_region(unsigned long start, unsigned long end)
+{
+	struct nvs_page *pos, *next;
+
+	while (start <=3D end) {
+		pos =3D kzalloc(sizeof(struct nvs_page), GFP_KERNEL);
+		if (!pos)
+			goto err;
+		pos->pfn =3D start;
+		start++;
+		list_add_tail(&pos->node, &nvs_pages_list);
+	}
+	return 0;
+
+err:
+	list_for_each_entry_safe(pos, next, &nvs_pages_list, node) {
+		list_del(&pos->node);
+		kfree(pos);
+	}
+	return -ENOMEM;
+}
+
+static void acpi_free_nvs_pages(void)
+{
+	struct nvs_page *pos;
+
+	list_for_each_entry(pos, &nvs_pages_list, node) {
+		if (!pos->data)
+			break;
+		free_page((long)pos->data);
+		pos->data =3D NULL;
+	}
+}
+
+static int acpi_allocate_nvs_pages(void)
+{
+	struct nvs_page *pos;
+
+	list_for_each_entry(pos, &nvs_pages_list, node) {
+		pos->data =3D (void *)__get_free_page(GFP_KERNEL);
+		if (!pos->data) {
+			acpi_free_nvs_pages();
+			return -ENOMEM;
+		}
+	}
+	return 0;
+}
+
+static void acpi_save_nvs_memory(void)
+{
+	void *kaddr;
+	struct nvs_page *pos;
+
+	pr_debug("ACPI: Saving ACPI NVS memory\n");
+	list_for_each_entry(pos, &nvs_pages_list, node) {
+		/* nvs page might not have a 'struct page' */
+		kaddr =3D kmap_atomic_pfn(pos->pfn, KM_USER0);
+		copy_page(pos->data, kaddr);
+		kunmap_atomic(kaddr, KM_USER0);
+	}
+	return;
+}
+
+static void acpi_restore_nvs_memory(void)
+{
+	void *kaddr;
+	struct nvs_page *pos;
+
+	pr_debug("ACPI: Restoring ACPI NVS memory\n");
+	list_for_each_entry(pos, &nvs_pages_list, node) {
+		kaddr =3D kmap_atomic_pfn(pos->pfn, KM_USER0);
+		copy_page(kaddr, pos->data);
+		kunmap_atomic(kaddr, KM_USER0);
+	}
+}
+
 static int acpi_hibernation_begin(void)
 {
 	acpi_target_sleep_state =3D ACPI_STATE_S4;
-	return 0;
+
+	/* allocate pages for ACPI NVS memory before swsusp_shrink_memory */
+	return acpi_allocate_nvs_pages();
+}
+
+static int acpi_hibernation_pre_snapshot(void)
+{
+	int result =3D acpi_pm_prepare();
+
+	acpi_save_nvs_memory();
+	return result;
 }
=20
 static int acpi_hibernation_enter(void)
@@ -307,6 +403,12 @@
 	return ACPI_SUCCESS(status) ? 0 : -EFAULT;
 }
=20
+static void acpi_hibernation_end(void)
+{
+	acpi_free_nvs_pages();
+	acpi_pm_end();
+}
+
 static void acpi_hibernation_leave(void)
 {
 	/*
@@ -316,6 +418,7 @@
 	acpi_enable();
 	/* Reprogram control registers and execute _BFS */
 	acpi_leave_sleep_state_prep(ACPI_STATE_S4);
+	acpi_restore_nvs_memory();
 }
=20
 static void acpi_pm_enable_gpes(void)
@@ -325,8 +428,8 @@
=20
 static struct platform_hibernation_ops acpi_hibernation_ops =3D {
 	.begin =3D acpi_hibernation_begin,
-	.end =3D acpi_pm_end,
-	.pre_snapshot =3D acpi_pm_prepare,
+	.end =3D acpi_hibernation_end,
+	.pre_snapshot =3D acpi_hibernation_pre_snapshot,
 	.finish =3D acpi_pm_finish,
 	.prepare =3D acpi_pm_prepare,
 	.enter =3D acpi_hibernation_enter,
@@ -345,19 +448,28 @@
 {
 	int error =3D acpi_sleep_prepare(ACPI_STATE_S4);
=20
-	if (!error)
-		acpi_target_sleep_state =3D ACPI_STATE_S4;
+	if (!error) {
+		error =3D acpi_allocate_nvs_pages();
+		if (!error)
+			acpi_target_sleep_state =3D ACPI_STATE_S4;
+	}
 	return error;
 }
=20
+static int acpi_hibernation_pre_snapshot_old(void)
+{
+	acpi_save_nvs_memory();
+	return acpi_pm_disable_gpes();
+}
+
 /*
  * The following callbacks are used if the pre-ACPI 2.0 suspend orderi=
ng has
  * been requested.
  */
 static struct platform_hibernation_ops acpi_hibernation_ops_old =3D {
 	.begin =3D acpi_hibernation_begin_old,
-	.end =3D acpi_pm_end,
-	.pre_snapshot =3D acpi_pm_disable_gpes,
+	.end =3D acpi_hibernation_end,
+	.pre_snapshot =3D acpi_hibernation_pre_snapshot_old,
 	.finish =3D acpi_pm_finish,
 	.prepare =3D acpi_pm_disable_gpes,
 	.enter =3D acpi_hibernation_enter,
Index: linux-next/include/linux/acpi.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-next.orig/include/linux/acpi.h	2008-07-11 08:47:33.000000000 =
+0800
+++ linux-next/include/linux/acpi.h	2008-07-11 08:47:45.000000000 +0800
@@ -107,6 +107,9 @@
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
