From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: expicitly use XT_PIC interrupt for an old device?
Date: Wed, 13 Aug 2008 09:18:52 +0800
Message-ID: <1218590332.3998.27.camel@yakui_zhao.sh.intel.com>
References: <48A053E7.3090305@googlemail.com>
	 <1218503362.6671.143.camel@yakui_zhao.sh.intel.com>
	 <48A135E4.1090707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:26335 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755211AbYHMBEq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Aug 2008 21:04:46 -0400
In-Reply-To: <48A135E4.1090707@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dieter =?ISO-8859-1?Q?Sch=F6n?= <tshinbum@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Tue, 2008-08-12 at 09:04 +0200, Dieter Sch=C3=B6n wrote:
> hi,
>=20
> thanks for the answer,
>=20
> Zhao Yakui schrieb:
> > On Mon, 2008-08-11 at 16:59 +0200, Dieter Sch=C3=B6n wrote:
> >> hi group,
> >>
> >> i have to migrate a character device driver for an old synchronus
> >> serial PCI board (Moxa C502/PCI)
> >> from 2.2.something to 2.6.5-smp x86_64.
> >> the problem is, that no interrupts are routed to the driver.
> >> i was able to get interrupts when i used a non-SMP kernel and the
> >> "noapic" boot option.
> >>
> >> is there a way to explicitly force the use of the 8259 when i requ=
est
> >> an interrupt to get the interrupts for this card not routed via th=
e
> >> APIC?
> >> any pointers are appreciated.
> > doubt whether the I8259 and I/O APIC can be used at the same time.
> > When the non-smp kernel is used and boot option of "noapic" is adde=
d,
> > there exists the interrupt for PCI UART card.=20
> > Do you try it with the boot option of "noapic" on smp kernel?
> > Can you try it on the latest kernel?
>=20
> i have tried it with 2.6.25 on suse11, and also on another hardware=20
> platform (i have heard that some motherboards/BIOSes have problems wi=
th=20
> the APIC) to rule that out.
>=20
> and it seems that it is possible to operate both ways at the same tim=
e:
> the cascade driver seems to use the 8259.
> my driver is one line below, the Moxa. another idea: would it be=20
> possible to force a IO-APIC-level interrupt instead of an edge-trigge=
red?
If the interrupt for Moxa is below 16, you can try to use it as
edge-triggered. But you should confirm that it won't be shared by other
devices.=20

Maybe after you do so, the Moxa still can't work unless you can confirm
that the interrupt Pin of Moxa card is already connected with the I/O
APIC input pin.

Have you tried it with the boot option of "noapic" on smp-kernel?
Thanks.
>=20
> user@host $ cat /proc/interrupts
>             CPU0       CPU1
>    0:     145319     102178    IO-APIC-edge  timer
>    1:        368        485    IO-APIC-edge  i8042
>    2:          0          0          XT-PIC  cascade
>    6:          0          0    IO-APIC-edge  Moxa
>    8:          0          0    IO-APIC-edge  rtc
>    9:          0          0   IO-APIC-level  acpi
>   12:        668       1190    IO-APIC-edge  i8042
>   14:        494        624    IO-APIC-edge  ide0
>   16:          0          0   IO-APIC-level  eth0, ehci_hcd, uhci_hcd
>   17:          0          0   IO-APIC-level  eth1, uhci_hcd
>   18:       6783       3973   IO-APIC-level  libata
> NMI:     247349     247309
> LOC:     246859     247246
> ERR:          0
> MIS:          0
>=20
> user@host $ uname -a
> Linux host 2.6.5-7.244-smp #1 SMP Mon Dec 12 18:32:25 UTC 2005 x86_64=
=20
> x86_64 x86_64 GNU/Linux
>=20
> user@host $ cat /proc/cpuinfo
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 15
> model           : 6
> model name      :               Intel(R) Pentium(R) D CPU 3.40GHz
> stepping        : 4
> cpu MHz         : 3400.280
> cache size      : 2048 KB
> physical id     : 0
> siblings        : 2
> core id         : 0
> cpu cores       : 2
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 6
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pg=
e=20
> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscal=
l=20
> lm pni monitor ds_cpl tm2 cid cmpxchg16b lahf_lm
> bogomips        : 6717.44
> clflush size    : 64
> cache_alignment : 128
> address sizes   : 36 bits physical, 48 bits virtual
> power management:
>=20
> processor       : 1
> vendor_id       : GenuineIntel
> cpu family      : 15
> model           : 6
> model name      :               Intel(R) Pentium(R) D CPU 3.40GHz
> stepping        : 4
> cpu MHz         : 3400.280
> cache size      : 2048 KB
> physical id     : 0
> siblings        : 2
> core id         : 1
> cpu cores       : 2
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 6
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pg=
e=20
> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscal=
l=20
> lm pni monitor ds_cpl tm2 cid cmpxchg16b lahf_lm
> bogomips        : 6782.97
> clflush size    : 64
> cache_alignment : 128
> address sizes   : 36 bits physical, 48 bits virtual
> power management:
>=20
>=20
> kind regards,
> dieter

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
