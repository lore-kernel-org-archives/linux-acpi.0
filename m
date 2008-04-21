From: majie <china.majie@gmail.com>
Subject: Re: can't shut down
Date: Mon, 21 Apr 2008 12:45:26 +0800
Message-ID: <480C1BE6.50201@gmail.com>
References: <1c0ea1cc0804150709u3c4274fbq39467e6a1d704642@mail.gmail.com>	 <1208334994.6931.2.camel@yakui_zhao.sh.intel.com>	 <4806E81F.2010008@gmail.com> <1208523832.4072.6.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:25040 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987AbYDUEo1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Apr 2008 00:44:27 -0400
Received: by wa-out-1112.google.com with SMTP id m16so2828305waf.23
        for <linux-acpi@vger.kernel.org>; Sun, 20 Apr 2008 21:44:24 -0700 (PDT)
In-Reply-To: <1208523832.4072.6.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org

Zhao Yakui wrote:
> On Thu, 2008-04-17 at 14:03 +0800, majie wrote:
>> Zhao Yakui wrote:
>>> On Tue, 2008-04-15 at 22:09 +0800, majie wrote:
>>>> Hi all,
>>>>
>>>> I'm using Linux kernel 2.6.21.5-smp(Slackware 12). I experience an
>>>> error when I turn off my computer. It doesn't turn off itself (maybe
>>>> called going into G2/S5 Soft Off in the specification) after printing
>>>> a message "acpi_power_off called". I have to press the power button
>>>> for several seconds to turn it off. I think the CPUs may be running in
>>>> full speed because I hear my fan running in high speed.
>>>>
>>>> I tried to find out the problem by adding some printk()'s to the
>>>> function acpi_enter_sleep_state()(in
>>>> linux-2.6.21.5\drivers\acpi\hardware\hwsleep.c). And It shows that it
>>>> runs into the final do-while loop in the function and doing an
>>>> infinite loop. Maybe this is why my CPUs are running in full speed.
>>>>
>>>> I don't have the ability to debug the kernel. So this is the only
>>>> information I can provide about the code. If you want me to post my
>>>> hardware spec or anything else, I'm very glad to, but please tell me
>>>> which command and arguments should I use to get the info.
>>>>
>>>> I have tried the kernel options, but they don't work for me. My laptop
>>>> can shut down flawlessly when using windows xp.
>>>>
>>>> By the way, It's a linux distribution independent problem because I
>>>> also experienced it in kubuntu 7.10.
>>> Will you please attach the output of acpidump?
>>> The latest dump tool (20070116) can be found in 
>>> http://www.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/
>>>
> Will you please try the latest kernel(2.6.25-rc9) and see whether the
> problem still exists? 
> Note: 
> a. ACPI should be enabled in kernel configuration.
> b. Don't use the custom DSDT
> c. use "poweroff" command to shutdown
> 
> If the problem still exists, please attach the output of dmesg.
> thanks.
>       

Hi Yakui,
Do you receive my email I sent to you on April 19 ? I'm still unable to 
have the 2.6.25-rc9 kernel boot and run. I can't make a valid initrd to 
boot the kernel. I've spend the whole weekend to solve the problem. But 
I've no idea why it can mount my real root filesystem.

So I can't test the 2.6.25-rc9 kernel in normal mode. I want to shutdown 
the computer using busybox's poweroff in the initrd before the real root 
filesystem being mounted. Is this approach equal to the "normal" shutdown?

Sorry for causing the trouble to you.
Thank you.

-------
Regards,
	majie



