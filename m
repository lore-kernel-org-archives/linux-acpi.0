From: Peter Chubb <peterc-M3ycANVxPotyL3EAZA59ERCuuivNXqWP@public.gmane.org>
Subject: [PATCH] `unaligned access' in acpi get_root_bridge_busnr()
Date: Thu, 20 Oct 2005 13:37:31 +1000
Message-ID: <17239.4347.595396.783239@berry.gelato.unsw.EDU.AU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


In drivers/acpi/glue.c the address of an integer is cast to the
address of an unsigned long.  This breaks on systems where a long is
larger than an int --- for a start the int can be misaligned; for a
second the assignment through the pointer will overwrite part of the
next variable.

Patch is against linux-2.6.14-rc4

Signed-off-by: Peter Chubb <peterc-M3ycANVxPotyL3EAZA59ERCuuivNXqWP@public.gmane.org>

Index: linux-2.6-import/drivers/acpi/glue.c
===================================================================
--- linux-2.6-import.orig/drivers/acpi/glue.c	2005-09-09 09:08:49.928854100 +1000
+++ linux-2.6-import/drivers/acpi/glue.c	2005-10-20 13:32:32.126445742 +1000
@@ -89,46 +89,46 @@ static int acpi_find_bridge_device(struc
 /* Get PCI root bridge's handle from its segment and bus number */
 struct acpi_find_pci_root {
 	unsigned int seg;
 	unsigned int bus;
 	acpi_handle handle;
 };
 
 static acpi_status
 do_root_bridge_busnr_callback(struct acpi_resource *resource, void *data)
 {
-	int *busnr = (int *)data;
+	unsigned long *busnr = (unsigned long *)data;
 	struct acpi_resource_address64 address;
 
 	if (resource->id != ACPI_RSTYPE_ADDRESS16 &&
 	    resource->id != ACPI_RSTYPE_ADDRESS32 &&
 	    resource->id != ACPI_RSTYPE_ADDRESS64)
 		return AE_OK;
 
 	acpi_resource_to_address64(resource, &address);
 	if ((address.address_length > 0) &&
 	    (address.resource_type == ACPI_BUS_NUMBER_RANGE))
 		*busnr = address.min_address_range;
 
 	return AE_OK;
 }
 
 static int get_root_bridge_busnr(acpi_handle handle)
 {
 	acpi_status status;
-	int bus, bbn;
+	unsigned long bus, bbn;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 
 	acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
 
 	status = acpi_evaluate_integer(handle, METHOD_NAME__BBN, NULL,
-				       (unsigned long *)&bbn);
+				       &bbn);
 	if (status == AE_NOT_FOUND) {
 		/* Assume bus = 0 */
 		printk(KERN_INFO PREFIX
 		       "Assume root bridge [%s] bus is 0\n",
 		       (char *)buffer.pointer);
 		status = AE_OK;
 		bbn = 0;
 	}
 	if (ACPI_FAILURE(status)) {
 		bbn = -ENODEV;
@@ -146,21 +146,21 @@ static int get_root_bridge_busnr(acpi_ha
 		goto exit;
 	/* We select _CRS */
 	if (bbn != bus) {
 		printk(KERN_INFO PREFIX
 		       "_BBN and _CRS returns different value for %s. Select _CRS\n",
 		       (char *)buffer.pointer);
 		bbn = bus;
 	}
       exit:
 	acpi_os_free(buffer.pointer);
-	return bbn;
+	return (int)bbn;
 }
 
 static acpi_status
 find_pci_rootbridge(acpi_handle handle, u32 lvl, void *context, void **rv)
 {
 	struct acpi_find_pci_root *find = (struct acpi_find_pci_root *)context;
 	unsigned long seg, bus;
 	acpi_status status;
 	int tmp;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
