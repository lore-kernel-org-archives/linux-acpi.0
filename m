From: Len Brown <lenb@kernel.org>
Subject: [PATCH 43/140] ACPICA: Handle mis-matched package length
Date: Wed,  7 Feb 2007 13:50:57 -0500
Message-ID: <11708744311281-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org> <11708744253790-git-send-email-lenb@kernel.org> <11708744263395-git-send-email-lenb@kernel.org> <11708744273028-git-send-email-lenb@kernel.org> <11708744272354-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:31152 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422767AbXBGSyA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:54:00 -0500
In-Reply-To: <11708744272354-git-send-email-lenb@kernel.org>
Message-Id: <24058054d781934df526be114c612cf2b29cf4e7.1170873816.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Implement support within the AML interpreter for
package objects that contain a mismatch between the AML
length and package element count. In this case, the lesser
of the two is used. Some BIOS code apparently modifies
the package length on the fly, and this change supports
this. Provides compatibility with the MS AML interpreter.

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dispatcher/dsobject.c |   27 +++++++++++++++++++--------
 1 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/dispatcher/dsobject.c b/drivers/acpi/dispatcher/dsobject.c
index 72190ab..aaeb9f9 100644
--- a/drivers/acpi/dispatcher/dsobject.c
+++ b/drivers/acpi/dispatcher/dsobject.c
@@ -318,9 +318,7 @@ acpi_ds_build_internal_package_obj(struct acpi_walk_state *walk_state,
 		obj_desc->package.node = parent->common.node;
 	}
 
-	obj_desc->package.count = package_length;
-
-	/* Count the number of items in the package list */
+	/* Count the *actual* number of items in the package list */
 
 	arg = op->common.value.arg;
 	arg = arg->common.next;
@@ -329,11 +327,24 @@ acpi_ds_build_internal_package_obj(struct acpi_walk_state *walk_state,
 	}
 
 	/*
-	 * The package length (number of elements) will be the greater
-	 * of the specified length and the length of the initializer list
+	 * The number of elements in the package will be the lesser of the
+	 * specified element count and the length of the initializer list.
+	 *
+	 * Even though the ASL compilers do not allow this to happen (for the
+	 * fixed length package opcode), some BIOS code modifies the AML on the
+	 * fly to adjust the package length, and this code compensates for that.
+	 * This also provides compatibility with other AML interpreters.
 	 */
-	if (package_list_length > package_length) {
-		obj_desc->package.count = package_list_length;
+	obj_desc->package.count = package_length;
+
+	if (package_list_length != package_length) {
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+				  "Package length mismatch, using lesser of %X(Length Arg) and %X(AML Length)\n",
+				  package_length, package_list_length));
+
+		if (package_list_length < package_length) {
+			obj_desc->package.count = package_list_length;
+		}
 	}
 
 	/*
@@ -356,7 +367,7 @@ acpi_ds_build_internal_package_obj(struct acpi_walk_state *walk_state,
 	 */
 	arg = op->common.value.arg;
 	arg = arg->common.next;
-	for (i = 0; arg; i++) {
+	for (i = 0; i < obj_desc->package.count; i++) {
 		if (arg->common.aml_opcode == AML_INT_RETURN_VALUE_OP) {
 
 			/* Object (package or buffer) is already built */
-- 
1.5.0.rc3.39.gec804
