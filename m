From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/14] ACPICA: Add repair for bad _MAT buffers
Date: Wed, 09 Dec 2009 12:22:03 -0500
Message-ID: <0240d7b4f20f7d156a74dfdd0647a0231b7e8ef4.1260379153.git.len.brown@intel.com>
References: <1260379335-24263-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:52594 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754174AbZLIRW1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Dec 2009 12:22:27 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUE00A7XAX6PA96@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 09 Dec 2009 11:22:24 -0600 (CST)
In-reply-to: <1260379335-24263-1-git-send-email-lenb@kernel.org>
In-reply-to: <2752699392b828edf3123f911f6e8b4dd7daeb56.1260379153.git.len.brown@intel.com>
References: <2752699392b828edf3123f911f6e8b4dd7daeb56.1260379153.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

_MAT can inadvertently return an Integer instead of a Buffer
if the return value has been read from a Field whose width is
less than or equal to the global integer width (32 or 64 bits).
ACPICA BZ 810.

http://www.acpica.org/bugzilla/show_bug.cgi?id=810

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/nsrepair.c |   23 +++++++++++++++++++++--
 1 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/nsrepair.c b/drivers/acpi/acpica/nsrepair.c
index dfa31c5..f2f5269 100644
--- a/drivers/acpi/acpica/nsrepair.c
+++ b/drivers/acpi/acpica/nsrepair.c
@@ -44,6 +44,7 @@
 #include <acpi/acpi.h>
 #include "accommon.h"
 #include "acnamesp.h"
+#include "acinterp.h"
 #include "acpredef.h"
 
 #define _COMPONENT          ACPI_NAMESPACE
@@ -76,6 +77,7 @@ acpi_ns_repair_object(struct acpi_predefined_data *data,
 	union acpi_operand_object *return_object = *return_object_ptr;
 	union acpi_operand_object *new_object;
 	acpi_size length;
+	acpi_status status;
 
 	/*
 	 * At this point, we know that the type of the returned object was not
@@ -120,9 +122,26 @@ acpi_ns_repair_object(struct acpi_predefined_data *data,
 
 	case ACPI_TYPE_INTEGER:
 
-		/* Does the method/object legally return a string? */
+		/* 1) Does the method/object legally return a buffer? */
+
+		if (expected_btypes & ACPI_RTYPE_BUFFER) {
+			/*
+			 * Convert the Integer to a packed-byte buffer. _MAT needs
+			 * this sometimes, if a read has been performed on a Field
+			 * object that is less than or equal to the global integer
+			 * size (32 or 64 bits).
+			 */
+			status =
+			    acpi_ex_convert_to_buffer(return_object,
+						      &new_object);
+			if (ACPI_FAILURE(status)) {
+				return (status);
+			}
+		}
+
+		/* 2) Does the method/object legally return a string? */
 
-		if (expected_btypes & ACPI_RTYPE_STRING) {
+		else if (expected_btypes & ACPI_RTYPE_STRING) {
 			/*
 			 * The only supported Integer-to-String conversion is to convert
 			 * an integer of value 0 to a NULL string. The last element of
-- 
1.6.0.6

