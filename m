From: Len Brown <lenb@kernel.org>
Subject: [PATCH 10/65] ACPICA: Change behavior of object copy for mutex/event
 objects
Date: Fri, 29 May 2009 21:41:48 -0400
Message-ID: <33a1d461d294722dd15ffe17651bdd48b5763883.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:39590 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756947AbZE3BnD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:43:03 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF00H0ROREPWW2@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:42:50 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

When copying these internal objects, cannot simply copy the
underlying OS object. A new OS object must be created.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/utcopy.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/utcopy.c b/drivers/acpi/acpica/utcopy.c
index 919624f..0f0c64b 100644
--- a/drivers/acpi/acpica/utcopy.c
+++ b/drivers/acpi/acpica/utcopy.c
@@ -676,6 +676,7 @@ acpi_ut_copy_simple_object(union acpi_operand_object *source_desc,
 {
 	u16 reference_count;
 	union acpi_operand_object *next_object;
+	acpi_status status;
 
 	/* Save fields from destination that we don't want to overwrite */
 
@@ -768,6 +769,28 @@ acpi_ut_copy_simple_object(union acpi_operand_object *source_desc,
 		}
 		break;
 
+		/*
+		 * For Mutex and Event objects, we cannot simply copy the underlying
+		 * OS object. We must create a new one.
+		 */
+	case ACPI_TYPE_MUTEX:
+
+		status = acpi_os_create_mutex(&dest_desc->mutex.os_mutex);
+		if (ACPI_FAILURE(status)) {
+			return status;
+		}
+		break;
+
+	case ACPI_TYPE_EVENT:
+
+		status = acpi_os_create_semaphore(ACPI_NO_UNIT_LIMIT, 0,
+						  &dest_desc->event.
+						  os_semaphore);
+		if (ACPI_FAILURE(status)) {
+			return status;
+		}
+		break;
+
 	default:
 		/* Nothing to do for other simple objects */
 		break;
-- 
1.6.0.6

