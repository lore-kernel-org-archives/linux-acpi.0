From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: New battery doesn't work under linux, but does under windows
Date: Thu, 16 Oct 2008 01:09:27 +0400
Message-ID: <48F65C07.8090405@gmail.com>
References: <200810151359.58976.eric@certus.bz> <48F64F8F.4070004@gmail.com> <200810151441.37779.eric@certus.bz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:22975 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582AbYJOVJ3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Oct 2008 17:09:29 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1347564nfc.21
        for <linux-acpi@vger.kernel.org>; Wed, 15 Oct 2008 14:09:27 -0700 (PDT)
In-Reply-To: <200810151441.37779.eric@certus.bz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Eric Atkin <eric@certus.bz>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Eric Atkin wrote:
> On Wednesday 15 October 2008 2:16:15 pm you wrote:
>   
>> Eric Atkin wrote:
>>     
>>> So I bought a new battery for my laptop and installed it. I booted into
>>> Linux (gentoo) and kpowersave recognized the new battery and for the next
>>> few hours showed it charging up. The guy at the battery store said I
>>> should charge it fully and then discharge fully to calibrate, so, once
>>> full, i disconnected AC power and continued to work. kpowersave recognize
>>> that power had been removed and showed the battery discharging at a
>>> normal rate. After about 1 minute, my laptop just shut off. No warnings
>>> or attempts to suspend or hibernate or anything. Power was just cut off.
>>> I tested several times and always got the same result. I assumed it was a
>>> bad battery, but then I had to boot into windows for something and
>>> decided to try it there. In windows, I waited till the charge was at 100%
>>> then disconnected AC and let it run. It ran for about two hours as
>>> expected before dying. But if I boot back into linux, it dies again after
>>> just a minute or two. I don't even know where to begin. Any ideas? $170
>>> battery that I can't take back because it does actually work, and anyway,
>>> it seems to be a software issue.
>>> Eric
>>>       
>> First, you should tell us your kernel version and loaded battery module
>> (battery.ko or sbs.ko)
>> Second, please do a "grep . /proc/acpi/battery/*/*" with attached AC
>> and try to do this with it disconnected.
>> It might be a good idea to open a new bug report in bugzilla.kernel.org
>> for ACPI/battery and assign it to
>> astarikovskiy@suse.de (me).
>>
>> Regards,
>> Alex.
>>     
>
> Alex,
> Thank you for your time. See the things you've requested below. I'm still 
> waiting for my password to log into bugzilla. I'll create that when I can. 
> I've not used a mailing list like this before. Should I have sent this 
> response to the list?
>   
Yes, it is better to have it stored somewhere beside my inbox :)
So if did not go to bugzilla yet, keep it posted in the list.
> Eric
>
> --
>
> I'm using 'battery' and _not_ 'sbs' and it is built into the kernel rather 
> than a loadable module. I don't really know the difference between the two 
> modules and I would be happy to compile and test with sbs if you think that 
> is relevant.
>
> eris linux # uname -a
> Linux eris 2.6.25-gentoo-r8 #1 SMP PREEMPT Sun Oct 12 20:19:52 MDT 2008 i686 
> Intel(R) Core(TM)2 CPU T7200 @ 2.00GHz GenuineIntel GNU/Linux
>
> With AC:
> eris linux # grep . /proc/acpi/battery/*/*
> /proc/acpi/battery/BAT0/alarm:alarm:                   unsupported
> /proc/acpi/battery/BAT0/info:present:                 yes
> /proc/acpi/battery/BAT0/info:design capacity:         53280 mWh
> /proc/acpi/battery/BAT0/info:last full capacity:      50430 mWh
> /proc/acpi/battery/BAT0/info:battery technology:      non-rechargeable
> /proc/acpi/battery/BAT0/info:design voltage:          123160 mV
> /proc/acpi/battery/BAT0/info:design capacity warning: 1000 mWh
> /proc/acpi/battery/BAT0/info:design capacity low:     400 mWh
> /proc/acpi/battery/BAT0/info:capacity granularity 1:  100 mWh
> /proc/acpi/battery/BAT0/info:capacity granularity 2:  100 mWh
> /proc/acpi/battery/BAT0/info:model number:
> /proc/acpi/battery/BAT0/info:serial number:
> /proc/acpi/battery/BAT0/info:battery type:            LiOn
> /proc/acpi/battery/BAT0/info:OEM info:                Sony Corp.
> /proc/acpi/battery/BAT0/state:present:                 yes
> /proc/acpi/battery/BAT0/state:capacity state:          ok
> /proc/acpi/battery/BAT0/state:charging state:          charging
> /proc/acpi/battery/BAT0/state:present rate:            unknown
> /proc/acpi/battery/BAT0/state:remaining capacity:      50430 mWh
> /proc/acpi/battery/BAT0/state:present voltage:         unknown
>
> On battery:
> eris linux # grep . /proc/acpi/battery/*/*
> /proc/acpi/battery/BAT0/alarm:alarm:                   unsupported
> /proc/acpi/battery/BAT0/info:present:                 yes
> /proc/acpi/battery/BAT0/info:design capacity:         53280 mWh
> /proc/acpi/battery/BAT0/info:last full capacity:      50430 mWh
> /proc/acpi/battery/BAT0/info:battery technology:      non-rechargeable
> /proc/acpi/battery/BAT0/info:design voltage:          123160 mV
> /proc/acpi/battery/BAT0/info:design capacity warning: 1000 mWh
> /proc/acpi/battery/BAT0/info:design capacity low:     400 mWh
> /proc/acpi/battery/BAT0/info:capacity granularity 1:  100 mWh
> /proc/acpi/battery/BAT0/info:capacity granularity 2:  100 mWh
> /proc/acpi/battery/BAT0/info:model number:
> /proc/acpi/battery/BAT0/info:serial number:
> /proc/acpi/battery/BAT0/info:battery type:            LiOn
> /proc/acpi/battery/BAT0/info:OEM info:                Sony Corp.
> /proc/acpi/battery/BAT0/state:present:                 yes
> /proc/acpi/battery/BAT0/state:capacity state:          ok
> /proc/acpi/battery/BAT0/state:charging state:          discharging
> /proc/acpi/battery/BAT0/state:present rate:            unknown
> /proc/acpi/battery/BAT0/state:remaining capacity:      50430 mWh
> /proc/acpi/battery/BAT0/state:present voltage:         unknown
>   
Ok, I think the problem is "unknown" discharge rate and voltage in the 
state. kpowersave might be stupid enough
to try to approximate remaining time (impossible with two unknowns) and 
shutdown...
Please check if killing kpowersave (or, better, running in single user 
mode) helps.
Also, attach an acpidump output (better to bugzilla report).

Regards,
Alex
 
