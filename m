From: Len Brown <lenb@kernel.org>
Subject: [PATCH 079/122] ACPI: thinkpad-acpi: Remove duplicate line
Date: Thu, 23 Oct 2008 02:38:53 -0400
Message-ID: <396293237cbc964fcedd4208cbc0d0f4880a98bb.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms172071pub.verizon.net ([206.46.172.71]:62933 "EHLO
	vms172071pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754500AbYJWGk0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:40:26 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms172071.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K960072DIIZ8LC1@vms172071.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:40:12 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Pascal Terjan <pterjan@mandriva.com>, Len Brown <len.brown@intel.com>

From: Pascal Terjan <pterjan@mandriva.com>

Signed-off-by: Pascal Terjan <pterjan@mandriva.com>
Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.5.5.1

