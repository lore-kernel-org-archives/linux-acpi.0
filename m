From: Len Brown <len.brown@intel.com>
Subject: [PATCH 52/77] ACPI: thinkpad-acpi: add power-management handler capability
Date: Sun, 22 Jul 2007 05:14:37 -0400
Message-ID: <11850957561003-git-send-email-len.brown@intel.com>
References: <11850957022956-git-send-email-len.brown@intel.com>
 <11850957033938-git-send-email-len.brown@intel.com>
 <11850957043270-git-send-email-len.brown@intel.com>
 <11850957053842-git-send-email-len.brown@intel.com>
 <11850957062754-git-send-email-len.brown@intel.com>
 <11850957073494-git-send-email-len.brown@intel.com>
 <1185095708928-git-send-email-len.brown@intel.com>
 <11850957093360-git-send-email-len.brown@intel.com>
 <11850957102641-git-send-email-len.brown@intel.com>
 <11850957111797-git-send-email-len.brown@intel.com>
 <11850957123807-git-send-email-len.brown@intel.com>
 <11850957131802-git-send-email-len.brown@intel.com>
 <1185095714699-git-send-email-len.brown@intel.com>
 <1185095715506-git-send-email-len.brown@intel.com>
 <11850957162801-git-send-email-len.brown@intel.com>
 <11850957173842-git-send-email-len.brown@intel.com>
 <11850957181201-git-send-email-len.brown@intel.com>
 <11850957192175-git-send-email-len.brown@intel.com>
 <1185095721166-git-send-email-len.brown@intel.com>
 <1185095721760-git-send-email-len.brown@intel.com>
 <11850957232745-git-send-email-len.brown@intel.com>
 <11850957242656-git-send-email-len.brown@intel.com>
 <11850957252722-git-send-email-len.brown@intel.com>
 <11850957262869-git-send-email-len.brown@intel.com>
 <11850957272369-git-send-email-len.brown@intel.com>
 <11850957282082-git-send-email-len.brown@intel.com>
 <11850957292555-git-send-email-len.brown@intel.com>
 <11850957302782-git-send-email-len.brown@intel.com>
 <11850957311269-git-send-email-len.brown@intel.com>
 <11850957323059-git-send-email-len.brown@intel.com>
 <11850957332171-git-send-email-len.brown@intel.com>
 <11850957342584-git-send-email-len.brown@intel.com>
 <11850957362476-git-send-email-len.brown@intel.com>
 <11850957361736-git-send-email-len.brown@intel.com>
 <1185095737422-git-send-email-len.brown@intel.com>
 <11850957384004-git-send-email-len.brown@intel.com>
 <1185095739370-git-send-email-len.brown@intel.com>
 <11850957403722-git-send-email-len.brown@intel.com>
 <11850957413607-git-send-email-len.brown@intel.com>
 <11850957432095-git-send-email-len.brown@intel.com>
 <11850957443711-git-send-email-len.brown@intel.com>
 <11850957451942-git-send-email-len.brown@intel.com>
 <11850957462109-git-send-email-len.brown@intel.com>
 <11850957471828-git-send-email-len.brown@intel.com>
 <11850957482671-git-send-email-len.brown@intel.com>
 <11850957491254-git-send-email-len.brown@intel.com>
 <11850957503243-git-send-email-len.brown@intel.com>
 <1185095751279-git-send-email-len.brown@intel.com>
 <11850957522609-git-send-email-len.brown@intel.com>
 <11850957531914-git-send-email-len.brown@intel.com>
 <11850957541879-git-send-email-len.brown@intel.com>
 <11850957552824-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53139 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763424AbXGVJP6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:15:58 -0400
In-Reply-To: <11850957552824-git-send-email-len.brown@intel.com>
Message-Id: <e295e8508c1dd56e06c73e78a2f67f2eb563e74f.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Some subdrivers could benefit from resume handling, so add the
infrastructure for simple resume handling.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/thinkpad_acpi.c |   16 ++++++++++++++++
 drivers/misc/thinkpad_acpi.h |    1 +
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index c86b228..78914bf 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -519,11 +519,27 @@ static struct platform_device *tpacpi_pdev;
 static struct class_device *tpacpi_hwmon;
 static struct input_dev *tpacpi_inputdev;
 
+
+static int tpacpi_resume_handler(struct platform_device *pdev)
+{
+	struct ibm_struct *ibm, *itmp;
+
+	list_for_each_entry_safe(ibm, itmp,
+				 &tpacpi_all_drivers,
+				 all_drivers) {
+		if (ibm->resume)
+			(ibm->resume)();
+	}
+
+	return 0;
+}
+
 static struct platform_driver tpacpi_pdriver = {
 	.driver = {
 		.name = IBM_DRVR_NAME,
 		.owner = THIS_MODULE,
 	},
+	.resume = tpacpi_resume_handler,
 };
 
 
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index 00f1bd7..c5c1316 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -205,6 +205,7 @@ struct ibm_struct {
 	int (*read) (char *);
 	int (*write) (char *);
 	void (*exit) (void);
+	void (*resume) (void);
 
 	struct list_head all_drivers;
 
-- 
1.5.3.rc2.22.g69a9b
