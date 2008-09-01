From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: a problem about the two patches in bug 10724 & 11428
Date: Mon, 01 Sep 2008 16:18:30 +0400
Message-ID: <48BBDD96.4090900@suse.de>
References: <1220251221.4039.52.camel@yakui_zhao.sh.intel.com>	 <48BB9E86.7070503@suse.de> <1220262941.4039.77.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:37999 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751182AbYIAMSc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Sep 2008 08:18:32 -0400
In-Reply-To: <1220262941.4039.77.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

Please read this, and then ask your questions again.

>>Once again, there is driver mode and there is GPE enabled/disabled. ec_intr controls the latter, and driver mode tries to follow automatically.


Zhao Yakui wrote:
> On Mon, 2008-09-01 at 11:49 +0400, Alexey Starikovskiy wrote:
>> Hi Yakui,
>> Zhao Yakui wrote:
>>> Hi, Alexey
>>>     You have a lot of experiences about EC driver and a lot of EC patches are from you.
>>>     You attach two patches related with EC driver in the bug 10724 & 11428.
>>>     In the bug 10724:
>>>         Add a boot ption of "ec_intr= " to select the EC work mode( Interrupt/Polling mode)
>>>         After this patch is applied, EC won't switch to polling mode automatically from interrupt mode when EC irq storm is detected.
>>>     In the bug 11428
>>>         In this patch the EC won't switch off GPE mode on missing interrupts
>>>
>>>     Will the above two patches hit the upstream kernel? If the above two patches hits the upstream kernel, it 
>>> seems that the boot option of "ec_intr=" comes back again and EC can't be switched from interrupt mode to polling 
>>> mode if EC GPE interrupt is missing. In such case maybe the battery/AC/thermal driver can't work well if the info of
>>> battery/AC/thermal is related with EC. Maybe there exists the regression on some laptops.
>> There are two steps here. First, you don't use GPE while waiting for status to become expected value (here you don't care if GPE is at all enabled) and second, there you can't handle GPE coming in very fast rate -- thus you need to disable it.
>> 11428 restores first behavior, there we don't touch GPE if it does not hurt us, and provide a way to manually switch it off if it does. 
> For the first step: If EC time out happens while waiting for the EC
> status to become expected value(in EC GPE mode), maybe it can be
> regarded as that EC can't return the expected status in the predefined
> time.  In such case it will be more reasonable that EC is switched to
> polling mode.(In most cases the EC will return the expected status in a
> very short time while EC works in interrupt mode). 
>      Of course it is appropriate that the mode switch is disabled on
> some specific laptops. Maybe the EC can still return the expected status
> in the predefined time after time out happens once on such laptops.
> 
> For the second step: Understand what you said. If OS can't handle the
> coming GPE in a very fast rate, it should be disabled. But if the manual
> switch is used, the user must reboot the system with the option of
> "ec_intr=0" and EC will always be in Polling mode. What will be affected
> if EC is automatically switched to polling mode and EC GPE is disabled?
>> Once again, there is driver mode and there is GPE enabled/disabled. ec_intr controls the latter, and driver mode tries to follow automatically.
>>>     At the same time the boot option of "ec_intr=1" indicates that EC will work in EC GPE interrupt mode. But maybe the following
>>> phenomenon will appear on some laptops:
>>>    EC is initialized as polling mode. After the EC GPE interrupt is triggered, it will be switched to GPE interrupt mode. But if
>>> no EC GPE interrupt is triggered, it will still work in polling mode. Although it is harmless and EC can also work well, 
>>> maybe the EC working mode is inconsistent with the EC boot option. At the same time after the system is resumed from S3, the EC working
>>> mode will also be polling mode in the function of acpi_ec_resume.
>> Why do you care about such consistency? Code is trying to use interrupt mode if it allowed to. If it fails, it reports this failure.
> The consistency is meaningless. In fact I don't care about it. What I
> want to say is that EC working mode maybe is not what the boot option of
> "ec_intr=1" expected.
>>  
>>>     IMO the EC working mode is not very reasonable if the above two patches hit the upstream kernel.
>> It is reasonable for me. If you read code more carefully, you might find it reasonable too.
> Understand what you said.
>>>     Are the following two methods reasonable? Which of them is better?
>> No. Niether.
>>>     a. Add the boot option of "ec_intr=" (ec_intr=auto, intr, polling). For most laptops the boot option of "ec_intr=auto" is the default option
>>> and "ec_intr=auto" means that the EC working mode can be switched automatically between interrupt mode and polling mode.The purpose of "ec_intr=auto"
>>> is used to avoid the regression on some laptops.(Maybe some laptops can't work well if the EC mode switch is disabled.) 
>>>      If the boot option of "ec_intr=intr" is added, the EC will be forced to work in interrupt mode and can't be switched to polling mode even 
>>> when the EC confirmation GPE interrupt is missing. 
>>>      If the boot option of "ec_intr=polling" is added, the EC will be forced to work in polling mode.
>>>      
>>>      In such case the EC working mode is related with user input. 
>>>
>>>     b. EC mode switch is disabled on some specific laptops. In such case the user doesn't care for the EC working mode. At the same time
>>> EC is still started in polling mode. It will be switched to interrupt mode if the EC GPE interrupt is triggered. EC will be switched to polling
>>> mode on most laptops in case of missing confirmation GPE interrupt. But on some specific laptops the EC mode switch is disabled, which means
>>> that EC will still work in interrupt mode even when the EC confirmation GPE interrupt is missing. This can be realized by adding EC DMI check table.
>>>
>>>     I am not sure whether my above suggestion is appropriate. 
>>>
>>> Thanks for the comments.
>>>
>>> Best regards.
>>>    Yakui
>>>
>> Regards,
>> Alex.
> 

