From: James Morse <james.morse@arm.com>
Subject: [RFC 3/7] ACPI / APEI: Switch NOTIFY_SEA to use the estatus queue
Date: Mon, 22 Jan 2018 19:29:38 +0000
Message-ID: <20180122192942.30487-4-james.morse@arm.com>
References: <20180122192942.30487-1-james.morse@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34332 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751071AbeAVTcO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 Jan 2018 14:32:14 -0500
In-Reply-To: <20180122192942.30487-1-james.morse@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: linux-acpi@vger.kernel.org, huangshaoyu@huawei.com, Tyler Baicar <tbaicar@codeaurora.org>, James Morse <james.morse@arm.com>

Now that the estatus queue can be used by more than one notification
method, we can move notifications that have NMI-like behaviour over to
it, and start abstracting GHES's single in_nmi() path.

Switch NOTIFY_SEA over to use the estatus queue.

Not-signed-off: James Morse <james.morse@arm.com>
---
 drivers/acpi/apei/ghes.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index ca15f6537dbb..7d58a791de90 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -59,7 +59,7 @@
 
 #define GHES_PFX	"GHES: "
 
-#ifdef CONFIG_HAVE_ACPI_APEI_NMI
+#if defined(CONFIG_HAVE_ACPI_APEI_NMI) || defined(CONFIG_ACPI_APEI_SEA)
 #define WANT_NMI_ESTATUS_QUEUE	1
 #endif
 
@@ -967,20 +967,13 @@ static LIST_HEAD(ghes_sea);
  */
 int ghes_notify_sea(void)
 {
-	struct ghes *ghes;
-	int ret = -ENOENT;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(ghes, &ghes_sea, list) {
-		if (!ghes_proc(ghes))
-			ret = 0;
-	}
-	rcu_read_unlock();
-	return ret;
+	return ghes_estatus_queue_notified(&ghes_sea);
 }
 
 static void ghes_sea_add(struct ghes *ghes)
 {
+	ghes_estatus_queue_grow_pool(ghes);
+
 	mutex_lock(&ghes_list_mutex);
 	list_add_rcu(&ghes->list, &ghes_sea);
 	mutex_unlock(&ghes_list_mutex);
@@ -992,6 +985,8 @@ static void ghes_sea_remove(struct ghes *ghes)
 	list_del_rcu(&ghes->list);
 	mutex_unlock(&ghes_list_mutex);
 	synchronize_rcu();
+
+	ghes_estatus_queue_shrink_pool(ghes);
 }
 #else /* CONFIG_ACPI_APEI_SEA */
 static inline void ghes_sea_add(struct ghes *ghes) { }
-- 
2.15.1

