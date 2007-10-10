From: Len Brown <lenb@kernel.org>
Subject: [PATCH 26/37] ACPI: EC: Add new query handler to list head.
Date: Wed, 10 Oct 2007 01:06:33 -0400
Message-ID: <1191992804-14965-27-git-send-email-lenb@kernel.org>
References: <1191992804-14965-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:19103 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751212AbXJJFHI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Oct 2007 01:07:08 -0400
In-Reply-To: <1191992804-14965-1-git-send-email-lenb@kernel.org>
Message-Id: <30c08574da0ead1a47797ce028218ce5b2de61c7.1191992584.git.len.brown@intel.com>
In-Reply-To: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1191992584.git.len.brown@intel.com>
References: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1191992584.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 3f7935a..e9a0405 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -425,7 +425,7 @@ int acpi_ec_add_query_handler(struct acpi_ec *ec, u8 query_bit,
 	handler->func = func;
 	handler->data = data;
 	mutex_lock(&ec->lock);
-	list_add_tail(&handler->node, &ec->list);
+	list_add(&handler->node, &ec->list);
 	mutex_unlock(&ec->lock);
 	return 0;
 }
@@ -440,7 +440,6 @@ void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8 query_bit)
 		if (query_bit == handler->query_bit) {
 			list_del(&handler->node);
 			kfree(handler);
-			break;
 		}
 	}
 	mutex_unlock(&ec->lock);
-- 
1.5.3.4.206.g58ba4
