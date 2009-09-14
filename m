From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: [PATCH] ACPI fan: fix memleak on acpi_fan_add_fs() failure
Date: Mon, 14 Sep 2009 08:49:30 +0100
Message-ID: <4AADF58A.4070109@tuffmail.co.uk>
References: <4AACC94E.9040208@tuffmail.co.uk> <1252890570.3609.229.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:47262 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696AbZINHt3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Sep 2009 03:49:29 -0400
Received: by bwz19 with SMTP id 19so1894283bwz.37
        for <linux-acpi@vger.kernel.org>; Mon, 14 Sep 2009 00:49:32 -0700 (PDT)
In-Reply-To: <1252890570.3609.229.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ykzhao <yakui.zhao@intel.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

ykzhao wrote:
> On Sun, 2009-09-13 at 18:28 +0800, Alan Jenkins wrote:
>   
>> Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
>>     
> It sounds reasonable although we don't fail in calling the function of
> acpi_fan_add_fs.
>   

Agreed, this applies to ENOMEM or other weird internal errors only.

>> ---
>>  drivers/acpi/fan.c |    8 ++++++--
>>  1 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
>> index 947556e..eb1511e 100644
>> --- a/drivers/acpi/fan.c
>> +++ b/drivers/acpi/fan.c
>> @@ -283,13 +283,17 @@ static int acpi_fan_add(struct acpi_device *device)
>>  
>>  	result = acpi_fan_add_fs(device);
>>  	if (result)
>> -		goto end;
>> +		goto unregister;
>>  
>>  	printk(KERN_INFO PREFIX "%s [%s] (%s)\n",
>>  	       acpi_device_name(device), acpi_device_bid(device),
>>  	       !device->power.state ? "on" : "off");
>>     
>
> At the same time we should return directly if the result is zero. 
> But in this patch it seems that it will also remove the sysfs I/F link
> when the result is zero.
>
> Thanks.
>   

Eek, thanks for pointing this out.  I'll send a fixed version
Alan
