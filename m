From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 03/15] ACPICA: Fix a module for excessive debug output
Date: Wed, 26 Apr 2017 16:17:56 +0800
Message-ID: <4b585e2c4d78cbbf4afee77fa85d4e4acb20d5f3.1493194142.git.lv.zheng@intel.com>
References: <cover.1493194142.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:18876 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1952675AbdDZISA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 26 Apr 2017 04:18:00 -0400
In-Reply-To: <cover.1493194142.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 5ecc479f62a57ab1e9d25ec3b0b84682fdf8a543

hwvalid.c - no trace needed for validate I/O function.

Link: https://github.com/acpica/acpica/commit/5ecc479f
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/hwvalid.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/hwvalid.c b/drivers/acpi/acpica/hwvalid.c
index 531620a..0b102e0 100644
--- a/drivers/acpi/acpica/hwvalid.c
+++ b/drivers/acpi/acpica/hwvalid.c
@@ -102,7 +102,7 @@ static const struct acpi_port_info acpi_protected_ports[] = {
 	{"PCI", 0x0CF8, 0x0CFF, ACPI_OSI_WIN_XP}
 };
 
-#define ACPI_PORT_INFO_ENTRIES  ACPI_ARRAY_LENGTH (acpi_protected_ports)
+#define ACPI_PORT_INFO_ENTRIES      ACPI_ARRAY_LENGTH (acpi_protected_ports)
 
 /******************************************************************************
  *
@@ -128,14 +128,14 @@ acpi_hw_validate_io_request(acpi_io_address address, u32 bit_width)
 	acpi_io_address last_address;
 	const struct acpi_port_info *port_info;
 
-	ACPI_FUNCTION_TRACE(hw_validate_io_request);
+	ACPI_FUNCTION_NAME(hw_validate_io_request);
 
 	/* Supported widths are 8/16/32 */
 
 	if ((bit_width != 8) && (bit_width != 16) && (bit_width != 32)) {
 		ACPI_ERROR((AE_INFO,
 			    "Bad BitWidth parameter: %8.8X", bit_width));
-		return (AE_BAD_PARAMETER);
+		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
 	port_info = acpi_protected_ports;
@@ -167,7 +167,7 @@ acpi_hw_validate_io_request(acpi_io_address address, u32 bit_width)
 	for (i = 0; i < ACPI_PORT_INFO_ENTRIES; i++, port_info++) {
 		/*
 		 * Check if the requested address range will write to a reserved
-		 * port. Four cases to consider:
+		 * port. There are four cases to consider:
 		 *
 		 * 1) Address range is contained completely in the port address range
 		 * 2) Address range overlaps port range at the port range start
@@ -206,7 +206,7 @@ acpi_hw_validate_io_request(acpi_io_address address, u32 bit_width)
  * FUNCTION:    acpi_hw_read_port
  *
  * PARAMETERS:  Address             Address of I/O port/register to read
- *              Value               Where value is placed
+ *              Value               Where value (data) is returned
  *              Width               Number of bits
  *
  * RETURN:      Status and value read from port
@@ -244,7 +244,7 @@ acpi_status acpi_hw_read_port(acpi_io_address address, u32 *value, u32 width)
 	/*
 	 * There has been a protection violation within the request. Fall
 	 * back to byte granularity port I/O and ignore the failing bytes.
-	 * This provides Windows compatibility.
+	 * This provides compatibility with other ACPI implementations.
 	 */
 	for (i = 0, *value = 0; i < width; i += 8) {
 
@@ -307,7 +307,7 @@ acpi_status acpi_hw_write_port(acpi_io_address address, u32 value, u32 width)
 	/*
 	 * There has been a protection violation within the request. Fall
 	 * back to byte granularity port I/O and ignore the failing bytes.
-	 * This provides Windows compatibility.
+	 * This provides compatibility with other ACPI implementations.
 	 */
 	for (i = 0; i < width; i += 8) {
 
-- 
2.7.4

