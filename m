From: Len Brown <lenb@kernel.org>
Subject: [PATCH 094/122] ACPICA: Improve object conversion error messages
Date: Thu, 23 Oct 2008 02:39:08 -0400
Message-ID: <c2de3a49454cdc9ca42bbd5d742913421d049f59.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:55856 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755454AbYJWGkf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:40:35 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K96002THIJ4SKAA@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:40:17 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Andi Kleen <ak@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Better error messages during object conversion from internal
to the external ACPI_OBJECT. Used for external calls to
acpi_evaluate_object.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/utilities/utobject.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/utilities/utobject.c b/drivers/acpi/utilities/utobject.c
index 916eff3..924d05a 100644
--- a/drivers/acpi/utilities/utobject.c
+++ b/drivers/acpi/utilities/utobject.c
@@ -503,7 +503,9 @@ acpi_ut_get_simple_object_size(union acpi_operand_object *internal_object,
 			 * required eventually.
 			 */
 			ACPI_ERROR((AE_INFO,
-				    "Unsupported Reference opcode=%X in object %p",
+				    "Cannot convert to external object - "
+				    "unsupported Reference type [%s] %X in object %p",
+				    acpi_ut_get_reference_name(internal_object),
 				    internal_object->reference.opcode,
 				    internal_object));
 			status = AE_TYPE;
@@ -513,7 +515,9 @@ acpi_ut_get_simple_object_size(union acpi_operand_object *internal_object,
 
 	default:
 
-		ACPI_ERROR((AE_INFO, "Unsupported type=%X in object %p",
+		ACPI_ERROR((AE_INFO, "Cannot convert to external object - "
+			    "unsupported type [%s] %X in object %p",
+			    acpi_ut_get_object_type_name(internal_object),
 			    ACPI_GET_OBJECT_TYPE(internal_object),
 			    internal_object));
 		status = AE_TYPE;
-- 
1.5.5.1

