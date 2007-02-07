From: Len Brown <lenb@kernel.org>
Subject: [PATCH 20/140] ACPI: Optimize acpi_get_pci_rootbridge_handle() to boot faster
Date: Wed,  7 Feb 2007 13:50:34 -0500
Message-ID: <11708744003959-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:34715 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422734AbXBGSxX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:53:23 -0500
In-Reply-To: <11708743993414-git-send-email-lenb@kernel.org>
Message-Id: <d91a0078476ca536d76419f3b53196873b2931bc.1170873816.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Justin Chen <justin.chen@hp.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Justin Chen <justin.chen@hp.com>

Move acpi_get_pci_rootbridge_handle() from glue.c to pci_root.c and get the
root bridge ACPI handles by searching the &acpi_pci_roots list instead of
walking through the ACPI name space.  This significantly reduces boot time
on large I/O systems.

Signed-off-by: Justin Chen <justin.chen@hp.com>
Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/glue.c     |  123 -----------------------------------------------
 drivers/acpi/pci_root.c |   13 +++++
 2 files changed, 13 insertions(+), 123 deletions(-)

diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index 8a0324b..7b6c9ff 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -86,129 +86,6 @@ static int acpi_find_bridge_device(struct device *dev, acpi_handle * handle)
 	return ret;
 }
 
-/* Get PCI root bridge's handle from its segment and bus number */
-struct acpi_find_pci_root {
-	unsigned int seg;
-	unsigned int bus;
-	acpi_handle handle;
-};
-
-static acpi_status
-do_root_bridge_busnr_callback(struct acpi_resource *resource, void *data)
-{
-	unsigned long *busnr = data;
-	struct acpi_resource_address64 address;
-
-	if (resource->type != ACPI_RESOURCE_TYPE_ADDRESS16 &&
-	    resource->type != ACPI_RESOURCE_TYPE_ADDRESS32 &&
-	    resource->type != ACPI_RESOURCE_TYPE_ADDRESS64)
-		return AE_OK;
-
-	acpi_resource_to_address64(resource, &address);
-	if ((address.address_length > 0) &&
-	    (address.resource_type == ACPI_BUS_NUMBER_RANGE))
-		*busnr = address.minimum;
-
-	return AE_OK;
-}
-
-static int get_root_bridge_busnr(acpi_handle handle)
-{
-	acpi_status status;
-	unsigned long bus, bbn;
-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-
-	acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
-
-	status = acpi_evaluate_integer(handle, METHOD_NAME__BBN, NULL,
-				       &bbn);
-	if (status == AE_NOT_FOUND) {
-		/* Assume bus = 0 */
-		printk(KERN_INFO PREFIX
-		       "Assume root bridge [%s] bus is 0\n",
-		       (char *)buffer.pointer);
-		status = AE_OK;
-		bbn = 0;
-	}
-	if (ACPI_FAILURE(status)) {
-		bbn = -ENODEV;
-		goto exit;
-	}
-	if (bbn > 0)
-		goto exit;
-
-	/* _BBN in some systems return 0 for all root bridges */
-	bus = -1;
-	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
-				     do_root_bridge_busnr_callback, &bus);
-	/* If _CRS failed, we just use _BBN */
-	if (ACPI_FAILURE(status) || (bus == -1))
-		goto exit;
-	/* We select _CRS */
-	if (bbn != bus) {
-		printk(KERN_INFO PREFIX
-		       "_BBN and _CRS returns different value for %s. Select _CRS\n",
-		       (char *)buffer.pointer);
-		bbn = bus;
-	}
-      exit:
-	kfree(buffer.pointer);
-	return (int)bbn;
-}
-
-static acpi_status
-find_pci_rootbridge(acpi_handle handle, u32 lvl, void *context, void **rv)
-{
-	struct acpi_find_pci_root *find = (struct acpi_find_pci_root *)context;
-	unsigned long seg, bus;
-	acpi_status status;
-	int tmp;
-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-
-	acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
-
-	status = acpi_evaluate_integer(handle, METHOD_NAME__SEG, NULL, &seg);
-	if (status == AE_NOT_FOUND) {
-		/* Assume seg = 0 */
-		status = AE_OK;
-		seg = 0;
-	}
-	if (ACPI_FAILURE(status)) {
-		status = AE_CTRL_DEPTH;
-		goto exit;
-	}
-
-	tmp = get_root_bridge_busnr(handle);
-	if (tmp < 0) {
-		printk(KERN_ERR PREFIX
-		       "Find root bridge failed for %s\n",
-		       (char *)buffer.pointer);
-		status = AE_CTRL_DEPTH;
-		goto exit;
-	}
-	bus = tmp;
-
-	if (seg == find->seg && bus == find->bus)
-	{
-		find->handle = handle;
-		status = AE_CTRL_TERMINATE;
-	}
-	else
-		status = AE_OK;
-      exit:
-	kfree(buffer.pointer);
-	return status;
-}
-
-acpi_handle acpi_get_pci_rootbridge_handle(unsigned int seg, unsigned int bus)
-{
-	struct acpi_find_pci_root find = { seg, bus, NULL };
-
-	acpi_get_devices(PCI_ROOT_HID_STRING, find_pci_rootbridge, &find, NULL);
-	return find.handle;
-}
-EXPORT_SYMBOL_GPL(acpi_get_pci_rootbridge_handle);
-
 /* Get device's handler per its address under its parent */
 struct acpi_find_child {
 	acpi_handle handle;
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index a860efa..1f06229 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -117,6 +117,19 @@ void acpi_pci_unregister_driver(struct acpi_pci_driver *driver)
 
 EXPORT_SYMBOL(acpi_pci_unregister_driver);
 
+acpi_handle acpi_get_pci_rootbridge_handle(unsigned int seg, unsigned int bus)
+{
+	struct acpi_pci_root *tmp;
+	
+	list_for_each_entry(tmp, &acpi_pci_roots, node) {
+		if ((tmp->id.segment == (u16) seg) && (tmp->id.bus == (u16) bus))
+			return tmp->device->handle;
+	}
+	return NULL;		
+}
+
+EXPORT_SYMBOL_GPL(acpi_get_pci_rootbridge_handle);
+
 static acpi_status
 get_root_bridge_busnr_callback(struct acpi_resource *resource, void *data)
 {
-- 
1.5.0.rc3.39.gec804
