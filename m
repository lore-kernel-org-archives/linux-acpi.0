From: Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH 1/1] acpi:apei:handle GSIV and GPIO notification types
Date: Mon, 13 Mar 2017 13:16:28 +0000
Message-ID: <86258A5CC0A3704780874CF6004BA8A62DCB6D39@lhreml502-mbx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:15521 "EHLO
        lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751032AbdCMNQ7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Mar 2017 09:16:59 -0400
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "bp@suse.de" <bp@suse.de>, "mingo@kernel.org" <mingo@kernel.org>, "prarit@redhat.com" <prarit@redhat.com>, "tbaicar@codeaurora.org" <tbaicar@codeaurora.org>, "punit.agrawal@arm.com" <punit.agrawal@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "james.morse@arm.com" <james.morse@arm.com>, "fu.wei@linaro.org" <fu.wei@linaro.org>, "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>, Gabriele Paoloni <gabriele.paoloni@huawei.com>, John Garry <john.garry@huawei.com>, "xuwei (O)" <xuwei5@hisilicon.com>, "Zhengqiang (turing)" <zhengqiang10@huawei.com>

System Controller Interrupts are received by ACPI's error device,
which in turn notifies the GHES code. The same is true of
APEI's GSIV and GPIO notification types.
Add support for GSIV and GPIO sharing the SCI
register/unregister/notifier code.Rename the list and notifier
to show this is no longer just SCI, but anything from the
Hardware Error Device.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
[james.morse@arm.com: rewrote commit log]
Signed-off-by: James Morse <james.morse@arm.com>
CC: James Morse <james.morse@arm.com>
CC: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/apei/ghes.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index b192b42..fd39929 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -89,14 +89,14 @@
 module_param_named(disable, ghes_disable, bool, 0);
 
 /*
- * All error sources notified with SCI shares one notifier function,
+ * All error sources notified with HED shares one notifier function,
  * so they need to be linked and checked one by one.  This is applied
  * to NMI too.
  *
  * RCU is used for these lists, so ghes_list_mutex is only used for
  * list changing, not for traversing.
  */
-static LIST_HEAD(ghes_sci);
+static LIST_HEAD(ghes_hed);
 static DEFINE_MUTEX(ghes_list_mutex);
 
 /*
@@ -702,14 +702,14 @@ static irqreturn_t ghes_irq_func(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int ghes_notify_sci(struct notifier_block *this,
+static int ghes_notify_hed(struct notifier_block *this,
 				  unsigned long event, void *data)
 {
 	struct ghes *ghes;
 	int ret = NOTIFY_DONE;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(ghes, &ghes_sci, list) {
+	list_for_each_entry_rcu(ghes, &ghes_hed, list) {
 		if (!ghes_proc(ghes))
 			ret = NOTIFY_OK;
 	}
@@ -718,8 +718,8 @@ static int ghes_notify_sci(struct notifier_block *this,
 	return ret;
 }
 
-static struct notifier_block ghes_notifier_sci = {
-	.notifier_call = ghes_notify_sci,
+static struct notifier_block ghes_notifier_hed = {
+	.notifier_call = ghes_notify_hed,
 };
 
 #ifdef CONFIG_HAVE_ACPI_APEI_NMI
@@ -966,6 +966,8 @@ static int ghes_probe(struct platform_device *ghes_dev)
 	case ACPI_HEST_NOTIFY_POLLED:
 	case ACPI_HEST_NOTIFY_EXTERNAL:
 	case ACPI_HEST_NOTIFY_SCI:
+	case ACPI_HEST_NOTIFY_GSIV:
+	case ACPI_HEST_NOTIFY_GPIO:
 		break;
 	case ACPI_HEST_NOTIFY_NMI:
 		if (!IS_ENABLED(CONFIG_HAVE_ACPI_APEI_NMI)) {
@@ -1026,10 +1028,12 @@ static int ghes_probe(struct platform_device *ghes_dev)
 		}
 		break;
 	case ACPI_HEST_NOTIFY_SCI:
+	case ACPI_HEST_NOTIFY_GSIV:
+	case ACPI_HEST_NOTIFY_GPIO:
 		mutex_lock(&ghes_list_mutex);
-		if (list_empty(&ghes_sci))
-			register_acpi_hed_notifier(&ghes_notifier_sci);
-		list_add_rcu(&ghes->list, &ghes_sci);
+		if (list_empty(&ghes_hed))
+			register_acpi_hed_notifier(&ghes_notifier_hed);
+		list_add_rcu(&ghes->list, &ghes_hed);
 		mutex_unlock(&ghes_list_mutex);
 		break;
 	case ACPI_HEST_NOTIFY_NMI:
@@ -1068,10 +1072,12 @@ static int ghes_remove(struct platform_device *ghes_dev)
 		free_irq(ghes->irq, ghes);
 		break;
 	case ACPI_HEST_NOTIFY_SCI:
+	case ACPI_HEST_NOTIFY_GSIV:
+	case ACPI_HEST_NOTIFY_GPIO:
 		mutex_lock(&ghes_list_mutex);
 		list_del_rcu(&ghes->list);
-		if (list_empty(&ghes_sci))
-			unregister_acpi_hed_notifier(&ghes_notifier_sci);
+		if (list_empty(&ghes_hed))
+			unregister_acpi_hed_notifier(&ghes_notifier_hed);
 		mutex_unlock(&ghes_list_mutex);
 		break;
 	case ACPI_HEST_NOTIFY_NMI:
-- 
1.9.1
