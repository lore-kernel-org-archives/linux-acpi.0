From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: [PATCH 3/3] ACPI: battery: register power_supply subdevice even
 when battery not present
Date: Mon, 07 Sep 2009 13:29:55 +0100
Message-ID: <4AA4FCC3.2090805@tuffmail.co.uk>
References: <4A098D0A.6090509@tuffmail.co.uk> <1252291027.4627.2.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:46003 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753240AbZIGMaC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Sep 2009 08:30:02 -0400
Received: by bwz19 with SMTP id 19so1537844bwz.37
        for <linux-acpi@vger.kernel.org>; Mon, 07 Sep 2009 05:30:04 -0700 (PDT)
In-Reply-To: <1252291027.4627.2.camel@maxim-laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>

Maxim Levitsky wrote:
> On Tue, 2009-05-12 at 15:51 +0100, Alan Jenkins wrote:
>   
>> Keeping this device around lets userspace know that we have a battery
>> bay, even if there is nothing in it at the moment.  This is what every
>> other battery driver does, so ACPI should do it as well.
>>
>> There is no reason to preserve the old behaviour.  We now correctly
>> provide the "present" attribute, which will return "0" when the battery
>> is removed.  HAL was already trying to check this attribute, so
>> it should be fine.
>>
>> Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
>>     
>
> What happened to this patch?
>
> I still get the issue this patch attempts to fix:
>
> maxim@maxim-laptop:~/software/kernel/linux-2.6$
> ls /sys/class/power_supply/
> AC
> maxim@maxim-laptop:~/software/kernel/linux-2.6$
> ls /sys/class/power_supply/
> AC  BAT0
> maxim@maxim-laptop:~/software/kernel/linux-2.6$
> ls /sys/class/power_supply/
> AC
> maxim@maxim-laptop:~/software/kernel/linux-2.6$ uname -r
> 2.6.31-rc8-next-20090904-next
> maxim@maxim-laptop:~/software/kernel/linux-2.6$ 
>
>
> When I unplug the battery, its sysfs entry disappears.
> Thus if system was booted without battery, there will be no way to know
> system has one.
>
> This patch doesn't apply.
>   

I rebased these patches a while back

http://patchwork.kernel.org/patch/33118/
http://patchwork.kernel.org/patch/33119/
http://patchwork.kernel.org/patch/33120/

you should find these will still apply.

Regards
Alan
