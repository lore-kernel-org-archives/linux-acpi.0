From: Shraddha Barke <shraddha.6596@gmail.com>
Subject: [PATCH 2756/2756] Staging: acpi: Merge lines for immediate return
Date: Fri, 24 Jul 2015 22:30:56 +0530
Message-ID: <1437757256-10228-1-git-send-email-shraddha.6596@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33621 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753102AbbGXRCK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Jul 2015 13:02:10 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>, Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Shraddha Barke <shraddha.6596@gmail.com>

This patch merges two lines in a single line if immediate return is found.
This is done using Coccinelle.Semantic patch used for this is as follows:

@@
expression ret;
identifier f;
@@

-ret =
+return
     f(...);
-return ret;

Signed-off-by: Shraddha Barke <shraddha.6596@gmail.com>
---
 drivers/acpi/apei/erst.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index 3670bba..58e1bdd 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -162,8 +162,7 @@ static int erst_exec_add_value(struct apei_exec_context *ctx,
 	if (rc)
 		return rc;
 	val += ctx->value;
-	rc = __apei_exec_write_register(entry, val);
-	return rc;
+	return __apei_exec_write_register(entry, val);
 }
 
 static int erst_exec_subtract_value(struct apei_exec_context *ctx,
@@ -176,8 +175,7 @@ static int erst_exec_subtract_value(struct apei_exec_context *ctx,
 	if (rc)
 		return rc;
 	val -= ctx->value;
-	rc = __apei_exec_write_register(entry, val);
-	return rc;
+	return __apei_exec_write_register(entry, val);
 }
 
 static int erst_exec_stall(struct apei_exec_context *ctx,
@@ -979,9 +977,7 @@ static int erst_open_pstore(struct pstore_info *psi)
 	if (erst_disable)
 		return -ENODEV;
 
-	rc = erst_get_record_id_begin(&reader_pos);
-
-	return rc;
+	return erst_get_record_id_begin(&reader_pos);
 }
 
 static int erst_close_pstore(struct pstore_info *psi)
-- 
2.1.0

