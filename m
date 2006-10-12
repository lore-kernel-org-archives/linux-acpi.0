From: Stephen Hemminger <shemminger@osdl.org>
Subject: [PATCH] ACPI header length printk format warning
Date: Thu, 12 Oct 2006 11:03:45 -0700
Message-ID: <20061012110345.1d9da93a@dxpl.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:51607 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750783AbWJLUEH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Oct 2006 16:04:07 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

Get rid of warning from printk arguments on 64 bit platforms.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>


--- orig/drivers/acpi/tables/tbget.c
+++ new/drivers/acpi/tables/tbget.c
@@ -324,8 +324,9 @@ acpi_tb_get_this_table(struct acpi_point
 
 	if (header->length < sizeof(struct acpi_table_header)) {
 		ACPI_ERROR((AE_INFO,
-			    "Table length (%X) is smaller than minimum (%X)",
-			    header->length, sizeof(struct acpi_table_header)));
+			    "Table length (%lx) is smaller than minimum (%zx)",
+			    (unsigned long) header->length,
+			    sizeof(struct acpi_table_header)));
 
 		return_ACPI_STATUS(AE_INVALID_TABLE_LENGTH);
 	}
@@ -343,8 +344,8 @@ acpi_tb_get_this_table(struct acpi_point
 		full_table = ACPI_ALLOCATE(header->length);
 		if (!full_table) {
 			ACPI_ERROR((AE_INFO,
-				    "Could not allocate table memory for [%4.4s] length %X",
-				    header->signature, header->length));
+				    "Could not allocate table memory for [%4.4s] length %lx",
+				    header->signature, (unsigned long) header->length));
 			return_ACPI_STATUS(AE_NO_MEMORY);
 		}
 
