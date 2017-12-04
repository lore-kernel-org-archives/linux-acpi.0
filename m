From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] ACPI / LPSS: Add device link for CHT SD card dependency
 on I2C
Date: Mon, 4 Dec 2017 16:30:41 +0200
Message-ID: <1860f193-3300-c718-9a79-d6fb690810cf@intel.com>
References: <1512390731-11171-1-git-send-email-adrian.hunter@intel.com>
 <a949a90b-95f5-ad89-9ee0-b7e7feaf4387@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:36884 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752856AbdLDObE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 4 Dec 2017 09:31:04 -0500
In-Reply-To: <a949a90b-95f5-ad89-9ee0-b7e7feaf4387@redhat.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Carlo Caione <carlo@endlessm.com>

On 04/12/17 15:48, Hans de Goede wrote:
> Hi,
> 
> Wouldn't it be easier to use the ACPI _DEP tracking for this, e.g.

It is using _DEP, see acpi_lpss_dep()

> add something like this to the the probe function:
> 
>     struct acpi_device = ACPI_COMPANION(device);
> 
>     if (acpi_device->dep_unmet)
>         return -EPROBE_DEFER;
> 
> No idea if this will work, but if it does work, using the deps described
> in the ACPI tables seems like a better solution then hardcoding this.

That would not work because there are other devices listed in the _DEP
method so dep_unmet is always true.  So we are left checking _DEP but only
for specific device dependencies.

> 
> Regards,
> 
> Hans
> 
> 
> 
> On 04-12-17 13:32, Adrian Hunter wrote:
>> Some Cherry Trail boards have a dependency between the SDHCI host
>> controller used for SD cards and an external PMIC accessed via I2C. Add a
>> device link between the SDHCI host controller (consumer) and the I2C
>> adapter (supplier).
>>
>> This patch depends on a fix to devices links, namely commit 0ff26c662d5f
>> ("driver core: Fix device link deferred probe"). And also either,
>> commit 126dbc6b49c8 ("PM: i2c-designware-platdrv: Clean up PM handling in
>> probe"), or patch "PM / runtime: Fix handling of suppliers with disabled
>> runtime PM".
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>   drivers/acpi/acpi_lpss.c | 139
>> +++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 139 insertions(+)
>>
>> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
>> index 7f2b02cc8ea1..9d82f2f6c327 100644
>> --- a/drivers/acpi/acpi_lpss.c
>> +++ b/drivers/acpi/acpi_lpss.c
>> @@ -290,6 +290,11 @@ static void bsw_pwm_setup(struct lpss_private_data
>> *pdata)
>>       {}
>>   };
>>   +static const struct x86_cpu_id cht_cpu[] = {
>> +    ICPU(INTEL_FAM6_ATOM_AIRMONT),    /* Braswell, Cherry Trail */
>> +    {}
>> +};
>> +
>>   #else
>>     #define LPSS_ADDR(desc) (0UL)
>> @@ -427,6 +432,139 @@ static int register_device_clock(struct acpi_device
>> *adev,
>>       return 0;
>>   }
>>   +struct lpss_device_links {
>> +    const char *supplier_hid;
>> +    const char *supplier_uid;
>> +    const char *consumer_hid;
>> +    const char *consumer_uid;
>> +    const struct x86_cpu_id *cpus;
>> +    u32 flags;
>> +};
>> +
>> +static const struct lpss_device_links lpss_device_links[] = {
>> +    {"808622C1", "7", "80860F14", "3", cht_cpu, DL_FLAG_PM_RUNTIME},
>> +};
>> +
>> +static bool hid_uid_match(const char *hid1, const char *uid1,
>> +              const char *hid2, const char *uid2)
>> +{
>> +    return !strcmp(hid1, hid2) && uid1 && uid2 && !strcmp(uid1, uid2);
>> +}
>> +
>> +static bool acpi_lpss_is_supplier(struct acpi_device *adev,
>> +                  const struct lpss_device_links *link)
>> +{
>> +    return hid_uid_match(acpi_device_hid(adev), acpi_device_uid(adev),
>> +                 link->supplier_hid, link->supplier_uid);
>> +}
>> +
>> +static bool acpi_lpss_is_consumer(struct acpi_device *adev,
>> +                  const struct lpss_device_links *link)
>> +{
>> +    return hid_uid_match(acpi_device_hid(adev), acpi_device_uid(adev),
>> +                 link->consumer_hid, link->consumer_uid);
>> +}
>> +
>> +struct hid_uid {
>> +    const char *hid;
>> +    const char *uid;
>> +};
>> +
>> +static int match_hid_uid(struct device *dev, void *data)
>> +{
>> +    struct acpi_device *adev = ACPI_COMPANION(dev);
>> +    struct hid_uid *id = data;
>> +
>> +    if (!adev)
>> +        return 0;
>> +
>> +    return hid_uid_match(acpi_device_hid(adev), acpi_device_uid(adev),
>> +                 id->hid, id->uid);
>> +}
>> +
>> +static struct device *acpi_lpss_find_device(const char *hid, const char
>> *uid)
>> +{
>> +    struct hid_uid data = {
>> +        .hid = hid,
>> +        .uid = uid,
>> +    };
>> +
>> +    return bus_find_device(&platform_bus_type, NULL, &data, match_hid_uid);
>> +}
>> +
>> +static bool acpi_lpss_dep(struct acpi_device *adev, acpi_handle handle)
>> +{
>> +    struct acpi_handle_list dep_devices;
>> +    acpi_status status;
>> +    int i;
>> +
>> +    if (!acpi_has_method(adev->handle, "_DEP"))
>> +        return false;
>> +
>> +    status = acpi_evaluate_reference(adev->handle, "_DEP", NULL,
>> +                     &dep_devices);
>> +    if (ACPI_FAILURE(status)) {
>> +        dev_dbg(&adev->dev, "Failed to evaluate _DEP.\n");
>> +        return false;
>> +    }
>> +
>> +    for (i = 0; i < dep_devices.count; i++) {
>> +        if (dep_devices.handles[i] == handle)
>> +            return true;
>> +    }
>> +
>> +    return false;
>> +}
>> +
>> +static void acpi_lpss_link_consumer(struct device *dev1,
>> +                    const struct lpss_device_links *link)
>> +{
>> +    struct device *dev2;
>> +
>> +    dev2 = acpi_lpss_find_device(link->consumer_hid, link->consumer_uid);
>> +    if (!dev2)
>> +        return;
>> +
>> +    if (acpi_lpss_dep(ACPI_COMPANION(dev2), ACPI_HANDLE(dev1)))
>> +        device_link_add(dev2, dev1, link->flags);
>> +
>> +    put_device(dev2);
>> +}
>> +
>> +static void acpi_lpss_link_supplier(struct device *dev1,
>> +                    const struct lpss_device_links *link)
>> +{
>> +    struct device *dev2;
>> +
>> +    dev2 = acpi_lpss_find_device(link->supplier_hid, link->supplier_uid);
>> +    if (!dev2)
>> +        return;
>> +
>> +    if (acpi_lpss_dep(ACPI_COMPANION(dev1), ACPI_HANDLE(dev2)))
>> +        device_link_add(dev1, dev2, link->flags);
>> +
>> +    put_device(dev2);
>> +}
>> +
>> +static void acpi_lpss_create_device_links(struct acpi_device *adev,
>> +                      struct platform_device *pdev)
>> +{
>> +    int i;
>> +
>> +    for (i = 0; i < ARRAY_SIZE(lpss_device_links); i++) {
>> +        const struct lpss_device_links *link = &lpss_device_links[i];
>> +
>> +        if (link->cpus && !x86_match_cpu(link->cpus))
>> +            continue;
>> +
>> +        if (acpi_lpss_is_supplier(adev, link))
>> +            acpi_lpss_link_consumer(&pdev->dev, link);
>> +
>> +        if (acpi_lpss_is_consumer(adev, link))
>> +            acpi_lpss_link_supplier(&pdev->dev, link);
>> +    }
>> +}
>> +
>>   static int acpi_lpss_create_device(struct acpi_device *adev,
>>                      const struct acpi_device_id *id)
>>   {
>> @@ -500,6 +638,7 @@ static int acpi_lpss_create_device(struct acpi_device
>> *adev,
>>       adev->driver_data = pdata;
>>       pdev = acpi_create_platform_device(adev, dev_desc->properties);
>>       if (!IS_ERR_OR_NULL(pdev)) {
>> +        acpi_lpss_create_device_links(adev, pdev);
>>           return 1;
>>       }
>>  
> 

