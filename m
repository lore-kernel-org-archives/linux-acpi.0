From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 03/30] ACPICA: Interpreter: Remove temporary code for External() opcode
Date: Thu,  4 Aug 2016 16:42:42 +0800
Message-ID: <a71dfd3d935d9177ce729c83bc186516ce2099ee.1470299677.git.lv.zheng@intel.com>
References: <cover.1470299677.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:35354 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932352AbcHDImw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Aug 2016 04:42:52 -0400
In-Reply-To: <cover.1470299677.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit f2d349f8a11efc0f438ad6903564f3a6755dc6b9

The interpreter should never see this opcode (it is used by
disassemblers), so the final implementation is to return an
error.

Link: https://github.com/acpica/acpica/commit/f2d349f8
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/dsutils.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/acpica/dsutils.c b/drivers/acpi/acpica/dsutils.c
index f393de9..7d8ef52 100644
--- a/drivers/acpi/acpica/dsutils.c
+++ b/drivers/acpi/acpica/dsutils.c
@@ -565,15 +565,14 @@ acpi_ds_create_operand(struct acpi_walk_state *walk_state,
 					status = AE_OK;
 				} else if (parent_op->common.aml_opcode ==
 					   AML_EXTERNAL_OP) {
-
-					/* TBD: May only be temporary */
-
-					obj_desc =
-					    acpi_ut_create_string_object((acpi_size)name_length);
-
-					strncpy(obj_desc->string.pointer,
-						name_string, name_length);
-					status = AE_OK;
+					/*
+					 * This opcode should never appear here. It is used only
+					 * by AML disassemblers and is surrounded by an If(0)
+					 * by the ASL compiler.
+					 *
+					 * Therefore, if we see it here, it is a serious error.
+					 */
+					status = AE_AML_BAD_OPCODE;
 				} else {
 					/*
 					 * We just plain didn't find it -- which is a
-- 
1.7.10

