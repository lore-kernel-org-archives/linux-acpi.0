From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 06/32] acpi: kacpi*_wq don't need WQ_MEM_RECLAIM
Date: Mon,  3 Jan 2011 14:49:29 +0100
Message-ID: <1294062595-30097-7-git-send-email-tj@kernel.org>
References: <1294062595-30097-1-git-send-email-tj@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1294062595-30097-1-git-send-email-tj@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

ACPI workqueues aren't used during memory reclaming.  Use
alloc_workqueue() to create workqueues w/o rescuers.

If the purpose of the separation between kacpid_wq and kacpi_notify_wq
was to give notifications better response time, kacpi_notify_wq can be
dropped and kacpi_wq can be created with higher @max_active.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
---
Only compile tested.  Please feel free to take it into the subsystem
tree or simply ack - I'll route it through the wq tree.

Thanks.

 drivers/acpi/osl.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 055d7b7..c961e18 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1573,9 +1573,9 @@ acpi_status __init acpi_os_initialize(void)
 
 acpi_status __init acpi_os_initialize1(void)
 {
-	kacpid_wq = create_workqueue("kacpid");
-	kacpi_notify_wq = create_workqueue("kacpi_notify");
-	kacpi_hotplug_wq = create_workqueue("kacpi_hotplug");
+	kacpid_wq = alloc_workqueue("kacpid", 0, 1);
+	kacpi_notify_wq = alloc_workqueue("kacpi_notify", 0, 1);
+	kacpi_hotplug_wq = alloc_workqueue("kacpi_hotplug", 0, 1);
 	BUG_ON(!kacpid_wq);
 	BUG_ON(!kacpi_notify_wq);
 	BUG_ON(!kacpi_hotplug_wq);
-- 
1.7.1
