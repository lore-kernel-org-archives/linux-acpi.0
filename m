From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: acpi-20040715: functional regression on ASUS M2N
Date: Tue, 31 Aug 2004 16:45:04 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B44D37711ED29844BEA67908EAF36F03AC6ACF@pdsmsx401.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C48F36.C9C2E11B"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Georg C. F. Greve" <greve-mXXj517/zsQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C48F36.C9C2E11B
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
I guess it's the problem I encountered (the dmesg is the same as mine).
Attached email includes two workarounds for this issue, but no final
solution yet.

Thanks,
Shaohua

>-----Original Message-----
>From: Georg C. F. Greve [mailto:greve-1r/uNngapc3YtjvyW6yDsg@public.gmane.org] On Behalf Of Georg C.
F.
>Greve
>Sent: Tuesday, August 31, 2004 4:16 PM
>To: ACPI Developers; Li, Shaohua
>Subject: Re: [ACPI] acpi-20040715: functional regression on ASUS M2N
>
>Hi all,
>
>I thought you might like to know that I've just managed to build a
>kernel that allows me to suspend to ram again -- and in fact better
>than before in so far as the network cards work correctly after
>resume. Unfortunately this only works once. So there is progress on
>the problem, even though it is not fully solved yet.
>
>The kernel is a 2.6.9-rc1 with the following patches applied in this
>order:
>
> acpi-20040816-26-latest-release.diff.bz2
> alsa-bk-2004-08-26.patch.gz
> software-suspend-2.0.0.105-for-2.6.8.1.tar.bz2
>
>(Note: the software suspend 2 has one reject that is apparently
> relatively easy to fix, however software suspend 2 does not work
> anymore on this kernel. On suspend it does not switch to the suspend
> screen, although the machine appears to be suspending successfully,
> but on resume the machine hangs when "Copying original kernel back")
>
>Please note that the ALSA patch is absolutely necessary for this to
>work, when I left it out, the resume from suspend to ram hung. Only
>with the patch applied it resumes properly and I see the messages for
>irq 6 and irq 11 having been disabled during the suspend phase.
>
>In the syslog it shows that something still appears to be fishy,
>however:
>
> kernel: Back to C!
> kernel: irq 6: nobody cared!
> kernel:  [__report_bad_irq+42/139] __report_bad_irq+0x2a/0x8b
> kernel:  [note_interrupt+111/159] note_interrupt+0x6f/0x9f
> kernel:  [do_IRQ+295/310] do_IRQ+0x127/0x136
> kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
> kernel:  [handle_IRQ_event+36/100] handle_IRQ_event+0x24/0x64
> kernel:  [do_IRQ+148/310] do_IRQ+0x94/0x136
> kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
> kernel:  [handle_IRQ_event+36/100] handle_IRQ_event+0x24/0x64
> kernel:  [do_IRQ+148/310] do_IRQ+0x94/0x136
> kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
> kernel:  [__do_softirq+47/135] __do_softirq+0x2f/0x87
> kernel:  [do_softirq+38/40] do_softirq+0x26/0x28
> kernel:  [do_IRQ+259/310] do_IRQ+0x103/0x136
> kernel:  [time_resume+0/74] time_resume+0x0/0x4a
> kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
> kernel:  [time_resume+0/74] time_resume+0x0/0x4a
> kernel:  [time_resume+66/74] time_resume+0x42/0x4a
> kernel:  [sysdev_resume+225/230] sysdev_resume+0xe1/0xe6
> kernel:  [device_power_up+5/10] device_power_up+0x5/0xa
> kernel:  [suspend_enter+54/74] suspend_enter+0x36/0x4a
> kernel:  [enter_state+105/161] enter_state+0x69/0xa1
> kernel:  [acpi_suspend+62/77] acpi_suspend+0x3e/0x4d
> kernel:  [acpi_system_write_sleep+96/139]
>acpi_system_write_sleep+0x60/0x8b
> kernel:  [acpi_system_write_sleep+117/139]
>acpi_system_write_sleep+0x75/0x8b
> kernel:  [acpi_system_write_sleep+0/139]
acpi_system_write_sleep+0x0/0x8b
> kernel:  [vfs_write+176/281] vfs_write+0xb0/0x119
> kernel:  [sys_write+81/128] sys_write+0x51/0x80
> kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
> kernel: handlers:
> kernel: [snd_intel8x0_interrupt+0/542]
(snd_intel8x0_interrupt+0x0/0x21e)
> kernel: Disabling IRQ #6
> kernel: irq 11: nobody cared!
> kernel:  [__report_bad_irq+42/139] __report_bad_irq+0x2a/0x8b
> kernel:  [note_interrupt+111/159] note_interrupt+0x6f/0x9f
> kernel:  [do_IRQ+295/310] do_IRQ+0x127/0x136
> kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
> kernel:  [handle_IRQ_event+36/100] handle_IRQ_event+0x24/0x64
> kernel:  [do_IRQ+148/310] do_IRQ+0x94/0x136
> kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
> kernel:  [__do_softirq+47/135] __do_softirq+0x2f/0x87
> kernel:  [do_softirq+38/40] do_softirq+0x26/0x28
> kernel:  [do_IRQ+259/310] do_IRQ+0x103/0x136
> kernel:  [time_resume+0/74] time_resume+0x0/0x4a
> kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
> kernel:  [time_resume+0/74] time_resume+0x0/0x4a
> kernel:  [time_resume+66/74] time_resume+0x42/0x4a
> kernel:  [sysdev_resume+225/230] sysdev_resume+0xe1/0xe6
> kernel:  [device_power_up+5/10] device_power_up+0x5/0xa
> kernel:  [suspend_enter+54/74] suspend_enter+0x36/0x4a
> kernel:  [enter_state+105/161] enter_state+0x69/0xa1
> kernel:  [acpi_suspend+62/77] acpi_suspend+0x3e/0x4d
> kernel:  [acpi_system_write_sleep+96/139]
>acpi_system_write_sleep+0x60/0x8b
> kernel:  [acpi_system_write_sleep+117/139]
>acpi_system_write_sleep+0x75/0x8b
> kernel:  [acpi_system_write_sleep+0/139]
acpi_system_write_sleep+0x0/0x8b
> kernel:  [vfs_write+176/281] vfs_write+0xb0/0x119
> kernel:  [sys_write+81/128] sys_write+0x51/0x80
> kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
> kernel: handlers:
> kernel: [pg0+536303635/1068441600] (ohci_irq_handler+0x0/0x80e
[ohci1394])
> kernel: Disabling IRQ #11
> kernel: PM: Finishing up.
> [...]
> kernel: ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 11 (level, low) ->
IRQ
>11
> kernel: PCI: Setting latency timer of device 0000:00:1d.0 to 64
> kernel: ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 5 (level, low) ->
IRQ 5
> kernel: PCI: Setting latency timer of device 0000:00:1d.1 to 64
> kernel: ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 7 (level, low) ->
IRQ 7
> kernel: PCI: Setting latency timer of device 0000:00:1d.2 to 64
> kernel: ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 4 (level, low) ->
IRQ 4
> kernel: PCI: Setting latency timer of device 0000:00:1d.7 to 64
> kernel: ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 7 (level, low) ->
IRQ 7
> kernel: ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 6 (level, low) ->
IRQ 6
> kernel: PCI: Setting latency timer of device 0000:00:1f.5 to 64
> kernel: ACPI: PCI interrupt 0000:01:03.0[A] -> GSI 6 (level, low) ->
IRQ 6
> kernel: ACPI: PCI interrupt 0000:01:03.1[B] -> GSI 7 (level, low) ->
IRQ 7
> kernel: ACPI: PCI interrupt 0000:01:03.2[C] -> GSI 11 (level, low) ->
IRQ
>11
> [...]
> kernel: ACPI: PCI interrupt 0000:01:03.0[A] -> GSI 6 (level, low) ->
IRQ 6
> kernel: Yenta: CardBus bridge found at 0000:01:03.0 [1043:1754]
> kernel: yenta 0000:01:03.0: Preassigned resource 1 busy,
reconfiguring...
> kernel: yenta 0000:01:03.0: Preassigned resource 2 busy,
reconfiguring...
> kernel: yenta 0000:01:03.0: Preassigned resource 3 busy,
reconfiguring...
> kernel: Yenta: ISA IRQ mask 0x0000, PCI irq 6
> kernel: Socket status: 30000006
> kernel: ACPI: PCI interrupt 0000:01:03.1[B] -> GSI 7 (level, low) ->
IRQ 7
> kernel: Yenta: CardBus bridge found at 0000:01:03.1 [1043:1754]
> kernel: yenta 0000:01:03.1: Preassigned resource 0 busy,
reconfiguring...
> kernel: yenta 0000:01:03.1: Preassigned resource 1 busy,
reconfiguring...
> kernel: yenta 0000:01:03.1: Preassigned resource 2 busy,
reconfiguring...
> kernel: yenta 0000:01:03.1: Preassigned resource 3 busy,
reconfiguring...
> kernel: Yenta: ISA IRQ mask 0x0000, PCI irq 7
> [...]
> kernel: ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB/DBM (ICH4/ICH4-M)
USB
>2.0 EHCI Controller
> kernel: PCI: Setting latency timer of device 0000:00:1d.7 to 64
> kernel: ehci_hcd 0000:00:1d.7: irq 4, pci mem e0434c00
> kernel: ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus
number
>4
> kernel: PCI: cache line size of 32 is not supported by device
0000:00:1d.7
> kernel: ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver
2004-
>May-10
> kernel: hub 4-0:1.0: USB hub found
> kernel: hub 4-0:1.0: 6 ports detected
> pci.agent[4271]:      ehci-hcd: loaded successfully
> [...]
> kernel: usb 1-1: control timeout on ep0out
> kernel: uhci_hcd 0000:00:1d.0: Unlink after no-IRQ?  Different ACPI or
>APIC settings may help.
>
>The second attempt at suspending gives
>
> kernel: ehci_hcd 0000:00:1d.7: remove, state 1
>
>upon stopping the hotplug services. The system does not resume but
>keeps running, apparently remaining functional.
>
>If more info is helpful, let me know.
>
>Regards,
>Georg
>
>--
>Georg C. F. Greve                                       <greve-mXXj517/zsQ@public.gmane.org>
>Free Software Foundation Europe
(http://fsfeurope.org)
>Brave GNU World
(http://brave-gnu-world.org)

------_=_NextPart_001_01C48F36.C9C2E11B
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit

X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Received: from pdsmsx404.ccr.corp.intel.com ([172.16.12.64]) by pdsmsx401.ccr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.0); Mon, 23 Aug 2004 14:06:56 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Received: from orsmsx311.amr.corp.intel.com ([192.168.65.40]) by pdsmsx404.ccr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.0); Mon, 23 Aug 2004 14:06:57 +0800
Received: from fmsmsx312.amr.corp.intel.com ([132.233.42.227]) by orsmsx311.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.0); Sun, 22 Aug 2004 23:05:51 -0700
Received: from fmsmsx332.amr.corp.intel.com ([132.233.42.148]) by fmsmsx312.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.0); Sun, 22 Aug 2004 23:05:50 -0700
Received: from fmsmsxvs043.fm.intel.com ([132.233.42.129]) by fmsmsx332.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.0); Sun, 22 Aug 2004 23:05:49 -0700
Received: from talaria.fm.intel.com ([10.1.192.39]) by fmsmsxvs043.fm.intel.com (SAVSMTP 3.1.2.35) with SMTP id M2004082223054832617 ; Sun, 22 Aug 2004 23:05:48 -0700
Received: from fmsfmr003.fm.intel.com (fmsfmr003.fm.intel.com [10.1.193.43]) by talaria.fm.intel.com (8.12.9-20030918-01/8.12.9/d: major-inner.mc,v 1.11 2004/07/29 22:51:53 root Exp $) with ESMTP id i7N68IFO025514; Mon, 23 Aug 2004 06:08:18 GMT
Received: from sc8-sf-list2.sourceforge.net (lists.sourceforge.net [66.35.250.206]) by fmsfmr003.fm.intel.com (8.12.9-20030918-01/8.12.9/d: major-outer.mc,v 1.15 2004/01/30 18:16:28 root Exp $) with ESMTP id i7N66X0D028203; Mon, 23 Aug 2004 06:06:33 GMT
Received: from localhost ([127.0.0.1] helo=projects.sourceforge.net) by sc8-sf-list2.sourceforge.net with esmtp (Exim 4.30) id 1Bz7xA-0005PF-9G; Sun, 22 Aug 2004 23:05:12 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net) by sc8-sf-list2.sourceforge.net with esmtp (Exim 4.30) id 1Bz7wj-0005L9-73 for acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Sun, 22 Aug 2004 23:04:45 -0700
Received: from fmr06.intel.com ([134.134.136.7] helo=caduceus.jf.intel.com) by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34) id 1Bz7wi-0008HP-Nf for acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Sun, 22 Aug 2004 23:04:45 -0700
Received: from petasus.jf.intel.com (petasus.jf.intel.com [10.7.209.6]) by caduceus.jf.intel.com (8.12.9-20030918-01/8.12.9/d: major-outer.mc,v 1.15 2004/01/30 18:16:28 root Exp $) with ESMTP id i7N636wr023654; Mon, 23 Aug 2004 06:03:06 GMT
Received: from pdsmsxvs01.pd.intel.com (pdsmsxvs01.pd.intel.com [172.16.12.122]) by petasus.jf.intel.com (8.12.9-20030918-01/8.12.9/d: major-inner.mc,v 1.11 2004/07/29 22:51:53 root Exp $) with SMTP id i7N66FTV001803; Mon, 23 Aug 2004 06:06:16 GMT
Received: from pdsmsx331.ccr.corp.intel.com ([172.16.12.58]) by pdsmsxvs01.pd.intel.com (SAVSMTP 3.1.2.35) with SMTP id M2004082314034301234 ; Mon, 23 Aug 2004 14:03:43 +0800
Received: from pdsmsx401.ccr.corp.intel.com ([172.16.12.51]) by pdsmsx331.ccr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.0); Mon, 23 Aug 2004 14:03:43 +0800
Content-class: urn:content-classes:message
Subject: RE: [ACPI] [PATCH][RFC] fix ACPI IRQ routing after S3 suspend
Date: Mon, 23 Aug 2004 13:58:52 +0800
Message-ID: <B44D37711ED29844BEA67908EAF36F039EA6C2-4yWAQGcml65pB2pF5aRoyrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] [PATCH][RFC] fix ACPI IRQ routing after S3 suspend
Thread-Index: AcSG1B8NKA/yvNTfSIKG2utFIIsxDgAEsBHQAHtkvoA=
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	<stefandoesinger-RbZlAiThDcE@public.gmane.org>,
	"Nathan Bryant" <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	<acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"Linux Kernel Mailing List" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Right, this looks like the problem I encounter. My current test shows =
that the problem only occurs if ACPI changed LINK devices' IRQ. If ACPI =
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

2. change 'device_initcall(i8259A_init_sysfs);' to =
'late_initcall(i8259A_init_sysfs);'
It seems that if OS changed BIOS IRQ router setting (like ACPI change =
Link device setting), IRQ router should resume before PIC. This possibly =
proves what Venki said.

PS. For the resume order, isn't it strange Local APIC resumes after PIT? =
I guess it should be the first device to resume.

Thanks,
Shaohua
>-----Original Message-----
>From: Pallipadi, Venkatesh
>Sent: Saturday, August 21, 2004 3:00 AM
>To: stefandoesinger-RbZlAiThDcE@public.gmane.org; Nathan Bryant
>Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Brown, Len; Linux Kernel list; =
Li,
>Shaohua
>Subject: RE: [ACPI] [PATCH][RFC] fix ACPI IRQ routing after S3 suspend
>
>
>
>
>>-----Original Message-----
>>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of
>>Stefan D=F6singer
>>Sent: Friday, August 20, 2004 9:36 AM
>>To: Nathan Bryant
>>Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Brown, Len; Linux Kernel
>>list; Li, Shaohua
>>Subject: Re: [ACPI] [PATCH][RFC] fix ACPI IRQ routing after S3 suspend
>>
>>Am Freitag, 20. August 2004 14:18 schrieb Nathan Bryant:
>>> Stefan -
>>>
>>> Also - did suspend/resume for the ipw2100 ever work under any kernel
>>> version?
>>Yes, it works with acpi=3Dnoirq at least up to 2.6.7(not tested
>>with later
>>versions, but I'm sure it does)
>>It works with 2.6.8-rc2 and 2.6.8-rc4 and 2.6.8.1 with acpi IRQs and a
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


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel

------_=_NextPart_001_01C48F36.C9C2E11B--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
