From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 3/5] thinkpad-acpi: fix use of MODULE_AUTHOR
Date: Mon, 13 Apr 2009 23:44:12 -0300
Message-ID: <1239677054-3221-4-git-send-email-hmh@hmh.eng.br>
References: <1239677054-3221-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:50264 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752254AbZDNCoW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Apr 2009 22:44:22 -0400
In-Reply-To: <1239677054-3221-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Fix the module to use one instance of MODULE_AUTHOR per author.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/platform/x86/thinkpad_acpi.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index a1d2abc..7a7cac2 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -7883,7 +7883,8 @@ IBM_BIOS_MODULE_ALIAS("I[BDHIMNOTWVYZ]");
 IBM_BIOS_MODULE_ALIAS("1[0368A-GIKM-PST]");
 IBM_BIOS_MODULE_ALIAS("K[UX-Z]");
 
-MODULE_AUTHOR("Borislav Deianov, Henrique de Moraes Holschuh");
+MODULE_AUTHOR("Borislav Deianov <borislav@users.sf.net>");
+MODULE_AUTHOR("Henrique de Moraes Holschuh <hmh@hmh.eng.br>");
 MODULE_DESCRIPTION(TPACPI_DESC);
 MODULE_VERSION(TPACPI_VERSION);
 MODULE_LICENSE("GPL");
-- 
1.6.2.1

