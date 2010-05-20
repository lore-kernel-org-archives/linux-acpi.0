From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/22] ACPICA: Add write support for DataTable operation regions
Date: Thu, 20 May 2010 01:18:36 -0400
Message-ID: <c1637e9c649a0eb72c467041d78275aabdd48a41.1274332657.git.len.brown@intel.com>
References: <1274332730-27370-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:34419 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756Ab0ETFTQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 May 2010 01:19:16 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L2P005GBDFJHSC0@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 20 May 2010 00:19:01 -0500 (CDT)
In-reply-to: <1274332730-27370-1-git-send-email-lenb@kernel.org>
In-reply-to: <4cdf1a562bfb5852954aadbe8515557b8acc8168.1274332657.git.len.brown@intel.com>
References: <4cdf1a562bfb5852954aadbe8515557b8acc8168.1274332657.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

The original implementation only supported reading from a DataTable
region. However, some machines have been seen that actually write
to the ACPI table contained in such a region. This change adds
support for writing to a DataTable region.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/exregion.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index a8703cc..531000f 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -491,8 +491,10 @@ acpi_ex_data_table_space_handler(u32 function,
 {
 	ACPI_FUNCTION_TRACE(ex_data_table_space_handler);
 
-	/* Perform the memory read or write */
-
+	/*
+	 * Perform the memory read or write. The bit_width was already
+	 * validated.
+	 */
 	switch (function) {
 	case ACPI_READ:
 
@@ -502,9 +504,14 @@ acpi_ex_data_table_space_handler(u32 function,
 		break;
 
 	case ACPI_WRITE:
+
+		ACPI_MEMCPY(ACPI_PHYSADDR_TO_PTR(address),
+			    ACPI_CAST_PTR(char, value), ACPI_DIV_8(bit_width));
+		break;
+
 	default:
 
-		return_ACPI_STATUS(AE_SUPPORT);
+		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
 	return_ACPI_STATUS(AE_OK);
-- 
1.6.0.6

