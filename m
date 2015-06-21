From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: ACPI regression? Was Re: Ethernet chip disappeared from lspci
Date: Mon, 22 Jun 2015 01:25:05 +0800
Message-ID: <5586F371.2040100@linux.intel.com>
References: <55841815.5000701@pr.hu> <558419B2.7010703@pr.hu> <55841D48.8080809@pr.hu> <12950452.K8inU2UIYe@vostro.rjw.lan> <55869329.4040908@pr.hu> <CAErSpo4W9N+vtqNM=b24Temh16JHHT4ANk_NwUxjPysMGcJVfA@mail.gmail.com> <5586C7E2.9070902@pr.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:12610 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751365AbbFURZI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 21 Jun 2015 13:25:08 -0400
In-Reply-To: <5586C7E2.9070902@pr.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Boszormenyi Zoltan <zboszor@pr.hu>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Andreas Mohr <andi@lisas.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>

On 2015/6/21 22:19, Boszormenyi Zoltan wrote:
> 2015-06-21 16:03 keltez=C3=A9ssel, Bjorn Helgaas =C3=ADrta:
>> [+cc linux-pci]
>>
>> Hi Boszormenyi,
>>
>> On Sun, Jun 21, 2015 at 5:34 AM, Boszormenyi Zoltan <zboszor@pr.hu> =
wrote:
>>> Hi,
>>>
>>> please, cc me, I am not subscribed to lkml.
>>>
>>>> Hi,
>>>>
>>>> [lkml.org still broken --> no accurate mail header info possible..=
=2E]
>>>>
>>>> Just to ask the obvious:
>>>> I assume using /sys/bus/pci/rescan does not help once it's broken?
>>>> (since the machine comes up empty at initial-boot scan, too)
>>> I will try it, too, but I am not sure it would work.
>>>
>>> Currently I can't test it because the last time I completely discha=
rged
>>> the battery. I also disconnected it to be able to get the realtek c=
hip back
>>> immediately for faster testing. Now, that I have reconnected the ba=
ttery,
>>> I need to wait for it to be charged somewhat to be able to reproduc=
e
>>> losing the network chip.
>>>
>>>> Also, you could try diffing lspci -vvxxx -s.... output
>>>> of working vs. "distorting" kernel version - perhaps some register=
 setup
>>>> has been changed (e.g. due to power management improvements or som=
e such),
>>>> which may encourage the card
>>>> to get a problematic/corrupt state.
>>> I attached a tarball that contains lspci -vvxxx for
>>> - all devices / only the network chip
>>> - before / after "modprobe r8169"
>>> - for all 3 kernel versions tested.
>>>
>>> I figured out that if I type the modprobe and lspci in the same com=
mand line,
>>> I can get diagnostics out of the machine, after all.
>>>
>>> It's not just the Realtek chip that has changed parameters.
>>>
>>> (Vague idea) I noticed that some devices have changed like this:
>>>
>>> -       Memory behind bridge: 80000000-801fffff
>>> -       Prefetchable memory behind bridge: 0000000080200000-0000000=
0803fffff
>>> +       Memory behind bridge: ff000000-ff1fffff
>>> +       Prefetchable memory behind bridge: 00000000ff200000-0000000=
0ff3fffff
>>>
>>> Can't this cause a problem? E.g. programming the bridge with an add=
ress range
>>> that the bridge doesn't actually support?
>> This worked in v3.18.16, but not in v4.0.5 or v4.1.0-rc8.  You
>> attached a v4.1.0-rc8 dmesg log earlier.  Would you mind collecting =
a
>> v3.18.16 dmesg log, so we can compare them?
>=20
> I collected all 3 for you to compare them, compressed, attached.
>=20
> BTW, I browsed git log and found 2ea3d266bab3b497238113b20136f7c3f69a=
d9c0
> as suspicious. I will try the 4.0/4.1 kernels with this one reverted.
>=20
>>
>> These (from the v4.1.0-rc8 dmesg) look wrong, but I'll have to look =
at
>> the code to see what might be going on:
>>
>>   acpi PNP0A08:00: host bridge window expanded to [mem
>> 0x00000000-0xffffffff window]; [mem 0x00000000-0xffffffff window]
>> ignored
>>   pci 0000:00:1c.1: can't claim BAR 15 [mem 0xfdf00000-0xfdffffff
>> 64bit pref]: address conflict with PCI Bus 0000:00 [mem
>> 0xf0000000-0xfed8ffff window]
>>
>> Bjorn
Hi Bjorn and Boszormenyi,
	From the 3.18 kernel, we got a message:
[    0.126248] acpi PNP0A08:00: host bridge window
[0x400000000-0xfffffffff] (ignored, not CPU addressable)
	And from 4.1.-rc8, we got another message:
[    0.127051] acpi PNP0A08:00: host bridge window expanded to [mem
0x00000000-0xffffffff window]; [mem 0x00000000-0xffffffff window] ignor=
ed

That smells like a 32bit overflow or 64bit cut-off issue.

Hi Boszormenyi, could you please help to provide acpidump from the
machine?
Thanks!
Gerry

=09

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
