From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/14] Revert "ACPI: make some IO ports off-limits to AML"
Date: Mon, 16 Mar 2009 01:23:48 -0400
Message-ID: <7b46ecd5fcebf381a7bde966db352d8fb1b8e944.1237181013.git.len.brown@intel.com>
References: <1237181040-24165-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:14134 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbZCPFYI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Mar 2009 01:24:08 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KGL00K6O304V9H1@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 16 Mar 2009 00:24:04 -0500 (CDT)
In-reply-to: <1237181040-24165-1-git-send-email-lenb@kernel.org>
In-reply-to: <a140449584522c3eea1bb381f746d40939e6f62a.1237181013.git.len.brown@intel.com>
References: <a140449584522c3eea1bb381f746d40939e6f62a.1237181013.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

This reverts commit 5ec5d38a1c8af255ffc481c81eef13e9155524b3.
because it caused spurious dmesg warmings.
We'll implement the check for off-limit ports
in a more clever way in the future.

http://bugzilla.kernel.org/show_bug.cgi?id=12758

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/osl.c |   50 --------------------------------------------------
 1 files changed, 0 insertions(+), 50 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index b3193ec..1e35f34 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1317,54 +1317,6 @@ acpi_os_validate_interface (char *interface)
 	return AE_SUPPORT;
 }
 
-#ifdef	CONFIG_X86
-
-struct aml_port_desc {
-	uint	start;
-	uint	end;
-	char*   name;
-	char	warned;
-};
-
-static struct aml_port_desc aml_invalid_port_list[] = {
-	{0x20, 0x21, "PIC0", 0},
-	{0xA0, 0xA1, "PIC1", 0},
-	{0x4D0, 0x4D1, "ELCR", 0}
-};
-
-/*
- * valid_aml_io_address()
- *
- * if valid, return true
- * else invalid, warn once, return false
- */
-static bool valid_aml_io_address(uint address, uint length)
-{
-	int i;
-	int entries = sizeof(aml_invalid_port_list) / sizeof(struct aml_port_desc);
-
-	for (i = 0; i < entries; ++i) {
-		if ((address >= aml_invalid_port_list[i].start &&
-			address <= aml_invalid_port_list[i].end) ||
-			(address + length >= aml_invalid_port_list[i].start &&
-			address  + length <= aml_invalid_port_list[i].end))
-		{
-			if (!aml_invalid_port_list[i].warned)
-			{
-				printk(KERN_ERR "ACPI: Denied BIOS AML access"
-					" to invalid port 0x%x+0x%x (%s)\n",
-					address, length,
-					aml_invalid_port_list[i].name);
-				aml_invalid_port_list[i].warned = 1;
-			}
-			return false;	/* invalid */
-		}
-	}
-	return true;	/* valid */
-}
-#else
-static inline bool valid_aml_io_address(uint address, uint length) { return true; }
-#endif
 /******************************************************************************
  *
  * FUNCTION:    acpi_os_validate_address
@@ -1394,8 +1346,6 @@ acpi_os_validate_address (
 
 	switch (space_id) {
 	case ACPI_ADR_SPACE_SYSTEM_IO:
-		if (!valid_aml_io_address(address, length))
-			return AE_AML_ILLEGAL_ADDRESS;
 	case ACPI_ADR_SPACE_SYSTEM_MEMORY:
 		/* Only interference checks against SystemIO and SytemMemory
 		   are needed */
-- 
1.5.6.6

