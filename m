From: George Cherian <george.cherian@cavium.com>
Subject: [PATCH v3 1/2] mailbox: PCC: Move the MAX_PCC_SUBSPACES definition to header file
Date: Tue,  5 Sep 2017 03:18:09 +0000
Message-ID: <1504581490-4183-2-git-send-email-george.cherian@cavium.com>
References: <1504581490-4183-1-git-send-email-george.cherian@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-dm3nam03on0083.outbound.protection.outlook.com ([104.47.41.83]:4646
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754107AbdIEDSp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 4 Sep 2017 23:18:45 -0400
In-Reply-To: <1504581490-4183-1-git-send-email-george.cherian@cavium.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: devel@acpica.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, jassisinghbrar@gmail.com, robert.moore@intel.com, lv.zheng@intel.com, pprakash@codeaurora.org, George Cherian <george.cherian@cavium.com>

Move the MAX_PCC_SUBSPACES definition to acpi/pcc.h file. In preparation to add
subspace id support for cppc_acpi driver.

Signed-off-by: George Cherian <george.cherian@cavium.com>
---
 drivers/mailbox/pcc.c | 1 -
 include/acpi/pcc.h    | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index cbca5e5..df1a50a 100644
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

