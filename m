From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH V3] ACPI / LPSS: Add device link for CHT SD card
 dependency on I2C
Date: Fri, 15 Dec 2017 19:04:30 +0200
Message-ID: <1513357470.7000.121.camel@linux.intel.com>
References: <1513342127-26646-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:38156 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755715AbdLORGF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Dec 2017 12:06:05 -0500
In-Reply-To: <1513342127-26646-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Carlo Caione <carlo@endlessm.com>, Hans de Goede <hdegoede@redhat.com>

On Fri, 2017-12-15 at 14:48 +0200, Adrian Hunter wrote:
> Some Cherry Trail boards have a dependency between the SDHCI host
> controller used for SD cards and an external PMIC accessed via I2C.
> Add a
> device link between the SDHCI host controller (consumer) and the I2C
> adapter (supplier).
> 
> This patch depends on a fix to devices links, namely commit
> 0ff26c662d5f
> ("driver core: Fix device link deferred probe"). And also either,
> commit 126dbc6b49c8 ("PM: i2c-designware-platdrv: Clean up PM handling
> in
> probe"), or patch "PM / runtime: Fix handling of suppliers with
> disabled
> runtime PM".

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
> 
> 
> Changes in V3:
> 
> 	I2C HID is from CHT so the cpu check is not necessary for now,
> so
> 	it was removed.
> 
> Changes in V2:
> 
> 	Add a comment about why it is necessary to hardcode the links
> 	information in the code
> 
> 
>  drivers/acpi/acpi_lpss.c | 137
> +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 137 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index 7f2b02cc8ea1..d78c57a95b86 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -427,6 +427,142 @@ static int register_device_clock(struct
> acpi_device *adev,
>  	return 0;
>  }
>  
> +struct lpss_device_links {
> +	const char *supplier_hid;
> +	const char *supplier_uid;
> +	const char *consumer_hid;
> +	const char *consumer_uid;
> +	u32 flags;
> +};
> +
> +/*
> + * The _DEP method is used to identify dependencies but instead of
> creating
> + * device links for every handle in _DEP, only links in the following
> list are
> + * created. That is necessary because, in the general case, _DEP can
> refer to
> + * devices that might not have drivers, or that are on different
> buses, or where
> + * the supplier is not enumerated until after the consumer is probed.
> + */
> +static const struct lpss_device_links lpss_device_links[] = {
> +	{"808622C1", "7", "80860F14", "3", DL_FLAG_PM_RUNTIME},
> +};
> +
> +static bool hid_uid_match(const char *hid1, const char *uid1,
> +			  const char *hid2, const char *uid2)
> +{
> +	return !strcmp(hid1, hid2) && uid1 && uid2 && !strcmp(uid1,
> uid2);
> +}
> +
> +static bool acpi_lpss_is_supplier(struct acpi_device *adev,
> +				  const struct lpss_device_links
> *link)
> +{
> +	return hid_uid_match(acpi_device_hid(adev),
> acpi_device_uid(adev),
> +			     link->supplier_hid, link->supplier_uid);
> +}
> +
> +static bool acpi_lpss_is_consumer(struct acpi_device *adev,
> +				  const struct lpss_device_links
> *link)
> +{
> +	return hid_uid_match(acpi_device_hid(adev),
> acpi_device_uid(adev),
> +			     link->consumer_hid, link->consumer_uid);
> +}
> +
> +struct hid_uid {
> +	const char *hid;
> +	const char *uid;
> +};
> +
> +static int match_hid_uid(struct device *dev, void *data)
> +{
> +	struct acpi_device *adev = ACPI_COMPANION(dev);
> +	struct hid_uid *id = data;
> +
> +	if (!adev)
> +		return 0;
> +
> +	return hid_uid_match(acpi_device_hid(adev),
> acpi_device_uid(adev),
> +			     id->hid, id->uid);
> +}
> +
> +static struct device *acpi_lpss_find_device(const char *hid, const
> char *uid)
> +{
> +	struct hid_uid data = {
> +		.hid = hid,
> +		.uid = uid,
> +	};
> +
> +	return bus_find_device(&platform_bus_type, NULL, &data,
> match_hid_uid);
> +}
> +
> +static bool acpi_lpss_dep(struct acpi_device *adev, acpi_handle
> handle)
> +{
> +	struct acpi_handle_list dep_devices;
> +	acpi_status status;
> +	int i;
> +
> +	if (!acpi_has_method(adev->handle, "_DEP"))
> +		return false;
> +
> +	status = acpi_evaluate_reference(adev->handle, "_DEP", NULL,
> +					 &dep_devices);
> +	if (ACPI_FAILURE(status)) {
> +		dev_dbg(&adev->dev, "Failed to evaluate _DEP.\n");
> +		return false;
> +	}
> +
> +	for (i = 0; i < dep_devices.count; i++) {
> +		if (dep_devices.handles[i] == handle)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static void acpi_lpss_link_consumer(struct device *dev1,
> +				    const struct lpss_device_links
> *link)
> +{
> +	struct device *dev2;
> +
> +	dev2 = acpi_lpss_find_device(link->consumer_hid, link-
> >consumer_uid);
> +	if (!dev2)
> +		return;
> +
> +	if (acpi_lpss_dep(ACPI_COMPANION(dev2), ACPI_HANDLE(dev1)))
> +		device_link_add(dev2, dev1, link->flags);
> +
> +	put_device(dev2);
> +}
> +
> +static void acpi_lpss_link_supplier(struct device *dev1,
> +				    const struct lpss_device_links
> *link)
> +{
> +	struct device *dev2;
> +
> +	dev2 = acpi_lpss_find_device(link->supplier_hid, link-
> >supplier_uid);
> +	if (!dev2)
> +		return;
> +
> +	if (acpi_lpss_dep(ACPI_COMPANION(dev1), ACPI_HANDLE(dev2)))
> +		device_link_add(dev1, dev2, link->flags);
> +
> +	put_device(dev2);
> +}
> +
> +static void acpi_lpss_create_device_links(struct acpi_device *adev,
> +					  struct platform_device
> *pdev)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(lpss_device_links); i++) {
> +		const struct lpss_device_links *link =
> &lpss_device_links[i];
> +
> +		if (acpi_lpss_is_supplier(adev, link))
> +			acpi_lpss_link_consumer(&pdev->dev, link);
> +
> +		if (acpi_lpss_is_consumer(adev, link))
> +			acpi_lpss_link_supplier(&pdev->dev, link);
> +	}
> +}
> +
>  static int acpi_lpss_create_device(struct acpi_device *adev,
>  				   const struct acpi_device_id *id)
>  {
> @@ -500,6 +636,7 @@ static int acpi_lpss_create_device(struct
> acpi_device *adev,
>  	adev->driver_data = pdata;
>  	pdev = acpi_create_platform_device(adev, dev_desc-
> >properties);
>  	if (!IS_ERR_OR_NULL(pdev)) {
> +		acpi_lpss_create_device_links(adev, pdev);
>  		return 1;
>  	}
>  

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
