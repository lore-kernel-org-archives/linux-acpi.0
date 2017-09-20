From: George Cherian <george.cherian@cavium.com>
Subject: [PATCH v4 1/2] mailbox: PCC: Move the MAX_PCC_SUBSPACES definition to header file
Date: Wed, 20 Sep 2017 05:24:46 +0000
Message-ID: <1505885087-5112-2-git-send-email-george.cherian@cavium.com>
References: <1505885087-5112-1-git-send-email-george.cherian@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-sn1nam01on0050.outbound.protection.outlook.com ([104.47.32.50]:43018
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750924AbdITFZW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 20 Sep 2017 01:25:22 -0400
In-Reply-To: <1505885087-5112-1-git-send-email-george.cherian@cavium.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: devel@acpica.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: lv.zheng@intel.com, robert.moore@intel.com, jassisinghbrar@gmail.com, lenb@kernel.org, rjw@rjwysocki.net, pprakash@codeaurora.org, George Cherian <george.cherian@cavium.com>

Move the MAX_PCC_SUBSPACES definition to acpi/pcc.h file. In preparation to add
subspace id support for cppc_acpi driver.

Signed-off-by: George Cherian <george.cherian@cavium.com>
---
 drivers/mailbox/pcc.c | 1 -
 include/acpi/pcc.h    | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 9b7005e..e5a6967 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -69,7 +69,6 @@
 
 #include "mailbox.h"
 
-#define MAX_PCC_SUBSPACES	256
 #define MBOX_IRQ_NAME		"pcc-mbox"
 
 static struct mbox_chan *pcc_mbox_channels;
diff --git a/include/acpi/pcc.h b/include/acpi/pcc.h
index 8caa79c..cd6ef45 100644
--- a/include/acpi/pcc.h
+++ b/include/acpi/pcc.h
@@ -13,6 +13,7 @@
 #include <linux/mailbox_controller.h>
 #include <linux/mailbox_client.h>
 
+#define MAX_PCC_SUBSPACES	256
 #ifdef CONFIG_PCC
 extern struct mbox_chan *pcc_mbox_request_channel(struct mbox_client *cl,
 						  int subspace_id);
-- 
2.1.4

