From: "Li, Shaohua" <shaohua.li@intel.com>
Subject: RE: [ACPI] [PATCH][RFC] fix ACPI IRQ routing after S3 suspend
Date: Mon, 23 Aug 2004 13:58:52 +0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <B44D37711ED29844BEA67908EAF36F039EA6C2@pdsmsx401.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S267416AbUHWGEv@vger.kernel.org>
Content-class: urn:content-classes:message
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, stefandoesinger@gmx.at, Nathan Bryant <nbryant@optonline.net>
Cc: "Brown, Len" <len.brown@intel.com>, acpi-devel@lists.sourceforge.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Right, this looks like the problem I encounter. My current test shows t=
hat the problem only occurs if ACPI changed LINK devices' IRQ. If ACPI =
use default LINK device IRQ, the problem went off.
Currently there are two workarounds:
1. comment one line in pci_link.c:acpi_pci_link_allocate, like below
	/*
	 * forget active IRQ that is not in possible list
	 */
	if (i =3D=3D link->irq.possible_count) {
		if (acpi_strict)
			printk(KERN_WARNING PREFIX "_CRS %d not found"
				" in _PRS\n", link->irq.active);
+//		link->irq.active =3D 0;
	}
This disables rebalance IRQ, which fixes my problem.

2. change 'device_initcall(i8259A_init_sysfs);' to 'late_initcall(i8259=
A_init_sysfs);'
It seems that if OS changed BIOS IRQ router setting (like ACPI change L=
ink device setting), IRQ router should resume before PIC. This possibly=
 proves what Venki said.

PS. For the resume order, isn't it strange Local APIC resumes after PIT=
? I guess it should be the first device to resume.

Thanks,
Shaohua
>-----Original Message-----
>From: Pallipadi, Venkatesh
>Sent: Saturday, August 21, 2004 3:00 AM
>To: stefandoesinger@gmx.at; Nathan Bryant
>Cc: acpi-devel@lists.sourceforge.net; Brown, Len; Linux Kernel list; L=
i,
>Shaohua
>Subject: RE: [ACPI] [PATCH][RFC] fix ACPI IRQ routing after S3 suspend
>
>
>
>
>>-----Original Message-----
>>From: acpi-devel-admin@lists.sourceforge.net
>>[mailto:acpi-devel-admin@lists.sourceforge.net] On Behalf Of
>>Stefan D=F6singer
>>Sent: Friday, August 20, 2004 9:36 AM
>>To: Nathan Bryant
>>Cc: acpi-devel@lists.sourceforge.net; Brown, Len; Linux Kernel
>>list; Li, Shaohua
>>Subject: Re: [ACPI] [PATCH][RFC] fix ACPI IRQ routing after S3 suspen=
d
>>
>>Am Freitag, 20. August 2004 14:18 schrieb Nathan Bryant:
>>> Stefan -
>>>
>>> Also - did suspend/resume for the ipw2100 ever work under any kerne=
l
>>> version?
>>Yes, it works with acpi=3Dnoirq at least up to 2.6.7(not tested
>>with later
>>versions, but I'm sure it does)
>>It works with 2.6.8-rc2 and 2.6.8-rc4 and 2.6.8.1 with acpi IRQs and =
a
>>modified dsdt which forces LNKE to IRQ 10. I attached a dmesg
>>output of a
>>successful resume.
>>
>>Cheers,
>>Stefan
>
>This seems to be the same resume order issue, that Shaohua is hitting.
>
>On my system the resume order looks like this:
>Resuming System Devices
>Resuming type 'cpu':
> cpu0
>aux driver resume 0xc010e410 (mtrr_restore)
>aux driver resume 0xc03365f0 (cpufreq_resume)
>Resuming type 'i8259':
> i82590
>Resuming type 'timer':
> timer0
>Resuming type 'pit':
> pit0
>Resuming type 'lapic':
> lapic0
>Resuming type 'irqrouter':
> irqrouter0
>Resuming type 'i8042':
> i80420
>
>The current theory I have for this issue is we resume pci_link driver
>A bit too late, which is causing this problem.
>
>Say a particular device doesn't do anything for suspend and resume.
>So, as soon as we resume this particular device can start
>generating interrupts. Once we have PIC enabled, it starts sending
>interrupts and no one handles that original IRQ. As pci_link that
>resumes later is reprogramming the device to different IRQ, where the
>driver is handling the device.
>
>That's probably the reason why it works with acpi=3Dnoirq or
>modified DSDT. Does it make sense?
>
>I think we have to resume pci_link device before PIC.
>We should be able to achieve this my changing the makefile orders.
>
>Thanks,
>Venki
>
