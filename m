From: Len Brown <len.brown@intel.com>
Subject: [PATCH 45/65] ACPICA: Update interpreter error paths to always report the error
Date: Fri, 24 Nov 2006 02:18:55 -0500
Message-ID: <11643528062723-git-send-email-len.brown@intel.com>
References: <1164352755500-git-send-email-len.brown@intel.com> <11643527561399-git-send-email-len.brown@intel.com> <11643527572123-git-send-email-len.brown@intel.com> <11643527582206-git-send-email-len.brown@intel.com> <11643527591227-git-send-email-len.brown@intel.com> <11643527604195-git-send-email-len.brown@intel.com> <1164352761941-git-send-email-len.brown@intel.com> <1164352762703-git-send-email-len.brown@intel.com> <11643527631929-git-send-email-len.brown@intel.com> <11643527633954-git-send-email-len.brown@intel.com> <11643527641142-git-send-email-len.brown@intel.com> <11643527654192-git-send-email-len.brown@intel.com> <11643527703526-git-send-email-len.brown@intel.com> <11643527731111-git-send-email-len.brown@intel.com> <11643527743390-git-send-email-len.brown@intel.com> <11643527752251-git-send-email-len.brown@intel.com> <1164352776767-git-send-email-len.brown@intel.com> <1164352
 7782767-git-send-email-len.brown@intel.com> <11643527804057-git-send-email-len.brown@intel.com> <11643527812144-git-send-email-len.brown@intel.com> <11643527821346-git-send-email-len.brown@intel.com> <11643527832869-git-send-email-len.brown@intel.com> <11643527843465-git-send-email-len.brown@intel.com> <11643527853403-git-send-email-len.brown@intel.com> <1164352786236-git-send-email-len.brown@intel.com> <11643527871558-git-send-email-len.brown@intel.com> <1164352787694-git-send-email-len.brown@intel.com> <1164352788512-git-send-email-len.brown@intel.com> <11643527891947-git-send-email-len.brown@intel.com> <1164352791852-git-send-email-len.brown@intel.com> <1164352792447-git-send-email-len.brown@intel.com> <11643527931850-git-send-email-len.brown@intel.com> <11643527943385-git-send-email-len.brown@intel.com> <11643527951196-git-send-email-len.brown@intel.com> <1164352796746-git-send-ema
 il-len.brown@intel.com> <11643527973892-git-send-email-len.brown@intel.com> <11643527982269-git-send-email-len.brown@intel.com> <11643527993578-git-send-email-len.brown@intel.com> <11643527992802-git-send-email-len.brown@intel.com> <11643528001078-git-send-email-len.brown@intel.com> <11643528013509-git-send-email-len.brown@intel.com> <11643528022585-git-send-email-len.brown@intel.com> <11643528032291-git-send-email-len.brown@intel.com> <11643528042439-git-send-email-len.brown@intel.com> <11643528053298-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:12136 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S934487AbWKXHQI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 02:16:08 -0500
In-Reply-To: <11643528053298-git-send-email-len.brown@intel.com>
Message-Id: <fe21784a741d247ff18c34d67d56f5d374a0b5cb.1164352294.git.len.brown@intel.com>
In-Reply-To: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
References: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Robert Moore <robert.moore@intel.com>

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dispatcher/dswexec.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/dispatcher/dswexec.c b/drivers/acpi/dispatcher/dswexec.c
index d7a616c..b5b8f16 100644
--- a/drivers/acpi/dispatcher/dswexec.c
+++ b/drivers/acpi/dispatcher/dswexec.c
@@ -219,7 +219,7 @@ acpi_ds_exec_begin_op(struct acpi_walk_s
 	if (!op) {
 		status = acpi_ds_load2_begin_op(walk_state, out_op);
 		if (ACPI_FAILURE(status)) {
-			return_ACPI_STATUS(status);
+			goto error_exit;
 		}
 
 		op = *out_op;
@@ -238,7 +238,7 @@ acpi_ds_exec_begin_op(struct acpi_walk_s
 
 			status = acpi_ds_scope_stack_pop(walk_state);
 			if (ACPI_FAILURE(status)) {
-				return_ACPI_STATUS(status);
+				goto error_exit;
 			}
 		}
 	}
@@ -287,7 +287,7 @@ acpi_ds_exec_begin_op(struct acpi_walk_s
 
 		status = acpi_ds_result_stack_push(walk_state);
 		if (ACPI_FAILURE(status)) {
-			return_ACPI_STATUS(status);
+			goto error_exit;
 		}
 
 		status = acpi_ds_exec_begin_control_op(walk_state, op);
@@ -328,6 +328,10 @@ acpi_ds_exec_begin_op(struct acpi_walk_s
 	/* Nothing to do here during method execution */
 
 	return_ACPI_STATUS(status);
+
+      error_exit:
+	status = acpi_ds_method_error(status, walk_state);
+	return_ACPI_STATUS(status);
 }
 
 /*****************************************************************************
-- 
1.4.4.1
