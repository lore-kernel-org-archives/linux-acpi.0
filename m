From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH 2/9] ACPI: EC: Add new query handler to list head.
Date: Sat, 01 Sep 2007 00:10:58 +0400
Message-ID: <20070831201058.27033.94160.stgit@z61m>
References: <20070831201051.27033.74238.stgit@z61m>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:47847 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753212AbXHaULW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Aug 2007 16:11:22 -0400
In-Reply-To: <20070831201051.27033.74238.stgit@z61m>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/ec.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 5f4918d..e7109a5 100644
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

