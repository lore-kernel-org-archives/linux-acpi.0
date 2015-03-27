From: Borislav Petkov <bp@alien8.de>
Subject: [RFC PATCH 5/5] GHES: Make NMI handler have a single reader
Date: Fri, 27 Mar 2015 10:22:58 +0100
Message-ID: <1427448178-20689-6-git-send-email-bp@alien8.de>
References: <1427448178-20689-1-git-send-email-bp@alien8.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427448178-20689-1-git-send-email-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-edac <linux-edac@vger.kernel.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Borislav Petkov <bp@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "Chen, Gong" <gong.chen@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Lv Zheng <lv.zheng@intel.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

Since GHES sources are global, we theoretically need only a single CPU
reading them per NMI instead of a thundering herd of CPUs waiting on a
spinlock in NMI context for no reason at all.

Do that.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/acpi/apei/ghes.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 94a44bad5576..2bfd53cbfe80 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -729,10 +729,10 @@ static struct llist_head ghes_estatus_llist;
 static struct irq_work ghes_proc_irq_work;
 
 /*
- * NMI may be triggered on any CPU, so ghes_nmi_lock is used for
- * mutual exclusion.
+ * NMI may be triggered on any CPU, so ghes_in_nmi is used for
+ * having only one concurrent reader.
  */
-static DEFINE_RAW_SPINLOCK(ghes_nmi_lock);
+static atomic_t ghes_in_nmi = ATOMIC_INIT(0);
 
 static LIST_HEAD(ghes_nmi);
 
@@ -840,7 +840,9 @@ static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
 	struct ghes *ghes;
 	int sev, ret = NMI_DONE;
 
-	raw_spin_lock(&ghes_nmi_lock);
+	if (!atomic_add_unless(&ghes_in_nmi, 1, 1))
+		return ret;
+
 	list_for_each_entry_rcu(ghes, &ghes_nmi, list) {
 		if (ghes_read_estatus(ghes, 1)) {
 			ghes_clear_estatus(ghes);
@@ -863,7 +865,7 @@ static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
 #ifdef CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG
 	irq_work_queue(&ghes_proc_irq_work);
 #endif
-	raw_spin_unlock(&ghes_nmi_lock);
+	atomic_dec(&ghes_in_nmi);
 	return ret;
 }
 
-- 
2.3.3
