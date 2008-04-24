From: majie <china.majie@gmail.com>
Subject: Re: can't shut down
Date: Thu, 24 Apr 2008 15:43:41 +0800
Message-ID: <48103A2D.4080306@gmail.com>
References: <1c0ea1cc0804150709u3c4274fbq39467e6a1d704642@mail.gmail.com>	 <1208334994.6931.2.camel@yakui_zhao.sh.intel.com>	 <4806E81F.2010008@gmail.com>	 <1208523832.4072.6.camel@yakui_zhao.sh.intel.com>	 <480C1BE6.50201@gmail.com> <1208863963.14474.41.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020302030203030804090706"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:13563 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776AbYDXHmz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Apr 2008 03:42:55 -0400
Received: by wf-out-1314.google.com with SMTP id 28so2372819wff.4
        for <linux-acpi@vger.kernel.org>; Thu, 24 Apr 2008 00:42:55 -0700 (PDT)
In-Reply-To: <1208863963.14474.41.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------020302030203030804090706
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Zhao Yakui 写道:
> On Mon, 2008-04-21 at 12:45 +0800, majie wrote:
>> Zhao Yakui wrote:
>>> On Thu, 2008-04-17 at 14:03 +0800, majie wrote:
>>>> Zhao Yakui wrote:
>>>>> On Tue, 2008-04-15 at 22:09 +0800, majie wrote:
>>>>>> Hi all,
>>>>>>
>>>>>> I'm using Linux kernel 2.6.21.5-smp(Slackware 12). I experience an
>>>>>> error when I turn off my computer. It doesn't turn off itself (maybe
>>>>>> called going into G2/S5 Soft Off in the specification) after printing
>>>>>> a message "acpi_power_off called". I have to press the power button
>>>>>> for several seconds to turn it off. I think the CPUs may be running in
>>>>>> full speed because I hear my fan running in high speed.
>>>>>>
>>>>>> I tried to find out the problem by adding some printk()'s to the
>>>>>> function acpi_enter_sleep_state()(in
>>>>>> linux-2.6.21.5\drivers\acpi\hardware\hwsleep.c). And It shows that it
>>>>>> runs into the final do-while loop in the function and doing an
>>>>>> infinite loop. Maybe this is why my CPUs are running in full speed.
>>>>>>
>>>>>> I don't have the ability to debug the kernel. So this is the only
>>>>>> information I can provide about the code. If you want me to post my
>>>>>> hardware spec or anything else, I'm very glad to, but please tell me
>>>>>> which command and arguments should I use to get the info.
>>>>>>
>>>>>> I have tried the kernel options, but they don't work for me. My laptop
>>>>>> can shut down flawlessly when using windows xp.
>>>>>>
>>>>>> By the way, It's a linux distribution independent problem because I
>>>>>> also experienced it in kubuntu 7.10.
>>>>> Will you please attach the output of acpidump?
>>>>> The latest dump tool (20070116) can be found in 
>>>>> http://www.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/
>>>>>
>>> Will you please try the latest kernel(2.6.25-rc9) and see whether the
>>> problem still exists? 
>>> Note: 
>>> a. ACPI should be enabled in kernel configuration.
>>> b. Don't use the custom DSDT
>>> c. use "poweroff" command to shutdown
>>>
>>> If the problem still exists, please attach the output of dmesg.
>>> thanks.
>>>       
>> Hi Yakui,
>> Do you receive my email I sent to you on April 19 ? I'm still unable to 
>> have the 2.6.25-rc9 kernel boot and run. I can't make a valid initrd to 
>> boot the kernel. I've spend the whole weekend to solve the problem. But 
>> I've no idea why it can mount my real root filesystem.
> 
> Sorry for the no response.
> IMO the problem is related to the kernel config. For example: the SATA
> driver should be built into kernel. (If not, OS can't find the root
> filesystem).
> Please do it again as listed in the following:(Pay attention to the
> kernel configuration).
> a. make bzImage; make modules;
> b. make modules_install; make install;
Hi, Yakui

2.6.25-rc9 kernel successfully runs on my computer. But the bad news is 
that this kernel can't shut down my computer too. Can you fix this 
problem in a newer kernel? Thanks.

And my dmesg output is here.

------------
  Regards,
  	majie






--------------020302030203030804090706
Content-Type: application/gzip;
 name="dmesg.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="dmesg.txt.gz"

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

--------------020302030203030804090706--
