From: yakui.zhao@intel.com
Subject: [PATCH 1/3] ipmi/acpi: Fix the building error in ipmi module
Date: Wed, 16 Dec 2009 22:40:29 +0800
Message-ID: <1260974431-4330-1-git-send-email-yakui.zhao@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3431 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762165AbZLPOmS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Dec 2009 09:42:18 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, minyard@acm.org, openipmi-developer@lists.sourceforege.net, Zhao Yakui <yakui.zhao@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>

From: Zhao Yakui <yakui.zhao@intel.com>

When the IPMI module is selected as module, it will complain the
following building error.
>ERROR: "pnpacpi_protocol" [drivers/char/ipmi/ipmi_si.ko] undefined!

Fix the above building error.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/pnp/pnpacpi/core.c |    7 +++++++
 include/linux/pnp.h        |   11 +++--------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index 8dd0f37..8eebbe4 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -155,6 +155,13 @@ struct pnp_protocol pnpacpi_protocol = {
 #endif
 };
 
+struct acpi_device *pnp_acpi_device(struct pnp_dev *dev)
+{
+	if (dev->protocol == &pnpacpi_protocol)
+		return dev->data;
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(pnp_acpi_device);
 static int __init pnpacpi_add_device(struct acpi_device *device)
 {
 	acpi_handle temp = NULL;
diff --git a/include/linux/pnp.h b/include/linux/pnp.h
index 7c4193e..0ae2c64 100644
--- a/include/linux/pnp.h
+++ b/include/linux/pnp.h
@@ -335,16 +335,11 @@ extern struct pnp_protocol pnpbios_protocol;
 #endif
 
 #ifdef CONFIG_PNPACPI
-extern struct pnp_protocol pnpacpi_protocol;
 
-static inline struct acpi_device *pnp_acpi_device(struct pnp_dev *dev)
-{
-	if (dev->protocol == &pnpacpi_protocol)
-		return dev->data;
-	return NULL;
-}
+extern struct acpi_device *pnp_acpi_device(struct pnp_dev *dev);
 #else
-#define pnp_acpi_device(dev) 0
+static inline struct acpi_device *pnp_acpi_device(struct pnp_dev *dev)
+{ return NULL; }
 #endif
 
 /* status */
-- 
1.5.4.5

