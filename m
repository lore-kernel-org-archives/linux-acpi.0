From: James Morse <james.morse@arm.com>
Subject: [RFC 2/7] ACPI / APEI: Generalise the estatus queue's add/remove and notify code
Date: Mon, 22 Jan 2018 19:29:37 +0000
Message-ID: <20180122192942.30487-3-james.morse@arm.com>
References: <20180122192942.30487-1-james.morse@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34324 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751071AbeAVTcM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 Jan 2018 14:32:12 -0500
In-Reply-To: <20180122192942.30487-1-james.morse@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: linux-acpi@vger.kernel.org, huangshaoyu@huawei.com, Tyler Baicar <tbaicar@codeaurora.org>, James Morse <james.morse@arm.com>

Refactor the estatus queue's pool grow/shrink code and notification
routine from NOTIFY_NMI's handlers. This will allow another notification
method to use the estatus queue without duplicating this code.

This patch adds rcu_read_lock()/rcu_read_unlock() around the list
list_for_each_entry_rcu() walker. These aren't strictly necessary as
the whole nmi_enter/nmi_exit() window is a spooky RCU read-side
critical section.

This patch keeps the oops_begin() call only for x86, arm64 doesn't have
one of these, and APEI is the only thing outside arch code calling this..

The existing ghes_estatus_pool_shrink() is folded into the new
ghes_estatus_queue_shrink_pool() as only the queue uses it.
(in contrast ghes_init() calls ghes_estatus_pool_expand() to allocate
 the pool memory used by the estatus-cache)

Not-signed-off: James Morse <james.morse@arm.com>
---
 drivers/acpi/apei/ghes.c | 93 ++++++++++++++++++++++++++++++------------------
 1 file changed, 58 insertions(+), 35 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index fef59ca1f7a7..ca15f6537dbb 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -740,6 +740,44 @@ static void __process_error(struct ghes *ghes)
 #endif
 }
 
+static int ghes_estatus_queue_notified(struct list_head *rcu_list)
+{
+	int sev;
+	int ret = -ENOENT;
+	struct ghes *ghes;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(ghes, rcu_list, list) {
+		if (ghes_read_estatus(ghes, 1)) {
+			ghes_clear_estatus(ghes);
+			continue;
+		} else {
+			ret = 0;
+		}
+
+		sev = ghes_severity(ghes->estatus->error_severity);
+		if (sev >= GHES_SEV_PANIC) {
+#ifdef CONFIG_X86
+			oops_begin();
+#endif
+			ghes_print_queued_estatus();
+			__ghes_panic(ghes);
+		}
+
+		if (!(ghes->flags & GHES_TO_CLEAR))
+			continue;
+
+		__process_error(ghes);
+		ghes_clear_estatus(ghes);
+	}
+	rcu_read_unlock();
+
+	if (IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) && ret == 0)
+		irq_work_queue(&ghes_proc_irq_work);
+
+	return ret;
+}
+
 static unsigned long ghes_esource_prealloc_size(
 	const struct acpi_hest_generic *generic)
 {
@@ -755,11 +793,24 @@ static unsigned long ghes_esource_prealloc_size(
 	return prealloc_size;
 }
 
-static void ghes_estatus_pool_shrink(unsigned long len)
+/* After removing a queue user, we can shrink to pool */
+static void ghes_estatus_queue_shrink_pool(struct ghes *ghes)
 {
+	unsigned long len;
+
+	len = ghes_esource_prealloc_size(ghes->generic);
 	ghes_estatus_pool_size_request -= PAGE_ALIGN(len);
 }
 
+/* Before adding a queue user, grow the pool */
+static void ghes_estatus_queue_grow_pool(struct ghes *ghes)
+{
+	unsigned long len;
+
+	len = ghes_esource_prealloc_size(ghes->generic);
+	ghes_estatus_pool_expand(len);
+}
+
 static void ghes_proc_in_irq(struct irq_work *irq_work)
 {
 	struct llist_node *llnode, *next;
@@ -958,48 +1009,22 @@ static LIST_HEAD(ghes_nmi);
 
 static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
 {
-	struct ghes *ghes;
-	int sev, ret = NMI_DONE;
+	int ret = NMI_DONE;
 
 	if (!atomic_add_unless(&ghes_in_nmi, 1, 1))
 		return ret;
 
-	list_for_each_entry_rcu(ghes, &ghes_nmi, list) {
-		if (ghes_read_estatus(ghes, 1)) {
-			ghes_clear_estatus(ghes);
-			continue;
-		} else {
-			ret = NMI_HANDLED;
-		}
-
-		sev = ghes_severity(ghes->estatus->error_severity);
-		if (sev >= GHES_SEV_PANIC) {
-			oops_begin();
-			ghes_print_queued_estatus();
-			__ghes_panic(ghes);
-		}
-
-		if (!(ghes->flags & GHES_TO_CLEAR))
-			continue;
+	if (!ghes_estatus_queue_notified(&ghes_nmi))
+		ret = NMI_HANDLED;
 
-		__process_error(ghes);
-		ghes_clear_estatus(ghes);
-	}
-
-#ifdef CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG
-	if (ret == NMI_HANDLED)
-		irq_work_queue(&ghes_proc_irq_work);
-#endif
 	atomic_dec(&ghes_in_nmi);
 	return ret;
 }
 
 static void ghes_nmi_add(struct ghes *ghes)
 {
-	unsigned long len;
+	ghes_estatus_queue_grow_pool(ghes);
 
-	len = ghes_esource_prealloc_size(ghes->generic);
-	ghes_estatus_pool_expand(len);
 	mutex_lock(&ghes_list_mutex);
 	if (list_empty(&ghes_nmi))
 		register_nmi_handler(NMI_LOCAL, ghes_notify_nmi, 0, "ghes");
@@ -1009,8 +1034,6 @@ static void ghes_nmi_add(struct ghes *ghes)
 
 static void ghes_nmi_remove(struct ghes *ghes)
 {
-	unsigned long len;
-
 	mutex_lock(&ghes_list_mutex);
 	list_del_rcu(&ghes->list);
 	if (list_empty(&ghes_nmi))
@@ -1021,8 +1044,8 @@ static void ghes_nmi_remove(struct ghes *ghes)
 	 * freed after NMI handler finishes.
 	 */
 	synchronize_rcu();
-	len = ghes_esource_prealloc_size(ghes->generic);
-	ghes_estatus_pool_shrink(len);
+
+	ghes_estatus_queue_shrink_pool(ghes);
 }
 
 #else /* CONFIG_HAVE_ACPI_APEI_NMI */
-- 
2.15.1

