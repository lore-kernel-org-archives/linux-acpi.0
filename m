From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 04/15] ACPICA: Fix several incorrect invocations of ACPICA return macro
Date: Wed, 26 Apr 2017 16:18:02 +0800
Message-ID: <9dc9fbff0de68a144bb47997af00558cb3979511.1493194142.git.lv.zheng@intel.com>
References: <cover.1493194142.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:4966 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1952686AbdDZISG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 26 Apr 2017 04:18:06 -0400
In-Reply-To: <cover.1493194142.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 521bedc49b42e59116de1b54dcd95d30d36cac90

Not needed since there is no function tracing for the
validation function in hwvalid.c

Link: https://github.com/acpica/acpica/commit/521bedc4
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/hwvalid.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/hwvalid.c b/drivers/acpi/acpica/hwvalid.c
index 0b102e0..3094cec 100644
--- a/drivers/acpi/acpica/hwvalid.c
+++ b/drivers/acpi/acpica/hwvalid.c
@@ -135,7 +135,7 @@ acpi_hw_validate_io_request(acpi_io_address address, u32 bit_width)
 	if ((bit_width != 8) && (bit_width != 16) && (bit_width != 32)) {
 		ACPI_ERROR((AE_INFO,
 			    "Bad BitWidth parameter: %8.8X", bit_width));
-		return_ACPI_STATUS(AE_BAD_PARAMETER);
+		return (AE_BAD_PARAMETER);
 	}
 
 	port_info = acpi_protected_ports;
@@ -153,13 +153,13 @@ acpi_hw_validate_io_request(acpi_io_address address, u32 bit_width)
 		ACPI_ERROR((AE_INFO,
 			    "Illegal I/O port address/length above 64K: %8.8X%8.8X/0x%X",
 			    ACPI_FORMAT_UINT64(address), byte_width));
-		return_ACPI_STATUS(AE_LIMIT);
+		return (AE_LIMIT);
 	}
 
 	/* Exit if requested address is not within the protected port table */
 
 	if (address > acpi_protected_ports[ACPI_PORT_INFO_ENTRIES - 1].end) {
-		return_ACPI_STATUS(AE_OK);
+		return (AE_OK);
 	}
 
 	/* Check request against the list of protected I/O ports */
@@ -198,7 +198,7 @@ acpi_hw_validate_io_request(acpi_io_address address, u32 bit_width)
 		}
 	}
 
-	return_ACPI_STATUS(AE_OK);
+	return (AE_OK);
 }
 
 /******************************************************************************
-- 
2.7.4

