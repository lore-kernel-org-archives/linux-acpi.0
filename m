From: Len Brown <lenb@kernel.org>
Subject: [PATCH 09/32] ACPI: EC: Add new query handler to list head.
Date: Fri, 21 Sep 2007 23:46:15 -0400
Message-ID: <11904328061489-git-send-email-lenb@kernel.org>
References: <11904327981905-git-send-email-lenb@kernel.org>
 <11904327991059-git-send-email-lenb@kernel.org>
 <11904328003655-git-send-email-lenb@kernel.org>
 <11904328012791-git-send-email-lenb@kernel.org>
 <11904328011699-git-send-email-lenb@kernel.org>
 <1190432802575-git-send-email-lenb@kernel.org>
 <11904328031107-git-send-email-lenb@kernel.org>
 <11904328041498-git-send-email-lenb@kernel.org>
 <11904328052010-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:18967 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756703AbXIVDqr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Sep 2007 23:46:47 -0400
In-Reply-To: <11904328052010-git-send-email-lenb@kernel.org>
Message-Id: <e59812330152303aff434d2d3a8a2d9340fbb66e.1190432418.git.len.brown@intel.com>
In-Reply-To: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1190432417.git.len.brown@intel.com>
References: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1190432417.git.len.brown@intel.com>
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
1.5.3.1.27.g57543
