From: Len Brown <len.brown@intel.com>
Subject: [PATCH 03/16] ACPI, PNP: hook ACPI D-state to PNP suspend/resume
Date: Wed, 25 Jul 2007 01:51:12 -0400
Message-ID: <11853426881963-git-send-email-len.brown@intel.com>
References: <11853426852588-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:52336 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752734AbXGYFva (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jul 2007 01:51:30 -0400
In-Reply-To: <11853426852588-git-send-email-len.brown@intel.com>
Message-Id: <fc30e68e88baf463683bde43347756889ba2ffae.1185342489.git.len.brown@intel.com>
In-Reply-To: <e9b3aba887f47f9cd64de20fec9c333a932b70dc.1185342489.git.len.brown@intel.com>
References: <e9b3aba887f47f9cd64de20fec9c333a932b70dc.1185342489.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Shaohua Li <shaohua.li@intel.com>, Len Brown <len.brown@intel.com>

From: Shaohua Li <shaohua.li@intel.com>

applied after Rafel's 'PM: Update global suspend and hibernation operations framework' patch set

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/driver.c       |    5 +++++
 drivers/pnp/pnpacpi/core.c |   14 ++++++++++++++
 include/linux/pnp.h        |    4 ++++
 3 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/drivers/pnp/driver.c b/drivers/pnp/driver.c
index e161423..1432806 100644
--- a/drivers/pnp/driver.c
+++ b/drivers/pnp/driver.c
@@ -167,6 +167,8 @@ static int pnp_bus_suspend(struct device *dev, pm_message_t state)
 	    		return error;
 	}
 
+	if (pnp_dev->protocol && pnp_dev->protocol->suspend)
+		pnp_dev->protocol->suspend(pnp_dev, state);
 	return 0;
 }
 
@@ -179,6 +181,9 @@ static int pnp_bus_resume(struct device *dev)
 	if (!pnp_drv)
 		return 0;
 
+	if (pnp_dev->protocol && pnp_dev->protocol->resume)
+		pnp_dev->protocol->resume(pnp_dev);
+
 	if (!(pnp_drv->flags & PNP_DRIVER_RES_DO_NOT_CHANGE)) {
 		error = pnp_start_dev(pnp_dev);
 		if (error)
diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index a005487..c37a558 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -119,11 +119,25 @@ static int pnpacpi_disable_resources(struct pnp_dev *dev)
 	return ACPI_FAILURE(status) ? -ENODEV : 0;
 }
 
+static int pnpacpi_suspend(struct pnp_dev *dev, pm_message_t state)
+{
+	return acpi_bus_set_power((acpi_handle)dev->data,
+		acpi_pm_device_sleep_state(&dev->dev,
+		device_may_wakeup(&dev->dev), NULL));
+}
+
+static int pnpacpi_resume(struct pnp_dev *dev)
+{
+	return acpi_bus_set_power((acpi_handle)dev->data, ACPI_STATE_D0);
+}
+
 static struct pnp_protocol pnpacpi_protocol = {
 	.name	= "Plug and Play ACPI",
 	.get	= pnpacpi_get_resources,
 	.set	= pnpacpi_set_resources,
 	.disable = pnpacpi_disable_resources,
+	.suspend = pnpacpi_suspend,
+	.resume = pnpacpi_resume,
 };
 
 static int __init pnpacpi_add_device(struct acpi_device *device)
diff --git a/include/linux/pnp.h b/include/linux/pnp.h
index 2a1897e..66edb22 100644
--- a/include/linux/pnp.h
+++ b/include/linux/pnp.h
@@ -335,6 +335,10 @@ struct pnp_protocol {
 	int (*set)(struct pnp_dev *dev, struct pnp_resource_table *res);
 	int (*disable)(struct pnp_dev *dev);
 
+	/* protocol specific suspend/resume */
+	int (*suspend)(struct pnp_dev *dev, pm_message_t state);
+	int (*resume)(struct pnp_dev *dev);
+
 	/* used by pnp layer only (look but don't touch) */
 	unsigned char		number;		/* protocol number*/
 	struct device		dev;		/* link to driver model */
-- 
1.5.3.rc2.22.g69a9b
