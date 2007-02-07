From: Len Brown <lenb@kernel.org>
Subject: [PATCH 76/140] ACPICA: Report error if method creates 2 objects with the same name
Date: Wed,  7 Feb 2007 13:51:30 -0500
Message-ID: <11708744903381-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org> <11708744253790-git-send-email-lenb@kernel.org> <11708744263395-git-send-email-lenb@kernel.org> <11708744273028-git-send-email-lenb@kernel.org> <11708744272354-git-send-email-lenb@kernel.org> <11708744311281-git-send-email-lenb@kernel.org> <11708744322360-git-send-email-lenb@kernel.org> <1170874433382-git-send-email-lenb@kernel.org> <11708744353864-git-send-email-lenb@kernel.org> <11708744352790-git-send-email-lenb@kernel.org> <1170874437973-git-send-email-lenb@kernel.org> <11708744382626-git-send-email-lenb@kernel.org> <11708744402139-git-send-email-lenb@kernel.org> <11708744413743-git-send-email-lenb@kernel.org> <117087444256-git-send-email-lenb@kernel.org> <11708744461131-git-send-email-lenb@kernel.org> <1170874451354
 1-git-send-email-lenb@kernel.org> <11708744522444-git-send-email-lenb@kernel.org> <1170874453363-git-send-email-lenb@kernel.org> <11708744542419-git-send-email-lenb@kernel.org> <11708744562243-git-send-email-lenb@kernel.org> <1170874458256-git-send-email-lenb@kernel.org> <11708744603317-git-send-email-lenb@kernel.org> <11708744612314-git-send-email-lenb@kernel.org> <117087446376-git-send-email-lenb@kernel.org> <11708744642267-git-send-email-lenb@kernel.org> <11708744674050-git-send-email-lenb@kernel.org> <11708744692041-git-send-email-lenb@kernel.org> <11708744712690-git-send-email-lenb@kernel.org> <11708744732351-git-send-email-lenb@kernel.org> <11708744752537-git-send-email-lenb@kernel.org> <11708744772462-git-send-email-lenb@kernel.org> <11708744803527-git-send-email-lenb@kernel.org> <11708744813011-git-send-email-lenb@kernel.org> <11708744852095-git-send-email-lenb@kernel.org> <117
 08744874154-git-send-email-lenb@kernel.org> <11708744878-git-send-email-lenb@kernel.org> <1170874488430-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:26503 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422790AbXBGSyv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:54:51 -0500
In-Reply-To: <1170874488430-git-send-email-lenb@kernel.org>
Message-Id: <13b572a35ed904ae1e162f8ee89ca7fd6992b44c.1170873817.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

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
@@ -547,6 +547,7 @@ acpi_ds_load2_begin_op(struct acpi_walk_state *walk_state,
 	acpi_status status;
 	acpi_object_type object_type;
 	char *buffer_ptr;
+	u32 flags;
 
 	ACPI_FUNCTION_TRACE(ds_load2_begin_op);
 
@@ -752,12 +753,20 @@ acpi_ds_load2_begin_op(struct acpi_walk_state *walk_state,
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
@@ -540,6 +540,11 @@ acpi_status acpi_ps_parse_aml(struct acpi_walk_state *walk_state)
 
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
1.5.0.rc3.39.gec804
