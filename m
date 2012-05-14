From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH 2/3] usb/acpi: add the support of usb hub ports' acpi
 binding without attached devices.
Date: Mon, 14 May 2012 22:09:02 +0800
Message-ID: <4FB111FE.80500@intel.com>
References: <Pine.LNX.4.44L0.1205140957230.1699-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:33163 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756366Ab2ENOJH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 May 2012 10:09:07 -0400
In-Reply-To: <Pine.LNX.4.44L0.1205140957230.1699-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: lenb@kernel.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, sarah.a.sharp@linux.intel.com

On 2012/5/14 21:58, Alan Stern wrote:
> On Mon, 14 May 2012, Lan Tianyu wrote:
>
>> The usb port is a device in the acpi table but it's not in the linux
>> usb subsystem. USB hub port doesn't have struct device. So the acpi
>> glue framework only can cover the usb port connected with usb device
>> and store the acpi handle to struct device.archdata.acpi_handle. This
>> patch is to add member port_acpi_handle in the struct usb_hub_port to
>> store acpi handle. The acpi method "_UPC" and "_PLD" can be accessed
>> without attached device.
>> --- a/drivers/usb/core/usb-acpi.c
>> +++ b/drivers/usb/core/usb-acpi.c
>> @@ -83,7 +83,16 @@ static int usb_acpi_find_device(struct device *dev, acpi_handle *handle)
>>   	if (!parent_handle)
>>   		return -ENODEV;
>>
>> -	*handle = acpi_get_child(parent_handle, udev->portnum);
>> +	/**
>> +	 * The root hub's acpi handle is got from acpi method.
>> +	 * Other device's acpi handle can be got from the usb hub
>> +	 * port's platform_data.
>> +	 */
> The /** pattern is reserved for kerneldoc comments, which appear only
> at the start of a function.  Within a function you should use the
> normal /* comment pattern.
Ok. Thanks for review.
>
> Alan Stern
>


-- 
Best Regards
Tianyu Lan
linux kernel enabling team

