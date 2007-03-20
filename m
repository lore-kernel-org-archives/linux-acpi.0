From: Len Brown <len.brown@intel.com>
Subject: [PATCH 6/9] ACPI: ibm-acpi: allow module to load when acpi notifiers can't be set (v2)
Date: Tue, 20 Mar 2007 11:27:08 -0400
Message-ID: <11744044363481-git-send-email-len.brown@intel.com>
References: <1174404431897-git-send-email-len.brown@intel.com> <11744044323719-git-send-email-len.brown@intel.com> <11744044323692-git-send-email-len.brown@intel.com> <11744044333328-git-send-email-len.brown@intel.com> <11744044341614-git-send-email-len.brown@intel.com> <11744044351759-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:9682 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933826AbXCTP1d (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Mar 2007 11:27:33 -0400
In-Reply-To: <11744044351759-git-send-email-len.brown@intel.com>
Message-Id: <96e89afe6da630dc54cfbca33c2c6a7ab9b6c11b.1174404137.git.len.brown@intel.com>
In-Reply-To: <a1fdcc0d2714b6622e3fd5c00db1635213d6c41a.1174404136.git.len.brown@intel.com>
References: <a1fdcc0d2714b6622e3fd5c00db1635213d6c41a.1174404136.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

This patch allows for ibm-acpi to coexist (with diminished functionality) with
other drivers like ACPI_BAY.  ibm-acpi will simply disable the functions it is
not able to register ACPI notifiers for.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Chris Wedgwood <cw@f00f.org>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ibm_acpi.c |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index 3690136..dc10966 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -2507,7 +2507,7 @@ static int __init setup_notify(struct ibm_struct *ibm)
 	ret = acpi_bus_get_device(*ibm->handle, &ibm->device);
 	if (ret < 0) {
 		printk(IBM_ERR "%s device not present\n", ibm->name);
-		return 0;
+		return -ENODEV;
 	}
 
 	acpi_driver_data(ibm->device) = ibm;
@@ -2516,8 +2516,13 @@ static int __init setup_notify(struct ibm_struct *ibm)
 	status = acpi_install_notify_handler(*ibm->handle, ibm->type,
 					     dispatch_notify, ibm);
 	if (ACPI_FAILURE(status)) {
-		printk(IBM_ERR "acpi_install_notify_handler(%s) failed: %d\n",
-		       ibm->name, status);
+		if (status == AE_ALREADY_EXISTS) {
+			printk(IBM_NOTICE "another device driver is already handling %s events\n",
+				ibm->name);
+		} else {
+			printk(IBM_ERR "acpi_install_notify_handler(%s) failed: %d\n",
+				ibm->name, status);
+		}
 		return -ENODEV;
 	}
 	ibm->notify_installed = 1;
@@ -2553,6 +2558,8 @@ static int __init register_driver(struct ibm_struct *ibm)
 	return ret;
 }
 
+static void ibm_exit(struct ibm_struct *ibm);
+
 static int __init ibm_init(struct ibm_struct *ibm)
 {
 	int ret;
@@ -2594,6 +2601,12 @@ static int __init ibm_init(struct ibm_struct *ibm)
 
 	if (ibm->notify) {
 		ret = setup_notify(ibm);
+		if (ret == -ENODEV) {
+			printk(IBM_NOTICE "disabling subdriver %s\n",
+				ibm->name);
+			ibm_exit(ibm);
+			return 0;
+		}
 		if (ret < 0)
 			return ret;
 	}
-- 
1.5.0.3.382.g34572
