From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH - 1/2] Identify native drivers and ACPI subsystem accessing
	the same resources -  ACPICA stuff
Date: Fri, 13 Jul 2007 14:59:09 +0200
Message-ID: <1184331549.3960.105.camel@d88.suse.de>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53469 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759236AbXGMM7K (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Jul 2007 08:59:10 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Bernhard Walle <bwalle@suse.de>, "Starikovskiy, Alexey Y" <aystarik@gmail.com>, linux-acpi <linux-acpi@vger.kernel.org>, lm-sensors@lm-sensors.org, Bjorn Helgaas <bjorn.helgaas@hp.com>, Jean Delvare <khali@linux-fr.org>, akpm <akpm@linux-foundation.org>

Also pass the OperationRegion name to the OS validate func


Signed-off-by: Thomas Renninger <trenn@suse.de>

---
 drivers/acpi/dispatcher/dsopcode.c |    4 +++-
 include/acpi/acpiosxf.h            |    4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

Index: linux-2.6.22-rc5/include/acpi/acpiosxf.h
===================================================================
--- linux-2.6.22-rc5.orig/include/acpi/acpiosxf.h
+++ linux-2.6.22-rc5/include/acpi/acpiosxf.h
@@ -239,8 +239,8 @@ acpi_status acpi_os_validate_interface(c
 acpi_status acpi_osi_invalidate(char* interface);
 
 acpi_status
-acpi_os_validate_address(u8 space_id,
-			 acpi_physical_address address, acpi_size length);
+acpi_os_validate_address(u8 space_id, acpi_physical_address address,
+			 acpi_size length, char *name);
 
 u64 acpi_os_get_timer(void);
 
Index: linux-2.6.22-rc5/drivers/acpi/dispatcher/dsopcode.c
===================================================================
--- linux-2.6.22-rc5.orig/drivers/acpi/dispatcher/dsopcode.c
+++ linux-2.6.22-rc5/drivers/acpi/dispatcher/dsopcode.c
@@ -359,7 +359,9 @@ acpi_status acpi_ds_get_region_arguments
 
 	status = acpi_os_validate_address(obj_desc->region.space_id,
 					  obj_desc->region.address,
-					  (acpi_size) obj_desc->region.length);
+					  (acpi_size) obj_desc->region.length,
+					  acpi_ut_get_node_name(node));
+
 	if (ACPI_FAILURE(status)) {
 		/*
 		 * Invalid address/length. We will emit an error message and mark


