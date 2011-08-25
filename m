From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] ACPICA: Add newlines to debug output
Date: Thu, 25 Aug 2011 14:06:28 -0600
Message-ID: <20110825200628.15112.503.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:7327 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753581Ab1HYUGf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Aug 2011 16:06:35 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Add newlines to avoid run-on debug output.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/acpica/hwvalid.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/hwvalid.c b/drivers/acpi/acpica/hwvalid.c
index 5f16058..e132ca2 100644
--- a/drivers/acpi/acpica/hwvalid.c
+++ b/drivers/acpi/acpica/hwvalid.c
@@ -141,7 +141,7 @@ acpi_hw_validate_io_request(acpi_io_address address, u32 bit_width)
 	byte_width = ACPI_DIV_8(bit_width);
 	last_address = address + byte_width - 1;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_IO, "Address %p LastAddress %p Length %X",
+	ACPI_DEBUG_PRINT((ACPI_DB_IO, "Address %p LastAddress %p Length %X\n",
 			  ACPI_CAST_PTR(void, address), ACPI_CAST_PTR(void,
 								      last_address),
 			  byte_width));
@@ -180,7 +180,7 @@ acpi_hw_validate_io_request(acpi_io_address address, u32 bit_width)
 
 			if (acpi_gbl_osi_data >= port_info->osi_dependency) {
 				ACPI_DEBUG_PRINT((ACPI_DB_IO,
-						  "Denied AML access to port 0x%p/%X (%s 0x%.4X-0x%.4X)",
+						  "Denied AML access to port 0x%p/%X (%s 0x%.4X-0x%.4X)\n",
 						  ACPI_CAST_PTR(void, address),
 						  byte_width, port_info->name,
 						  port_info->start,

