From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ACPI / APEI: remove redundant variables len and node_len
Date: Sun, 15 Oct 2017 22:24:54 +0100
Message-ID: <20171015212454.16012-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Tyler Baicar <tbaicar@codeaurora.org>, Will Deacon <will.deacon@arm.com>, linux-acpi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variables len and node_len are redundant and can be removed. Cleans
up clang warning: node_len = GHES_ESTATUS_NODE_LEN(len);

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/acpi/apei/ghes.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 3c3a37b8503b..f2e1049232c0 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -923,7 +923,6 @@ static void ghes_print_queued_estatus(void)
 	struct ghes_estatus_node *estatus_node;
 	struct acpi_hest_generic *generic;
 	struct acpi_hest_generic_status *estatus;
-	u32 len, node_len;
 
 	llnode = llist_del_all(&ghes_estatus_llist);
 	/*
@@ -935,8 +934,6 @@ static void ghes_print_queued_estatus(void)
 		estatus_node = llist_entry(llnode, struct ghes_estatus_node,
 					   llnode);
 		estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
-		len = cper_estatus_len(estatus);
-		node_len = GHES_ESTATUS_NODE_LEN(len);
 		generic = estatus_node->generic;
 		ghes_print_estatus(NULL, generic, estatus);
 		llnode = llnode->next;
-- 
2.14.1
