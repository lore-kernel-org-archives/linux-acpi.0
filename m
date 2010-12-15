From: Chen Gong <gong.chen@linux.intel.com>
Subject: [PATCH] eliminate the usage of printk_ratelimit
Date: Wed, 15 Dec 2010 18:18:14 +0800
Message-ID: <1292408294-30584-2-git-send-email-gong.chen@linux.intel.com>
References: <1292408294-30584-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:57248 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752266Ab0LOKPO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Dec 2010 05:15:14 -0500
In-Reply-To: <1292408294-30584-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Chen Gong <gong.chen@linux.intel.com>

To avoid messages to be suppressed, use __ratelimit to
substitute printk_ratelimit.

Signed-off-by: Chen Gong <gong.chen@linux.intel.com>
---
 drivers/acpi/apei/ghes.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 51905d0..29d38ad 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -180,13 +180,15 @@ static int ghes_copy_tofrom_phys(void *buffer, u64 paddr, u32 len,
 static int ghes_read_estatus(struct ghes *ghes, int silent)
 {
 	struct acpi_hest_generic *g = ghes->generic;
+	/* Not more than 2 messages every 5 seconds */
+	static DEFINE_RATELIMIT_STATE(ratelimit, 5*HZ, 2);
 	u64 buf_paddr;
 	u32 len;
 	int rc;
 
 	rc = acpi_atomic_read(&buf_paddr, &g->error_status_address);
 	if (rc) {
-		if (!silent && printk_ratelimit())
+		if (!silent && __ratelimit(&ratelimit))
 			pr_warning(FW_WARN GHES_PFX
 "Failed to read error status block address for hardware error source: %d.\n",
 				   g->header.source_id);
-- 
1.7.3.1.120.g38a18

