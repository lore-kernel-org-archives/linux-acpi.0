From: helgaas@ldl.fc.hp.com
Subject: [patch 11/17] PNPBIOS: remove unused bioscalls code
Date: Mon, 23 Jul 2007 15:28:08 -0600
Message-ID: <20070723213242.526621439@ldl.fc.hp.com>
References: <20070723212757.122218147@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:56474 "EHLO atlrel9.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759108AbXGWVdd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jul 2007 17:33:33 -0400
Content-Disposition: inline; filename=pnpbios-format-pnpbios
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jaroslav Kysela <perex@suse.cz>, Adam Belay <ambx1@neo.rr.com>, linux-acpi@vger.kernel.org

Remove unused code surrounded by "#if needed".  No functional change.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work2/include/linux/pnpbios.h
===================================================================
--- work2.orig/include/linux/pnpbios.h	2007-07-23 14:25:57.000000000 -0600
+++ work2/include/linux/pnpbios.h	2007-07-23 14:26:04.000000000 -0600
@@ -141,14 +141,6 @@
 extern int pnp_bios_escd_info (struct escd_info_struc *data);
 extern int pnp_bios_read_escd (char *data, u32 nvram_base);
 extern int pnp_bios_dock_station_info(struct pnp_docking_station_info *data);
-#define needed 0
-#if needed
-extern int pnp_bios_get_event (u16 *message);
-extern int pnp_bios_send_message (u16 message);
-extern int pnp_bios_set_stat_res (char *info);
-extern int pnp_bios_apm_id_table (char *table, u16 *size);
-extern int pnp_bios_write_escd (char *data, u32 nvram_base);
-#endif
 
 #endif /* CONFIG_PNPBIOS */
 

--
