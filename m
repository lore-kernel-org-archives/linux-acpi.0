From: Ferenc Szalma <szalmaf-JAjqph6Yjy97jm546uhsrg@public.gmane.org>
Subject: swsusp: FATAL: cannot find swap device, try swapon -a!
Date: Wed, 23 Mar 2005 19:09:37 -0500 (EST)
Message-ID: <Pine.GSO.4.61.0503231901190.15962@z.glue.umd.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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

Hi,

Swsusp comes back with the following error message on my Toshiba m200 
laptop:


Stopping tasks: 
==========================================================================|
Freeing memory... done (35896 pages freed)
BUG: using smp_processor_id() in preemptible [00000001] code: 
acpitool/8191
caller is disable_nonboot_cpus+0x10/0xdb
  [<c025c6bf>] smp_processor_id+0xa3/0xb4
  [<c013a2c5>] disable_nonboot_cpus+0x10/0xdb
  [<c013a2c5>] disable_nonboot_cpus+0x10/0xdb
  [<c013a4c7>] free_some_memory+0x5e/0x64
  [<c013a53b>] prepare+0x2f/0xaf
  [<c013a5c4>] pm_suspend_disk+0x9/0x73
  [<c0138cac>] enter_state+0x8e/0x92
  [<c0138dd4>] state_store+0xa4/0xb7
  [<c0197015>] subsys_attr_store+0x34/0x3d
  [<c0197299>] flush_write_buffer+0x3e/0x4a
  [<c01972fd>] sysfs_write_file+0x58/0x80
  [<c015da98>] vfs_write+0x148/0x14d
  [<c015db6e>] sys_write+0x51/0x80
  [<c010319f>] syscall_call+0x7/0xb
Freezing CPUs (at 0)...ok
eth1: Going into suspend...
NVRM: RmPowerManagement: 3
swsusp: FATAL: cannot find swap device, try swapon -a!
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.1 to 64
PCI: Setting latency timer of device 0000:00:1d.2 to 64
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 restarted, EHCI 1.00, driver 10 Dec 2004
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 11 (level, low) 
-> IRQ 11
ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 11 (level, low) 
-> IRQ 11
PCI: Setting latency timer of device 0000:00:1f.5 to 64
NVRM: RmPowerManagement: 4
eth1: Coming out of suspend...
PCI: Enabling device 0000:02:05.0 (0000 -> 0002)
ACPI: PCI Interrupt 0000:02:05.0[A] -> Link [LNKC] -> GSI 11 (level, low) 
-> IRQ 11
Restarting CPUs...ok
Restarting tasks... done
usb 2-2: USB disconnect, address 2
usb 2-2.1: USB disconnect, address 3
usb 2-2.3: USB disconnect, address 4
usb 2-2: new full speed USB device using uhci_hcd and address 5
hub 2-2:1.0: USB hub found
hub 2-2:1.0: 3 ports detected
ALPS Touchpad (Glidepoint) detected
   Disabling hardware tapping
input: AlpsPS/2 ALPS TouchPad on isa0060/serio1
usb 2-2.1: new full speed USB device using uhci_hcd and address 6
input: USB HID v1.10 Keyboard [Dell Dell USB Keyboard Hub] on 
usb-0000:00:1d.0-2.1
input: USB HID v1.10 Device [Dell Dell USB Keyboard Hub] on 
usb-0000:00:1d.0-2.1
usb 2-2.3: new low speed USB device using uhci_hcd and address 7
input: USB HID v1.10 Mouse [Logitech Optical USB Mouse] on 
usb-0000:00:1d.0-2.3

I use gentoo linux with kernel-2.6.11.4 kernel (not gentoo-kernel!) 
patched with acpi-20050309-2.6.11.diff.gz and boot with 
resume=swap:/dev/hda3 where hda3 is my swap patition. I have searched the 
web and I see that I am not the 1st one getting the same error message; 
the question is if anybody has come up with a remedy to this problem.

Thanks,

Ferenc



-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
