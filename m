From: Borislav Petkov <bp@alien8.de>
Subject: [PATCH] GHES: Make ghes_estatus_caches static
Date: Mon, 29 Sep 2014 13:39:25 +0200
Message-ID: <1411990765-26541-1-git-send-email-bp@alien8.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:51599 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751694AbaI2Lj3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 29 Sep 2014 07:39:29 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>

From: Borislav Petkov <bp@suse.de>

It is used only in ghes.c.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/acpi/apei/ghes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 9dcc9158c8e2..1b6aa514848f 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -128,7 +128,7 @@ static DEFINE_SPINLOCK(ghes_ioremap_lock_irq);
 static struct gen_pool *ghes_estatus_pool;
 static unsigned long ghes_estatus_pool_size_request;
 
-struct ghes_estatus_cache *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
+static struct ghes_estatus_cache *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
 static atomic_t ghes_estatus_cache_alloced;
 
 static int ghes_ioremap_init(void)
-- 
2.0.0

