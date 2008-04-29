From: Len Brown <lenb@kernel.org>
Subject: [PATCH 171/171] thinkpad_acpi: fix possible NULL pointer dereference if kstrdup failed
Date: Tue, 29 Apr 2008 04:44:35 -0400
Message-ID: <4ab9b7d232ea17f0f927886eaa1b10910da9c130.1209457073.git.len.brown@intel.com>
References: <1209458675-9757-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:45231 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755857AbYD2Ips (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2008 04:45:48 -0400
In-Reply-To: <1209458675-9757-1-git-send-email-lenb@kernel.org>
In-Reply-To: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
References: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Cyrill Gorcunov <gorcunov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Cyrill Gorcunov <gorcunov@gmail.com>

Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/thinkpad_acpi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 6cb7812..31115c9 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -5826,7 +5826,7 @@ static void __init get_thinkpad_model_data(struct thinkpad_id_data *tp)
 
 	tp->model_str = kstrdup(dmi_get_system_info(DMI_PRODUCT_VERSION),
 					GFP_KERNEL);
-	if (strnicmp(tp->model_str, "ThinkPad", 8) != 0) {
+	if (tp->model_str && strnicmp(tp->model_str, "ThinkPad", 8) != 0) {
 		kfree(tp->model_str);
 		tp->model_str = NULL;
 	}
-- 
1.5.5.1.99.gf0ec4

