From: Thorsten Zachmann <t.zachmann-c61pB8mzqkY@public.gmane.org>
Subject: no sound after S3
Date: Fri, 5 Mar 2004 05:22:49 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200403041624.07079.t.zachmann@zagge.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hello all,

after suspend to RAM my sound is no longer working. When waking up I get the 
following messages:

Mar  4 16:12:46 zaglno kernel:  hwsleep-0300 [1146] acpi_enter_sleep_state: 
Entering sleep state [S3]
Mar  4 16:12:46 zaglno kernel: Back to C!
Mar  4 16:12:46 zaglno kernel: PM: Finishing up.
Mar  4 16:12:46 zaglno kernel: hda: Wakeup request inited, waiting for !BSY...
Mar  4 16:12:46 zaglno kernel: hda: start_power_step(step: 1000)
Mar  4 16:12:46 zaglno kernel: blk: queue dfc47600, I/O limit 4095Mb (mask 
0xffffffff)
Mar  4 16:12:46 zaglno kernel: hda: completing PM request, resume
Mar  4 16:12:46 zaglno kernel: hdc: Wakeup request inited, waiting for !BSY...
Mar  4 16:12:46 zaglno kernel: hdc: start_power_step(step: 1000)
Mar  4 16:12:46 zaglno kernel: hdc: completing PM request, resume
Mar  4 16:12:46 zaglno kernel: Restarting tasks... done
Mar  4 16:12:52 zaglno kernel: MCE: The hardware reports a non fatal, 
correctable incident occurred on
 CPU 0.
Mar  4 16:12:52 zaglno kernel: Bank 1: e200000000000000
Mar  4 16:12:54 zaglno kernel: irq 11: nobody cared!
Mar  4 16:12:54 zaglno kernel: Call Trace:
Mar  4 16:12:54 zaglno kernel:  [<c010d497>] __report_bad_irq+0x2a/0x8b
Mar  4 16:12:54 zaglno kernel:  [<c010d5a3>] note_interrupt+0x91/0xaf
Mar  4 16:12:54 zaglno kernel:  [<c010d839>] do_IRQ+0x10e/0x133
Mar  4 16:12:54 zaglno kernel:  [<c010bc74>] common_interrupt+0x18/0x20
Mar  4 16:12:54 zaglno kernel:  [<c010d42d>] handle_IRQ_event+0x24/0x64
Mar  4 16:12:54 zaglno kernel:  [<c010d7bf>] do_IRQ+0x94/0x133
Mar  4 16:12:54 zaglno kernel:  [<c010bc74>] common_interrupt+0x18/0x20
Mar  4 16:12:54 zaglno kernel:  [<c0127750>] do_softirq+0x40/0x9b
Mar  4 16:12:54 zaglno kernel:  [<c010d840>] do_IRQ+0x115/0x133
Mar  4 16:12:54 zaglno kernel:  [<c010bc74>] common_interrupt+0x18/0x20
Mar  4 16:12:54 zaglno kernel:  [<c010ddb5>] setup_irq+0x79/0xde
Mar  4 16:12:54 zaglno kernel:  [<e2970989>] snd_intel8x0_interrupt+0x0/0x27b 
[snd_intel8x0]
Mar  4 16:12:54 zaglno kernel:  [<c010d920>] request_irq+0x8f/0xd6
Mar  4 16:12:54 zaglno kernel:  [<e2973605>] snd_intel8x0_create+0x1d2/0x5e3 
[snd_intel8x0]
Mar  4 16:12:54 zaglno kernel:  [<e2970989>] snd_intel8x0_interrupt+0x0/0x27b 
[snd_intel8x0]
Mar  4 16:12:54 zaglno kernel:  [<e2973af3>] snd_intel8x0_probe+0xdd/0x28c 
[snd_intel8x0]
Mar  4 16:12:54 zaglno kernel:  [<c01745f0>] dput+0x93/0x240
Mar  4 16:12:54 zaglno kernel:  [<c01e5f71>] pci_device_probe_static+0x52/0x6f
Mar  4 16:12:54 zaglno kernel:  [<c01e5fc9>] __pci_device_probe+0x3b/0x4e
Mar  4 16:12:54 zaglno kernel:  [<c01e6008>] pci_device_probe+0x2c/0x56
Mar  4 16:12:54 zaglno kernel:  [<c023c4fb>] bus_match+0x3f/0x7a
Mar  4 16:12:54 zaglno kernel:  [<c023c645>] driver_attach+0x52/0x8f
Mar  4 16:12:54 zaglno kernel:  [<c023c8b2>] bus_add_driver+0x8b/0xb1
Mar  4 16:12:54 zaglno kernel:  [<c023cc89>] driver_register+0x2f/0x33
Mar  4 16:12:54 zaglno kernel:  [<c01e61d0>] pci_register_driver+0x5c/0x84
Mar  4 16:12:54 zaglno kernel:  [<e281d017>] alsa_card_intel8x0_init+0x17/0x67 
[snd_intel8x0]
Mar  4 16:12:54 zaglno kernel:  [<c01395a1>] sys_init_module+0x114/0x248
Mar  4 16:12:54 zaglno kernel:  [<c010b307>] syscall_call+0x7/0xb
Mar  4 16:12:54 zaglno kernel:
Mar  4 16:12:54 zaglno kernel: handlers:
Mar  4 16:12:54 zaglno kernel: [<e2970989>] (snd_intel8x0_interrupt+0x0/0x27b 
[snd_intel8x0])
Mar  4 16:12:54 zaglno kernel: Disabling IRQ #11

and sound is not working.

I unload usb and sound modules before going to suspend. 
I run a 2.6.3 kernel with the latest acpi patch. A cat /proc/interrupts is 
attached.

Thorsten

 # cat /proc/interrupts
           CPU0
  0:     711006          XT-PIC  timer
  1:       3280          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  6:          3          XT-PIC  eth0
  8:          2          XT-PIC  rtc
  9:       1032          XT-PIC  acpi
 11:     200000          XT-PIC  Intel 82801DB-ICH4
 12:       6116          XT-PIC  i8042
 14:       6975          XT-PIC  ide0
 15:       5382          XT-PIC  ide1
NMI:          0
LOC:     696979
ERR:          0
MIS:          0





-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
