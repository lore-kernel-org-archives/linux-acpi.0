From: Sander Eikelenboom <linux@eikelenboom.it>
Subject: Re: ACPI if power button pressed 1x it creates the same ACPI event twice
Date: Tue, 10 Feb 2015 23:46:17 +0100
Message-ID: <1891343962.20150210234617@eikelenboom.it>
References: <618666178.20150113173510@eikelenboom.it> <1202643605.20150113174724@eikelenboom.it> <577867575.20150119140934@eikelenboom.it> <13866742.20150119142155@eikelenboom.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vserver.eikelenboom.it ([84.200.39.61]:59642 "EHLO
	smtp.eikelenboom.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754812AbbBJWq0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Feb 2015 17:46:26 -0500
In-Reply-To: <13866742.20150119142155@eikelenboom.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sander Eikelenboom <linux@eikelenboom.it>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Hello Sander,

Monday, January 19, 2015, 2:21:55 PM, you wrote:


> Monday, January 19, 2015, 2:09:34 PM, you wrote:

>> Hello Sander,

>> Tuesday, January 13, 2015, 5:47:24 PM, you wrote:

>>> Tuesday, January 13, 2015, 5:35:10 PM, you wrote:

>>>> Hi Rafael / Len,

>>>> When i press the power-button on my intel NUC, i get twp ACPI power-events shortly 
>>>> after one another (within a second), instead of just one. 

>>>> It doesn't matter if i have the old /proc/acpi interface enabled or disabled in the kernel config.

>>>> I have tested a few older kernels lingering around on the box and 3.14 already 
>>>> has this problem. 3.2 (from the debian repo) doesn't have the problem, it only 
>>>> fires one event.

>>>> I did find another report:
>>>>     Re: lenovo ultrabay docking station: if power button pressed 1x it creates 2x the same ACPI event
>>>>     http://www.spinics.net/lists/linux-acpi/msg54723.html
>>>> But that hasn't come to a conclusion ...


>>>> Unfortunately 3.2 - 3.19-rc4 is a bit of a largish bisect window, so that's 
>>>> unfeasible :-)

>>>> I compiled in apci debug support and tried:
>>>>  echo "0x00080000" > /sys/module/acpi/parameters/debug_layer
>>>>  echo "0xffffffff" > /sys/module/acpi/parameters/debug_level

>>>> But i don't get any extra output in dmesg ?

>>>> Do you have any ideas for a debug patch or better values to figure out what is going on ?

>>>> --
>>>> Sander

>>> Hmm is it normal that it registers in this way (twice) ?

>>> [    5.817980] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
>>> [    5.837907] ACPI: Power Button [PWRB]
>>> [    5.847540] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
>>> [    5.866915] ACPI: Power Button [PWRF]

>>> --
>>> Sander

>> Hi Rafael / Len,

>> Got some more time to test:

>> - It's indeed giving one event for both registered power buttons (which in reality 
>>   are just one hardware button) printing acpid's "%e" revealed that:
>>   1421672289-161192235 | button/power PBTN 00000080 00000000
>>   1421672289-279647745 | button/power LNXPWRBN:00 00000080 00000004

>> So i tested on another box (amd instead of intel), and that also registers 2 
>> power buttons:

>> # dmesg | grep -i button
>> [   13.435060] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
>> [   13.435294] ACPI: Power Button [PWRB]
>> [   13.435495] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
>> [   13.435683] ACPI: Power Button [PWRF]
>>  
>> So the question is .. should both register and should scripts adjust to pick up just one of them ?
>> Or can, as a more general solution, just one be ignored when registering ?

>> --
>> Sander

> Whoops sorry for the fragmentation of the report ... but just thought the output 
> under kernel 3.2.0 could be handy as well .. as that only fires one event:

> [    4.003753] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
> [    4.003838] ACPI: Power Button [PWRB]
> [    4.003977] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
> [    4.005530] ACPI: Power Button [PWRF]

> It registers also two ..
> But when the power button is pressed only fires this one:

> 1421673524-817561070 | button/power PBTN 00000080 00000000

> --
> Sander

Hi Rafael / Len,

Unfortunately haven't heard anything back .. and with 3.19-rc6 it seems 
miraculously fixed, i receive only one event on a powerbutton press.

However with 3.19.0 (final) .. it was back again .. 1 press .. 2 events.

So i bisected ... but i came out on the netlink commit below. Now seems acpid to 
be using input layer and netlink if the deprecated /proc/apci/events is not compiled in (which 
isn't at present) according to [1]. 

But how the fsck this relates to one another... the only thing i can imagine is 
that i have to take that text literal: It uses both input layer and netlink 
simultaneously and will receive an event via both of those ways which slightly 
differ in naming but have the same origin ?

acpid used is debian wheezy: acpid 1:2.0.16-1+deb7u1 amd64 Advanced Configuration and Power Interface event daemon

--
Sander

[1] http://manpages.ubuntu.com/manpages/precise/man8/acpid.8.html



8b7c36d810c61ab16997f4387fc16291410700f8 is the first bad commit
commit 8b7c36d810c61ab16997f4387fc16291410700f8
Author: Pablo Neira <pablo@netfilter.org>
Date:   Thu Jan 29 10:51:53 2015 +0100

    netlink: fix wrong subscription bitmask to group mapping in

    The subscription bitmask passed via struct sockaddr_nl is converted to
    the group number when calling the netlink_bind() and netlink_unbind()
    callbacks.

    The conversion is however incorrect since bitmask (1 << 0) needs to be
    mapped to group number 1. Note that you cannot specify the group number 0
    (usually known as _NONE) from setsockopt() using NETLINK_ADD_MEMBERSHIP
    since this is rejected through -EINVAL.

    This problem became noticeable since 97840cb ("netfilter: nfnetlink:
    fix insufficient validation in nfnetlink_bind") when binding to bitmask
    (1 << 0) in ctnetlink.

    Reported-by: Andre Tomt <andre@tomt.net>
    Reported-by: Ivan Delalande <colona@arista.com>
    Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
    Signed-off-by: David S. Miller <davem@davemloft.net>

:040000 040000 1a624f23ebb1006bcd734f850c2350bdce751356 e24acc011aea2048599514ed278582a27265fab6 M      net
 

