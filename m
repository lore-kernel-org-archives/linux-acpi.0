From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] ACPICA: Add newlines to hwvalid debug output
Date: Fri, 04 Jan 2013 15:24:28 -0700
Message-ID: <20130104222428.10275.2683.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ea0-f202.google.com ([209.85.215.202]:44226 "EHLO
	mail-ea0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754865Ab3ADWYa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Jan 2013 17:24:30 -0500
Received: by mail-ea0-f202.google.com with SMTP id j12so1057761eaa.5
        for <linux-acpi@vger.kernel.org>; Fri, 04 Jan 2013 14:24:29 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

Add newlines to avoid run-on debug output.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/acpica/hwvalid.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/hwvalid.c b/drivers/acpi/acpica/hwvalid.c
index b6aae58..04ab4a2 100644
--- a/drivers/acpi/acpica/hwvalid.c
+++ b/drivers/acpi/acpica/hwvalid.c
@@ -142,7 +142,7 @@ acpi_hw_validate_io_request(acpi_io_address address, u32 bit_width)
 	byte_width = ACPI_DIV_8(bit_width);
 	last_address = address + byte_width - 1;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_IO, "Address %p LastAddress %p Length %X",
+	ACPI_DEBUG_PRINT((ACPI_DB_IO, "Address %p LastAddress %p Length %X\n",
 			  ACPI_CAST_PTR(void, address), ACPI_CAST_PTR(void,
 								      last_address),
 			  byte_width));
@@ -181,7 +181,7 @@ acpi_hw_validate_io_request(acpi_io_address address, u32 bit_width)
 
 			if (acpi_gbl_osi_data >= port_info->osi_dependency) {
 				ACPI_DEBUG_PRINT((ACPI_DB_IO,
-						  "Denied AML access to port 0x%p/%X (%s 0x%.4X-0x%.4X)",
+						  "Denied AML access to port 0x%p/%X (%s 0x%.4X-0x%.4X)\n",
 						  ACPI_CAST_PTR(void, address),
 						  byte_width, port_info->name,
 						  port_info->start,

