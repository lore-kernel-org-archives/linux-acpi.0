From: louisqi <louisqi@viatech.com.cn>
Subject: [PATCH] ACPI: Add _PDC object evaluate for VIA.
Date: Sat, 27 Sep 2008 16:52:00 +0800
Message-ID: <48DDF430.8060806@viatech.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from exchtp08.via.com.tw ([61.66.243.7]:1546 "EHLO
	exchtp08.via.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbYI0JIL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 27 Sep 2008 05:08:11 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com, venkatesh.pallipadi@intel.com, linux-acpi@vger.kernel.org

Dear Brown & Pallipadi=A3=BA

Attached is a patch to support _PDC object evaluate for VIA CPUs.
The routine "arch_acpi_processor_init_pdc" which is at
"arch/x86/kernel/acpi/processor.c" currently only supports INTEL CPUs.

The patch has been tested on the "VIA VX800"chipset + "VIA C7-M1.8G" CP=
U.
It should work for other VIA chipset / BIOS that implements the _PDC ob=
ject.

Thanks
Louis

-----------------------------------------------------------------------=
---------

[PATCH] ACPI: Add _PDC object evaluate for VIA.

=46rome: Louis Qi <louisqi@viatech.com.cn>

The current routine "arch_acpi_processor_init_pdc" only supports INTEL =
CPUs.
This patch add support for VIA CPUs.

Signed-off-by: Louis Qi <louisqi@viatech.com.cn>
---

--- 2.6.26.5/arch/x86/kernel/acpi/processor.c.orig	2008-09-27 15:46:14.=
000000000
+0800
+++ 2.6.26.5/arch/x86/kernel/acpi/processor.c	2008-09-27 15:46:14.00000=
0000 +0800
@@ -66,6 +66,55 @@ static void init_intel_pdc(struct acpi_p
 	return;
 }

+static void init_via_pdc(struct acpi_processor *pr, struct cpuinfo_x86=
 *c)
+{
+	struct acpi_object_list *obj_list;
+	union acpi_object *obj;
+	u32 *buf;
+
+	/* allocate and initialize pdc. It will be used later. */
+	obj_list =3D kmalloc(sizeof(struct acpi_object_list), GFP_KERNEL);
+	if (!obj_list) {
+		printk(KERN_ERR "Memory allocation error\n");
+		return;
+	}
+
+	obj =3D kmalloc(sizeof(union acpi_object), GFP_KERNEL);
+	if (!obj) {
+		printk(KERN_ERR "Memory allocation error\n");
+		kfree(obj_list);
+		return;
+	}
+
+	buf =3D kmalloc(12, GFP_KERNEL);
+	if (!buf) {
+		printk(KERN_ERR "Memory allocation error\n");
+		kfree(obj);
+		kfree(obj_list);
+		return;
+	}
+
+	buf[0] =3D ACPI_PDC_REVISION_ID;
+	buf[1] =3D 1;
+	buf[2] =3D 0;
+
+	if (cpu_has(c, X86_FEATURE_EST))
+		buf[2] |=3D ACPI_PDC_P_FFH;
+
+	if (cpu_has(c, X86_FEATURE_ACPI))
+		buf[2] |=3D ACPI_PDC_T_FFH;
+
+	obj->type =3D ACPI_TYPE_BUFFER;
+	obj->buffer.length =3D 12;
+	obj->buffer.pointer =3D (u8 *) buf;
+	obj_list->count =3D 1;
+	obj_list->pointer =3D obj;
+	pr->pdc =3D obj_list;
+
+	return;
+}
+
+
 /* Initialize _PDC data based on the CPU vendor */
 void arch_acpi_processor_init_pdc(struct acpi_processor *pr)
 {
@@ -74,6 +123,8 @@ void arch_acpi_processor_init_pdc(struct
 	pr->pdc =3D NULL;
 	if (c->x86_vendor =3D=3D X86_VENDOR_INTEL)
 		init_intel_pdc(pr, c);
+	else if (c->x86_vendor =3D=3D X86_VENDOR_CENTAUR)
+		init_via_pdc(pr, c);

 	return;
 }
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
