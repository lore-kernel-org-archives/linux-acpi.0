From: James Morse <james.morse@arm.com>
Subject: [RFC 1/7] ACPI / APEI: Move the estatus queue code up, and under its own ifdef
Date: Mon, 22 Jan 2018 19:29:36 +0000
Message-ID: <20180122192942.30487-2-james.morse@arm.com>
References: <20180122192942.30487-1-james.morse@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34318 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751071AbeAVTcK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 Jan 2018 14:32:10 -0500
In-Reply-To: <20180122192942.30487-1-james.morse@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: linux-acpi@vger.kernel.org, huangshaoyu@huawei.com, Tyler Baicar <tbaicar@codeaurora.org>, James Morse <james.morse@arm.com>

We want to allow multiple NMI-like notifications on arm64, but the GHES
driver only has one in_nmi() path. To support asynchronous notifications
we also need to use the estatus-queue.

First we move the estatus-queue code so that notification types other
than NOTFIY_NMI can use it.

This patch moves code around ... and makes the following trivial changes:
 * Adds WANT_NMI_ESTATUS_QUEUE to allow this code to be built without
   CONFIG_HAVE_ACPI_APEI_NMI. This symbol later comes to mean NOTIFY_NMI,
   which would only be selected by x86.
 * Freshen the dated comment above ghes_estatus_llist. printk() is no
   longer the issue, its the helpers like memory_failure_queue() that
   still aren't nmi safe.

If anyone prefers I can split this so these two non-code changes are a
separate patch.

Not-signed-off: James Morse <james.morse@arm.com>
---
 drivers/acpi/apei/ghes.c | 281 +++++++++++++++++++++++++----------------------
 1 file changed, 148 insertions(+), 133 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 6402f7fad3bb..fef59ca1f7a7 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -59,6 +59,10 @@
 
 #define GHES_PFX	"GHES: "
 
+#ifdef CONFIG_HAVE_ACPI_APEI_NMI
+#define WANT_NMI_ESTATUS_QUEUE	1
+#endif
+
 #define GHES_ESTATUS_MAX_SIZE		65536
 #define GHES_ESOURCE_PREALLOC_MAX_SIZE	65536
 
@@ -529,6 +533,16 @@ static int ghes_print_estatus(const char *pfx,
 	return 0;
 }
 
+static void __ghes_panic(struct ghes *ghes)
+{
+	__ghes_print_estatus(KERN_EMERG, ghes->generic, ghes->estatus);
+
+	/* reboot to log the error! */
+	if (!panic_timeout)
+		panic_timeout = ghes_panic_timeout;
+	panic("Fatal hardware error!");
+}
+
 /*
  * GHES error status reporting throttle, to report more kinds of
  * errors, instead of just most frequently occurred errors.
@@ -656,6 +670,138 @@ static void ghes_estatus_cache_add(
 	rcu_read_unlock();
 }
 
+#ifdef WANT_NMI_ESTATUS_QUEUE
+/*
+ * While printk() now has an in_nmi() path, the handling for CPER records
+ * does not. For example, memory_failure_queue() takes spinlocks and calls
+ * schedule_work_on().
+ *
+ * So in any NMI-like handler, we allocate required memory from lock-less
+ * memory allocator (ghes_estatus_pool), save estatus into it, put them into
+ * lock-less list (ghes_estatus_llist), then delay printk into IRQ context via
+ * irq_work (ghes_proc_irq_work).  ghes_estatus_size_request record
+ * required pool size by all NMI error source.
+ *
+ * Memory from the ghes_estatus_pool is also used with the ghes_estatus_cache
+ * to suppress frequent messages.
+ */
+static struct llist_head ghes_estatus_llist;
+static struct irq_work ghes_proc_irq_work;
+
+static void ghes_print_queued_estatus(void)
+{
+	struct llist_node *llnode;
+	struct ghes_estatus_node *estatus_node;
+	struct acpi_hest_generic *generic;
+	struct acpi_hest_generic_status *estatus;
+	u32 len, node_len;
+
+	llnode = llist_del_all(&ghes_estatus_llist);
+	/*
+	 * Because the time order of estatus in list is reversed,
+	 * revert it back to proper order.
+	 */
+	llnode = llist_reverse_order(llnode);
+	while (llnode) {
+		estatus_node = llist_entry(llnode, struct ghes_estatus_node,
+					   llnode);
+		estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
+		len = cper_estatus_len(estatus);
+		node_len = GHES_ESTATUS_NODE_LEN(len);
+		generic = estatus_node->generic;
+		ghes_print_estatus(NULL, generic, estatus);
+		llnode = llnode->next;
+	}
+}
+
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
+static unsigned long ghes_esource_prealloc_size(
+	const struct acpi_hest_generic *generic)
+{
+	unsigned long block_length, prealloc_records, prealloc_size;
+
+	block_length = min_t(unsigned long, generic->error_block_length,
+			     GHES_ESTATUS_MAX_SIZE);
+	prealloc_records = max_t(unsigned long,
+				 generic->records_to_preallocate, 1);
+	prealloc_size = min_t(unsigned long, block_length * prealloc_records,
+			      GHES_ESOURCE_PREALLOC_MAX_SIZE);
+
+	return prealloc_size;
+}
+
+static void ghes_estatus_pool_shrink(unsigned long len)
+{
+	ghes_estatus_pool_size_request -= PAGE_ALIGN(len);
+}
+
+static void ghes_proc_in_irq(struct irq_work *irq_work)
+{
+	struct llist_node *llnode, *next;
+	struct ghes_estatus_node *estatus_node;
+	struct acpi_hest_generic *generic;
+	struct acpi_hest_generic_status *estatus;
+	u32 len, node_len;
+
+	llnode = llist_del_all(&ghes_estatus_llist);
+	/*
+	 * Because the time order of estatus in list is reversed,
+	 * revert it back to proper order.
+	 */
+	llnode = llist_reverse_order(llnode);
+	while (llnode) {
+		next = llnode->next;
+		estatus_node = llist_entry(llnode, struct ghes_estatus_node,
+					   llnode);
+		estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
+		len = cper_estatus_len(estatus);
+		node_len = GHES_ESTATUS_NODE_LEN(len);
+		ghes_do_proc(estatus_node->ghes, estatus);
+		if (!ghes_estatus_cached(estatus)) {
+			generic = estatus_node->generic;
+			if (ghes_print_estatus(NULL, generic, estatus))
+				ghes_estatus_cache_add(generic, estatus);
+		}
+		gen_pool_free(ghes_estatus_pool, (unsigned long)estatus_node,
+			      node_len);
+		llnode = next;
+	}
+}
+
+static void ghes_nmi_init_cxt(void)
+{
+	init_irq_work(&ghes_proc_irq_work, ghes_proc_in_irq);
+}
+
+#else
+static inline void ghes_nmi_init_cxt(void) { }
+#endif /* WANT_NMI_ESTATUS_QUEUE */
+
 static int ghes_ack_error(struct acpi_hest_generic_v2 *gv2)
 {
 	int rc;
@@ -671,16 +817,6 @@ static int ghes_ack_error(struct acpi_hest_generic_v2 *gv2)
 	return apei_write(val, &gv2->read_ack_register);
 }
 
-static void __ghes_panic(struct ghes *ghes)
-{
-	__ghes_print_estatus(KERN_EMERG, ghes->generic, ghes->estatus);
-
-	/* reboot to log the error! */
-	if (!panic_timeout)
-		panic_timeout = ghes_panic_timeout;
-	panic("Fatal hardware error!");
-}
-
 static int ghes_proc(struct ghes *ghes)
 {
 	int rc;
@@ -813,109 +949,13 @@ static inline void ghes_sea_remove(struct ghes *ghes) { }
 
 #ifdef CONFIG_HAVE_ACPI_APEI_NMI
 /*
- * printk is not safe in NMI context.  So in NMI handler, we allocate
- * required memory from lock-less memory allocator
- * (ghes_estatus_pool), save estatus into it, put them into lock-less
- * list (ghes_estatus_llist), then delay printk into IRQ context via
- * irq_work (ghes_proc_irq_work).  ghes_estatus_size_request record
- * required pool size by all NMI error source.
- */
-static struct llist_head ghes_estatus_llist;
-static struct irq_work ghes_proc_irq_work;
-
-/*
- * NMI may be triggered on any CPU, so ghes_in_nmi is used for
- * having only one concurrent reader.
+ * NOTIFY_NMI may be triggered on any CPU, so ghes_in_nmi is
+ * used for having only one concurrent reader.
  */
 static atomic_t ghes_in_nmi = ATOMIC_INIT(0);
 
 static LIST_HEAD(ghes_nmi);
 
-static void ghes_proc_in_irq(struct irq_work *irq_work)
-{
-	struct llist_node *llnode, *next;
-	struct ghes_estatus_node *estatus_node;
-	struct acpi_hest_generic *generic;
-	struct acpi_hest_generic_status *estatus;
-	u32 len, node_len;
-
-	llnode = llist_del_all(&ghes_estatus_llist);
-	/*
-	 * Because the time order of estatus in list is reversed,
-	 * revert it back to proper order.
-	 */
-	llnode = llist_reverse_order(llnode);
-	while (llnode) {
-		next = llnode->next;
-		estatus_node = llist_entry(llnode, struct ghes_estatus_node,
-					   llnode);
-		estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
-		len = cper_estatus_len(estatus);
-		node_len = GHES_ESTATUS_NODE_LEN(len);
-		ghes_do_proc(estatus_node->ghes, estatus);
-		if (!ghes_estatus_cached(estatus)) {
-			generic = estatus_node->generic;
-			if (ghes_print_estatus(NULL, generic, estatus))
-				ghes_estatus_cache_add(generic, estatus);
-		}
-		gen_pool_free(ghes_estatus_pool, (unsigned long)estatus_node,
-			      node_len);
-		llnode = next;
-	}
-}
-
-static void ghes_print_queued_estatus(void)
-{
-	struct llist_node *llnode;
-	struct ghes_estatus_node *estatus_node;
-	struct acpi_hest_generic *generic;
-	struct acpi_hest_generic_status *estatus;
-	u32 len, node_len;
-
-	llnode = llist_del_all(&ghes_estatus_llist);
-	/*
-	 * Because the time order of estatus in list is reversed,
-	 * revert it back to proper order.
-	 */
-	llnode = llist_reverse_order(llnode);
-	while (llnode) {
-		estatus_node = llist_entry(llnode, struct ghes_estatus_node,
-					   llnode);
-		estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
-		len = cper_estatus_len(estatus);
-		node_len = GHES_ESTATUS_NODE_LEN(len);
-		generic = estatus_node->generic;
-		ghes_print_estatus(NULL, generic, estatus);
-		llnode = llnode->next;
-	}
-}
-
-/* Save estatus for further processing in IRQ context */
-static void __process_error(struct ghes *ghes)
-{
-#ifdef CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG
-	u32 len, node_len;
-	struct ghes_estatus_node *estatus_node;
-	struct acpi_hest_generic_status *estatus;
-
-	if (ghes_estatus_cached(ghes->estatus))
-		return;
-
-	len = cper_estatus_len(ghes->estatus);
-	node_len = GHES_ESTATUS_NODE_LEN(len);
-
-	estatus_node = (void *)gen_pool_alloc(ghes_estatus_pool, node_len);
-	if (!estatus_node)
-		return;
-
-	estatus_node->ghes = ghes;
-	estatus_node->generic = ghes->generic;
-	estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
-	memcpy(estatus, ghes->estatus, len);
-	llist_add(&estatus_node->llnode, &ghes_estatus_llist);
-#endif
-}
-
 static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
 {
 	struct ghes *ghes;
@@ -954,26 +994,6 @@ static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
 	return ret;
 }
 
-static unsigned long ghes_esource_prealloc_size(
-	const struct acpi_hest_generic *generic)
-{
-	unsigned long block_length, prealloc_records, prealloc_size;
-
-	block_length = min_t(unsigned long, generic->error_block_length,
-			     GHES_ESTATUS_MAX_SIZE);
-	prealloc_records = max_t(unsigned long,
-				 generic->records_to_preallocate, 1);
-	prealloc_size = min_t(unsigned long, block_length * prealloc_records,
-			      GHES_ESOURCE_PREALLOC_MAX_SIZE);
-
-	return prealloc_size;
-}
-
-static void ghes_estatus_pool_shrink(unsigned long len)
-{
-	ghes_estatus_pool_size_request -= PAGE_ALIGN(len);
-}
-
 static void ghes_nmi_add(struct ghes *ghes)
 {
 	unsigned long len;
@@ -1005,14 +1025,9 @@ static void ghes_nmi_remove(struct ghes *ghes)
 	ghes_estatus_pool_shrink(len);
 }
 
-static void ghes_nmi_init_cxt(void)
-{
-	init_irq_work(&ghes_proc_irq_work, ghes_proc_in_irq);
-}
 #else /* CONFIG_HAVE_ACPI_APEI_NMI */
 static inline void ghes_nmi_add(struct ghes *ghes) { }
 static inline void ghes_nmi_remove(struct ghes *ghes) { }
-static inline void ghes_nmi_init_cxt(void) { }
 #endif /* CONFIG_HAVE_ACPI_APEI_NMI */
 
 static int ghes_probe(struct platform_device *ghes_dev)
-- 
2.15.1

