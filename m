From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / LPSS: set first resuming device as a 'proxy'
Date: Wed, 21 Jan 2015 16:03:02 +0100
Message-ID: <1826096.Y1k7UfFlRi@vostro.rjw.lan>
References: <1421320244-3490-1-git-send-email-andriy.shevchenko@linux.intel.com> <6322489.a8QUfpK4WQ@vostro.rjw.lan> <15808134.zPSB1QlmdE@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58951 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752373AbbAUOk0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Jan 2015 09:40:26 -0500
In-Reply-To: <15808134.zPSB1QlmdE@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>

On Wednesday, January 21, 2015 03:37:43 AM Rafael J. Wysocki wrote:
> On Tuesday, January 20, 2015 03:45:36 PM Rafael J. Wysocki wrote:
> > On Thursday, January 15, 2015 01:10:44 PM Andy Shevchenko wrote:
> > > We can't rely on the first enumerated device since it might be not probed yet
> > > when DMA driver wants to resume the device. This patch changes the place where
> > > we assign the 'proxy' device. From now on the first resumed device will be
> > > recognized as a 'proxy' because it is probed.
> > 
> > I was about to apply this, but I realized that we couldn't do it this way. ->
> > 
> > > Reported-by: Jerome Blin <jerome.blin@intel.com>
> > > Fixes: 6c17ee44d524 (ACPI / LPSS: introduce a 'proxy' device to power on LPSS for DMA)
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > >  drivers/acpi/acpi_lpss.c | 17 +++++++++++------
> > >  1 file changed, 11 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> > > index 4f3febf..d851290 100644
> > > --- a/drivers/acpi/acpi_lpss.c
> > > +++ b/drivers/acpi/acpi_lpss.c
> > > @@ -374,8 +374,6 @@ static int acpi_lpss_create_device(struct acpi_device *adev,
> > >  	adev->driver_data = pdata;
> > >  	pdev = acpi_create_platform_device(adev);
> > >  	if (!IS_ERR_OR_NULL(pdev)) {
> > > -		if (!proxy_device && dev_desc->flags & LPSS_DEV_PROXY)
> > > -			proxy_device = &pdev->dev;
> > >  		return 1;
> > >  	}
> > >  
> > > @@ -615,10 +613,17 @@ static int acpi_lpss_runtime_resume(struct device *dev)
> > >  	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
> > >  	int ret;
> > >  
> > > -	if (pdata->dev_desc->flags & LPSS_PROXY_REQ && proxy_device) {
> > > -		ret = pm_runtime_get_sync(proxy_device);
> > > -		if (ret)
> > > -			return ret;
> > > +	if (!proxy_device && pdata->dev_desc->flags & LPSS_DEV_PROXY)
> > > +		proxy_device = dev;
> > 
> > -> OK, so what if the driver of proxy_device is removed later?
> > 
> > > +
> > > +	if (pdata->dev_desc->flags & LPSS_PROXY_REQ) {
> > > +		if (proxy_device) {
> > > +			ret = pm_runtime_get_sync(proxy_device);
> > > +			if (ret)
> > > +				return ret;
> > > +		} else {
> > > +			return -EPROBE_DEFER;
> > 
> > The error code returned here will disable runtime PM for dev forever,
> > even if proxy_device becomes available at one point.  You could return
> > -EBUSY instead, but why don't we add BUS_NOTIFY_BOUND_DRIVER and
> > BUS_NOTIFY_UNBIND_DRIVER handling to acpi_lpss_platform_notify() and
> > set/unset proxy_device from there?
> 
> Well, that's more complicated, because we need to be careful when we switch
> proxies while the old one has been reference counted.
> 
> Maybe something like this (untested)?

That sill had a few problems.

The one below should be better (still untested, though).  It assumes that
the devices needing a proxy will never start as runtime-suspended and will
always be resumed before removal.

---
 drivers/acpi/acpi_lpss.c |  126 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 113 insertions(+), 13 deletions(-)

Index: linux-pm/drivers/acpi/acpi_lpss.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpi_lpss.c
+++ linux-pm/drivers/acpi/acpi_lpss.c
@@ -72,12 +72,21 @@ struct lpss_device_desc {
 	void (*setup)(struct lpss_private_data *pdata);
 };
 
-static struct device *proxy_device;
-
 static struct lpss_device_desc lpss_dma_desc = {
 	.flags = LPSS_CLK | LPSS_PROXY_REQ,
 };
 
+struct lpss_proxy {
+	struct device *dev;
+	struct list_head node;
+};
+
+static struct lpss_proxy *current_proxy;
+static unsigned int proxy_count;
+static unsigned int proxy_suspend_count;
+static LIST_HEAD(proxy_list);
+static DEFINE_MUTEX(proxy_lock);
+
 struct lpss_private_data {
 	void __iomem *mmio_base;
 	resource_size_t mmio_size;
@@ -85,6 +94,7 @@ struct lpss_private_data {
 	struct clk *clk;
 	const struct lpss_device_desc *dev_desc;
 	u32 prv_reg_ctx[LPSS_PRV_REG_COUNT];
+	struct lpss_proxy proxy_entry;
 };
 
 /* UART Component Parameter Register */
@@ -373,11 +383,8 @@ static int acpi_lpss_create_device(struc
 
 	adev->driver_data = pdata;
 	pdev = acpi_create_platform_device(adev);
-	if (!IS_ERR_OR_NULL(pdev)) {
-		if (!proxy_device && dev_desc->flags & LPSS_DEV_PROXY)
-			proxy_device = &pdev->dev;
+	if (!IS_ERR_OR_NULL(pdev))
 		return 1;
-	}
 
 	ret = PTR_ERR(pdev);
 	adev->driver_data = NULL;
@@ -591,23 +598,41 @@ static int acpi_lpss_resume_early(struct
 static int acpi_lpss_runtime_suspend(struct device *dev)
 {
 	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
+	bool use_proxy;
 	int ret;
 
+	if (pdata->dev_desc->flags & LPSS_PROXY_REQ) {
+		use_proxy = true;
+		mutex_lock(&proxy_lock);
+		if (!current_proxy) {
+			ret = -EBUSY;
+			goto out;
+		}
+	} else {
+		use_proxy = false;
+	}
+
 	ret = pm_generic_runtime_suspend(dev);
 	if (ret)
-		return ret;
+		goto out;
 
 	if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
 		acpi_lpss_save_ctx(dev, pdata);
 
 	ret = acpi_dev_runtime_suspend(dev);
 	if (ret)
-		return ret;
+		goto out;
 
-	if (pdata->dev_desc->flags & LPSS_PROXY_REQ && proxy_device)
-		return pm_runtime_put_sync_suspend(proxy_device);
+	if (use_proxy) {
+		proxy_suspend_count++;
+		ret = pm_runtime_put_sync_suspend(current_proxy->dev);
+	}
 
-	return 0;
+ out:
+	if (use_proxy)
+		mutex_unlock(&proxy_lock);
+
+	return ret;
 }
 
 static int acpi_lpss_runtime_resume(struct device *dev)
@@ -615,8 +640,16 @@ static int acpi_lpss_runtime_resume(stru
 	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
 	int ret;
 
-	if (pdata->dev_desc->flags & LPSS_PROXY_REQ && proxy_device) {
-		ret = pm_runtime_get_sync(proxy_device);
+	if (pdata->dev_desc->flags & LPSS_PROXY_REQ) {
+		mutex_lock(&proxy_lock);
+		if (current_proxy) {
+			ret = pm_runtime_get_sync(current_proxy->dev);
+			if (!ret)
+				proxy_suspend_count--;
+		} else {
+			ret = -EBUSY;
+		}
+		mutex_unlock(&proxy_lock);
 		if (ret)
 			return ret;
 	}
@@ -652,6 +685,29 @@ static struct dev_pm_domain acpi_lpss_pm
 	},
 };
 
+static void acpi_lpss_switch_proxy(void)
+{
+	struct device *dev = current_proxy ? current_proxy->dev : NULL;
+	unsigned int count = proxy_count - proxy_suspend_count;
+
+	if (list_empty(&proxy_list)) {
+		current_proxy = NULL;
+	} else {
+		struct lpss_private_data *lpd;
+
+		lpd = list_first_entry(&proxy_list, struct lpss_private_data,
+				       proxy_entry.node);
+		current_proxy = &lpd->proxy_entry;
+	}
+	while (count--) {
+		if (dev)
+			pm_runtime_put_noidle(dev);
+
+		if (current_proxy)
+			pm_runtime_get_sync(current_proxy->dev);
+	}
+}
+
 static int acpi_lpss_platform_notify(struct notifier_block *nb,
 				     unsigned long action, void *data)
 {
@@ -680,15 +736,59 @@ static int acpi_lpss_platform_notify(str
 	switch (action) {
 	case BUS_NOTIFY_ADD_DEVICE:
 		pdev->dev.pm_domain = &acpi_lpss_pm_domain;
+		if (pdata->dev_desc->flags & LPSS_DEV_PROXY) {
+			mutex_lock(&proxy_lock);
+
+			/* This assimes the device to be powered up. */
+			proxy_count++;
+			if (current_proxy)
+				pm_runtime_get_sync(current_proxy->dev);
+
+			mutex_unlock(&proxy_lock);
+		}
 		if (pdata->dev_desc->flags & LPSS_LTR)
 			return sysfs_create_group(&pdev->dev.kobj,
 						  &lpss_attr_group);
 		break;
 	case BUS_NOTIFY_DEL_DEVICE:
+		if (pdata->dev_desc->flags & LPSS_DEV_PROXY) {
+			mutex_lock(&proxy_lock);
+
+			/* This assumes that the device is not suspended. */
+			proxy_count--;
+			if (current_proxy)
+				pm_runtime_put(current_proxy->dev);
+
+			mutex_unlock(&proxy_lock);
+		}
 		if (pdata->dev_desc->flags & LPSS_LTR)
 			sysfs_remove_group(&pdev->dev.kobj, &lpss_attr_group);
 		pdev->dev.pm_domain = NULL;
 		break;
+	case BUS_NOTIFY_BOUND_DRIVER:
+		if (pdata->dev_desc->flags & LPSS_DEV_PROXY) {
+			mutex_lock(&proxy_lock);
+
+			INIT_LIST_HEAD(&pdata->proxy_entry.node);
+			pdata->proxy_entry.dev = &pdev->dev;
+			list_add_tail(&pdata->proxy_entry.node, &proxy_list);
+			if (!current_proxy)
+				acpi_lpss_switch_proxy();
+
+			mutex_unlock(&proxy_lock);
+		}
+		break;
+	case BUS_NOTIFY_UNBIND_DRIVER:
+		if (pdata->dev_desc->flags & LPSS_DEV_PROXY) {
+			mutex_lock(&proxy_lock);
+
+			list_del(&pdata->proxy_entry.node);
+			if (current_proxy == &pdata->proxy_entry)
+				acpi_lpss_switch_proxy();
+
+			mutex_unlock(&proxy_lock);
+		}
+		break;
 	default:
 		break;
 	}

