From: Len Brown <len.brown@intel.com>
Subject: [PATCH 46/65] ACPICA: Fix for possible memory leak and fault.
Date: Fri, 24 Nov 2006 02:18:56 -0500
Message-ID: <1164352807227-git-send-email-len.brown@intel.com>
References: <1164352755500-git-send-email-len.brown@intel.com> <11643527561399-git-send-email-len.brown@intel.com> <11643527572123-git-send-email-len.brown@intel.com> <11643527582206-git-send-email-len.brown@intel.com> <11643527591227-git-send-email-len.brown@intel.com> <11643527604195-git-send-email-len.brown@intel.com> <1164352761941-git-send-email-len.brown@intel.com> <1164352762703-git-send-email-len.brown@intel.com> <11643527631929-git-send-email-len.brown@intel.com> <11643527633954-git-send-email-len.brown@intel.com> <11643527641142-git-send-email-len.brown@intel.com> <11643527654192-git-send-email-len.brown@intel.com> <11643527703526-git-send-email-len.brown@intel.com> <11643527731111-git-send-email-len.brown@intel.com> <11643527743390-git-send-email-len.brown@intel.com> <11643527752251-git-send-email-len.brown@intel.com> <1164352776767-git-send-email-len.brown@intel.com> <1164352
 7782767-git-send-email-len.brown@intel.com> <11643527804057-git-send-email-len.brown@intel.com> <11643527812144-git-send-email-len.brown@intel.com> <11643527821346-git-send-email-len.brown@intel.com> <11643527832869-git-send-email-len.brown@intel.com> <11643527843465-git-send-email-len.brown@intel.com> <11643527853403-git-send-email-len.brown@intel.com> <1164352786236-git-send-email-len.brown@intel.com> <11643527871558-git-send-email-len.brown@intel.com> <1164352787694-git-send-email-len.brown@intel.com> <1164352788512-git-send-email-len.brown@intel.com> <11643527891947-git-send-email-len.brown@intel.com> <1164352791852-git-send-email-len.brown@intel.com> <1164352792447-git-send-email-len.brown@intel.com> <11643527931850-git-send-email-len.brown@intel.com> <11643527943385-git-send-email-len.brown@intel.com> <11643527951196-git-send-email-len.brown@intel.com> <1164352796746-git-send-ema
 il-len.brown@intel.com> <11643527973892-git-send-email-len.brown@intel.com> <11643527982269-git-send-email-len.brown@intel.com> <11643527993578-git-send-email-len.brown@intel.com> <11643527992802-git-send-email-len.brown@intel.com> <11643528001078-git-send-email-len.brown@intel.com> <11643528013509-git-send-email-len.brown@intel.com> <11643528022585-git-send-email-len.brown@intel.com> <11643528032291-git-send-email-len.brown@intel.com> <11643528042439-git-send-email-len.brown@intel.com> <11643528053298-git-send-email-len.brown@intel.com> <11643528062723-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:41795 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S934491AbWKXHQJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 02:16:09 -0500
In-Reply-To: <11643528062723-git-send-email-len.brown@intel.com>
Message-Id: <d9debf4714e309c46d37e11d73f3eef7bdff67ff.1164352294.git.len.brown@intel.com>
In-Reply-To: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
References: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Robert Moore <robert.moore@intel.com>

Fixed a possible memory leak and fault in acpi_ex_resolve_object_to_value()
during a read from a buffer or region field. (BZ 458)

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/executer/exresolv.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/executer/exresolv.c b/drivers/acpi/executer/exresolv.c
index 6499de8..fa17f55 100644
--- a/drivers/acpi/executer/exresolv.c
+++ b/drivers/acpi/executer/exresolv.c
@@ -141,7 +141,7 @@ acpi_ex_resolve_object_to_value(union ac
 	acpi_status status = AE_OK;
 	union acpi_operand_object *stack_desc;
 	void *temp_node;
-	union acpi_operand_object *obj_desc;
+	union acpi_operand_object *obj_desc = NULL;
 	u16 opcode;
 
 	ACPI_FUNCTION_TRACE(ex_resolve_object_to_value);
@@ -299,8 +299,6 @@ acpi_ex_resolve_object_to_value(union ac
 		status = acpi_ds_get_package_arguments(stack_desc);
 		break;
 
-		/* These cases may never happen here, but just in case.. */
-
 	case ACPI_TYPE_BUFFER_FIELD:
 	case ACPI_TYPE_LOCAL_REGION_FIELD:
 	case ACPI_TYPE_LOCAL_BANK_FIELD:
@@ -314,6 +312,10 @@ acpi_ex_resolve_object_to_value(union ac
 		status =
 		    acpi_ex_read_data_from_field(walk_state, stack_desc,
 						 &obj_desc);
+
+		/* Remove a reference to the original operand, then override */
+
+		acpi_ut_remove_reference(*stack_ptr);
 		*stack_ptr = (void *)obj_desc;
 		break;
 
-- 
1.4.4.1
