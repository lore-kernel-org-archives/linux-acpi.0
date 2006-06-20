From: Johny <kernel@agotnes.com>
Subject: Re: [Fwd: Re: [Linux-usb-users] Fwd: Re: 2.6.17-rc6-mm2 - USB issues]
Date: Tue, 20 Jun 2006 21:21:35 +1000
Message-ID: <4497DA3F.80302@agotnes.com>
References: <44953B4B.9040108@agotnes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from munin.agotnes.com ([202.173.149.60]:25046 "EHLO
	mail.agotnes.com") by vger.kernel.org with ESMTP id S965006AbWFTLVu
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Jun 2006 07:21:50 -0400
In-Reply-To: <44953B4B.9040108@agotnes.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Johny <kernel@agotnes.com>
Cc: linux-acpi@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-usb-users@lists.sourceforge.net, USB development list <linux-usb-devel@lists.sourceforge.net>, Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@osdl.org>

=46irstly, apologies for a) the massive x-post and b) the time taken to=
=20
get back to people... Please let me know where this is most=20
appropriately dealt with and I'll keep it off other lists, considering=20
the latest information;

Andrew - please note - this is not a problem exclusive to the -mm=20
series, on testing various combos I found it in the stock series too.

Stock kernels break for me starting with 2.6.17-rc4 (I tested all rcs=20
and also .17 itself), rc3 works a treat for using USB. I suspect the=20
following line missing in dmesg for rc4 is the reason;

-PCI: Via IRQ fixup for 0000:00:11.1, from 255 to 11

See the following dmesg files for details;

http://www.agotnes.com/kernelStuff/dmesg-2.6.17-rc3-working
http://www.agotnes.com/kernelStuff/dmesg-2.6.17-rc4-not-working

And the diff, for convenience;

http://www.agotnes.com/kernelStuff/diff-rc3_rc4

I have a Via chipset motherboard (for my sins), further details=20
available on request, again, for convenience, the lspci;

http://www.agotnes.com/kernelStuff/lspci

A couple of possible suspect patches introduced in the changelog for rc=
4=20
were (with the first one looking particularly interesting, the others=20
less interesting as I go down the list);

[PATCH] PCI quirk: VIA IRQ fixup should only run for VIA southbridges
[PATCH] x86_64: avoid IRQ0 ioapic pin collision
[PATCH] PCI: fix via irq SATA patch
[ALSA] via82xx - Use DXS_SRC as default for VIA8235/8237/8251 chips
[ALSA] via82xx: tweak VT8251 workaround
[ALSA] via82xx: add support for VIA VT8251 (AC'97)

I'm no kernel hacker, so I'm not sure how I'd isolate this one patch an=
d=20
reverse / modify it. Please let me know how I can progress testing this=
=20
as I'm currently prevented from using USB with the latest set of kernel=
s=20
on my test server...

I've got all kernels in the 2.6.17-rc1 through to .17 itself there, plu=
s=20
a variety of mm ones too, so patches against any of those I can very=20
easily test.

Please keep me cc'd as I'm not on all these lists, thanks :)

:)Johny

Johny =C5gotnes wrote:
> didn't go through due to missing vger. ...
>=20
> ---------------------------------------------------------------------=
---
>=20
> Subject:
> Re: [Linux-usb-users] Fwd: Re: 2.6.17-rc6-mm2 - USB issues
> From:
> Johny <kernel@agotnes.com>
> Date:
> Sun, 18 Jun 2006 21:37:00 +1000
> To:
> Alan Stern <stern@rowland.harvard.edu>
>=20
> To:
> Alan Stern <stern@rowland.harvard.edu>
> CC:
> Johny <kernel@agotnes.com>, USB development list=20
> <linux-usb-devel@lists.sourceforge.net>, kernel list=20
> <linux-kernel@vger.kernel.org>, linux-acpi@kernel.org, akpm@osdl.org
>=20
>=20
> All,
>=20
> I've now tested the following;
>=20
> 2.6.17-rc6-mm2 with the following patch applied;
> ---
> git-acpi.patch from=20
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-=
rc6/2.6.17-rc6-mm2/broken-out/=20
>=20
> ---
>=20
> With no difference to the end-result.
>=20
> Next I stripped out 802.11 generic support and acx111 drivers from th=
e=20
> kernel (including the acpi patches) to check if it clashes, but the s=
ame=20
> errors occur....
>=20
> Thirdly, I booted with acpi=3Doff on the command line with two kernel=
s,=20
> the stock 2.6.17-rc6-mm2 (no acpi patch and including acx111) and the=
=20
> one including the acpi patch and no acx111, the results were;
>=20
> acpi_patch;
> works a treat, picks up USB devices as expected.
>=20
> stock;
> works a treat, picks up USB devices as expected, and my acx111 card=20
> works too :)
>=20
>=20
> Now I'm looking for good suggestions again, this definitely looks lik=
e=20
> it is related to ACPI, hence the cc' to that list too, as requested b=
y=20
> Andrew M.
>=20
> I'm happy to apply patches / config changes as appropriate and for th=
ose=20
> who may ask for my .config files, please see;
>=20
> http://www.agotnes.com/kernelStuff/config-2.6.17-rc6-mm2
>=20
> http://www.agotnes.com/kernelStuff/config-2.6.17-rc6-mm2git-acpi_patc=
h
>=20
> Also, I left the output of lspci there for reference;
>=20
> http://www.agotnes.com/kernelStuff/lspci
>=20
> Cheers,
>=20
> :)Johny
>=20
> Alan Stern wrote:
>> [Moved to linux-usb-devel in the hope of getting additional help]
>>
>> On Thu, 15 Jun 2006, Johny wrote:
>>
>>> Alan,
>>>
>>> See comments interspersed, thanks for your assistance :)
>>>
>>> Alan Stern wrote:
>>>> On Tue, 13 Jun 2006, Johny wrote:
>>>>
>>>>> Is this best suited to this mailing list?
>>>> It's appropriate.
>>>>
>>>>> I tried the kernel list with zero responses (so far ;), let me kn=
ow=20
>>>>> if there is
>>>>> anywhere else this should go.
>>>> ...
>>>>
>>>>> Johny =C5gotnes wrote:
>>>>>> All,
>>>>>>
>>>>>> My USB hub isn't recognised with the latest -mm series, whereas =
with
>>>>>> 2.6.16 vanilla it is picked up & used immediately.
>>>>>>
>>>>>> The error I get in dmesg is;
>>>>>>
>>>>>> hub 4-0:1.0: USB hub found
>>>>>> hub 4-0:1.0: 2 ports detected
>>>>>> usb 1-4: new high speed USB device using ehci_hcd and address 3
>>>>>> ehci_hcd 0000:00:10.3: Unlink after no-IRQ?  Controller is proba=
bly
>>>>>> using the wrong IRQ.
>>>> That last line is a clue.  What interrupt numbers are assigned und=
er
>>>> 2.6.16?  If you unplug the SonyEricsson DCU-11 Cable before bootin=
g=20
>>>> (and
>>>> leave it unplugged), what shows up in /proc/interrupts for both=20
>>>> versions
>>>> of the kernel?
>>> See attached, both with the DCU-11 cable disconnected.
>>
>> From 2.6.16:
>>            CPU0         0:      16101          XT-PIC  timer
>>   1:        148          XT-PIC  i8042
>>   2:          0          XT-PIC  cascade
>>   7:          0          XT-PIC  parport0
>>   9:          0          XT-PIC  acpi
>>  10:        151          XT-PIC  ehci_hcd:usb1, uhci_hcd:usb4
>>  11:          0          XT-PIC  uhci_hcd:usb2, uhci_hcd:usb3
>>  12:        138          XT-PIC  i8042
>>  14:        172          XT-PIC  ide0
>>  15:       2458          XT-PIC  ide1
>> NMI:          0 ERR:          0
>>
>> From 2.6.17:
>>            CPU0         0:      35651    XT-PIC-level    timer
>>   1:        129    XT-PIC-level    i8042
>>   2:          0    XT-PIC-level    cascade
>>   6:          3    XT-PIC-level    floppy
>>   7:          0    XT-PIC-level    parport0
>>   9:          0    XT-PIC-level    acpi
>>  10:          0    XT-PIC-level    ehci_hcd:usb1, uhci_hcd:usb4
>>  11:       1940    XT-PIC-level    uhci_hcd:usb2, uhci_hcd:usb3, wla=
n0
>>  12:        162    XT-PIC-level    i8042
>>  14:        171    XT-PIC-level    ide0
>>  15:       4251    XT-PIC-level    ide1
>> NMI:          0 ERR:          0
>>
>> There's nothing obviously wrong.
>>
>>>> Most likely this is a problem with the ACPI subsystem, not a USB=20
>>>> problem.
>>>>
>>> I guessed USB due to the number of USB changes in the -mm series an=
d,=20
>>> obviously, my USB devices stopped registering, however, I'd not kno=
w=20
>>> one from the other ;)
>>
>> What happens if you boot with "acpi=3Doff" on the boot command line?
>>
>> Alan Stern
>>
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
