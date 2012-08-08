From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 3/3] tpm_tis / PM: Fix unused function warning for CONFIG_PM_SLEEP
Date: Wed, 8 Aug 2012 23:22:22 +0200
Message-ID: <201208082322.22314.rjw@sisk.pl>
References: <201208082308.15466.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:49499 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753001Ab2HHVQ3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Aug 2012 17:16:29 -0400
In-Reply-To: <201208082308.15466.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Len Brown <lenb@kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg@redhat.com>, platform-driver-x86@vger.kernel.org


According to a compiler warning, the tpm_tis_resume() function is not
used for CONFIG_PM_SLEEP unset, so add a #ifdef to prevent it from
being built in that case.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/char/tpm/tpm_tis.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux/drivers/char/tpm/tpm_tis.c
===================================================================
--- linux.orig/drivers/char/tpm/tpm_tis.c
+++ linux/drivers/char/tpm/tpm_tis.c
@@ -807,6 +807,7 @@ module_param_string(hid, tpm_pnp_tbl[TIS
 MODULE_PARM_DESC(hid, "Set additional specific HID for this driver to probe");
 #endif
 
+#ifdef CONFIG_PM_SLEEP
 static int tpm_tis_resume(struct device *dev)
 {
 	struct tpm_chip *chip = dev_get_drvdata(dev);
@@ -816,6 +817,7 @@ static int tpm_tis_resume(struct device
 
 	return tpm_pm_resume(dev);
 }
+#endif
 
 static SIMPLE_DEV_PM_OPS(tpm_tis_pm, tpm_pm_suspend, tpm_tis_resume);
 

