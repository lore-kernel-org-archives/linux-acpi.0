From: akpm@osdl.org
Subject: [patch 06/19] drivers/acpi/osl.c: fix a NULL check
Date: Tue, 19 Dec 2006 12:56:13 -0800
Message-ID: <200612192056.kBJKuDdQ010023@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:34680 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932964AbWLSVAD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Dec 2006 16:00:03 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, bunk@stusta.de

From: Adrian Bunk <bunk@stusta.de>

This patch fixes a non-working NULL check introduced by commit
b229cf92eee616c7cb5ad8cdb35a19b119f00bc8.

Spotted by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/osl.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/acpi/osl.c~drivers-acpi-oslc-fix-a-null-check drivers/acpi/osl.c
--- a/drivers/acpi/osl.c~drivers-acpi-oslc-fix-a-null-check
+++ a/drivers/acpi/osl.c
@@ -1032,7 +1032,7 @@ acpi_status
 acpi_os_create_cache(char *name, u16 size, u16 depth, acpi_cache_t ** cache)
 {
 	*cache = kmem_cache_create(name, size, 0, 0, NULL, NULL);
-	if (cache == NULL)
+	if (*cache == NULL)
 		return AE_ERROR;
 	else
 		return AE_OK;
_
