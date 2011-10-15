From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PROBLEM] ASUS Sandybridge motherboards + PCI not working (IRQ n:
 nobody cared)
Date: Sat, 15 Oct 2011 10:23:59 -0600
Message-ID: <CADLC3L3wZuS-1oNoOkkU5uEDhmUio3edL05Cy4EDapfG-Y202w@mail.gmail.com>
References: <4E98175A.8040905@pobox.com>
	<4E98D402.2030600@gmail.com>
	<4E9947B1.4050100@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:38221 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702Ab1JOQYA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 15 Oct 2011 12:24:00 -0400
In-Reply-To: <4E9947B1.4050100@pobox.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chris Palmer <chris.palmer@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Sat, Oct 15, 2011 at 2:43 AM, Chris Palmer <chris.palmer@pobox.com> =
wrote:
> On 15/10/2011 01:29, Robert Hancock wrote:
>> On 10/14/2011 05:04 AM, Chris Palmer wrote:
>>> Interrupt handling for *PCI boards with ASUS Sandybridge motherboar=
ds*
>>> seems to be broken.
>>>
>>> It has been seen with network and non-network PCI boards. PCIx netw=
ork
>>> boards work OK. And all reports are for ASUS motherboards.
>>>
>>> It always results in the infamous "IRQ n: nobody cared" message usu=
ally
>>> within an hour. It is possible to restart things by rmmod/modprobe =
on
>>> the appropriate PCI driver.
>>>
>>> Andrew Morton kindly took a quick look and thinks it is most likely=
 an
>>> ACPI bug.
>>>
>>> Configuration summary:
>>> =A0 - ASUS P8H67-V/R3 Motherboard (others have problems with simila=
r M/Bs)
>>> =A0 - M/B BIOS 0804 (just updated to that - no change)
>>> =A0 - Core i5/2500K
>>> =A0 - Onboard ethernet (at11c driver - works)
>>> =A0 - Additional PCIx Intel ethernet board (e1000e driver - works)
>>> =A0 - Additional PCI Broadcom BCM5702X ethernet board (tg3 driver -=
 fails)
>>> =A0 =A0 [ Also fails with other PCI boards such as RTL8139 ]
>>> =A0 - Kernel 3.0.6
>>>
>>>
>>> Any help much appreciated...
>>>
>>> Previous references:
>>>
>>> https://lkml.org/lkml/2011/6/30/197
>>> https://bugzilla.kernel.org/show_bug.cgi?id=3D38632
>>> https://bugzilla.redhat.com/show_bug.cgi?id=3D713351
>>> https://bugzilla.kernel.org/show_bug.cgi?id=3D35332
>>> https://bugzilla.kernel.org/show_bug.cgi?id=3D34242
>>> https://bugzilla.kernel.org/show_bug.cgi?id=3D32242
>>> https://bugzilla.kernel.org/show_bug.cgi?id=3D39122
>>
>> The bugzilla reports aren't currently accessible so I don't know if =
it
>> was posted there, but can you post the output of "lspci -vv" as root=
?
>> Could be that some other device is configured on that IRQ and
>> sometimes spuriously generates interrupts.
>>
>
> Robert
>
> Various outputs below.
>
> Many thanks
> Chris
>

The only device lspci lists as using IRQ 16 is the network card:

09:01.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5702X
Gigabit Ethernet (rev 02)
        Subsystem: 3Com Corporation Device 1100
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64 (16000ns min), Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 16

But dmesg has some references to other devices routed to IRQ 16:

Oct 13 19:27:05 woody1 kernel: [    0.604919] pci 0000:00:01.0: PCI
INT A -> GSI 16 (level, low) -> IRQ 16

This is the PCI-E root port. lspci doesn't list any INTx interrupt for
this device but does list MSI as being enabled with vector 4159.

Oct 13 19:27:05 woody1 kernel: [    0.605616] pci 0000:00:1c.5: PCI
INT B -> GSI 16 (level, low) -> IRQ 16

This is the PCI-E root port 6, which the USB3 XHCI controller is
attached to. Likewise no INTx interrupt is listed but MSI is enabled
with vector 4181.

Oct 13 19:27:05 woody1 kernel: [   23.180060] radeon 0000:01:00.0: PCI
INT A -> GSI 16 (level, low) -> IRQ 16

This is the video card. lspci lists it as being on INTx IRQ 56, and
MSI is enabled with vector 4122.

I'm not quite sure what to make of this. It looks like somehow the
kernel's IRQ routing is inconsistent with what lspci is reporting. My
guess is that eventually one of these other devices that's actually
routed to IRQ 16 actually generates an interrupt and nothing is set up
to handle it.

CCing linux-acpi.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
