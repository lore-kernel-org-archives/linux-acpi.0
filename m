From: Len Brown <lenb@kernel.org>
Subject: [PATCH 20/30] ACPI: make some IO ports off-limits to AML
Date: Sat, 07 Feb 2009 01:41:28 -0500
Message-ID: <5ec5d38a1c8af255ffc481c81eef13e9155524b3.1233988826.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:12239 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771AbZBGGmA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Feb 2009 01:42:00 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-2.01 (built Jun 13 2007; 32bit))
 with ESMTPA id <0KEO00J75NXL9EZ1@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 07 Feb 2009 00:41:46 -0600 (CST)
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

ACPICA exports acpi_os_validate_address() so the OS
can prevent BIOS AML from accessing specified addresses.

Start using this interface to prevent AML from accessing
some well known IO addresses that the OS "owns".

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/osl.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 6729a49..4fb01b0 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1317,6 +1317,54 @@ acpi_os_validate_interface (char *interface)
 	return AE_SUPPORT;
 }
 
+#ifdef	CONFIG_X86
+
+struct aml_port_desc {
+	uint	start;
+	uint	end;
+	char*   name;
+	char	warned;
+};
+
+static struct aml_port_desc aml_invalid_port_list[] = {
+	{0x20, 0x21, "PIC0", 0},
+	{0xA0, 0xA1, "PIC1", 0},
+	{0x4D0, 0x4D1, "ELCR", 0}
+};
+
+/*
+ * valid_aml_io_address()
+ *
+ * if valid, return true
+ * else invalid, warn once, return false
+ */
+static bool valid_aml_io_address(uint address, uint length)
+{
+	int i;
+	int entries = sizeof(aml_invalid_port_list) / sizeof(struct aml_port_desc);
+
+	for (i = 0; i < entries; ++i) {
+		if ((address >= aml_invalid_port_list[i].start &&
+			address <= aml_invalid_port_list[i].end) ||
+			(address + length >= aml_invalid_port_list[i].start &&
+			address  + length <= aml_invalid_port_list[i].end))
+		{
+			if (!aml_invalid_port_list[i].warned)
+			{
+				printk(KERN_ERR "ACPI: Denied BIOS AML access"
+					" to invalid port 0x%x+0x%x (%s)\n",
+					address, length,
+					aml_invalid_port_list[i].name);
+				aml_invalid_port_list[i].warned = 1;
+			}
+			return false;	/* invalid */
+		}
+	}
+	return true;	/* valid */
+}
+#else
+static inline bool valid_aml_io_address(uint address, uint length) { return true; }
+#endif
 /******************************************************************************
  *
  * FUNCTION:    acpi_os_validate_address
@@ -1346,6 +1394,8 @@ acpi_os_validate_address (
 
 	switch (space_id) {
 	case ACPI_ADR_SPACE_SYSTEM_IO:
+		if (!valid_aml_io_address(address, length))
+			return AE_AML_ILLEGAL_ADDRESS;
 	case ACPI_ADR_SPACE_SYSTEM_MEMORY:
 		/* Only interference checks against SystemIO and SytemMemory
 		   are needed */
-- 
1.5.6.6

