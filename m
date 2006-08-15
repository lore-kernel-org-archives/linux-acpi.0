From: akpm@osdl.org
Subject: [patch 11/14] ACPI: change GFP_ATOMIC to GFP_KERNEL for non-atomic  allocation
Date: Mon, 14 Aug 2006 22:37:29 -0700
Message-ID: <200608150537.k7F5bTu8011560@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:49545 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965095AbWHOFhh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Aug 2006 01:37:37 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, jikos@jikos.cz

From: Jiri Kosina <jikos@jikos.cz>

acpi_pci_link_set() allocates with GFP_ATOMIC. On resume from suspend,
this is called with interrupts off, otherwise GFP_KERNEL is safe.

On the other hand, when resuming from suspend with interrupts off, the
following callchain allocates with GFP_KERNEL, which is wrong:

acpi_pci_link_resume -> acpi_pci_link_set -> acpi_set_current_resources ->
acpi_rs_set_srs_method_data -> acpi_ut_create_internal_object_dbg ->
acpi_ut_allocate_object_desc_dbg -> acpi_os_acquire_object ->
kmem_cache_alloc(GFP_KERNEL) flag.

Signed-off-by: Jiri Kosina <jikos@jikos.cz>
Cc: "Brown, Len" <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/pci_link.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff -puN drivers/acpi/pci_link.c~acpi-change-gfp_atomic-to-gfp_kernel-for-non-atomic drivers/acpi/pci_link.c
--- a/drivers/acpi/pci_link.c~acpi-change-gfp_atomic-to-gfp_kernel-for-non-atomic
+++ a/drivers/acpi/pci_link.c
@@ -307,7 +307,12 @@ static int acpi_pci_link_set(struct acpi
 	if (!link || !irq)
 		return -EINVAL;
 
-	resource = kmalloc(sizeof(*resource) + 1, GFP_ATOMIC);
+	/* irqs could be disabled when resuming from suspend */
+	if (irqs_disabled())
+		resource = kmalloc(sizeof(*resource) + 1, GFP_ATOMIC);
+	else
+		resource = kmalloc(sizeof(*resource) + 1, GFP_KERNEL);
+
 	if (!resource)
 		return -ENOMEM;
 
_
