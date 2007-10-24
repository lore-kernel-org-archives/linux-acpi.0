From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 1/5] Small ACPICA extension to be able to store the name of
	operation regions in osl.c later
Date: Wed, 24 Oct 2007 16:32:51 +0200
Message-ID: <1193236371.4590.228.camel@queen.suse.de>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:48470 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758409AbXJXOcw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Oct 2007 10:32:52 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@osdl.org>, Jean Delvare <khali@linux-fr.org>

---
 drivers/acpi/dispatcher/dsopcode.c |    4 +++-
 include/acpi/acpiosxf.h            |    4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

Index: lenb/drivers/acpi/dispatcher/dsopcode.c
===================================================================
--- lenb.orig/drivers/acpi/dispatcher/dsopcode.c
+++ lenb/drivers/acpi/dispatcher/dsopcode.c
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
Index: lenb/include/acpi/acpiosxf.h
===================================================================
--- lenb.orig/include/acpi/acpiosxf.h
+++ lenb/include/acpi/acpiosxf.h
@@ -239,8 +239,8 @@ acpi_status acpi_os_validate_interface(c
 acpi_status acpi_osi_invalidate(char* interface);
 
 acpi_status
-acpi_os_validate_address(u8 space_id,
-			 acpi_physical_address address, acpi_size length);
+acpi_os_validate_address(u8 space_id, acpi_physical_address address,
+			 acpi_size length, char *name);
 
 u64 acpi_os_get_timer(void);
 


