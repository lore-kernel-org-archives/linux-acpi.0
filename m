From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/4] ACPI hibernate: Add a mechanism to save/restore ACPI NVS memory (rev. 2)
Date: Thu, 23 Oct 2008 07:47:35 +0200
Message-ID: <200810230747.36119.rjw@sisk.pl>
References: <200810222249.20629.rjw@sisk.pl> <200810230108.45101.rjw@sisk.pl> <1224725825.15620.1.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:35761 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752554AbYJWFnL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 01:43:11 -0400
In-Reply-To: <1224725825.15620.1.camel@nigel-laptop>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>

On Thursday, 23 of October 2008, Nigel Cunningham wrote:
> Hi.

Hi,

> On Thu, 2008-10-23 at 01:08 +0200, Rafael J. Wysocki wrote:
> > On Thursday, 23 of October 2008, Nigel Cunningham wrote:
> > > On Wed, 2008-10-22 at 22:52 +0200, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rjw@sisk.pl>
[--snip--]
> > > > +/**
> > > > + *	hibernate_nvs_save - save NVS memory regions
> > > > + */
> > > > +void hibernate_nvs_save(void)
> > > > +{
> > > > +	struct nvs_page *entry;
> > > > +
> > > > +	printk(KERN_INFO "PM: Saving platform NVS memory\n");
> > > > +
> > > > +	list_for_each_entry(entry, &nvs_list, node)
> > > > +		if (entry->data) {
> > > > +			entry->kaddr =3D ioremap(entry->phys_start, entry->size);
> > > > +			memcpy(entry->data, entry->kaddr, entry->size);
> > >=20
> > > Why not unmap here? (I know you're delaying the unmap until the f=
ree,
> > > but it's probably clearer to map and unmap each time the memory i=
s
> > > accessed (ie in restore too).
> >=20
> > Ah, this one is tricky.  We cannot unmap from atomic context. :-)
>=20
> Maybe a comment then, lest someone get the same idea in future and be=
 as
> ignorant as me? :)

Well, I was considering to add one, now changed the kerneldoc comment t=
o
mention that.

Please find updated patch below.

---
=46rom: Rafael J. Wysocki <rjw@sisk.pl>

ACPI hibernate: Add a mechanism to save/restore ACPI NVS memory (rev. 2=
)

According to the ACPI Specification 3.0b, Section 15.3.2,
"OSPM will call the _PTS control method some time before entering a
sleeping state, to allow the platform=E2=80=99s AML code to update this
memory image before entering the sleeping state. After the system
awakes from an S4 state, OSPM will restore this memory area and call
the _WAK control method to enable the BIOS to reclaim its memory
image."  For this reason, implement a mechanism allowing us to save
the NVS memory during hibernation and to restore it during the
subsequent resume.

Based on a patch by Zhang Rui.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Nigel Cunningham <nigel@tuxonice.net>
Cc: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/sleep/main.c |   50 +++++++++++++++---
 include/linux/suspend.h   |   13 ++++
 kernel/power/swsusp.c     |  124 +++++++++++++++++++++++++++++++++++++=
+++++++++
 3 files changed, 180 insertions(+), 7 deletions(-)

Index: linux-2.6/drivers/acpi/sleep/main.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/acpi/sleep/main.c
+++ linux-2.6/drivers/acpi/sleep/main.c
@@ -321,8 +321,23 @@ void __init acpi_no_s4_hw_signature(void
=20
 static int acpi_hibernation_begin(void)
 {
-	acpi_target_sleep_state =3D ACPI_STATE_S4;
-	return 0;
+	int error;
+
+	error =3D hibernate_nvs_alloc();
+	if (!error)
+		acpi_target_sleep_state =3D ACPI_STATE_S4;
+
+	return error;
+}
+
+static int acpi_hibernation_pre_snapshot(void)
+{
+	int error =3D acpi_pm_prepare();
+
+	if (!error)
+		hibernate_nvs_save();
+
+	return error;
 }
=20
 static int acpi_hibernation_enter(void)
@@ -343,6 +358,12 @@ static int acpi_hibernation_enter(void)
 	return ACPI_SUCCESS(status) ? 0 : -EFAULT;
 }
=20
+static void acpi_hibernation_finish(void)
+{
+	hibernate_nvs_free();
+	acpi_pm_finish();
+}
+
 static void acpi_hibernation_leave(void)
 {
 	/*
@@ -358,6 +379,8 @@ static void acpi_hibernation_leave(void)
 			"cannot resume!\n");
 		panic("ACPI S4 hardware signature mismatch");
 	}
+	/* Restore the NVS memory area */
+	hibernate_nvs_restore();
 }
=20
 static void acpi_pm_enable_gpes(void)
@@ -368,8 +391,8 @@ static void acpi_pm_enable_gpes(void)
 static struct platform_hibernation_ops acpi_hibernation_ops =3D {
 	.begin =3D acpi_hibernation_begin,
 	.end =3D acpi_pm_end,
-	.pre_snapshot =3D acpi_pm_prepare,
-	.finish =3D acpi_pm_finish,
+	.pre_snapshot =3D acpi_hibernation_pre_snapshot,
+	.finish =3D acpi_hibernation_finish,
 	.prepare =3D acpi_pm_prepare,
 	.enter =3D acpi_hibernation_enter,
 	.leave =3D acpi_hibernation_leave,
@@ -387,8 +410,21 @@ static int acpi_hibernation_begin_old(vo
 {
 	int error =3D acpi_sleep_prepare(ACPI_STATE_S4);
=20
+	if (!error) {
+		error =3D hibernate_nvs_alloc();
+		if (!error)
+			acpi_target_sleep_state =3D ACPI_STATE_S4;
+	}
+	return error;
+}
+
+static int acpi_hibernation_pre_snapshot_old(void)
+{
+	int error =3D acpi_pm_disable_gpes();
+
 	if (!error)
-		acpi_target_sleep_state =3D ACPI_STATE_S4;
+		hibernate_nvs_save();
+
 	return error;
 }
=20
@@ -399,8 +435,8 @@ static int acpi_hibernation_begin_old(vo
 static struct platform_hibernation_ops acpi_hibernation_ops_old =3D {
 	.begin =3D acpi_hibernation_begin_old,
 	.end =3D acpi_pm_end,
-	.pre_snapshot =3D acpi_pm_disable_gpes,
-	.finish =3D acpi_pm_finish,
+	.pre_snapshot =3D acpi_hibernation_pre_snapshot_old,
+	.finish =3D acpi_hibernation_finish,
 	.prepare =3D acpi_pm_disable_gpes,
 	.enter =3D acpi_hibernation_enter,
 	.leave =3D acpi_hibernation_leave,
Index: linux-2.6/include/linux/suspend.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/include/linux/suspend.h
+++ linux-2.6/include/linux/suspend.h
@@ -233,6 +233,11 @@ extern unsigned long get_safe_page(gfp_t
 extern void hibernation_set_ops(struct platform_hibernation_ops *ops);
 extern int hibernate(void);
 extern bool system_entering_hibernation(void);
+extern int hibernate_nvs_register(unsigned long start, unsigned long s=
ize);
+extern int hibernate_nvs_alloc(void);
+extern void hibernate_nvs_free(void);
+extern void hibernate_nvs_save(void);
+extern void hibernate_nvs_restore(void);
 #else /* CONFIG_HIBERNATION */
 static inline int swsusp_page_is_forbidden(struct page *p) { return 0;=
 }
 static inline void swsusp_set_page_free(struct page *p) {}
@@ -241,6 +246,14 @@ static inline void swsusp_unset_page_fre
 static inline void hibernation_set_ops(struct platform_hibernation_ops=
 *ops) {}
 static inline int hibernate(void) { return -ENOSYS; }
 static inline bool system_entering_hibernation(void) { return false; }
+static inline int hibernate_nvs_register(unsigned long a, unsigned lon=
g b)
+{
+	return 0;
+}
+static inline int hibernate_nvs_alloc(void) { return 0; }
+static inline void hibernate_nvs_free(void) {}
+static inline void hibernate_nvs_save(void) {}
+static inline void hibernate_nvs_restore(void) {}
 #endif /* CONFIG_HIBERNATION */
=20
 #ifdef CONFIG_PM_SLEEP
Index: linux-2.6/kernel/power/swsusp.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/kernel/power/swsusp.c
+++ linux-2.6/kernel/power/swsusp.c
@@ -262,3 +262,127 @@ int swsusp_shrink_memory(void)
=20
 	return 0;
 }
+
+/*
+ * Platforms, like ACPI, may want us to save some memory used by them =
during
+ * hibernation and to restore the contents of this memory during the s=
ubsequent
+ * resume.  The code below implements a mechanism allowing us to do th=
at.
+ */
+
+struct nvs_page {
+	unsigned long phys_start;
+	unsigned int size;
+	void *kaddr;
+	void *data;
+	struct list_head node;
+};
+
+static LIST_HEAD(nvs_list);
+
+/**
+ *	hibernate_nvs_register - register platform NVS memory region to sav=
e
+ *	@start - physical address of the region
+ *	@size - size of the region
+ *
+ *	The NVS region need not be page-aligned (both ends) and we arrange
+ *	things so that the data from page-aligned addresses in this region =
will
+ *	be copied into separate RAM pages.
+ */
+int hibernate_nvs_register(unsigned long start, unsigned long size)
+{
+	struct nvs_page *entry, *next;
+
+	while (size > 0) {
+		unsigned int nr_bytes;
+
+		entry =3D kzalloc(sizeof(struct nvs_page), GFP_KERNEL);
+		if (!entry)
+			goto Error;
+
+		list_add_tail(&entry->node, &nvs_list);
+		entry->phys_start =3D start;
+		nr_bytes =3D PAGE_SIZE - (start & ~PAGE_MASK);
+		entry->size =3D (size < nr_bytes) ? size : nr_bytes;
+
+		start +=3D entry->size;
+		size -=3D entry->size;
+	}
+	return 0;
+
+ Error:
+	list_for_each_entry_safe(entry, next, &nvs_list, node) {
+		list_del(&entry->node);
+		kfree(entry);
+	}
+	return -ENOMEM;
+}
+
+/**
+ *	hibernate_nvs_free - free data pages allocated for saving NVS regio=
ns
+ *
+ *	It is allowed to call this function many times in a row.
+ */
+void hibernate_nvs_free(void)
+{
+	struct nvs_page *entry;
+
+	list_for_each_entry(entry, &nvs_list, node)
+		if (entry->data) {
+			free_page((unsigned long)entry->data);
+			entry->data =3D NULL;
+			if (entry->kaddr) {
+				iounmap(entry->kaddr);
+				entry->kaddr =3D NULL;
+			}
+		}
+}
+
+/**
+ *	hibernate_nvs_alloc - allocate memory necessary for saving NVS regi=
ons
+ */
+int hibernate_nvs_alloc(void)
+{
+	struct nvs_page *entry;
+
+	list_for_each_entry(entry, &nvs_list, node) {
+		entry->data =3D (void *)__get_free_page(GFP_KERNEL);
+		if (!entry->data) {
+			hibernate_nvs_free();
+			return -ENOMEM;
+		}
+	}
+	return 0;
+}
+
+/**
+ *	hibernate_nvs_save - save NVS memory regions
+ */
+void hibernate_nvs_save(void)
+{
+	struct nvs_page *entry;
+
+	printk(KERN_INFO "PM: Saving platform NVS memory\n");
+
+	list_for_each_entry(entry, &nvs_list, node)
+		if (entry->data) {
+			entry->kaddr =3D ioremap(entry->phys_start, entry->size);
+			memcpy(entry->data, entry->kaddr, entry->size);
+		}
+}
+
+/**
+ *	hibernate_nvs_restore - restore NVS memory regions
+ *
+ *	This function is going to be called with interrupts disabled, so it
+ *	cannot iounmap the virtual addresses used to access the NVS region.
+ */
+void hibernate_nvs_restore(void)
+{
+	struct nvs_page *entry;
+
+	printk(KERN_INFO "PM: Restoring platform NVS memory\n");
+
+	list_for_each_entry(entry, &nvs_list, node)
+		if (entry->data)
+			memcpy(entry->kaddr, entry->data, entry->size);
+}
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
