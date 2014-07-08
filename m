From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 21/25] ACPICA: Executer: Fix trivial issues in acpi_get_serial_access_bytes().
Date: Tue,  8 Jul 2014 10:08:05 +0800
Message-ID: <72b65f09ef5c8604eef4f032edbc0f07e58996fd.1404277202.git.lv.zheng@intel.com>
References: <cover.1404277202.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:64949 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753427AbaGHCIL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Jul 2014 22:08:11 -0400
In-Reply-To: <cover.1404277202.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

This patch fixes trivial issues in acpi_get_serial_access_bytes(), no real
functional bugs. Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/exfield.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
index 12878e1..1ff42c0 100644
--- a/drivers/acpi/acpica/exfield.c
+++ b/drivers/acpi/acpica/exfield.c
@@ -56,7 +56,7 @@ acpi_ex_get_serial_access_length(u32 accessor_type, u32 access_length);
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_get_serial_access_bytes
+ * FUNCTION:    acpi_ex_get_serial_access_length
  *
  * PARAMETERS:  accessor_type   - The type of the protocol indicated by region
  *                                field access attributes
@@ -103,7 +103,7 @@ acpi_ex_get_serial_access_length(u32 accessor_type, u32 access_length)
 	case AML_FIELD_ATTRIB_BLOCK_CALL:
 	default:
 
-		length = ACPI_GSBUS_BUFFER_SIZE;
+		length = ACPI_GSBUS_BUFFER_SIZE - 2;
 		break;
 	}
 
-- 
1.7.10

