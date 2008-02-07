From: Len Brown <lenb@kernel.org>
Subject: [PATCH 044/112] ACPI: thinkpad-acpi: add suspend handler
Date: Thu,  7 Feb 2008 04:34:06 -0500
Message-ID: <083f17606f624c79555e313d87cf37ac1486b073.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:20777 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755210AbYBGJgM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:12 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Add a handler for suspend events.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.5.4.23.gef5b9

