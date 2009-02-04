From: Len Brown <lenb@kernel.org>
Subject: [PATCH] ACPI: make some IO ports off-limits to AML
Date: Tue, 03 Feb 2009 22:59:43 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0902032258080.5607@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:16145 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbZBDD76 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Feb 2009 22:59:58 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

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
1.6.1.2.319.gbd9e

