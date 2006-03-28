From: akpm@osdl.org
Subject: [patch 16/26] acpi_os_acquire_object (GFP_KERNEL) called with IRQs disabled through suspend-resume
Date: Tue, 28 Mar 2006 14:03:42 -0800
Message-ID: <200603282203.k2SM3m1b027698@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:63151 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932421AbWC1WDz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Mar 2006 17:03:55 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, davi.arnaut@gmail.com, pavel@ucw.cz


From: Davi Arnaut <davi.arnaut@gmail.com>

acpi_os_acquire_object() gets called, with IRQs disabled, from:

Debug: sleeping function called from invalid context at mm/slab.c:2499
in_atomic():0, irqs_disabled():1
 [<c01462f3>] kmem_cache_alloc+0x40/0x4f     [<c0202c85>] acpi_os_acquire_object+0xb/0x3c
 [<c02171b1>] acpi_ut_allocate_object_desc_dbg+0x13/0x49     [<c021704b>] acpi_ut_create_internal_object_dbg+0xf/0x5e
 [<c02136d4>] acpi_rs_set_srs_method_data+0x3d/0xb9     [<c021aa3d>] acpi_pci_link_set+0x102/0x17b
 [<c021aecb>] irqrouter_resume+0x1e/0x3c     [<c024d921>] __sysdev_resume+0x11/0x6b
 [<c024dbde>] sysdev_resume+0x34/0x52     [<c0251cb7>] device_power_up+0x5/0xa
 [<c0138787>] suspend_enter+0x44/0x46     [<c01386e5>] suspend_prepare+0x63/0xc1
 [<c0138813>] enter_state+0x5e/0x7c     [<c013894c>] state_store+0x81/0x8f
 [<c01388cb>] state_store+0x0/0x8f     [<c0196a0a>] subsys_attr_store+0x1e/0x22
 [<c0196c12>] flush_write_buffer+0x22/0x28     [<c0196c64>] sysfs_write_file+0x4c/0x71
 [<c0196c18>] sysfs_write_file+0x0/0x71     [<c015b2c9>] vfs_write+0xa2/0x15a
 [<c015b42c>] sys_write+0x41/0x6a     [<c0102e75>] syscall_call+0x7/0xb

The patch also fixes a missing check for NULL return from
acpi_os_acquire_object().

Signed-off-by: Davi Arnaut <davi.arnaut@gmail.com>
Cc: "Brown, Len" <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/osl.c            |    7 ++++++-
 drivers/acpi/parser/psutils.c |    8 ++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff -puN drivers/acpi/osl.c~acpi_os_acquire_object-gfp_kernel-called-with-irqs drivers/acpi/osl.c
--- devel/drivers/acpi/osl.c~acpi_os_acquire_object-gfp_kernel-called-with-irqs	2006-03-28 14:03:05.000000000 -0800
+++ devel-akpm/drivers/acpi/osl.c	2006-03-28 14:03:05.000000000 -0800
@@ -1141,7 +1141,12 @@ acpi_status acpi_os_release_object(acpi_
 
 void *acpi_os_acquire_object(acpi_cache_t * cache)
 {
-	void *object = kmem_cache_alloc(cache, GFP_KERNEL);
+	void *object;
+
+	if (acpi_in_resume)
+		object = kmem_cache_alloc(cache, GFP_ATOMIC);
+	else
+		object = kmem_cache_alloc(cache, GFP_KERNEL);
 	WARN_ON(!object);
 	return object;
 }
diff -puN drivers/acpi/parser/psutils.c~acpi_os_acquire_object-gfp_kernel-called-with-irqs drivers/acpi/parser/psutils.c
--- devel/drivers/acpi/parser/psutils.c~acpi_os_acquire_object-gfp_kernel-called-with-irqs	2006-03-28 14:03:05.000000000 -0800
+++ devel-akpm/drivers/acpi/parser/psutils.c	2006-03-28 14:03:05.000000000 -0800
@@ -139,12 +139,16 @@ union acpi_parse_object *acpi_ps_alloc_o
 		/* The generic op (default) is by far the most common (16 to 1) */
 
 		op = acpi_os_acquire_object(acpi_gbl_ps_node_cache);
-		memset(op, 0, sizeof(struct acpi_parse_obj_common));
+
+		if (op)
+			memset(op, 0, sizeof(struct acpi_parse_obj_common));
 	} else {
 		/* Extended parseop */
 
 		op = acpi_os_acquire_object(acpi_gbl_ps_node_ext_cache);
-		memset(op, 0, sizeof(struct acpi_parse_obj_named));
+
+		if (op)
+			memset(op, 0, sizeof(struct acpi_parse_obj_named));
 	}
 
 	/* Initialize the Op */
_
