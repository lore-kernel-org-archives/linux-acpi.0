Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA203A5442
	for <linux-acpi@vger.kernel.org>; Tue, 31 Mar 2026 19:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774984773; cv=none; b=NghSwLguUNv85FXHEkqJO4q476jV0bktp+2DpFfGTeGQZmPAgv9DsQ5D8bQjI29somtzwhPqVd/BLoGPIvhT6iPXFk7IGGJwnYHeMmi84hxG2BvfRlH4wWUvONAG8rBTvPzy8za7cc2ry3bznvzRQq+nTmWecMdTShcWbLpG1kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774984773; c=relaxed/simple;
	bh=kJ4XfBu+/Sx5IUFJaLKcBQVJryP5ZhZBKJqRtr60k/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LSdv6XRUF6+IO0iwu5GclXbbNDQPQLSKmQkw8xVMMzjca7IIwBm+nta1D1erIrfZA4/ZYiO1kjWqBXCx27dAFSORb+oHzZSoJD3zPOeeu2gZNJwa7Mbhn0/gaKzMF9f9yViQtBWj/3Qy7Qu3mYUlmpg8zT70jfBKX4b5NOBTdRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oLhLuPNz; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oLhLuPNz"
Message-ID: <7dcebac5-ef4a-4ddb-a276-82ffdb4796c4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774984758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1thraRRZOZ7peTSH3ZYe6lSStUD7WuMb66T+Rkw4Ebg=;
	b=oLhLuPNzG+BICY/jCqlOoxsvgZqduERWGiDJbvSa/9iDC7zskTB6n042mSUJPRqpTBg8IO
	MGfrNjc3iVeMYIJ5MTlMncYTOV3bELwpC1nn/sz93wCLUOzWfGU9e1tW4EVCYibX+LRZFh
	YxFfQWZuSjcNtlsGs4pTRRtJ/UAFBKM=
Date: Tue, 31 Mar 2026 21:19:14 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 2/4] platform/x86: asus-laptop: Convert ACPI driver to
 a platform one
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Hans de Goede
 <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones"
 <luke@ljones.dev>, =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
References: <5971620.DvuYhMxLoT@rafael.j.wysocki>
 <2402539.ElGaqSPkdT@rafael.j.wysocki>
 <c9697592-c70b-4ef8-864f-213b5ea4782d@linux.dev>
 <d42eed14-b6b1-b8f4-b73a-6033162e79e7@linux.intel.com>
Content-Language: en-US, it-IT, en-US-large
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <d42eed14-b6b1-b8f4-b73a-6033162e79e7@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 3/31/26 10:14, Ilpo Järvinen wrote:
> On Sat, 28 Feb 2026, Denis Benato wrote:
>> On 2/28/26 16:11, Rafael J. Wysocki wrote:
>>> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>>>
>>> In all cases in which a struct acpi_driver is used for binding a driver
>>> to an ACPI device object, a corresponding platform device is created by
>>> the ACPI core and that device is regarded as a proper representation of
>>> underlying hardware.  Accordingly, a struct platform_driver should be
>>> used by driver code to bind to that device.  There are multiple reasons
>>> why drivers should not bind directly to ACPI device objects [1].
>>>
>>> Overall, it is better to bind drivers to platform devices than to their
>>> ACPI companions, so convert the Asus laptop ACPI driver to a platform
>>> one.
>>>
>>> While this is not expected to alter functionality, it changes sysfs
>>> layout and so it will be visible to user space.
>> Alright I will take a look if asus-linux software is affected and act accordingly.
>> How much time do I have?
>>
>> Thanks. 
> Hi Denis,
>
> Has there been some progress with this check?
Hi!

I quickly looked at it and I think there shouldn't be any problem.

Worst case scenario I update the criteria udev uses to find certain
things but it shouldn't be necessary (or at least I can't find a problematic spot).

Thanks,
Denis
> --
>  i.
>
>>> Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Reviewed-by: Denis Benato <denis.benato@linux.dev>
>>> ---
>>>  drivers/platform/x86/asus-laptop.c | 35 +++++++++++++++---------------
>>>  1 file changed, 18 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
>>> index c927665dfa96..dbbb6292cd11 100644
>>> --- a/drivers/platform/x86/asus-laptop.c
>>> +++ b/drivers/platform/x86/asus-laptop.c
>>> @@ -1824,8 +1824,9 @@ static void asus_dmi_check(void)
>>>  
>>>  static bool asus_device_present;
>>>  
>>> -static int asus_acpi_add(struct acpi_device *device)
>>> +static int asus_acpi_probe(struct platform_device *pdev)
>>>  {
>>> +	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
>>>  	struct asus_laptop *asus;
>>>  	int result;
>>>  
>>> @@ -1837,7 +1838,6 @@ static int asus_acpi_add(struct acpi_device *device)
>>>  	asus->handle = device->handle;
>>>  	strscpy(acpi_device_name(device), ASUS_LAPTOP_DEVICE_NAME);
>>>  	strscpy(acpi_device_class(device), ASUS_LAPTOP_CLASS);
>>> -	device->driver_data = asus;
>>>  	asus->device = device;
>>>  
>>>  	asus_dmi_check();
>>> @@ -1846,6 +1846,8 @@ static int asus_acpi_add(struct acpi_device *device)
>>>  	if (result)
>>>  		goto fail_platform;
>>>  
>>> +	platform_set_drvdata(pdev, asus);
>>> +
>>>  	/*
>>>  	 * Need platform type detection first, then the platform
>>>  	 * device.  It is used as a parent for the sub-devices below.
>>> @@ -1907,11 +1909,12 @@ static int asus_acpi_add(struct acpi_device *device)
>>>  	return result;
>>>  }
>>>  
>>> -static void asus_acpi_remove(struct acpi_device *device)
>>> +static void asus_acpi_remove(struct platform_device *pdev)
>>>  {
>>> -	struct asus_laptop *asus = acpi_driver_data(device);
>>> +	struct asus_laptop *asus = platform_get_drvdata(pdev);
>>>  
>>> -	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY, asus_acpi_notify);
>>> +	acpi_dev_remove_notify_handler(asus->device, ACPI_DEVICE_NOTIFY,
>>> +				       asus_acpi_notify);
>>>  	asus_backlight_exit(asus);
>>>  	asus_rfkill_exit(asus);
>>>  	asus_led_exit(asus);
>>> @@ -1930,15 +1933,13 @@ static const struct acpi_device_id asus_device_ids[] = {
>>>  };
>>>  MODULE_DEVICE_TABLE(acpi, asus_device_ids);
>>>  
>>> -static struct acpi_driver asus_acpi_driver = {
>>> -	.name = ASUS_LAPTOP_NAME,
>>> -	.class = ASUS_LAPTOP_CLASS,
>>> -	.ids = asus_device_ids,
>>> -	.flags = ACPI_DRIVER_ALL_NOTIFY_EVENTS,
>>> -	.ops = {
>>> -		.add = asus_acpi_add,
>>> -		.remove = asus_acpi_remove,
>>> -		},
>>> +static struct platform_driver asus_acpi_driver = {
>>> +	.probe = asus_acpi_probe,
>>> +	.remove = asus_acpi_remove,
>>> +	.driver = {
>>> +		.name = ASUS_LAPTOP_NAME,
>>> +		.acpi_match_table = asus_device_ids,
>>> +	},
>>>  };
>>>  
>>>  static int __init asus_laptop_init(void)
>>> @@ -1949,7 +1950,7 @@ static int __init asus_laptop_init(void)
>>>  	if (result < 0)
>>>  		return result;
>>>  
>>> -	result = acpi_bus_register_driver(&asus_acpi_driver);
>>> +	result = platform_driver_register(&asus_acpi_driver);
>>>  	if (result < 0)
>>>  		goto fail_acpi_driver;
>>>  	if (!asus_device_present) {
>>> @@ -1959,7 +1960,7 @@ static int __init asus_laptop_init(void)
>>>  	return 0;
>>>  
>>>  fail_no_device:
>>> -	acpi_bus_unregister_driver(&asus_acpi_driver);
>>> +	platform_driver_unregister(&asus_acpi_driver);
>>>  fail_acpi_driver:
>>>  	platform_driver_unregister(&platform_driver);
>>>  	return result;
>>> @@ -1967,7 +1968,7 @@ static int __init asus_laptop_init(void)
>>>  
>>>  static void __exit asus_laptop_exit(void)
>>>  {
>>> -	acpi_bus_unregister_driver(&asus_acpi_driver);
>>> +	platform_driver_unregister(&asus_acpi_driver);
>>>  	platform_driver_unregister(&platform_driver);
>>>  }
>>>  
