From: Borislav Petkov <bp@alien8.de>
Subject: [RFC PATCH 1/5] GHES: Carve out error queueing in a separate function
Date: Fri, 27 Mar 2015 10:22:54 +0100
Message-ID: <1427448178-20689-2-git-send-email-bp@alien8.de>
References: <1427448178-20689-1-git-send-email-bp@alien8.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427448178-20689-1-git-send-email-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-edac <linux-edac@vger.kernel.org>
Cc: Borislav Petkov <bp@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "Chen, Gong" <gong.chen@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Lv Zheng <lv.zheng@intel.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Make the handler more readable.

No functionality change.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/acpi/apei/ghes.c | 51 +++++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index e82d0976a5d0..fe1e41bf5609 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -797,6 +797,32 @@ static void ghes_print_queued_estatus(void)
 	}
 }
 
+/* Save estatus for further processing in IRQ context */
+static void __process_error(struct ghes *ghes)
+{
+#ifdef CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG
+	u32 len, node_len;
+	struct ghes_estatus_node *estatus_node;
+	struct acpi_hest_generic_status *estatus;
+
+	if (ghes_estatus_cached(ghes->estatus))
+		return;
+
+	len = cper_estatus_len(ghes->estatus);
+	node_len = GHES_ESTATUS_NODE_LEN(len);
+
+	estatus_node = (void *)gen_pool_alloc(ghes_estatus_pool, node_len);
+	if (!estatus_node)
+		return;
+
+	estatus_node->ghes = ghes;
+	estatus_node->generic = ghes->generic;
+	estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
+	memcpy(estatus, ghes->estatus, len);
+	llist_add(&estatus_node->llnode, &ghes_estatus_llist);
+#endif
+}
+
 static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
 {
 	struct ghes *ghes, *ghes_global = NULL;
@@ -832,32 +858,13 @@ static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
 	}
 
 	list_for_each_entry_rcu(ghes, &ghes_nmi, list) {
-#ifdef CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG
-		u32 len, node_len;
-		struct ghes_estatus_node *estatus_node;
-		struct acpi_hest_generic_status *estatus;
-#endif
 		if (!(ghes->flags & GHES_TO_CLEAR))
 			continue;
-#ifdef CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG
-		if (ghes_estatus_cached(ghes->estatus))
-			goto next;
-		/* Save estatus for further processing in IRQ context */
-		len = cper_estatus_len(ghes->estatus);
-		node_len = GHES_ESTATUS_NODE_LEN(len);
-		estatus_node = (void *)gen_pool_alloc(ghes_estatus_pool,
-						      node_len);
-		if (estatus_node) {
-			estatus_node->ghes = ghes;
-			estatus_node->generic = ghes->generic;
-			estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
-			memcpy(estatus, ghes->estatus, len);
-			llist_add(&estatus_node->llnode, &ghes_estatus_llist);
-		}
-next:
-#endif
+
+		__process_error(ghes);
 		ghes_clear_estatus(ghes);
 	}
+
 #ifdef CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG
 	irq_work_queue(&ghes_proc_irq_work);
 #endif
-- 
2.3.3
