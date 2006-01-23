From: "Li, Shaohua" <shaohua.li@intel.com>
Subject: RE: Suspend to RAM no longer works in 2.6.15.1 worked in 2.6.9 and 2.6.10
Date: Mon, 23 Jan 2006 13:59:55 +0800
Message-ID: <59D45D057E9702469E5775CBB56411F10171AF01@pdsmsx406>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr18.intel.com ([134.134.136.17]:5797 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S964821AbWAWF77 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jan 2006 00:59:59 -0500
Received: from orsfmr101.jf.intel.com (orsfmr101.jf.intel.com [10.7.209.17])
	by orsfmr003.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k0N5xwg1030607
	for <linux-acpi@vger.kernel.org>; Mon, 23 Jan 2006 05:59:58 GMT
Received: from pdsmsxvs01.pd.intel.com (pdsmsxvs01.pd.intel.com [172.16.12.122])
	by orsfmr101.jf.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id k0N5xv49025140
	for <linux-acpi@vger.kernel.org>; Mon, 23 Jan 2006 05:59:58 GMT
Received: from pdsmsx331.ccr.corp.intel.com ([172.16.12.58])
 by pdsmsxvs01.pd.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2006012313595607106
 for <linux-acpi@vger.kernel.org>; Mon, 23 Jan 2006 13:59:56 +0800
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stephen Evanchik <evanchsa@gmail.com>, linux-acpi@vger.kernel.org

Hi,
>
> I have a Biostar iDEQ PC with a VIA KM400 chipset that used to STR in
>kernel version 2.6.9 and 2.6.10. I just got around to updating it to
>2.6.15.1 tonight and now STR no longer works.  echo "mem" >
>/sys/power/state causes the machine to turn off and then immediately
>power on, the dmesg output from the point of the STR to the resume is
>included below.
>
>I also tried kernel version 2.6.14 which does not work as well.
>
>I can provide more details if necessary, I am going to try 2.6.12 and
>then go from there in the meantime.
>
What's your output of /proc/acpi/wakeup?
please open a track in bugzilla
(http://bugzilla.kernel.org/enter_bug.cgi).

Thanks,
Shaohua


>
>
>Clip from dmesg:
>
>
>Stopping tasks:
>=======================================================================
====
>===========================|
>ACPI: PCI interrupt for device 0000:00:11.5 disabled
>ACPI: PCI interrupt for device 0000:00:10.4 disabled
>ACPI: PCI interrupt for device 0000:00:10.3 disabled
>ACPI: PCI interrupt for device 0000:00:10.2 disabled
>ACPI: PCI interrupt for device 0000:00:10.1 disabled
>ACPI: PCI interrupt for device 0000:00:10.0 disabled
>Intel machine check architecture supported.
>Intel machine check reporting enabled on CPU#0.
>Back to C!
>Debug: sleeping function called from invalid context at mm/slab.c:2472
>in_atomic():0, irqs_disabled():1
> [<c011bcf1>] __might_sleep+0xa1/0xc0
> [<c014a54a>] kmem_cache_alloc+0x5a/0x70
> [<c020fac2>] acpi_os_acquire_object+0xb/0x36
> [<c0224b86>] acpi_ut_allocate_object_desc_dbg+0x13/0x49
> [<c0224a17>] acpi_ut_create_internal_object_dbg+0xf/0x61
> [<c0220f14>] acpi_rs_set_srs_method_data+0x39/0xb5
> [<c021b2ac>] acpi_hw_low_level_write+0x3c/0x48
> [<c021b264>] acpi_hw_low_level_read+0x42/0x4e
> [<c0228a9b>] acpi_pci_link_set+0x121/0x1a2
> [<c0228f45>] irqrouter_resume+0x26/0x38
> [<c02607e4>] __sysdev_resume+0x34/0x80
> [<c0260aa8>] sysdev_resume+0x38/0x5b
> [<c0265925>] device_power_up+0x5/0xa
> [<c013b1e6>] suspend_enter+0x36/0x60
> [<c013b13f>] suspend_prepare+0x6f/0xe0
> [<c013b297>] enter_state+0x47/0x80
> [<c013b411>] state_store+0x91/0xa4
> [<c013b380>] state_store+0x0/0xa4
> [<c01a3868>] subsys_attr_store+0x38/0x50
> [<c01a3b1e>] flush_write_buffer+0x2e/0x40
> [<c01a3b81>] sysfs_write_file+0x51/0x80
> [<c0161389>] vfs_write+0xd9/0x180
> [<c01614e1>] sys_write+0x41/0x70
> [<c010327b>] sysenter_past_esp+0x54/0x75
>ACPI: PCI Interrupt Link [ALKA] BIOS reported IRQ 0, using IRQ 20
>ACPI: PCI Interrupt Link [ALKB] BIOS reported IRQ 0, using IRQ 21
>ACPI: PCI Interrupt Link [ALKC] BIOS reported IRQ 0, using IRQ 22
>ACPI: PCI Interrupt Link [ALKD] BIOS reported IRQ 0, using IRQ 23
>PCI: Setting latency timer of device 0000:00:01.0 to 64
>ACPI: PCI Interrupt 0000:00:09.0[A] -> GSI 17 (level, low) -> IRQ 20
>ACPI: PCI Interrupt 0000:00:0f.0[B] -> Link [ALKA] -> GSI 20 (level,
>low) -> IRQ 16
>ACPI: PCI Interrupt 0000:00:0f.1[A] -> Link [ALKA] -> GSI 20 (level,
>low) -> IRQ 16
>PCI: Via IRQ fixup for 0000:00:0f.1, from 255 to 0
>ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [ALKB] -> GSI 21 (level,
>low) -> IRQ 19
>ACPI: PCI Interrupt 0000:00:10.1[A] -> Link [ALKB] -> GSI 21 (level,
>low) -> IRQ 19
>ACPI: PCI Interrupt 0000:00:10.2[B] -> Link [ALKB] -> GSI 21 (level,
>low) -> IRQ 19
>ACPI: PCI Interrupt 0000:00:10.3[B] -> Link [ALKB] -> GSI 21 (level,
>low) -> IRQ 19
>ACPI: PCI Interrupt 0000:00:10.4[C] -> Link [ALKB] -> GSI 21 (level,
>low) -> IRQ 19
>ACPI: PCI Interrupt 0000:00:11.5[C] -> Link [ALKC] -> GSI 22 (level,
>low) -> IRQ 18
>eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
>Restarting tasks...<6>usb 2-1: USB disconnect, address 9
> done
>usb 2-2: USB disconnect, address 7
>usb 2-2.1: USB disconnect, address 8
>usb 2-2: new full speed USB device using uhci_hcd and address 10
>hub 2-2:1.0: USB hub found
>hub 2-2:1.0: 3 ports detected
>usb 2-2.1: new low speed USB device using uhci_hcd and address 11
>input: LOGITECH USB Keyboard as /class/input/input10
>input: USB HID v1.10 Keyboard [LOGITECH USB Keyboard] on
usb-0000:00:10.0-
>2.1
>input: LOGITECH USB Keyboard as /class/input/input11
>input: USB HID v1.10 Device [LOGITECH USB Keyboard] on
usb-0000:00:10.0-2.1
>usb 2-1: new low speed USB device using uhci_hcd and address 12
>input: Logitech USB Receiver as /class/input/input12
>input: USB HID v1.10 Mouse [Logitech USB Receiver] on
usb-0000:00:10.0-1
>-
>To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
