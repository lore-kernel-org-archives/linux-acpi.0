From: Len Brown <lenb@kernel.org>
Subject: [PATCH 20/85] ACPICA: Improve object conversion error messages
Date: Sat, 11 Oct 2008 02:35:40 -0400
Message-ID: <a98a40d2a43c94ff221929096561ed4f4394e95d.1223706853.git.len.brown@intel.com>
References: <1223707005-26864-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms172069pub.verizon.net ([206.46.172.69]:65510 "EHLO
	vms172069pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbYJKGgz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Oct 2008 02:36:55 -0400
In-reply-to: <1223707005-26864-1-git-send-email-lenb@kernel.org>
In-reply-to: <1d80ebdb81444701024ad9b9f026516561496a43.1223706853.git.len.brown@intel.com>
References: <1d80ebdb81444701024ad9b9f026516561496a43.1223706853.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
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

