From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 01/12] ACPICA: Debug output, no functional change
Date: Wed,  3 Jan 2018 15:06:20 -0800
Message-ID: <20180103230631.15939-2-erik.schmauss@intel.com>
References: <erik.schmauss@intel.com>
 <20180103230631.15939-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:43368 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751029AbeACXHk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Jan 2018 18:07:40 -0500
In-Reply-To: <20180103230631.15939-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 04fffc50a131662f57a41ca517c75d32d2479a1c

Fix use of return macros and other debug output changes.

Link: https://github.com/acpica/acpica/commit/04fffc50
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 drivers/acpi/acpica/hwvalid.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/hwvalid.c b/drivers/acpi/acpica/hwvalid.c
index 3094cec4eab4..d1679035d5f3 100644
--- a/drivers/acpi/acpica/hwvalid.c
+++ b/drivers/acpi/acpica/hwvalid.c
@@ -128,14 +128,14 @@ acpi_hw_validate_io_request(acpi_io_address address, u32 bit_width)
 	acpi_io_address last_address;
 	const struct acpi_port_info *port_info;
 
-	ACPI_FUNCTION_NAME(hw_validate_io_request);
+	ACPI_FUNCTION_TRACE(hw_validate_io_request);
 
 	/* Supported widths are 8/16/32 */
 
 	if ((bit_width != 8) && (bit_width != 16) && (bit_width != 32)) {
 		ACPI_ERROR((AE_INFO,
 			    "Bad BitWidth parameter: %8.8X", bit_width));
-		return (AE_BAD_PARAMETER);
+		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
 	port_info = acpi_protected_ports;
@@ -153,13 +153,13 @@ acpi_hw_validate_io_request(acpi_io_address address, u32 bit_width)
 		ACPI_ERROR((AE_INFO,
 			    "Illegal I/O port address/length above 64K: %8.8X%8.8X/0x%X",
 			    ACPI_FORMAT_UINT64(address), byte_width));
-		return (AE_LIMIT);
+		return_ACPI_STATUS(AE_LIMIT);
 	}
 
 	/* Exit if requested address is not within the protected port table */
 
 	if (address > acpi_protected_ports[ACPI_PORT_INFO_ENTRIES - 1].end) {
-		return (AE_OK);
+		return_ACPI_STATUS(AE_OK);
 	}
 
 	/* Check request against the list of protected I/O ports */
@@ -180,8 +180,8 @@ acpi_hw_validate_io_request(acpi_io_address address, u32 bit_width)
 			/* Port illegality may depend on the _OSI calls made by the BIOS */
 
 			if (acpi_gbl_osi_data >= port_info->osi_dependency) {
-				ACPI_DEBUG_PRINT((ACPI_DB_IO,
-						  "Denied AML access to port 0x%8.8X%8.8X/%X (%s 0x%.4X-0x%.4X)",
+				ACPI_DEBUG_PRINT((ACPI_DB_VALUES,
+						  "Denied AML access to port 0x%8.8X%8.8X/%X (%s 0x%.4X-0x%.4X)\n",
 						  ACPI_FORMAT_UINT64(address),
 						  byte_width, port_info->name,
 						  port_info->start,
@@ -198,7 +198,7 @@ acpi_hw_validate_io_request(acpi_io_address address, u32 bit_width)
 		}
 	}
 
-	return (AE_OK);
+	return_ACPI_STATUS(AE_OK);
 }
 
 /******************************************************************************
-- 
2.14.3

