From: Vegard Nossum <vegard.nossum@gmail.com>
Subject: Re: BUG: scheduling while atomic in acpi_ps_complete_op
Date: Mon, 24 Aug 2009 16:50:08 +0200
Message-ID: <19f34abd0908240750q454a684fy9aaf4a1cb596c4ce@mail.gmail.com>
References: <1250873707.2168.38.camel@dhcp231-106.rdu.redhat.com>
	 <4A8EFFB2.4040100@suse.de>
	 <1250886352.2168.83.camel@dhcp231-106.rdu.redhat.com>
	 <4A8F1081.3020803@suse.de>
	 <1251124609.2359.25.camel@dhcp231-106.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f207.google.com ([209.85.219.207]:38271 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752678AbZHXOuP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Aug 2009 10:50:15 -0400
In-Reply-To: <1251124609.2359.25.camel@dhcp231-106.rdu.redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Eric Paris <eparis@redhat.com>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, len.brown@intel.com

2009/8/24 Eric Paris <eparis@redhat.com>:
> On Sat, 2009-08-22 at 01:24 +0400, Alexey Starikovskiy wrote:
>> Eric Paris =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> > On Sat, 2009-08-22 at 00:12 +0400, Alexey Starikovskiy wrote:
>> >> Hi,
>> >> This should be handled by abe1dfab60e1839d115930286cb421f5a5b193f=
3.
>> >
>> > And yet I'm getting it from linux-next today.
>> >
>> > So you are apparently failing the in_atomic_preempt_off() test but
>> > succeeding in your !irqs_disabled() test.
>> >
>> > Something isn't right since I'm hitting it hundreds of times on bo=
ot.
>> >
>> > -Eric
>> >
>> Ok, let's see if replacing irqs_disabled() to
>> in_atomic_preempt_off() helps...
>
> It does stop my slew of warnings. =C2=A0Not sure it completely fixes =
my
> problems though....
>
> [ =C2=A0 =C2=A01.897021] ... counter mask: =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A00000000700000003^M
> [ =C2=A0 =C2=A01.906821] ACPI: Core revision 20090625^M
> [ =C2=A0 10.000008] INFO: RCU detected CPU 0 stall (t=3D10000 jiffies=
)^M
> [ =C2=A0 10.000008] sending NMI to all CPUs:^M
> [ =C2=A0 21.907580] Setting APIC routing to flat^M
> [ =C2=A0 21.973314] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D=
-1 pin2=3D-1^M
> [ =C2=A0 21.985260] CPU0: Intel(R) Xeon(R) CPU =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 X5355 =C2=A0@ 2.66GHz stepping 07^M
> [ =C2=A0 21.992017] kmemcheck: Limiting number of CPUs to 1.^M
> [ =C2=A0 21.993065] kmemcheck: Initialized^M
> [ =C2=A0 22.750118] Brought up 1 CPUs^M
> [ =C2=A0 22.751069] Total of 1 processors activated (5333.45 BogoMIPS=
).^M
> [ =C2=A0 23.493639] khelper used greatest stack depth: 4848 bytes lef=
t^M
> [ =C2=A0 24.999193] Booting paravirtualized kernel on bare hardware^M
> [ =C2=A0 25.265364] Time: 17:50:52 =C2=A0Date: 08/21/09^M
> [ =C2=A0 25.616191] NET: Registered protocol family 16^M
> [ =C2=A0 27.765113] ACPI: bus type pci registered^M
> [ =C2=A0 28.795307] PCI: Using configuration type 1 for base access^M
> [ =C2=A0 61.793279] bio: create slab <bio-0> at 0^M
> [ =C2=A0 95.285367] ACPI: BIOS _OSI(Linux) query ignored^M
> [ =C2=A0102.628227] ACPI: Interpreter enabled^M
> [ =C2=A0102.630134] ACPI: (supports S0 S1 S5)^M
> [ =C2=A0102.823225] ACPI: Using IOAPIC for interrupt routing^M
> [ =C2=A0142.365090] ACPI: No dock devices found.^M
> [ =C2=A0156.864036] ACPI: PCI Root Bridge [PCI0] (0000:00)^M
> [ =C2=A0157.460654] pci 0000:00:07.3: quirk: region 1000-103f claimed=
 by PIIX4 ACPI^M
> [ =C2=A0157.463937] pci 0000:00:07.3: quirk: region 1040-104f claimed=
 by PIIX4 SMB^M
> [ =C2=A0157.644036] pci 0000:00:11.0: transparent bridge^M
> [ =C2=A0193.009036] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9=
 10 11 14 15) *0, disabled.^M
> [ =C2=A0193.938036] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *=
9 10 11 14 15)^M
> [ =C2=A0194.864036] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9=
 10 *11 14 15)^M
> [ =C2=A0195.780036] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9=
 10 11 14 15) *0, disabled.^M
>
> Something took 20 seconds between "ACPI: Core revision 20090625" and
> "Setting APIC routing to flat"
>
> This is a linux-next kernel, on vmware-server, with kmemcheck enabled=
=2E
> Disabling kmemcheck seems to make all of this go away. =C2=A0If not t=
he ACPI
> guys who should I be talking to?
>
> A little bit later I finally see backtraces from NMIs because of RCU
> stalls. =C2=A0Anyone have ideas here?
>
> [ =C2=A0213.168161] INFO: RCU detected CPU 0 stall (t=3D10004 jiffies=
)^M

So this is probably just the intrinsic slowness of kmemcheck that
causes the the big delays and RCU stalls. It shouldn't cause any other
badness, as far as I understood, the 10000 jiffies limit is just a
heuristic. Maybe we need to adjust it when kmemcheck is enabled.

I'm more confused about the change you had to with
irqs_disabled()/in_atomic_preempt_off().


Vegard
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
