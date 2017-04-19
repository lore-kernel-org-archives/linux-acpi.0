From: Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH V3] acpi:apei:handle GSIV and GPIO notification types
Date: Wed, 19 Apr 2017 12:03:51 +0000
Message-ID: <86258A5CC0A3704780874CF6004BA8A62E695201@FRAEML521-MBX.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([45.249.212.187]:5778 "EHLO
        dggrg01-dlp.huawei.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933601AbdDSMET (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Apr 2017 08:04:19 -0400
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "bp@suse.de" <bp@suse.de>, "mingo@kernel.org" <mingo@kernel.org>, "prarit@redhat.com" <prarit@redhat.com>, "tbaicar@codeaurora.org" <tbaicar@codeaurora.org>, "punit.agrawal@arm.com" <punit.agrawal@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "james.morse@arm.com" <james.morse@arm.com>, "fu.wei@linaro.org" <fu.wei@linaro.org>, "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>, Gabriele Paoloni <gabriele.paoloni@huawei.com>, John Garry <john.garry@huawei.com>, "xuwei (O)" <xuwei5@hisilicon.com>, "Zhengqiang (turing)" <zhengqiang10@huawei.com>
Cc: Shiju Jose <shiju.jose@huawei.com>

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
Reviewed-by: James Morse <james.morse@arm.com>
---
 drivers/acpi/apei/ghes.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index b192b42..652971a 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -89,14 +89,15 @@
 module_param_named(disable, ghes_disable, bool, 0);
 
 /*
- * All error sources notified with SCI shares one notifier function,
- * so they need to be linked and checked one by one.  This is applied
- * to NMI too.
+ * All error sources notified with HED(Hardware Error Device)
+ * share a single notifier callback, so they need to be
+ * linked and checked one by one.  This holds true for
+ * NMI too.
  *
  * RCU is used for these lists, so ghes_list_mutex is only used for
  * list changing, not for traversing.
  */
-static LIST_HEAD(ghes_sci);
+static LIST_HEAD(ghes_hed);
 static DEFINE_MUTEX(ghes_list_mutex);
 
 /*
@@ -702,14 +703,14 @@ static irqreturn_t ghes_irq_func(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int ghes_notify_sci(struct notifier_block *this,
-				  unsigned long event, void *data)
+static int ghes_notify_hed(struct notifier_block *this,
+				    unsigned long event, void *data)
 {
 	struct ghes *ghes;
 	int ret = NOTIFY_DONE;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(ghes, &ghes_sci, list) {
+	list_for_each_entry_rcu(ghes, &ghes_hed, list) {
 		if (!ghes_proc(ghes))
 			ret = NOTIFY_OK;
 	}
@@ -718,8 +719,8 @@ static int ghes_notify_sci(struct notifier_block *this,
 	return ret;
 }
 
-static struct notifier_block ghes_notifier_sci = {
-	.notifier_call = ghes_notify_sci,
+static struct notifier_block ghes_notifier_hed = {
+	.notifier_call = ghes_notify_hed,
 };
 
 #ifdef CONFIG_HAVE_ACPI_APEI_NMI
@@ -966,7 +967,10 @@ static int ghes_probe(struct platform_device *ghes_dev)
 	case ACPI_HEST_NOTIFY_POLLED:
 	case ACPI_HEST_NOTIFY_EXTERNAL:
 	case ACPI_HEST_NOTIFY_SCI:
+	case ACPI_HEST_NOTIFY_GSIV:
+	case ACPI_HEST_NOTIFY_GPIO:
 		break;
+
 	case ACPI_HEST_NOTIFY_NMI:
 		if (!IS_ENABLED(CONFIG_HAVE_ACPI_APEI_NMI)) {
 			pr_warn(GHES_PFX "Generic hardware error source: %d notified via NMI interrupt is not supported!\n",
@@ -1025,13 +1029,17 @@ static int ghes_probe(struct platform_device *ghes_dev)
 			goto err_edac_unreg;
 		}
 		break;
+
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
+
 	case ACPI_HEST_NOTIFY_NMI:
 		ghes_nmi_add(ghes);
 		break;
@@ -1067,13 +1075,17 @@ static int ghes_remove(struct platform_device *ghes_dev)
 	case ACPI_HEST_NOTIFY_EXTERNAL:
 		free_irq(ghes->irq, ghes);
 		break;
+
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
+
 	case ACPI_HEST_NOTIFY_NMI:
 		ghes_nmi_remove(ghes);
 		break;
-- 
1.9.1

