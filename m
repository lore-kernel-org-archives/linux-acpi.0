From: "Georg C. F. Greve" <greve-mXXj517/zsQ@public.gmane.org>
Subject: VGA patch by Bruno Ducrot -- no success yet
Date: Thu, 12 Feb 2004 22:38:24 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m3u11wnflb.fsf@reason.gnu-hamburg>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--=-=-=

Hi Bruno,

thanks for your patch [*] to implement the ACPI VGA display
extensions, as promised, I gave it a shot on my machine with Linux
kernel 2.6.2 (swsusp2, ACPI20040116, ACPI/APIC fix).

The patch applied cleanly and the kernel compiled fine.


During boot, things look not too bad

 ACPI: AC Adapter [AC0] (on-line)
 ACPI: Battery Slot [BAT0] (battery present)
 ACPI: Power Button (FF) [PWRF]
 ACPI: Sleep Button (CM) [SLPB]
 ACPI: Lid Switch [LID]
 ACPI: Fan [FN00] (off)
 ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
 ACPI: Processor [CPU1] (supports C1 C2 C3, 8 throttling states)
 ACPI: Thermal Zone [THRM] (53 C)
 Asus Laptop ACPI Extras version 0.27
   M2N model detected, supported


Doing a tree /proc/acpi/video/ shows

 /proc/acpi/video/
 `-- VGA
     |-- CRTD
     |   |-- EDID
     |   |-- brightness
     |   |-- info
     |   `-- state
     |-- LCDD
     |   |-- EDID
     |   |-- brightness
     |   |-- info
     |   `-- state
     |-- POST
     |-- POST_info
     |-- ROM
     `-- info

(is it normal that CRT and LCD have another "D" at the end?)


Doing a cat on the different nodes gives for LCD:

cat ./LCDD/EDID
<not supported>
 
cat ./LCDD/brightness
<not supported>
 
cat ./LCDD/state
state:     0x1f
query:     0x01
 
cat ./LCDD/info
device_id:    0x0400
type:         UNKNOWN
known by bios: yes


And for CRT:

cat ./CRTD/EDID
<not supported>
 
cat ./CRTD/brightness
<not supported>
 
cat ./CRTD/state
state:     0x1d
query:     0x00
 
cat ./CRTD/info
device_id:    0x0100
type:         CRT
known by bios: yes


And finally POST:

cat ./POST
<not supported>
 
cat ./POST_info
<not supported>
 
cat ./ROM
<TODO>
 
cat ./info
Switching heads:              yes
Video ROM:                    no
Device to be POSTed on boot:  no
 

Suspend to RAM seemed to work fine, however, there was the usual
trouble upon powering back up:

--=-=-=
Content-Disposition: attachment

Feb 12 21:54:25 myhost kernel: Back to C!
Feb 12 21:54:25 myhost kernel: PM: Finishing up.
Feb 12 21:54:25 myhost kernel: PCI: Enabling device 0000:00:1f.5 (0005 -> 0007)
Feb 12 21:54:25 myhost kernel: PCI: Setting latency timer of device 0000:00:1f.5 to 64
Feb 12 21:54:25 myhost kernel: AC'97 warm reset still in progress? [0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_write 0: semaphore is not ready for register 0x26
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_write 0: semaphore is not ready for register 0x0
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_write 0: semaphore is not ready for register 0x26
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_write 0: semaphore is not ready for register 0x20
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_write 0: semaphore is not ready for register 0x26
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_write 0: semaphore is not ready for register 0x2
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_read 0: semaphore is not ready for register 0x2
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_read 0: semaphore is not ready for register 0x2
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_read 0: semaphore is not ready for register 0x2
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_read 0: semaphore is not ready for register 0x2
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_read 0: semaphore is not ready for register 0x2
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_read 0: semaphore is not ready for register 0x2
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_read 0: semaphore is not ready for register 0x2
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_read 0: semaphore is not ready for register 0x2
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_read 0: semaphore is not ready for register 0x2
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_read 0: semaphore is not ready for register 0x2
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_write 0: semaphore is not ready for register 0x2
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_read 0: semaphore is not ready for register 0x2
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_write 0: semaphore is not ready for register 0x4
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_read 0: semaphore is not ready for register 0x4
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_write 0: semaphore is not ready for register 0x6
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_read 0: semaphore is not ready for register 0x6
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_write 0: semaphore is not ready for register 0xa
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_read 0: semaphore is not ready for register 0xa
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_write 0: semaphore is not ready for register 0xc
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_read 0: semaphore is not ready for register 0xc
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_write 0: semaphore is not ready for register 0xe
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_read 0: semaphore is not ready for register 0xe
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_write 0: semaphore is not ready for register 0x10
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_read 0: semaphore is not ready for register 0x10
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_write 0: semaphore is not ready for register 0x12
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_read 0: semaphore is not ready for register 0x12
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_write 0: semaphore is not ready for register 0x14
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_read 0: semaphore is not ready for register 0x14
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_write 0: semaphore is not ready for register 0x16
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_read 0: semaphore is not ready for register 0x16
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_write 0: semaphore is not ready for register 0x18
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_read 0: semaphore is not ready for register 0x18
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_write 0: semaphore is not ready for register 0x1a
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_read 0: semaphore is not ready for register 0x1a
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_write 0: semaphore is not ready for register 0x1c
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_read 0: semaphore is not ready for register 0x1c
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_write 0: semaphore is not ready for register 0x20
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_read 0: semaphore is not ready for register 0x20
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_write 0: semaphore is not ready for register 0x22
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_read 0: semaphore is not ready for register 0x22
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_write 0: semaphore is not ready for register 0x2a
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_read 0: semaphore is not ready for register 0x2a
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_write 0: semaphore is not ready for register 0x2c
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_read 0: semaphore is not ready for register 0x2c
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_write 0: semaphore is not ready for register 0x32
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_read 0: semaphore is not ready for register 0x32
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_write 0: semaphore is not ready for register 0x3a
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_read 0: semaphore is not ready for register 0x3a
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_write 0: semaphore is not ready for register 0x2a
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_write 0: semaphore is not ready for register 0x2a
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_write 0: semaphore is not ready for register 0x3a
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_write 0: semaphore is not ready for register 0x2a
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_write 1: semaphore is not ready for register 0x26
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_write 1: semaphore is not ready for register 0x0
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_write 1: semaphore is not ready for register 0x26
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_write 1: semaphore is not ready for register 0x20
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_write 1: semaphore is not ready for register 0x26
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_write 1: semaphore is not ready for register 0x2
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_read 1: semaphore is not ready for register 0x2
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_read 1: semaphore is not ready for register 0x2
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_read 1: semaphore is not ready for register 0x2
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_read 1: semaphore is not ready for register 0x2
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_read 1: semaphore is not ready for register 0x2
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_read 1: semaphore is not ready for register 0x2
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_read 1: semaphore is not ready for register 0x2
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_read 1: semaphore is not ready for register 0x2
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_read 1: semaphore is not ready for register 0x2
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_read 1: semaphore is not ready for register 0x2
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_write 1: semaphore is not ready for register 0x1c
Feb 12 21:54:25 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 12 21:54:25 myhost kernel: codec_read 1: semaphore is not ready for register 0x1c
Feb 12 21:54:25 myhost kernel: hda: Wakeup request inited, waiting for !BSY...
Feb 12 21:54:25 myhost kernel: hda: start_power_step(step: 1000)
Feb 12 21:54:25 myhost kernel: blk: queue df4f2400, I/O limit 4095Mb (mask 0xffffffff)
Feb 12 21:54:25 myhost kernel: hda: completing PM request, resume
Feb 12 21:54:25 myhost kernel: hdc: Wakeup request inited, waiting for !BSY...
Feb 12 21:54:25 myhost kernel: hdc: start_power_step(step: 1000)
Feb 12 21:54:25 myhost kernel: hdc: completing PM request, resume
Feb 12 21:54:26 myhost kernel: Synaptics Touchpad, model: 1
Feb 12 21:54:26 myhost kernel:  Firmware: 4.6
Feb 12 21:54:26 myhost kernel:  180 degree mounted touchpad
Feb 12 21:54:26 myhost kernel:  Sensor: 18
Feb 12 21:54:26 myhost kernel:  new absolute packet format
Feb 12 21:54:26 myhost kernel:  Touchpad has extended capability bits
Feb 12 21:54:26 myhost kernel:  -> four buttons
Feb 12 21:54:26 myhost kernel:  -> multifinger detection
Feb 12 21:54:26 myhost kernel:  -> palm detection
Feb 12 21:54:27 myhost kernel: MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Feb 12 21:54:27 myhost kernel: Bank 1: f200000000000135

--=-=-=
Content-Disposition: inline


and the display remaining dead -- unfortunately.


But then I'm seeing new stuff which may be related to the new driver
as that is the only thing that changed:


--=-=-=
Content-Disposition: attachment

Feb 12 21:54:30 myhost kernel: Uninitialised timer!
Feb 12 21:54:30 myhost kernel: This is just a warning.  Your computer is OK
Feb 12 21:54:30 myhost kernel: function=0x00000000, data=0x0
Feb 12 21:54:30 myhost kernel: Call Trace:
Feb 12 21:54:30 myhost kernel:  [check_timer_failed+99/101] check_timer_failed+0x63/0x65
Feb 12 21:54:30 myhost kernel:  [del_timer+26/135] del_timer+0x1a/0x87
Feb 12 21:54:30 myhost kernel:  [_end+541737980/1069013880] ehci_stop+0x73/0xde [ehci_hcd]
Feb 12 21:54:30 myhost kernel:  [preempt_schedule+42/67] preempt_schedule+0x2a/0x43
Feb 12 21:54:30 myhost kernel:  [printk+298/378] printk+0x12a/0x17a
Feb 12 21:54:30 myhost kernel:  [usb_hcd_pci_remove+148/362] usb_hcd_pci_remove+0x94/0x16a
Feb 12 21:54:31 myhost kernel:  [usb_hcd_pci_probe+714/1182] usb_hcd_pci_probe+0x2ca/0x49e
Feb 12 21:54:31 myhost kernel:  [sys_select+325/1202] sys_select+0x145/0x4b2
Feb 12 21:54:31 myhost kernel:  [pci_device_probe_static+82/99] pci_device_probe_static+0x52/0x63
Feb 12 21:54:31 myhost kernel:  [__pci_device_probe+59/78] __pci_device_probe+0x3b/0x4e
Feb 12 21:54:31 myhost kernel:  [pci_device_probe+44/74] pci_device_probe+0x2c/0x4a
Feb 12 21:54:31 myhost kernel:  [bus_match+63/106] bus_match+0x3f/0x6a
Feb 12 21:54:31 myhost kernel:  [driver_attach+86/128] driver_attach+0x56/0x80
Feb 12 21:54:31 myhost kernel:  [bus_add_driver+139/157] bus_add_driver+0x8b/0x9d
Feb 12 21:54:31 myhost kernel:  [driver_register+47/51] driver_register+0x2f/0x33
Feb 12 21:54:31 myhost kernel:  [pci_register_driver+92/132] pci_register_driver+0x5c/0x84
Feb 12 21:54:31 myhost kernel:  [_end+541002651/1069013880] init+0x23/0x30 [ehci_hcd]
Feb 12 21:54:31 myhost kernel:  [sys_init_module+279/552] sys_init_module+0x117/0x228
Feb 12 21:54:31 myhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb 12 21:54:31 myhost kernel:

--=-=-=
Content-Disposition: inline



--=-=-=
Content-Disposition: attachment

Feb 12 21:54:31 myhost kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000048
Feb 12 21:54:31 myhost kernel:  printing eip:
Feb 12 21:54:31 myhost kernel: e0922c7c
Feb 12 21:54:31 myhost kernel: *pde = 00000000
Feb 12 21:54:31 myhost kernel: Oops: 0000 [#1]
Feb 12 21:54:31 myhost kernel: CPU:    0
Feb 12 21:54:31 myhost kernel: EIP:    0060:[_end+541730804/1069013880]    Not tainted
Feb 12 21:54:31 myhost kernel: EFLAGS: 00010002
Feb 12 21:54:31 myhost kernel: EIP is at scan_async+0x42/0x124 [ehci_hcd]
Feb 12 21:54:31 myhost kernel: eax: 00000000   ebx: deb9c800   ecx: c03ec5fc   edx: 00000000
Feb 12 21:54:31 myhost kernel: esi: 00000000   edi: deb9c800   ebp: ffffffed   esp: d4cc7dcc
Feb 12 21:54:31 myhost kernel: ds: 007b   es: 007b   ss: 0068
Feb 12 21:54:31 myhost kernel: Process modprobe (pid: 1674, threadinfo=d4cc6000 task=d50126a0)
Feb 12 21:54:31 myhost kernel: Stack: deb9c9f8 c010a2ac d50126a0 00000000 00000000 deb9c800 00000000 deb9c864
Feb 12 21:54:31 myhost kernel:        ffffffed e0924a6f deb9c800 00000000 d4cc6000 deb9c800 e09248bc deb9c800
Feb 12 21:54:31 myhost kernel:        00000000 00005cf0 3dffde7b 00000001 d50126a0 d5012864 d4cc6000 00000246
Feb 12 21:54:31 myhost kernel: Call Trace:
Feb 12 21:54:31 myhost kernel:  [dump_stack+28/32] dump_stack+0x1c/0x20
Feb 12 21:54:31 myhost kernel:  [_end+541738471/1069013880] ehci_work+0x35/0xbf [ehci_hcd]
Feb 12 21:54:31 myhost kernel:  [_end+541738036/1069013880] ehci_stop+0xab/0xde [ehci_hcd]
Feb 12 21:54:31 myhost kernel:  [preempt_schedule+42/67] preempt_schedule+0x2a/0x43
Feb 12 21:54:31 myhost kernel:  [printk+298/378] printk+0x12a/0x17a
Feb 12 21:54:31 myhost kernel:  [usb_hcd_pci_remove+148/362] usb_hcd_pci_remove+0x94/0x16a
Feb 12 21:54:31 myhost kernel:  [usb_hcd_pci_probe+714/1182] usb_hcd_pci_probe+0x2ca/0x49e
Feb 12 21:54:31 myhost kernel:  [sys_select+325/1202] sys_select+0x145/0x4b2
Feb 12 21:54:31 myhost kernel:  [pci_device_probe_static+82/99] pci_device_probe_static+0x52/0x63
Feb 12 21:54:31 myhost kernel:  [__pci_device_probe+59/78] __pci_device_probe+0x3b/0x4e
Feb 12 21:54:31 myhost kernel:  [pci_device_probe+44/74] pci_device_probe+0x2c/0x4a
Feb 12 21:54:31 myhost kernel:  [bus_match+63/106] bus_match+0x3f/0x6a
Feb 12 21:54:31 myhost kernel:  [driver_attach+86/128] driver_attach+0x56/0x80
Feb 12 21:54:31 myhost kernel:  [bus_add_driver+139/157] bus_add_driver+0x8b/0x9d
Feb 12 21:54:31 myhost kernel:  [driver_register+47/51] driver_register+0x2f/0x33
Feb 12 21:54:31 myhost kernel:  [pci_register_driver+92/132] pci_register_driver+0x5c/0x84
Feb 12 21:54:31 myhost kernel:  [_end+541002651/1069013880] init+0x23/0x30 [ehci_hcd]
Feb 12 21:54:31 myhost kernel:  [sys_init_module+279/552] sys_init_module+0x117/0x228
Feb 12 21:54:31 myhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb 12 21:54:31 myhost kernel:

--=-=-=
Content-Disposition: inline



--=-=-=
Content-Disposition: attachment

Feb 12 21:54:31 myhost kernel: Code: 8b 70 48 85 f6 74 6d 8d 6e 4c 8b 56 4c 39 ea 74 40 8b 87 24
Feb 12 21:54:31 myhost kernel:  <6>note: modprobe[1674] exited with preempt_count 1
Feb 12 21:54:31 myhost kernel: bad: scheduling while atomic!
Feb 12 21:54:31 myhost kernel: Call Trace:
Feb 12 21:54:31 myhost kernel:  [schedule+1422/1427] schedule+0x58e/0x593
Feb 12 21:54:31 myhost kernel:  [unmap_page_range+67/105] unmap_page_range+0x43/0x69
Feb 12 21:54:31 myhost kernel:  [unmap_vmas+432/520] unmap_vmas+0x1b0/0x208
Feb 12 21:54:31 myhost kernel:  [exit_mmap+124/400] exit_mmap+0x7c/0x190
Feb 12 21:54:31 myhost kernel:  [mmput+102/181] mmput+0x66/0xb5
Feb 12 21:54:31 myhost kernel:  [do_exit+360/1288] do_exit+0x168/0x508
Feb 12 21:54:31 myhost kernel:  [do_page_fault+0/1292] do_page_fault+0x0/0x50c
Feb 12 21:54:31 myhost kernel:  [do_divide_error+0/250] do_divide_error+0x0/0xfa
Feb 12 21:54:31 myhost kernel:  [do_page_fault+472/1292] do_page_fault+0x1d8/0x50c
Feb 12 21:54:31 myhost kernel:  [__print_symbol+63/350] __print_symbol+0x3f/0x15e
Feb 12 21:54:31 myhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb 12 21:54:31 myhost kernel:  [recalc_task_prio+144/426] recalc_task_prio+0x90/0x1aa
Feb 12 21:54:31 myhost kernel:  [_end+541435802/1069013880] snd_pcm_lib_write1+0x30e/0x4a6 [snd_pcm]
Feb 12 21:54:31 myhost kernel:  [recalc_task_prio+144/426] recalc_task_prio+0x90/0x1aa
Feb 12 21:54:31 myhost kernel:  [schedule+795/1427] schedule+0x31b/0x593
Feb 12 21:54:31 myhost kernel:  [do_page_fault+0/1292] do_page_fault+0x0/0x50c
Feb 12 21:54:31 myhost kernel:  [error_code+45/56] error_code+0x2d/0x38
Feb 12 21:54:31 myhost kernel:  [_end+541730804/1069013880] scan_async+0x42/0x124 [ehci_hcd]
Feb 12 21:54:31 myhost kernel:  [dump_stack+28/32] dump_stack+0x1c/0x20
Feb 12 21:54:31 myhost kernel:  [_end+541738471/1069013880] ehci_work+0x35/0xbf [ehci_hcd]
Feb 12 21:54:31 myhost kernel:  [_end+541738036/1069013880] ehci_stop+0xab/0xde [ehci_hcd]
Feb 12 21:54:31 myhost kernel:  [preempt_schedule+42/67] preempt_schedule+0x2a/0x43
Feb 12 21:54:31 myhost kernel:  [printk+298/378] printk+0x12a/0x17a
Feb 12 21:54:31 myhost kernel:  [usb_hcd_pci_remove+148/362] usb_hcd_pci_remove+0x94/0x16a
Feb 12 21:54:31 myhost kernel:  [usb_hcd_pci_probe+714/1182] usb_hcd_pci_probe+0x2ca/0x49e
Feb 12 21:54:31 myhost kernel:  [sys_select+325/1202] sys_select+0x145/0x4b2
Feb 12 21:54:31 myhost kernel:  [pci_device_probe_static+82/99] pci_device_probe_static+0x52/0x63
Feb 12 21:54:31 myhost kernel:  [__pci_device_probe+59/78] __pci_device_probe+0x3b/0x4e
Feb 12 21:54:31 myhost kernel:  [pci_device_probe+44/74] pci_device_probe+0x2c/0x4a
Feb 12 21:54:31 myhost kernel:  [bus_match+63/106] bus_match+0x3f/0x6a
Feb 12 21:54:31 myhost kernel:  [driver_attach+86/128] driver_attach+0x56/0x80
Feb 12 21:54:31 myhost kernel:  [bus_add_driver+139/157] bus_add_driver+0x8b/0x9d
Feb 12 21:54:31 myhost kernel:  [driver_register+47/51] driver_register+0x2f/0x33
Feb 12 21:54:31 myhost kernel:  [pci_register_driver+92/132] pci_register_driver+0x5c/0x84
Feb 12 21:54:31 myhost kernel:  [_end+541002651/1069013880] init+0x23/0x30 [ehci_hcd]
Feb 12 21:54:31 myhost kernel:  [sys_init_module+279/552] sys_init_module+0x117/0x228
Feb 12 21:54:31 myhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb 12 21:54:31 myhost kernel:

--=-=-=
Content-Disposition: inline



And then there is one that seems definitely related to the new driver:


--=-=-=
Content-Disposition: attachment

Feb 12 21:56:32 myhost kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004
Feb 12 21:56:32 myhost kernel:  printing eip:
Feb 12 21:56:32 myhost kernel: c020e756
Feb 12 21:56:32 myhost kernel: *pde = 00000000
Feb 12 21:56:32 myhost kernel: Oops: 0000 [#2]
Feb 12 21:56:32 myhost kernel: CPU:    0
Feb 12 21:56:32 myhost kernel: EIP:    0060:[acpi_video_device_write_brightness+188/248]    Not tainted
Feb 12 21:56:32 myhost kernel: EFLAGS: 00010246
Feb 12 21:56:32 myhost kernel: EIP is at acpi_video_device_write_brightness+0xbc/0xf8
Feb 12 21:56:32 myhost kernel: eax: df5e8820   ebx: 00000003   ecx: 00000000   edx: 00000000
Feb 12 21:56:32 myhost kernel: esi: d4a5ff58   edi: 080e940b   ebp: 00000000   esp: d4a5ff4c
Feb 12 21:56:32 myhost kernel: ds: 007b   es: 007b   ss: 0068
Feb 12 21:56:32 myhost kernel: Process bash (pid: 1962, threadinfo=d4a5e000 task=d4d26080)
Feb 12 21:56:32 myhost kernel: Stack: d50ae91c 00000014 df5e8820 000a3032 c020e69a d4dfec80 d4dfeca0 00000003
Feb 12 21:56:32 myhost kernel:        c015b3fc d4dfec80 080e9408 00000003 d4dfeca0 d4dfec80 d50ae880 d4dfec80
Feb 12 21:56:32 myhost kernel:        00000000 fffffff7 d4a5e000 c015b620 d4dfec80 080e9408 00000003 d4dfeca0
Feb 12 21:56:32 myhost kernel: Call Trace:
Feb 12 21:56:32 myhost kernel:  [acpi_video_device_write_brightness+0/248] acpi_video_device_write_brightness+0x0/0xf8
Feb 12 21:56:32 myhost kernel:  [vfs_write+176/281] vfs_write+0xb0/0x119
Feb 12 21:56:32 myhost kernel:  [sys_write+85/358] sys_write+0x55/0x166
Feb 12 21:56:32 myhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb 12 21:56:32 myhost kernel:
Feb 12 21:56:32 myhost kernel: Code: 3b 4a 04 7d 2d 8b 42 08 8b 74 24 04 3b 34 88 75 1b 56 ff 74

--=-=-=
Content-Disposition: inline



Hope this helps with the debugging... :-)

Regards,
Georg


P.S. Oh yeah, machine is ASUS M2N, Intel 855GM, more info:
     http://bugme.osdl.org/show_bug.cgi?id=1774#c3

[*]  http://bugme.osdl.org/show_bug.cgi?id=1944

-- 
Georg C. F. Greve                                       <greve-mXXj517/zsQ@public.gmane.org>
Free Software Foundation Europe	                 (http://fsfeurope.org)
Brave GNU World	                           (http://brave-gnu-world.org)

--=-=-=--


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
