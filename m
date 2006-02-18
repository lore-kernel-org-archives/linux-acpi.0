From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [Bugme-new] [Bug 6094] New: resuming from swsus: ipw2100 fails
Date: Sat, 18 Feb 2006 12:45:48 -0800
Message-ID: <20060218124548.25d9bd07.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:62107 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932151AbWBRUrN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 18 Feb 2006 15:47:13 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Pavel Machek <pavel@ucw.cz>


Is this an ACPI problem?

Begin forwarded message:

Date: Sat, 18 Feb 2006 06:56:51 -0800
From: bugme-daemon@bugzilla.kernel.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 6094] New: resuming from swsus: ipw2100 fails


http://bugzilla.kernel.org/show_bug.cgi?id=6094

           Summary: resuming from swsus: ipw2100 fails
    Kernel Version: 2.6.15.2
            Status: NEW
          Severity: normal
             Owner: power-management_other@kernel-bugs.osdl.org
         Submitter: spinningteacup@ftml.net


Distribution: Debian

Hardware Environment: acer travelmate 800 (intel centrino laptop)

Problem Description: After resuming from a (successful...) swsusp 
suspend-to-disk cycle, I get the message "eth1: Failed to start the card", 
repeatedly. The machine fails to reboot then, I need to turn it off or 
SysReq+b. eth1 is a ipw2100 driver loaded as a module. (Maybe this bug should 
be filed for ipw2100, but I'm not sure. Please forward it appropriately) If I 
remember correctly this worked fine with the external ipw2100, and hasn't 
worked anymore since ipw2100 was merged into mainline.

While resuming, I get this message: 
irq 11: nobody cared (try booting with the "irqpoll" option)
I haven't tried irqpoll yet.

cat /proc/interrupts
           CPU0
  0:   14194381          XT-PIC  timer
  1:         36          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:      20553          XT-PIC  uhci_hcd:usb2
  7:          1          XT-PIC  parport0
  8:          4          XT-PIC  rtc
  9:       1180          XT-PIC  acpi
 10:    1904128          XT-PIC  uhci_hcd:usb1, uhci_hcd:usb3, ehci_hcd:usb4, 
Intel 82801DB-ICH4 Modem, Intel 82801DB-ICH4, yenta, yenta, ohci1394, 
radeon@pci:0000:01:00.0
 11:      37903          XT-PIC  eth1
 12:        123          XT-PIC  i8042
 14:      42667          XT-PIC  ide0
 15:         50          XT-PIC  ide1
NMI:          0
LOC:          0
ERR:          0
MIS:          0


kernel.log looks like this:

ACPI: PCI interrupt for device 0000:00:1d.0 disabled
Stopping tasks: ========================================|
Freeing memory...  ^H-^H\^Hdone (13913 pages freed)
ACPI: PCI interrupt for device 0000:02:06.1 disabled
ACPI: PCI interrupt for device 0000:02:06.0 disabled
ACPI: PCI interrupt for device 0000:02:04.0 disabled
ACPI: PCI interrupt for device 0000:00:1f.6 disabled
ACPI: PCI interrupt for device 0000:00:1f.5 disabled
swsusp: Need to copy 11838 pages
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
swsusp: Restoring Highmem
irq 11: nobody cared (try booting with the "irqpoll" option)
 [__report_bad_irq+49/115] __report_bad_irq+0x31/0x73
 [note_interrupt+117/153] note_interrupt+0x75/0x99
 [__do_IRQ+101/145] __do_IRQ+0x65/0x91
 [do_IRQ+29/40] do_IRQ+0x1d/0x28
 [common_interrupt+26/32] common_interrupt+0x1a/0x20
 [__do_softirq+44/125] __do_softirq+0x2c/0x7d
 [do_softirq+34/38] do_softirq+0x22/0x26
 [do_IRQ+34/40] do_IRQ+0x22/0x28
 [common_interrupt+26/32] common_interrupt+0x1a/0x20
 [msix_capability_init+383/504] msix_capability_init+0x17f/0x1f8
 [cache_grow+107/256] cache_grow+0x6b/0x100
 [cache_alloc_refill+317/368] cache_alloc_refill+0x13d/0x170
 [kmem_cache_alloc+42/52] kmem_cache_alloc+0x2a/0x34
 [acpi_os_acquire_object+15/60] acpi_os_acquire_object+0xf/0x3c
 [acpi_ut_create_generic_state+12/37] acpi_ut_create_generic_state+0xc/0x25
 [acpi_ns_evaluate_relative+70/205] acpi_ns_evaluate_relative+0x46/0xcd
 [acpi_rs_set_srs_method_data+156/199] acpi_rs_set_srs_method_data+0x9c/0xc7
 [acpi_pci_link_set+268/387] acpi_pci_link_set+0x10c/0x183
 [acpi_pci_link_resume+33/39] acpi_pci_link_resume+0x21/0x27
 [irqrouter_resume+29/60] irqrouter_resume+0x1d/0x3c
 [__sysdev_resume+20/87] __sysdev_resume+0x14/0x57
 [sysdev_resume+24/74] sysdev_resume+0x18/0x4a
 [device_power_up+5/10] device_power_up+0x5/0xa
 [swsusp_suspend+107/131] swsusp_suspend+0x6b/0x83
 [pm_suspend_disk+59/132] pm_suspend_disk+0x3b/0x84
 [enter_state+73/123] enter_state+0x49/0x7b
 [state_store+127/139] state_store+0x7f/0x8b
 [flush_write_buffer+36/40] flush_write_buffer+0x24/0x28
 [sysfs_write_file+60/91] sysfs_write_file+0x3c/0x5b
 [vfs_write+161/312] vfs_write+0xa1/0x138
 [sys_write+59/100] sys_write+0x3b/0x64
 [syscall_call+7/11] syscall_call+0x7/0xb
handlers:
[pg0+544427201/1070281728] (ipw2100_interrupt+0x0/0x7c [ipw2100])
Disabling IRQ #11
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 10 (level, low) -> 
IRQ 10
ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 10 (level, low) -> 
IRQ 10
PCI: Setting latency timer of device 0000:00:1f.5 to 64
ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB] -> GSI 10 (level, low) -> 
IRQ 10
PCI: Setting latency timer of device 0000:00:1f.6 to 64
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> 
IRQ 10
ACPI: PCI Interrupt 0000:02:02.0[A] -> Link [LNKD] -> GSI 5 (level, low) -> IRQ 
5
ACPI: PCI Interrupt 0000:02:04.0[A] -> Link [LNKE] -> GSI 11 (level, low) -> 
IRQ 11
ipw2100: eth1: Failed to start the card.

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.
