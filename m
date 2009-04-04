From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 02/12] thinkpad-acpi: drop ibm-acpi alias
Date: Sat,  4 Apr 2009 01:25:43 -0300
Message-ID: <1238819153-16004-3-git-send-email-hmh@hmh.eng.br>
References: <1238819153-16004-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:57433 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750751AbZDDEZ6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 4 Apr 2009 00:25:58 -0400
In-Reply-To: <1238819153-16004-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

The driver was renamed two years ago, on 2.6.21.  Drop the old
compatibility alias, we have given everybody quite enough time
to update their configs to the new name.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/platform/x86/thinkpad_acpi.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index fd6985b..5fd5549 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -7515,9 +7515,6 @@ static int __init thinkpad_acpi_module_init(void)
 	return 0;
 }
 
-/* Please remove this in year 2009 */
-MODULE_ALIAS("ibm_acpi");
-
 MODULE_ALIAS(TPACPI_DRVR_SHORTNAME);
 
 /*
-- 
1.6.2.1

