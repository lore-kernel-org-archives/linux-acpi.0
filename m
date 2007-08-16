From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: [PATCH 07/12] ACPI: EC: Add new query handler to list head.
Date: Thu, 16 Aug 2007 18:03:52 +0400
Message-ID: <20070816140352.19441.21311.stgit@z61m>
References: <20070816140322.19441.63139.stgit@z61m>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from [81.5.104.13] ([81.5.104.13]:40427 "EHLO z61m"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1760400AbXHPOey (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 Aug 2007 10:34:54 -0400
In-Reply-To: <20070816140322.19441.63139.stgit@z61m>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org
Cc: astarikovskiy@suse.de

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/ec.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 56bee9e..25a84af 100644
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

