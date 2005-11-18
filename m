From: Rathgeb Markus <maggu2810-S0/GAf8tV78@public.gmane.org>
Subject: BIOS bug?
Date: Fri, 18 Nov 2005 23:15:41 +0100
Message-ID: <437E528D.5070305@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

i tested a few thing, why s3 will not work with new kernels for me 
(blank screen).
can someone have a look at a cut-out from my /var/log/messages

i have execute also
# lspci -vxxx > before
before i go to s3 and
# lspci -vxxx > after
after the machine waked up (via ssh-console)

for example:
before:
0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV350 
[Mobility Radeon 9600 M10] (prog-if 00 [VGA])
	Subsystem: Rioworks: Unknown device 2032

after:
0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV350 
[Mobility Radeon 9600 M10] (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc RV350 [Mobility Radeon 9600 M10]


=============================================================================

cut-out from my /var/log/messages:

Nov 18 22:56:18 walkuer PM: Preparing system for mem sleep
Nov 18 22:56:18 walkuer Debug: sleeping function called from invalid 
context at kernel/sched.c:3134
Nov 18 22:56:18 walkuer in_atomic():0, irqs_disabled():1
Nov 18 22:56:18 walkuer [<c011972d>] __might_sleep+0x90/0x98
Nov 18 22:56:18 walkuer [<c0314bde>] wait_for_completion+0x1a/0x24d
Nov 18 22:56:18 walkuer [<c0154e08>] cache_free_debugcheck+0x18c/0x195
Nov 18 22:56:18 walkuer [<c015575f>] kfree+0x46/0x7b
Nov 18 22:56:18 walkuer [<c013da21>] do_freeze_process+0x1cf/0x380
Nov 18 22:56:18 walkuer [<c013dbdb>] freeze_process+0x9/0xd
Nov 18 22:56:18 walkuer [<c012c82d>] notifier_call_chain+0x1f/0x35
Nov 18 22:56:18 walkuer [<c0103274>] do_signal+0x3f/0xd3
Nov 18 22:56:18 walkuer [<c01538e6>] poison_obj+0x26/0x3f
Nov 18 22:56:18 walkuer [<c0154e08>] cache_free_debugcheck+0x18c/0x195
Nov 18 22:56:18 walkuer [<c015575f>] kfree+0x46/0x7b
Nov 18 22:56:18 walkuer [<c0182cc3>] sys_select+0x3cb/0x3d7
Nov 18 22:56:18 walkuer [<c010332f>] do_notify_resume+0x27/0x38
Nov 18 22:56:18 walkuer [<c01034ce>] work_notifysig+0x13/0x15
Nov 18 22:56:18 walkuer ide-cdrom 1.0: suspending
Nov 18 22:56:18 walkuer ide-disk 0.0: suspending
Nov 18 22:56:18 walkuer serial8250 serial8250: suspending
Nov 18 22:56:18 walkuer i8042 i8042: suspending
Nov 18 22:56:18 walkuer 0000:01:00.0: suspending
Nov 18 22:56:18 walkuer 0000:00:18.3: suspending
Nov 18 22:56:18 walkuer 0000:00:18.2: suspending
Nov 18 22:56:18 walkuer 0000:00:18.1: suspending
Nov 18 22:56:18 walkuer 0000:00:18.0: suspending
Nov 18 22:56:18 walkuer 0000:00:13.0: suspending
Nov 18 22:56:18 walkuer 0000:00:12.0: suspending
Nov 18 22:56:18 walkuer 0000:00:11.6: suspending
Nov 18 22:56:18 walkuer VIA 82xx Audio 0000:00:11.5: suspending
Nov 18 22:56:18 walkuer ACPI: PCI interrupt for device 0000:00:11.5 disabled
Nov 18 22:56:18 walkuer VIA_IDE 0000:00:11.1: suspending
Nov 18 22:56:18 walkuer 0000:00:11.0: suspending
Nov 18 22:56:18 walkuer 0000:00:10.3: suspending
Nov 18 22:56:18 walkuer 0000:00:10.2: suspending
Nov 18 22:56:18 walkuer 0000:00:10.1: suspending
Nov 18 22:56:18 walkuer 0000:00:10.0: suspending
Nov 18 22:56:18 walkuer 0000:00:0c.0: suspending
Nov 18 22:56:18 walkuer yenta_cardbus 0000:00:0a.0: suspending
Nov 18 22:56:18 walkuer ACPI: PCI interrupt for device 0000:00:0a.0 disabled
Nov 18 22:56:18 walkuer 0000:00:01.0: suspending
Nov 18 22:56:18 walkuer agpgart-amd64 0000:00:00.0: suspending
Nov 18 22:56:18 walkuer PM: Entering mem sleep
Nov 18 22:56:18 walkuer Suspending System Devices
Nov 18 22:56:18 walkuer Suspending type 'acpi':
Nov 18 22:56:18 walkuer acpi0
Nov 18 22:56:18 walkuer Suspending type 'irqrouter':
Nov 18 22:56:18 walkuer irqrouter0
Nov 18 22:56:18 walkuer Suspending type 'ioapic':
Nov 18 22:56:18 walkuer ioapic0
Nov 18 22:56:18 walkuer Suspending type 'lapic':
Nov 18 22:56:18 walkuer lapic0
Nov 18 22:56:18 walkuer Suspending type 'timer_pit':
Nov 18 22:56:18 walkuer timer_pit0
Nov 18 22:56:18 walkuer Suspending type 'i8259':
Nov 18 22:56:18 walkuer i82590
Nov 18 22:56:18 walkuer Suspending type 'timer':
Nov 18 22:56:18 walkuer timer0
Nov 18 22:56:18 walkuer Suspending type 'cpu':
Nov 18 22:56:18 walkuer cpu0
Nov 18 22:56:18 walkuer Back to C!
Nov 18 22:56:18 walkuer Resuming System Devices
Nov 18 22:56:18 walkuer Resuming type 'cpu':
Nov 18 22:56:18 walkuer cpu0
Nov 18 22:56:18 walkuer Resuming type 'timer':
Nov 18 22:56:18 walkuer timer0
Nov 18 22:56:18 walkuer Resuming type 'i8259':
Nov 18 22:56:18 walkuer i82590
Nov 18 22:56:18 walkuer Resuming type 'timer_pit':
Nov 18 22:56:18 walkuer timer_pit0
Nov 18 22:56:18 walkuer Resuming type 'lapic':
Nov 18 22:56:18 walkuer lapic0
Nov 18 22:56:18 walkuer Resuming type 'ioapic':
Nov 18 22:56:18 walkuer ioapic0
Nov 18 22:56:18 walkuer Resuming type 'irqrouter':
Nov 18 22:56:18 walkuer irqrouter0
Nov 18 22:56:18 walkuer Debug: sleeping function called from invalid 
context at mm/slab.c:2096
Nov 18 22:56:18 walkuer in_atomic():0, irqs_disabled():1
Nov 18 22:56:18 walkuer [<c011972d>] __might_sleep+0x90/0x98
Nov 18 22:56:18 walkuer [<c0155527>] kmem_cache_alloc+0x22/0x73
Nov 18 22:56:18 walkuer [<c025515e>] acpi_pci_link_set+0x48/0x1a4
Nov 18 22:56:18 walkuer [<c02556db>] acpi_pci_link_resume+0x27/0x2d
Nov 18 22:56:18 walkuer [<c0255706>] irqrouter_resume+0x25/0x44
Nov 18 22:56:18 walkuer [<c0273006>] sysdev_resume+0x6a/0x14c
Nov 18 22:56:18 walkuer [<c02772ce>] device_power_up+0x5/0xa
Nov 18 22:56:18 walkuer [<c013d5fc>] suspend_enter+0x35/0x3d
Nov 18 22:56:18 walkuer [<c013d68c>] enter_state+0x5c/0x84
Nov 18 22:56:18 walkuer [<c013d79c>] state_store+0x84/0x9a
Nov 18 22:56:18 walkuer [<c01b2fc7>] subsys_attr_store+0x22/0x2a
Nov 18 22:56:18 walkuer [<c01b31af>] flush_write_buffer+0x25/0x2a
Nov 18 22:56:18 walkuer [<c01b31fa>] sysfs_write_file+0x46/0x64
Nov 18 22:56:18 walkuer [<c016d3f4>] vfs_write+0xa4/0x13b
Nov 18 22:56:18 walkuer [<c016d529>] sys_write+0x3b/0x63
Nov 18 22:56:18 walkuer [<c010343d>] syscall_call+0x7/0xb
Nov 18 22:56:18 walkuer ACPI: PCI Interrupt Link [ALKA] disabled and 
referenced, BIOS bug.
Nov 18 22:56:18 walkuer ACPI: PCI Interrupt Link [ALKA] BIOS reported 
IRQ 9, using IRQ 23
Nov 18 22:56:18 walkuer ACPI: PCI Interrupt Link [ALKB] disabled and 
referenced, BIOS bug.
Nov 18 22:56:18 walkuer ACPI: PCI Interrupt Link [ALKB] BIOS reported 
IRQ 11, using IRQ 23
Nov 18 22:56:18 walkuer ACPI: PCI Interrupt Link [ALKC] disabled and 
referenced, BIOS bug.
Nov 18 22:56:18 walkuer ACPI: PCI Interrupt Link [ALKC] BIOS reported 
IRQ 10, using IRQ 22
Nov 18 22:56:18 walkuer ACPI: PCI Interrupt Link [ALKD] disabled and 
referenced, BIOS bug.
Nov 18 22:56:18 walkuer ACPI: PCI Interrupt Link [ALKD] BIOS reported 
IRQ 10, using IRQ 21
Nov 18 22:56:18 walkuer Resuming type 'acpi':
Nov 18 22:56:18 walkuer acpi0
Nov 18 22:56:18 walkuer PM: Finishing wakeup.
Nov 18 22:56:18 walkuer agpgart-amd64 0000:00:00.0: resuming
Nov 18 22:56:18 walkuer 0000:00:01.0: resuming
Nov 18 22:56:18 walkuer PCI: Setting latency timer of device 
0000:00:01.0 to 64
Nov 18 22:56:18 walkuer yenta_cardbus 0000:00:0a.0: resuming
Nov 18 22:56:18 walkuer ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 17 
(level, low) -> IRQ 16
Nov 18 22:56:18 walkuer 0000:00:0c.0: resuming
Nov 18 22:56:18 walkuer 0000:00:10.0: resuming
Nov 18 22:56:18 walkuer 0000:00:10.1: resuming
Nov 18 22:56:18 walkuer 0000:00:10.2: resuming
Nov 18 22:56:18 walkuer 0000:00:10.3: resuming
Nov 18 22:56:18 walkuer 0000:00:11.0: resuming
Nov 18 22:56:18 walkuer VIA_IDE 0000:00:11.1: resuming
Nov 18 22:56:18 walkuer ACPI: PCI Interrupt 0000:00:11.1[A] -> Link 
[ALKA] -> GSI 23 (level, low) -> IRQ 17
Nov 18 22:56:18 walkuer PCI: Via IRQ fixup for 0000:00:11.1, from 0 to 1
Nov 18 22:56:18 walkuer VIA 82xx Audio 0000:00:11.5: resuming
Nov 18 22:56:18 walkuer ACPI: PCI Interrupt 0000:00:11.5[C] -> Link 
[ALKC] -> GSI 22 (level, low) -> IRQ 20
Nov 18 22:56:18 walkuer 0000:00:11.6: resuming
Nov 18 22:56:18 walkuer 0000:00:12.0: resuming
Nov 18 22:56:18 walkuer 0000:00:13.0: resuming
Nov 18 22:56:18 walkuer 0000:00:18.0: resuming
Nov 18 22:56:18 walkuer 0000:00:18.1: resuming
Nov 18 22:56:18 walkuer 0000:00:18.2: resuming
Nov 18 22:56:18 walkuer 0000:00:18.3: resuming
Nov 18 22:56:18 walkuer 0000:01:00.0: resuming
Nov 18 22:56:18 walkuer i8042 i8042: resuming
Nov 18 22:56:18 walkuer psmouse serio0: resuming
Nov 18 22:56:18 walkuer atkbd serio1: resuming
Nov 18 22:56:18 walkuer serial8250 serial8250: resuming
Nov 18 22:56:18 walkuer ide-disk 0.0: resuming
Nov 18 22:56:18 walkuer ide-cdrom 1.0: resuming


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
