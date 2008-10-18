From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 3/4] ACPI: thinkpad-acpi: Remove duplicate line
Date: Sat, 18 Oct 2008 14:23:54 -0300
Message-ID: <1224350635-14021-4-git-send-email-hmh@hmh.eng.br>
References: <1224350635-14021-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:53517 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750922AbYJRRYD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 18 Oct 2008 13:24:03 -0400
In-Reply-To: <1224350635-14021-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Pascal Terjan <pterjan@mandriva.com>

From: Pascal Terjan <pterjan@mandriva.com>

Signed-off-by: Pascal Terjan <pterjan@mandriva.com>
Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/misc/thinkpad_acpi.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 6c9b6c8..4c47f9b 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -159,7 +159,6 @@ enum {
 #define TPACPI_DEBUG  KERN_DEBUG  TPACPI_LOG
 
 #define TPACPI_DBG_ALL		0xffff
-#define TPACPI_DBG_ALL		0xffff
 #define TPACPI_DBG_INIT		0x0001
 #define TPACPI_DBG_EXIT		0x0002
 #define dbg_printk(a_dbg_level, format, arg...) \
-- 
1.5.6.5

