From: Len Brown <lenb@kernel.org>
Subject: [PATCH 23/65] ACPICA: Fix DebugObject output for DdbHandle objects
Date: Fri, 29 May 2009 21:42:01 -0400
Message-ID: <a76b7727364ebb77b25983427623757d2c99bbc3.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:50006 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757430AbZE3BnK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:43:10 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF007BFORG7OX2@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:42:53 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Was putting several extra spaces on the next line.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/exstore.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpica/exstore.c b/drivers/acpi/acpica/exstore.c
index 90d6061..6efd07a 100644
--- a/drivers/acpi/acpica/exstore.c
+++ b/drivers/acpi/acpica/exstore.c
@@ -193,10 +193,12 @@ acpi_ex_do_debug_object(union acpi_operand_object *source_desc,
 
 		case ACPI_REFCLASS_TABLE:
 
+			/* Case for ddb_handle */
+
 			ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT,
 					      "Table Index 0x%X\n",
 					      source_desc->reference.value));
-			break;
+			return;
 
 		default:
 			break;
-- 
1.6.0.6

