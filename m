From: James Morse <james.morse@arm.com>
Subject: [PATCH] ACPI / APEI: Add missing synchronize_rcu() on NOTIFY_SCI removal.
Date: Thu, 16 Mar 2017 14:30:39 +0000
Message-ID: <20170316143039.375-1-james.morse@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35076 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753166AbdCPO4L (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 16 Mar 2017 10:56:11 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Huang Ying <ying.huang@intel.com>, Shiju Jose <shiju.jose@huawei.com>, Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, James Morse <james.morse@arm.com>

When removing a GHES device notified by SCI, list_del_rcu() is used,
ghes_remove() should call synchronize_rcu() before it goes on to call
kfree(ghes), otherwise concurrent RCU readers may still hold this list
entry after it has been freed.

Signed-off-by: James Morse <james.morse@arm.com>
Cc: Huang Ying <ying.huang@intel.com>

---
It looks like 81e88fdc432a lifted this into ACPI_HEST_NOTIFY_NMI, missing
that ACPI_HEST_NOTIFY_SCI needed it too.

If there is only ever one SCI GHES entry this is safe today as
unregister_acpi_hed_notifier() takes a write lock on its semaphore, meaning
any RCU readers will have finished.
If there can be more than one SCI GHES entry...

Fixes: 81e88fdc432a ("ACPI, APEI, Generic Hardware Error Source POLL/IRQ/NMI notification type support")

 drivers/acpi/apei/ghes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index b192b42a8351..79b3c9c5a3bc 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1073,6 +1073,7 @@ static int ghes_remove(struct platform_device *ghes_dev)
 		if (list_empty(&ghes_sci))
 			unregister_acpi_hed_notifier(&ghes_notifier_sci);
 		mutex_unlock(&ghes_list_mutex);
+		synchronize_rcu();
 		break;
 	case ACPI_HEST_NOTIFY_NMI:
 		ghes_nmi_remove(ghes);
-- 
2.10.1

