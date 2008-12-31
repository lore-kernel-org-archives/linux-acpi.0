From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Subject: [PATCH for mmotm1230] acpi: fix unused variable warnings
Date: Wed, 31 Dec 2008 23:42:28 +0900 (JST)
Message-ID: <20081231233807.1299.KOSAKI.MOTOHIRO@jp.fujitsu.com>
References: <200812310006.mBV060iV029753@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:44201 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753669AbYLaOmm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Dec 2008 09:42:42 -0500
In-Reply-To: <200812310006.mBV060iV029753@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: kosaki.motohiro@jp.fujitsu.com

Patch against: mmotm 1230
Applied after: linux-next.patch
==
Recently, added ifdef ACPI_20_GTS_BFS, then related variable declaration 
also move into it.


Signed-off-by: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
---
 drivers/acpi/hardware/hwsleep.c |   48 ++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 21 deletions(-)

Index: b/drivers/acpi/hardware/hwsleep.c
===================================================================
--- a/drivers/acpi/hardware/hwsleep.c	2008-12-31 14:22:33.000000000 +0900
+++ b/drivers/acpi/hardware/hwsleep.c	2008-12-31 14:52:40.000000000 +0900
@@ -227,8 +227,6 @@ acpi_status asmlinkage acpi_enter_sleep_
 	struct acpi_bit_register_info *sleep_type_reg_info;
 	struct acpi_bit_register_info *sleep_enable_reg_info;
 	u32 in_value;
-	struct acpi_object_list arg_list;
-	union acpi_object arg;
 	acpi_status status;
 
 	ACPI_FUNCTION_TRACE(acpi_enter_sleep_state);
@@ -277,14 +275,19 @@ acpi_status asmlinkage acpi_enter_sleep_
 #ifdef	ACPI_20_GTS_BFS
 	/* Execute the _GTS method */
 
-	arg_list.count = 1;
-	arg_list.pointer = &arg;
-	arg.type = ACPI_TYPE_INTEGER;
-	arg.integer.value = sleep_state;
-
-	status = acpi_evaluate_object(NULL, METHOD_NAME__GTS, &arg_list, NULL);
-	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
-		return_ACPI_STATUS(status);
+	{
+		struct acpi_object_list arg_list;
+		union acpi_object arg;
+
+		arg_list.count = 1;
+		arg_list.pointer = &arg;
+		arg.type = ACPI_TYPE_INTEGER;
+		arg.integer.value = sleep_state;
+
+		status = acpi_evaluate_object(NULL, METHOD_NAME__GTS,
+					      &arg_list, NULL);
+		if (ACPI_FAILURE(status) && status != AE_NOT_FOUND)
+			return_ACPI_STATUS(status);
 	}
 #endif
 
@@ -467,8 +470,6 @@ ACPI_EXPORT_SYMBOL(acpi_enter_sleep_stat
  ******************************************************************************/
 acpi_status acpi_leave_sleep_state_prep(u8 sleep_state)
 {
-	struct acpi_object_list arg_list;
-	union acpi_object arg;
 	acpi_status status;
 	struct acpi_bit_register_info *sleep_type_reg_info;
 	struct acpi_bit_register_info *sleep_enable_reg_info;
@@ -524,15 +525,20 @@ acpi_status acpi_leave_sleep_state_prep(
 
 #ifdef	ACPI_20_GTS_BFS
 	/* Execute the _BFS method */
-
-	arg_list.count = 1;
-	arg_list.pointer = &arg;
-	arg.type = ACPI_TYPE_INTEGER;
-	arg.integer.value = sleep_state;
-
-	status = acpi_evaluate_object(NULL, METHOD_NAME__BFS, &arg_list, NULL);
-	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
-		ACPI_EXCEPTION((AE_INFO, status, "During Method _BFS"));
+	{
+		struct acpi_object_list arg_list;
+		union acpi_object arg;
+
+		arg_list.count = 1;
+		arg_list.pointer = &arg;
+		arg.type = ACPI_TYPE_INTEGER;
+		arg.integer.value = sleep_state;
+
+		status = acpi_evaluate_object(NULL, METHOD_NAME__BFS,
+					      &arg_list, NULL);
+		if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
+			ACPI_EXCEPTION((AE_INFO, status, "During Method _BFS"));
+		}
 	}
 #endif
 



