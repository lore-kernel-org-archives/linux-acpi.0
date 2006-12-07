From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 14/14] ACPI: ibm_acpi: don't use '/' in driver names
Date: Thu, 07 Dec 2006 20:57:57 +0800
Message-ID: <1165496277.11485.88.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:9779 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032181AbWLGMyB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Dec 2006 07:54:01 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: "linux-acpi@vger" <linux-acpi@vger.kernel.org>, hmh@hmh.eng.br

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

ibm-acpi uses sub-device names like ibm/hotkey, which get in the way of
a sysfs conversion.  Fix it to use ibm_hotkey instead.  Thanks to Zhang
Rui for noticing this.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---

 drivers/acpi/ibm_acpi.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.19/drivers/acpi/ibm_acpi.c
===================================================================
--- linux-2.6.19.orig/drivers/acpi/ibm_acpi.c	2006-12-01 11:10:37.000000000 +0800
+++ linux-2.6.19/drivers/acpi/ibm_acpi.c	2006-12-01 11:33:30.000000000 +0800
@@ -1825,7 +1825,7 @@ static int __init register_driver(struct
 	}
 
 	memset(ibm->driver, 0, sizeof(struct acpi_driver));
-	sprintf(ibm->driver->name, "%s/%s", IBM_NAME, ibm->name);
+	sprintf(ibm->driver->name, "%s_%s", IBM_NAME, ibm->name);
 	ibm->driver->ids = ibm->hid;
 	ibm->driver->ops.add = &ibm_device_add;
 
