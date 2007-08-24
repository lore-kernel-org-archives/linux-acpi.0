From: Len Brown <lenb@kernel.org>
Subject: Re: [Patch]: ACPI: Force to use RSDT when XSDT has NULL entry
Date: Fri, 24 Aug 2007 18:53:49 -0400
Message-ID: <200708241853.49143.lenb@kernel.org>
References: <1187943496.3766.5.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42315 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756241AbXHXWxy (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Fri, 24 Aug 2007 18:53:54 -0400
In-Reply-To: <1187943496.3766.5.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Linux-acpi@vger.kernel.org

Thanks, Yakui.

I've refreshed the patch and applied it as below.

Some trivia for next time:
please send to: me, and cc: the list, rather than the reverse.

After the
---
please note anything you don't want to say, but exclude
from the check-in comments.
in particular, this is a good place to say things like,
this patch has been tested, please apply,
or this patch is untested, or please give me feedback etc.

Please do not delete white-space that is not directly related
to the logical change at hand.  white-space is useful.

I couldn't resist deleting some temporary variables
and updating the comments and check-in comments etc,
Hopefully I didn't mess it up.
diff your patch and this one to see what I did.

thanks,
-Len

Subject: ACPI: Validate XSDT, use RSDT if XSDT fails
From: Zhao Yakui  <yakui.zhao@intel.com>

ACPI 1.0 used an RSDT with 32-bit physical addresses.
ACPI 2.0 adds an XSDT with 32-bit physical addresses.
An ACPI 2.0 aware OS is supposed to use the XSDT
(when present) instead of the RSDT.

However, several systems have failed because the XSDT
contains NULL entries -- while it is missing pointers
to needed tables, such as SSDTs.

When we find an XSDT with NULL entries, discard it
and use the ACPI 1.0 RSDT instead.

http://bugzilla.kernel.org/show_bug.cgi?id=8630

Signed-off-by: Zhao Yakui  <yakui.zhao@intel.com>

---
 tbutils.c |   71 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)


Index: linus/drivers/acpi/tables/tbutils.c
===================================================================
--- linus.orig/drivers/acpi/tables/tbutils.c
+++ linus/drivers/acpi/tables/tbutils.c
@@ -51,6 +51,65 @@ ACPI_MODULE_NAME("tbutils")
 static acpi_physical_address
 acpi_tb_get_root_table_entry(u8 * table_entry,
 			     acpi_native_uint table_entry_size);
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_tb_check_xsdt
+ *
+ * PARAMETERS:  address                    - Pointer to the XSDT
+ *
+ * RETURN:      status
+ *		AE_OK - XSDT is okay
+ *		AE_NO_MEMORY - can't map XSDT
+ *		AE_INVALID_TABLE_LENGTH - invalid table length
+ *		AE_NULL_ENTRY - XSDT has NULL entry
+ *
+ * DESCRIPTION: validate XSDT
+******************************************************************************/
+
+static acpi_status
+acpi_tb_check_xsdt(acpi_physical_address address)
+{
+	struct acpi_table_header *table;
+	u32 length;
+	u64 xsdt_entry_address;
+	u8 *table_entry;
+	u32 table_count;
+	int i;
+
+	table = acpi_os_map_memory(address, sizeof(struct acpi_table_header));
+	if (!table)
+		return AE_NO_MEMORY;
+
+	length = table->length;
+	acpi_os_unmap_memory(table, sizeof(struct acpi_table_header));
+	if (length < sizeof(struct acpi_table_header))
+		return AE_INVALID_TABLE_LENGTH;
+
+	table = acpi_os_map_memory(address, length);
+	if (!table)
+		return AE_NO_MEMORY;
+
+	/* Calculate the number of tables described in XSDT */
+	table_count =
+		(u32) ((table->length -
+		sizeof(struct acpi_table_header)) / sizeof(u64));
+	table_entry =
+		ACPI_CAST_PTR(u8, table) + sizeof(struct acpi_table_header);
+	for (i = 0; i < table_count; i++) {
+		ACPI_MOVE_64_TO_64(&xsdt_entry_address, table_entry);
+		if (!xsdt_entry_address) {
+			/* XSDT has NULL entry */
+			break;
+		}
+		table_entry += sizeof(u64);
+	}
+	acpi_os_unmap_memory(table, length);
+
+	if (i < table_count)
+		return AE_NULL_ENTRY;
+	else
+		return AE_OK;
+}
 
 /*******************************************************************************
  *
@@ -341,6 +400,7 @@ acpi_tb_parse_root_table(acpi_physical_a
 	u32 table_count;
 	struct acpi_table_header *table;
 	acpi_physical_address address;
+	acpi_physical_address rsdt_address;
 	u32 length;
 	u8 *table_entry;
 	acpi_status status;
@@ -369,6 +429,8 @@ acpi_tb_parse_root_table(acpi_physical_a
 		 */
 		address = (acpi_physical_address) rsdp->xsdt_physical_address;
 		table_entry_size = sizeof(u64);
+		rsdt_address = (acpi_physical_address)
+					rsdp->rsdt_physical_address;
 	} else {
 		/* Root table is an RSDT (32-bit physical addresses) */
 
@@ -382,6 +444,15 @@ acpi_tb_parse_root_table(acpi_physical_a
 	 */
 	acpi_os_unmap_memory(rsdp, sizeof(struct acpi_table_rsdp));
 
+	if (table_entry_size == sizeof(u64)) {
+		if (acpi_tb_check_xsdt(address) == AE_NULL_ENTRY) {
+			/* XSDT has NULL entry, RSDT is used */
+			address = rsdt_address;
+			table_entry_size = sizeof(u32);
+			ACPI_WARNING((AE_INFO, "BIOS XSDT has NULL entry,"
+					"using RSDT"));
+		}
+	}
 	/* Map the RSDT/XSDT table header to get the full table length */
 
 	table = acpi_os_map_memory(address, sizeof(struct acpi_table_header));
