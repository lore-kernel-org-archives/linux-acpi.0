From: akpm@linux-foundation.org
Subject: [patch 9/9] ThinkPad ACPI: fix possible NULL pointer dereference
Date: Fri, 18 Apr 2008 13:27:29 -0700
Message-ID: <200804182027.m3IKRUlu013564@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34398 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752868AbYDRU1w (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Apr 2008 16:27:52 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, gorcunov@gmail.com, hmh@hmh.eng.br

From: Cyrill Gorcunov <gorcunov@gmail.com>

Fix potential NULL pointer dereference if kstrdup failed

Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/misc/thinkpad_acpi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/misc/thinkpad_acpi.c~thinkpad-acpi-fix-possible-null-pointer-dereference drivers/misc/thinkpad_acpi.c
--- a/drivers/misc/thinkpad_acpi.c~thinkpad-acpi-fix-possible-null-pointer-dereference
+++ a/drivers/misc/thinkpad_acpi.c
@@ -5826,7 +5826,7 @@ static void __init get_thinkpad_model_da
 
 	tp->model_str = kstrdup(dmi_get_system_info(DMI_PRODUCT_VERSION),
 					GFP_KERNEL);
-	if (strnicmp(tp->model_str, "ThinkPad", 8) != 0) {
+	if (tp->model_str && strnicmp(tp->model_str, "ThinkPad", 8) != 0) {
 		kfree(tp->model_str);
 		tp->model_str = NULL;
 	}
_
