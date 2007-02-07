From: Len Brown <lenb@kernel.org>
Subject: [PATCH 49/140] ACPICA: Temporary fix for BankValue parameter
Date: Wed,  7 Feb 2007 13:51:03 -0500
Message-ID: <11708744382626-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org> <11708744253790-git-send-email-lenb@kernel.org> <11708744263395-git-send-email-lenb@kernel.org> <11708744273028-git-send-email-lenb@kernel.org> <11708744272354-git-send-email-lenb@kernel.org> <11708744311281-git-send-email-lenb@kernel.org> <11708744322360-git-send-email-lenb@kernel.org> <1170874433382-git-send-email-lenb@kernel.org> <11708744353864-git-send-email-lenb@kernel.org> <11708744352790-git-send-email-lenb@kernel.org> <1170874437973-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:7266 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422758AbXBGSyE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:54:04 -0500
In-Reply-To: <1170874437973-git-send-email-lenb@kernel.org>
Message-Id: <9c52657a2ac8aac5149e11049497b10918e1f58f.1170873816.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

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
@@ -133,7 +133,8 @@ acpi_ds_create_buffer_field(union acpi_parse_object *op,
 		}
 	}
 
-	/* We could put the returned object (Node) on the object stack for later,
+	/*
+	 * We could put the returned object (Node) on the object stack for later,
 	 * but for now, we will put it in the "op" object that the parser uses,
 	 * so we can get it again at the end of this scope
 	 */
@@ -514,8 +515,33 @@ acpi_ds_create_bank_field(union acpi_parse_object *op,
 
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
1.5.0.rc3.39.gec804
