From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH v6 7/8] usb: add usb_device_allow_power_off() and usb_device_prevent_power_off()
 function.
Date: Tue, 22 Jan 2013 21:59:12 +0800
Message-ID: <50FE9B30.8050004@intel.com>
References: <1358777887-2656-1-git-send-email-tianyu.lan@intel.com> <1358777887-2656-8-git-send-email-tianyu.lan@intel.com> <20130121213317.GD20083@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:49422 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751737Ab3AVN7R (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 Jan 2013 08:59:17 -0500
In-Reply-To: <20130121213317.GD20083@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: lenb@kernel.org, sarah.a.sharp@linux.intel.com, stern@rowland.harvard.edu, rjw@sisk.pl, oneukum@suse.de, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org

On 2013/1/22 5:33, Greg KH wrote:
> On Mon, Jan 21, 2013 at 10:18:06PM +0800, Lan Tianyu wrote:
>> Some usb devices can't be resumed correctly after power off. This
>> patch is to add usb_device_allow_power_off() and usb_device_prevent_power_off()
>> for device's driver. Call pm_runtime_get_sync(portdev) to increase port's usage
>> count and then port will not be suspended. The device will not be powered off.
>
> Please linewrap comments at the proper level (git likes 72).
>
>>
>> Acked-by: Alan Stern <stern@rowland.harvard.edu>
>> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
>> ---
>>   drivers/usb/core/port.c |   28 ++++++++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
>> index 0c51d24..0334d91 100644
>> --- a/drivers/usb/core/port.c
>> +++ b/drivers/usb/core/port.c
>> @@ -18,11 +18,39 @@
>>
>>   #include <linux/slab.h>
>>   #include <linux/pm_qos.h>
>> +#include <linux/module.h>
>>
>>   #include "hub.h"
>>
>>   static const struct attribute_group *port_dev_group[];
>>
>> +/**
>> + * usb_device_control_power_off - Allow or prohibit power off device.
>> + * @udev: target usb device
>> + * @allow: choice of allow or prohibit
>> + *
>> + * Call pm_runtime_get/put_sync(portdev) to allow or prohibit target
>> + * usb device to be powered off in the kernel. The operations of setting
>> + * true and false should be couple. The default status is allowed.
>> + */
>> +int usb_device_control_power_off(struct usb_device *udev, bool allow)
>
> Ick, again with the boolean variables.  Please don't do this, just make
> two different functions:
> 	usb_device_allow_power_off()
> 	usb_device_forbid_power_off()
> that makes it much easier to understand when you see the function being
> called, right?
Ok. I will do it.
>
> thanks,
>
> greg k-h
>


-- 
Best Regards
Tianyu Lan
linux kernel enabling team
