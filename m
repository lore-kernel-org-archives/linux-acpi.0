From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 26/37] PNPACPI: remove some pnp_dbg calls
Date: Tue, 01 Apr 2008 09:17:00 -0600
Message-ID: <20080401151740.814783953@ldl.fc.hp.com>
References: <20080401151634.730901933@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19]:35121 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755519AbYDAPSZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Apr 2008 11:18:25 -0400
Content-Disposition: inline; filename=pnpacpi-remove-debug-prints
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

These are turned off by default and don't print much useful information
anyway.  Anybody debugging this area will likely need to add his or her
own printks anyway.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work7/drivers/pnp/pnpacpi/rsparser.c
===================================================================
--- work7.orig/drivers/pnp/pnpacpi/rsparser.c	2008-03-25 10:14:46.000000000 -0600
+++ work7/drivers/pnp/pnpacpi/rsparser.c	2008-03-25 10:14:50.000000000 -0600
@@ -701,7 +701,6 @@
 	buffer->pointer = kzalloc(buffer->length - 1, GFP_KERNEL);
 	if (!buffer->pointer)
 		return -ENOMEM;
-	pnp_dbg("Res cnt %d", res_cnt);
 	resource = (struct acpi_resource *)buffer->pointer;
 	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
 				     pnpacpi_type_resources, &resource);
@@ -860,56 +859,47 @@
 	struct acpi_resource *resource = buffer->pointer;
 	int port = 0, irq = 0, dma = 0, mem = 0;
 
-	pnp_dbg("res cnt %d", res_cnt);
 	while (i < res_cnt) {
 		switch (resource->type) {
 		case ACPI_RESOURCE_TYPE_IRQ:
-			pnp_dbg("Encode irq");
 			pnpacpi_encode_irq(resource,
 					   &res_table->irq_resource[irq]);
 			irq++;
 			break;
 
 		case ACPI_RESOURCE_TYPE_DMA:
-			pnp_dbg("Encode dma");
 			pnpacpi_encode_dma(resource,
 					   &res_table->dma_resource[dma]);
 			dma++;
 			break;
 		case ACPI_RESOURCE_TYPE_IO:
-			pnp_dbg("Encode io");
 			pnpacpi_encode_io(resource,
 					  &res_table->port_resource[port]);
 			port++;
 			break;
 		case ACPI_RESOURCE_TYPE_FIXED_IO:
-			pnp_dbg("Encode fixed io");
 			pnpacpi_encode_fixed_io(resource,
 						&res_table->
 						port_resource[port]);
 			port++;
 			break;
 		case ACPI_RESOURCE_TYPE_MEMORY24:
-			pnp_dbg("Encode mem24");
 			pnpacpi_encode_mem24(resource,
 					     &res_table->mem_resource[mem]);
 			mem++;
 			break;
 		case ACPI_RESOURCE_TYPE_MEMORY32:
-			pnp_dbg("Encode mem32");
 			pnpacpi_encode_mem32(resource,
 					     &res_table->mem_resource[mem]);
 			mem++;
 			break;
 		case ACPI_RESOURCE_TYPE_FIXED_MEMORY32:
-			pnp_dbg("Encode fixed mem32");
 			pnpacpi_encode_fixed_mem32(resource,
 						   &res_table->
 						   mem_resource[mem]);
 			mem++;
 			break;
 		case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
-			pnp_dbg("Encode ext irq");
 			pnpacpi_encode_ext_irq(resource,
 					       &res_table->irq_resource[irq]);
 			irq++;

-- 
