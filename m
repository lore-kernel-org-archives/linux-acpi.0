From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 13/20] ACPI: thinkpad-acpi: add suspend handler
Date: Tue,  8 Jan 2008 13:02:50 -0200
Message-ID: <1199804577-32017-14-git-send-email-hmh@hmh.eng.br>
References: <1199804577-32017-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:47034 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754758AbYAHPDM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Jan 2008 10:03:12 -0500
In-Reply-To: <1199804577-32017-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Add a handler for suspend events.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/misc/thinkpad_acpi.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index dd6fa81..c6c25a4 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -188,6 +188,7 @@ struct ibm_struct {
 	int (*write) (char *);
 	void (*exit) (void);
 	void (*resume) (void);
+	void (*suspend) (pm_message_t state);
 
 	struct list_head all_drivers;
 
@@ -658,6 +659,21 @@ static struct input_dev *tpacpi_inputdev;
 static struct mutex tpacpi_inputdev_send_mutex;
 static LIST_HEAD(tpacpi_all_drivers);
 
+static int tpacpi_suspend_handler(struct platform_device *pdev,
+				  pm_message_t state)
+{
+	struct ibm_struct *ibm, *itmp;
+
+	list_for_each_entry_safe(ibm, itmp,
+				 &tpacpi_all_drivers,
+				 all_drivers) {
+		if (ibm->suspend)
+			(ibm->suspend)(state);
+	}
+
+	return 0;
+}
+
 static int tpacpi_resume_handler(struct platform_device *pdev)
 {
 	struct ibm_struct *ibm, *itmp;
@@ -677,6 +693,7 @@ static struct platform_driver tpacpi_pdriver = {
 		.name = TPACPI_DRVR_NAME,
 		.owner = THIS_MODULE,
 	},
+	.suspend = tpacpi_suspend_handler,
 	.resume = tpacpi_resume_handler,
 };
 
-- 
1.5.3.7

