From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH] acpi: Fix the ERST warning
Date: Tue, 28 Sep 2010 13:30:35 +0100
Message-ID: <20100928123029.9667.22883.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:52831 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753862Ab0I1NSp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Sep 2010 09:18:45 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I got bored of seeing this every compile so I fixed it.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/acpi/apei/erst.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index a4904f1..37d7a05 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -270,8 +270,8 @@ static int erst_exec_move_data(struct apei_exec_context *ctx,
 	rc = __apei_exec_read_register(entry, &offset);
 	if (rc)
 		return rc;
-	memmove((void *)ctx->dst_base + offset,
-		(void *)ctx->src_base + offset,
+	memmove((void *)(unsigned long)ctx->dst_base + offset,
+		(void *)(unsigned long)ctx->src_base + offset,
 		ctx->var2);
 
 	return 0;

