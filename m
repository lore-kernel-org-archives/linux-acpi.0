From: Len Brown <len.brown@intel.com>
Subject: [PATCH 8/65] ACPICA: Temporary fix for BankValue parameter
Date: Fri, 24 Nov 2006 02:18:18 -0500
Message-ID: <11643527631929-git-send-email-len.brown@intel.com>
References: <1164352755500-git-send-email-len.brown@intel.com> <11643527561399-git-send-email-len.brown@intel.com> <11643527572123-git-send-email-len.brown@intel.com> <11643527582206-git-send-email-len.brown@intel.com> <11643527591227-git-send-email-len.brown@intel.com> <11643527604195-git-send-email-len.brown@intel.com> <1164352761941-git-send-email-len.brown@intel.com> <1164352762703-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:49574 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S934461AbWKXHPY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 02:15:24 -0500
In-Reply-To: <1164352762703-git-send-email-len.brown@intel.com>
Message-Id: <c439b8a0815e3992b20e20f5890daf0c494f9519.1164352288.git.len.brown@intel.com>
In-Reply-To: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
References: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Robert Moore <robert.moore@intel.com>

Temporary fix for BankValue parameter of a Bank
Field to support all constant values, including Zero
and One. Must eventually be converted to a full TermArg
evaluation.

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dispatcher/dsfield.c |   30 ++++++++++++++++++++++++++++--
 1 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/dispatcher/dsfield.c b/drivers/acpi/dispatcher/dsfield.c
index a6d77ef..379dd71 100644
--- a/drivers/acpi/dispatcher/dsfield.c
+++ b/drivers/acpi/dispatcher/dsfield.c
@@ -133,7 +133,8 @@ acpi_ds_create_buffer_field(union acpi_p
 		}
 	}
 
-	/* We could put the returned object (Node) on the object stack for later,
+	/*
+	 * We could put the returned object (Node) on the object stack for later,
 	 * but for now, we will put it in the "op" object that the parser uses,
 	 * so we can get it again at the end of this scope
 	 */
@@ -514,8 +515,33 @@ acpi_ds_create_bank_field(union acpi_par
 
 	/* Third arg is the bank_value */
 
+	/* TBD: This arg is a term_arg, not a constant, and must be evaluated */
+
 	arg = arg->common.next;
-	info.bank_value = (u32) arg->common.value.integer;
+
+	/* Currently, only the following constants are supported */
+
+	switch (arg->common.aml_opcode) {
+	case AML_ZERO_OP:
+		info.bank_value = 0;
+		break;
+
+	case AML_ONE_OP:
+		info.bank_value = 1;
+		break;
+
+	case AML_BYTE_OP:
+	case AML_WORD_OP:
+	case AML_DWORD_OP:
+	case AML_QWORD_OP:
+		info.bank_value = (u32) arg->common.value.integer;
+		break;
+
+	default:
+		info.bank_value = 0;
+		ACPI_ERROR((AE_INFO,
+			    "Non-constant BankValue for BankField is not implemented"));
+	}
 
 	/* Fourth arg is the field flags */
 
-- 
1.4.4.1
