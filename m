From: Len Brown <len.brown@intel.com>
Subject: [PATCH 35/65] ACPICA: Report error if method creates 2 objects with the same name
Date: Fri, 24 Nov 2006 02:18:45 -0500
Message-ID: <11643527973892-git-send-email-len.brown@intel.com>
References: <1164352755500-git-send-email-len.brown@intel.com> <11643527561399-git-send-email-len.brown@intel.com> <11643527572123-git-send-email-len.brown@intel.com> <11643527582206-git-send-email-len.brown@intel.com> <11643527591227-git-send-email-len.brown@intel.com> <11643527604195-git-send-email-len.brown@intel.com> <1164352761941-git-send-email-len.brown@intel.com> <1164352762703-git-send-email-len.brown@intel.com> <11643527631929-git-send-email-len.brown@intel.com> <11643527633954-git-send-email-len.brown@intel.com> <11643527641142-git-send-email-len.brown@intel.com> <11643527654192-git-send-email-len.brown@intel.com> <11643527703526-git-send-email-len.brown@intel.com> <11643527731111-git-send-email-len.brown@intel.com> <11643527743390-git-send-email-len.brown@intel.com> <11643527752251-git-send-email-len.brown@intel.com> <1164352776767-git-send-email-len.brown@intel.com> <1164352
 7782767-git-send-email-len.brown@intel.com> <11643527804057-git-send-email-len.brown@intel.com> <11643527812144-git-send-email-len.brown@intel.com> <11643527821346-git-send-email-len.brown@intel.com> <11643527832869-git-send-email-len.brown@intel.com> <11643527843465-git-send-email-len.brown@intel.com> <11643527853403-git-send-email-len.brown@intel.com> <1164352786236-git-send-email-len.brown@intel.com> <11643527871558-git-send-email-len.brown@intel.com> <1164352787694-git-send-email-len.brown@intel.com> <1164352788512-git-send-email-len.brown@intel.com> <11643527891947-git-send-email-len.brown@intel.com> <1164352791852-git-send-email-len.brown@intel.com> <1164352792447-git-send-email-len.brown@intel.com> <11643527931850-git-send-email-len.brown@intel.com> <11643527943385-git-send-email-len.brown@intel.com> <11643527951196-git-send-email-len.brown@intel.com> <1164352796746-git-send-ema
 il-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:35472 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S934468AbWKXHP7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 02:15:59 -0500
In-Reply-To: <1164352796746-git-send-email-len.brown@intel.com>
Message-Id: <c2b3bf4643dbb78eb201b921c55d8a842d7f4d7b.1164352294.git.len.brown@intel.com>
In-Reply-To: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
References: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Robert Moore <robert.moore@intel.com>

Fixed a regression where an error was no
longer emitted if a control method attempts to create 2
objects of the same name. This previously and now returns
AE_ALREADY_EXISTS. When this exception occurs, it invokes
the mechanism that will dynamically serialize the control
method to possible prevent future errors. (BZ 440)

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dispatcher/dswload.c |   15 ++++++++++++---
 drivers/acpi/parser/psparse.c     |    5 +++++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/dispatcher/dswload.c b/drivers/acpi/dispatcher/dswload.c
index d60d062..565d455 100644
--- a/drivers/acpi/dispatcher/dswload.c
+++ b/drivers/acpi/dispatcher/dswload.c
@@ -547,6 +547,7 @@ acpi_ds_load2_begin_op(struct acpi_walk_
 	acpi_status status;
 	acpi_object_type object_type;
 	char *buffer_ptr;
+	u32 flags;
 
 	ACPI_FUNCTION_TRACE(ds_load2_begin_op);
 
@@ -752,12 +753,20 @@ acpi_ds_load2_begin_op(struct acpi_walk_
 			break;
 		}
 
-		/* Add new entry into namespace */
+		flags = ACPI_NS_NO_UPSEARCH;
+		if (walk_state->pass_number == 3) {
+
+			/* Execution mode, node cannot already exist */
+
+			flags |= ACPI_NS_ERROR_IF_FOUND;
+		}
+
+		/* Add new entry or lookup existing entry */
 
 		status =
 		    acpi_ns_lookup(walk_state->scope_info, buffer_ptr,
-				   object_type, ACPI_IMODE_LOAD_PASS2,
-				   ACPI_NS_NO_UPSEARCH, walk_state, &(node));
+				   object_type, ACPI_IMODE_LOAD_PASS2, flags,
+				   walk_state, &node);
 		break;
 	}
 
diff --git a/drivers/acpi/parser/psparse.c b/drivers/acpi/parser/psparse.c
index a02aa62..6e875ce 100644
--- a/drivers/acpi/parser/psparse.c
+++ b/drivers/acpi/parser/psparse.c
@@ -540,6 +540,11 @@ acpi_status acpi_ps_parse_aml(struct acp
 
 			if ((status == AE_ALREADY_EXISTS) &&
 			    (!walk_state->method_desc->method.mutex)) {
+				ACPI_INFO((AE_INFO,
+					   "Marking method %4.4s as Serialized",
+					   walk_state->method_node->name.
+					   ascii));
+
 				/*
 				 * Method tried to create an object twice. The probable cause is
 				 * that the method cannot handle reentrancy.
-- 
1.4.4.1
