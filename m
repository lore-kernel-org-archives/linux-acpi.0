From: Punit Agrawal <punit.agrawal@arm.com>
Subject: [PATCH 1/3] GHES: Expand the estatus pool in ghes_estatus_pool_init()
Date: Tue,  1 Aug 2017 14:36:06 +0100
Message-ID: <20170801133608.21017-2-punit.agrawal@arm.com>
References: <20170801133608.21017-1-punit.agrawal@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170801133608.21017-1-punit.agrawal@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Punit Agrawal <punit.agrawal@arm.com>, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, James Morse <james.morse@arm.com>
List-Id: linux-acpi@vger.kernel.org

During the GHES driver initialisation, a pool of memory is created by
calling ghes_estatus_pool_init() which is then immediately expanded by
making a call to ghes_estatus_pool_expand().

Re-factor the code so that on successful creation of the pool,
ghes_estatus_pool_init() expands the initialised pool by calling
ghes_estatus_pool_expand().

The change is in preparation for moving the pool creation out of driver
initialisation to when a platform device is being probed.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: James Morse <james.morse@arm.com>
---
 drivers/acpi/apei/ghes.c | 55 +++++++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index d661d452b238..007b38abcb34 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -207,11 +207,25 @@ static void ghes_iounmap_irq(void __iomem *vaddr_ptr)
 	arch_apei_flush_tlb_one(vaddr);
 }
 
-static int ghes_estatus_pool_init(void)
+static int ghes_estatus_pool_expand(unsigned long len)
 {
-	ghes_estatus_pool = gen_pool_create(GHES_ESTATUS_POOL_MIN_ALLOC_ORDER, -1);
-	if (!ghes_estatus_pool)
-		return -ENOMEM;
+	unsigned long i, pages, size, addr;
+	int ret;
+
+	ghes_estatus_pool_size_request += PAGE_ALIGN(len);
+	size = gen_pool_size(ghes_estatus_pool);
+	if (size >= ghes_estatus_pool_size_request)
+		return 0;
+	pages = (ghes_estatus_pool_size_request - size) / PAGE_SIZE;
+	for (i = 0; i < pages; i++) {
+		addr = __get_free_page(GFP_KERNEL);
+		if (!addr)
+			return -ENOMEM;
+		ret = gen_pool_add(ghes_estatus_pool, addr, PAGE_SIZE, -1);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -229,26 +243,20 @@ static void ghes_estatus_pool_exit(void)
 	gen_pool_destroy(ghes_estatus_pool);
 }
 
-static int ghes_estatus_pool_expand(unsigned long len)
+static int ghes_estatus_pool_init(void)
 {
-	unsigned long i, pages, size, addr;
-	int ret;
+	int rc;
 
-	ghes_estatus_pool_size_request += PAGE_ALIGN(len);
-	size = gen_pool_size(ghes_estatus_pool);
-	if (size >= ghes_estatus_pool_size_request)
-		return 0;
-	pages = (ghes_estatus_pool_size_request - size) / PAGE_SIZE;
-	for (i = 0; i < pages; i++) {
-		addr = __get_free_page(GFP_KERNEL);
-		if (!addr)
-			return -ENOMEM;
-		ret = gen_pool_add(ghes_estatus_pool, addr, PAGE_SIZE, -1);
-		if (ret)
-			return ret;
-	}
+	ghes_estatus_pool = gen_pool_create(GHES_ESTATUS_POOL_MIN_ALLOC_ORDER, -1);
+	if (!ghes_estatus_pool)
+		return -ENOMEM;
 
-	return 0;
+	rc = ghes_estatus_pool_expand(GHES_ESTATUS_CACHE_AVG_SIZE *
+				      GHES_ESTATUS_CACHE_ALLOCED_MAX);
+	if (rc)
+		ghes_estatus_pool_exit();
+
+	return rc;
 }
 
 static int map_gen_v2(struct ghes *ghes)
@@ -1285,11 +1293,6 @@ static int __init ghes_init(void)
 	if (rc)
 		goto err_ioremap_exit;
 
-	rc = ghes_estatus_pool_expand(GHES_ESTATUS_CACHE_AVG_SIZE *
-				      GHES_ESTATUS_CACHE_ALLOCED_MAX);
-	if (rc)
-		goto err_pool_exit;
-
 	rc = platform_driver_register(&ghes_platform_driver);
 	if (rc)
 		goto err_pool_exit;
-- 
2.11.0
