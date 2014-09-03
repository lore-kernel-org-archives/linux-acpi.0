From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Subject: Re: [PATCH] acpi : not caching sun value in acpi_device_pnp
Date: Thu, 4 Sep 2014 08:45:09 +0900
Message-ID: <5407A805.9010702@jp.fujitsu.com>
References: <54052305.9060308@jp.fujitsu.com> <5406796A.30303@jp.fujitsu.com> <54069B71.30404@jp.fujitsu.com> <3131841.YbdEdF5Xfu@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:50468 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933406AbaICXqJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Sep 2014 19:46:09 -0400
Received: from kw-mxauth.gw.nic.fujitsu.com (unknown [10.0.237.134])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id EB7653EE1AF
	for <linux-acpi@vger.kernel.org>; Thu,  4 Sep 2014 08:46:07 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
	by kw-mxauth.gw.nic.fujitsu.com (Postfix) with ESMTP id EA6D7AC0661
	for <linux-acpi@vger.kernel.org>; Thu,  4 Sep 2014 08:46:06 +0900 (JST)
Received: from g01jpfmpwyt03.exch.g01.fujitsu.local (g01jpfmpwyt03.exch.g01.fujitsu.local [10.128.193.57])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 8CAAB1DB803B
	for <linux-acpi@vger.kernel.org>; Thu,  4 Sep 2014 08:46:06 +0900 (JST)
In-Reply-To: <3131841.YbdEdF5Xfu@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: rafael.j.wysocki@intel.com, mika.westerberg@linux.intel.com, rafael@kernel.org, linux-acpi@vger.kernel.org

(2014/09/04 6:41), Rafael J. Wysocki wrote:
> On Wednesday, September 03, 2014 01:39:13 PM Yasuaki Ishimatsu wrote:
>> By this commit, "202317a : ACPI / scan: Add acpi_device objects for all
>> device nodes in the namespace", all device nodes in the namespace are
>> shown under /sys/bus/acpi/devices directory even if the devices are not
>> present and not functional. And if a device node has _SUN method, it is
>> decoded and the sun value is cached to acpi_device_pnp->sun.
>>
>> But when device is not present and not functional, some firmware returns
>> wrong sun value. And the wrong value is cached to acpi_device_pnp->sun.
>>
>> Therefore, even if a device is hot added and firmware returns correct
>> sun value of the device, the value is not reflected to
>> acpi_device_pnp->sun. So user cannot know correct sun value of the
>> device.
>>
>> By not caching sun value, the patch fixes the issue.
>

> Queued up for 3.17-rc4, but with a different changelog, because in my opinion
> the main problem is that _SUN is not guaranteed to return the same value
> every time it is evaluated, so either it should not be cached, or we should
> update the cached value whenever the device status changes.

I see. I have no objection to changing the changelog.
Please change it.

Thanks,
Yasuaki Ishimatsu
>
>> Signed-off-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
>> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>    drivers/acpi/scan.c     | 15 ++++++++-------
>>    include/acpi/acpi_bus.h |  1 -
>>    2 files changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>> index 9a92989..3bf7764 100644
>> --- a/drivers/acpi/scan.c
>> +++ b/drivers/acpi/scan.c
>> @@ -667,8 +667,14 @@ static ssize_t
>>    acpi_device_sun_show(struct device *dev, struct device_attribute *attr,
>>    		     char *buf) {
>>    	struct acpi_device *acpi_dev = to_acpi_device(dev);
>> +	acpi_status status;
>> +	unsigned long long sun;
>> +
>> +	status = acpi_evaluate_integer(acpi_dev->handle, "_SUN", NULL, &sun);
>> +	if (ACPI_FAILURE(status))
>> +		return -ENODEV;
>>
>> -	return sprintf(buf, "%lu\n", acpi_dev->pnp.sun);
>> +	return sprintf(buf, "%llu\n", sun);
>>    }
>>    static DEVICE_ATTR(sun, 0444, acpi_device_sun_show, NULL);
>>
>> @@ -690,7 +696,6 @@ static int acpi_device_setup_files(struct acpi_device *dev)
>>    {
>>    	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
>>    	acpi_status status;
>> -	unsigned long long sun;
>>    	int result = 0;
>>
>>    	/*
>> @@ -731,14 +736,10 @@ static int acpi_device_setup_files(struct acpi_device *dev)
>>    	if (dev->pnp.unique_id)
>>    		result = device_create_file(&dev->dev, &dev_attr_uid);
>>
>> -	status = acpi_evaluate_integer(dev->handle, "_SUN", NULL, &sun);
>> -	if (ACPI_SUCCESS(status)) {
>> -		dev->pnp.sun = (unsigned long)sun;
>> +	if (acpi_has_method(dev->handle, "_SUN")) {
>>    		result = device_create_file(&dev->dev, &dev_attr_sun);
>>    		if (result)
>>    			goto end;
>> -	} else {
>> -		dev->pnp.sun = (unsigned long)-1;
>>    	}
>>
>>    	if (acpi_has_method(dev->handle, "_STA")) {
>> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
>> index bcfd808..c1c9de1 100644
>> --- a/include/acpi/acpi_bus.h
>> +++ b/include/acpi/acpi_bus.h
>> @@ -246,7 +246,6 @@ struct acpi_device_pnp {
>>    	acpi_device_name device_name;	/* Driver-determined */
>>    	acpi_device_class device_class;	/*        "          */
>>    	union acpi_object *str_obj;	/* unicode string for _STR method */
>> -	unsigned long sun;		/* _SUN */
>>    };
>>
>>    #define acpi_device_bid(d)	((d)->pnp.bus_id)
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


