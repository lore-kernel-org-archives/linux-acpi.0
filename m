From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH] PNPACPI trivial cleanup
Date: Tue, 11 Jan 2005 17:16:03 -0700
Message-ID: <1105488963.31942.74.camel@eeyore>
Mime-Version: 1.0
Content-Type: text/plain
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
To: shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Trivial cleanup (mostly white-space).

Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>

--- pnp1/drivers/pnp/pnpacpi/core.c	2005-01-11 15:44:30.000000000 -0700
+++ pnp1/drivers/pnp/pnpacpi/core.c.1	2005-01-11 15:36:30.000000000 -0700
@@ -3,7 +3,7 @@
  *
  * Copyright (c) 2004 Matthieu Castet <castet.matthieu-GANU6spQydw@public.gmane.org>
  * Copyright (c) 2004 Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
- * 
+ *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
  * Free Software Foundation; either version 2, or (at your option) any
@@ -18,7 +18,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
- 
+
 #include <linux/acpi.h>
 #include <linux/pnp.h>
 #include <acpi/acpi_bus.h>
@@ -87,7 +87,7 @@
 static int pnpacpi_get_resources(struct pnp_dev * dev, struct pnp_resource_table * res)
 {
 	acpi_status status;
-	status = pnpacpi_parse_allocated_resource((acpi_handle)dev->data, 
+	status = pnpacpi_parse_allocated_resource((acpi_handle)dev->data,
 		&dev->res);
 	return ACPI_FAILURE(status) ? -ENODEV : 0;
 }
@@ -119,7 +119,7 @@
 	acpi_status status;
 	
 	/* acpi_unregister_gsi(pnp_irq(dev, 0)); */
-	status = acpi_evaluate_object((acpi_handle)dev->data, 
+	status = acpi_evaluate_object((acpi_handle)dev->data,
 		"_DIS", NULL, NULL);
 	return ACPI_FAILURE(status) ? -ENODEV : 0;
 }
@@ -179,8 +179,7 @@
 	pnpidacpi_to_pnpid(acpi_device_hid(device), dev_id->id);
 	pnp_add_id(dev_id, dev);
 
-	if(dev->active) {
-		/* parse allocated resource */
+	if (dev->active) {
 		status = pnpacpi_parse_allocated_resource(device->handle, &dev->res);
 		if (ACPI_FAILURE(status) && (status != AE_NOT_FOUND)) {
 			pnp_err("PnPACPI: METHOD_NAME__CRS failure for %s", dev_id->id);
@@ -188,8 +187,8 @@
 		}
 	}
 
-	if(dev->capabilities & PNP_CONFIGURABLE) {
-		status = pnpacpi_parse_resource_option_data(device->handle, 
+	if (dev->capabilities & PNP_CONFIGURABLE) {
+		status = pnpacpi_parse_resource_option_data(device->handle,
 			dev);
 		if (ACPI_FAILURE(status) && (status != AE_NOT_FOUND)) {
 			pnp_err("PnPACPI: METHOD_NAME__PRS failure for %s", dev_id->id);
@@ -205,7 +204,7 @@
 		for (i = 0; i < cid_list->count; i++) {
 			if (!ispnpidacpi(cid_list->id[i].value))
 				continue;
-			dev_id = pnpacpi_kmalloc(sizeof(struct pnp_id), 
+			dev_id = pnpacpi_kmalloc(sizeof(struct pnp_id),
 				GFP_KERNEL);
 			if (!dev_id)
 				continue;
@@ -219,7 +218,7 @@
 	if (!dev->active)
 		pnp_init_resource_table(&dev->res);
 	pnp_add_device(dev);
-	num ++;
+	num++;
 
 	return AE_OK;
 err1:
@@ -244,7 +243,7 @@
 int __init pnpacpi_init(void)
 {
 	if (acpi_disabled) {
-		pnp_info("PnP ACPI: ACPI disable");
+		pnp_info("PnP ACPI: ACPI disabled");
 		return 0;
 	}
 	pnp_info("PnP ACPI init");




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
