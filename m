From: "Georg C. F. Greve" <greve-mXXj517/zsQ@public.gmane.org>
Subject: Re: acpi-20040715: functional regression on ASUS M2N
Date: Tue, 31 Aug 2004 10:15:43 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m3656zoh8w.fsf@brain.gnuhh.org>
References: <4112814C.2070808@optonline.net>
	<m37jsc3424.fsf@reason.gnu-hamburg> <41138944.3060309@optonline.net>
	<m3u0vgurzy.fsf@reason.gnu-hamburg> <4113BAD5.1030909@optonline.net>
	<m3r7qkt2hx.fsf@reason.gnu-hamburg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi all,

I thought you might like to know that I've just managed to build a
kernel that allows me to suspend to ram again -- and in fact better
than before in so far as the network cards work correctly after
resume. Unfortunately this only works once. So there is progress on
the problem, even though it is not fully solved yet.

The kernel is a 2.6.9-rc1 with the following patches applied in this
order: 

 acpi-20040816-26-latest-release.diff.bz2
 alsa-bk-2004-08-26.patch.gz
 software-suspend-2.0.0.105-for-2.6.8.1.tar.bz2

(Note: the software suspend 2 has one reject that is apparently
 relatively easy to fix, however software suspend 2 does not work
 anymore on this kernel. On suspend it does not switch to the suspend
 screen, although the machine appears to be suspending successfully,
 but on resume the machine hangs when "Copying original kernel back")

Please note that the ALSA patch is absolutely necessary for this to
work, when I left it out, the resume from suspend to ram hung. Only
with the patch applied it resumes properly and I see the messages for
irq 6 and irq 11 having been disabled during the suspend phase.

In the syslog it shows that something still appears to be fishy,
however:

 kernel: Back to C!
 kernel: irq 6: nobody cared!
 kernel:  [__report_bad_irq+42/139] __report_bad_irq+0x2a/0x8b
 kernel:  [note_interrupt+111/159] note_interrupt+0x6f/0x9f
 kernel:  [do_IRQ+295/310] do_IRQ+0x127/0x136
 kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
 kernel:  [handle_IRQ_event+36/100] handle_IRQ_event+0x24/0x64
 kernel:  [do_IRQ+148/310] do_IRQ+0x94/0x136
 kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
 kernel:  [handle_IRQ_event+36/100] handle_IRQ_event+0x24/0x64
 kernel:  [do_IRQ+148/310] do_IRQ+0x94/0x136
 kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
 kernel:  [__do_softirq+47/135] __do_softirq+0x2f/0x87
 kernel:  [do_softirq+38/40] do_softirq+0x26/0x28
 kernel:  [do_IRQ+259/310] do_IRQ+0x103/0x136
 kernel:  [time_resume+0/74] time_resume+0x0/0x4a
 kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
 kernel:  [time_resume+0/74] time_resume+0x0/0x4a
 kernel:  [time_resume+66/74] time_resume+0x42/0x4a
 kernel:  [sysdev_resume+225/230] sysdev_resume+0xe1/0xe6
 kernel:  [device_power_up+5/10] device_power_up+0x5/0xa
 kernel:  [suspend_enter+54/74] suspend_enter+0x36/0x4a
 kernel:  [enter_state+105/161] enter_state+0x69/0xa1
 kernel:  [acpi_suspend+62/77] acpi_suspend+0x3e/0x4d
 kernel:  [acpi_system_write_sleep+96/139] acpi_system_write_sleep+0x60/0x8b
 kernel:  [acpi_system_write_sleep+117/139] acpi_system_write_sleep+0x75/0x8b
 kernel:  [acpi_system_write_sleep+0/139] acpi_system_write_sleep+0x0/0x8b
 kernel:  [vfs_write+176/281] vfs_write+0xb0/0x119
 kernel:  [sys_write+81/128] sys_write+0x51/0x80
 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
 kernel: handlers:
 kernel: [snd_intel8x0_interrupt+0/542] (snd_intel8x0_interrupt+0x0/0x21e)
 kernel: Disabling IRQ #6
 kernel: irq 11: nobody cared!
 kernel:  [__report_bad_irq+42/139] __report_bad_irq+0x2a/0x8b
 kernel:  [note_interrupt+111/159] note_interrupt+0x6f/0x9f
 kernel:  [do_IRQ+295/310] do_IRQ+0x127/0x136
 kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
 kernel:  [handle_IRQ_event+36/100] handle_IRQ_event+0x24/0x64
 kernel:  [do_IRQ+148/310] do_IRQ+0x94/0x136
 kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
 kernel:  [__do_softirq+47/135] __do_softirq+0x2f/0x87
 kernel:  [do_softirq+38/40] do_softirq+0x26/0x28
 kernel:  [do_IRQ+259/310] do_IRQ+0x103/0x136
 kernel:  [time_resume+0/74] time_resume+0x0/0x4a
 kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
 kernel:  [time_resume+0/74] time_resume+0x0/0x4a 
 kernel:  [time_resume+66/74] time_resume+0x42/0x4a
 kernel:  [sysdev_resume+225/230] sysdev_resume+0xe1/0xe6
 kernel:  [device_power_up+5/10] device_power_up+0x5/0xa
 kernel:  [suspend_enter+54/74] suspend_enter+0x36/0x4a
 kernel:  [enter_state+105/161] enter_state+0x69/0xa1
 kernel:  [acpi_suspend+62/77] acpi_suspend+0x3e/0x4d
 kernel:  [acpi_system_write_sleep+96/139] acpi_system_write_sleep+0x60/0x8b
 kernel:  [acpi_system_write_sleep+117/139] acpi_system_write_sleep+0x75/0x8b
 kernel:  [acpi_system_write_sleep+0/139] acpi_system_write_sleep+0x0/0x8b
 kernel:  [vfs_write+176/281] vfs_write+0xb0/0x119
 kernel:  [sys_write+81/128] sys_write+0x51/0x80
 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
 kernel: handlers:
 kernel: [pg0+536303635/1068441600] (ohci_irq_handler+0x0/0x80e [ohci1394])
 kernel: Disabling IRQ #11
 kernel: PM: Finishing up.
 [...]
 kernel: ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 11 (level, low) -> IRQ 11
 kernel: PCI: Setting latency timer of device 0000:00:1d.0 to 64
 kernel: ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 5 (level, low) -> IRQ 5
 kernel: PCI: Setting latency timer of device 0000:00:1d.1 to 64
 kernel: ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 7 (level, low) -> IRQ 7
 kernel: PCI: Setting latency timer of device 0000:00:1d.2 to 64
 kernel: ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 4 (level, low) -> IRQ 4
 kernel: PCI: Setting latency timer of device 0000:00:1d.7 to 64
 kernel: ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 7 (level, low) -> IRQ 7
 kernel: ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 6 (level, low) -> IRQ 6
 kernel: PCI: Setting latency timer of device 0000:00:1f.5 to 64
 kernel: ACPI: PCI interrupt 0000:01:03.0[A] -> GSI 6 (level, low) -> IRQ 6
 kernel: ACPI: PCI interrupt 0000:01:03.1[B] -> GSI 7 (level, low) -> IRQ 7
 kernel: ACPI: PCI interrupt 0000:01:03.2[C] -> GSI 11 (level, low) -> IRQ 11
 [...]
 kernel: ACPI: PCI interrupt 0000:01:03.0[A] -> GSI 6 (level, low) -> IRQ 6
 kernel: Yenta: CardBus bridge found at 0000:01:03.0 [1043:1754]
 kernel: yenta 0000:01:03.0: Preassigned resource 1 busy, reconfiguring...
 kernel: yenta 0000:01:03.0: Preassigned resource 2 busy, reconfiguring...
 kernel: yenta 0000:01:03.0: Preassigned resource 3 busy, reconfiguring...
 kernel: Yenta: ISA IRQ mask 0x0000, PCI irq 6
 kernel: Socket status: 30000006
 kernel: ACPI: PCI interrupt 0000:01:03.1[B] -> GSI 7 (level, low) -> IRQ 7
 kernel: Yenta: CardBus bridge found at 0000:01:03.1 [1043:1754]
 kernel: yenta 0000:01:03.1: Preassigned resource 0 busy, reconfiguring...
 kernel: yenta 0000:01:03.1: Preassigned resource 1 busy, reconfiguring...
 kernel: yenta 0000:01:03.1: Preassigned resource 2 busy, reconfiguring...
 kernel: yenta 0000:01:03.1: Preassigned resource 3 busy, reconfiguring...
 kernel: Yenta: ISA IRQ mask 0x0000, PCI irq 7
 [...]
 kernel: ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Controller
 kernel: PCI: Setting latency timer of device 0000:00:1d.7 to 64
 kernel: ehci_hcd 0000:00:1d.7: irq 4, pci mem e0434c00
 kernel: ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 4
 kernel: PCI: cache line size of 32 is not supported by device 0000:00:1d.7
 kernel: ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
 kernel: hub 4-0:1.0: USB hub found
 kernel: hub 4-0:1.0: 6 ports detected
 pci.agent[4271]:      ehci-hcd: loaded successfully
 [...]
 kernel: usb 1-1: control timeout on ep0out
 kernel: uhci_hcd 0000:00:1d.0: Unlink after no-IRQ?  Different ACPI or APIC settings may help.

The second attempt at suspending gives

 kernel: ehci_hcd 0000:00:1d.7: remove, state 1

upon stopping the hotplug services. The system does not resume but
keeps running, apparently remaining functional.

If more info is helpful, let me know.

Regards,
Georg

-- 
Georg C. F. Greve                                       <greve-mXXj517/zsQ@public.gmane.org>
Free Software Foundation Europe	                 (http://fsfeurope.org)
Brave GNU World	                           (http://brave-gnu-world.org)


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
