From: Ian Pilcher <i.pilcher-Wuw85uim5zDR7s880joybQ@public.gmane.org>
Subject: 2.6.1 - IRQ routing regression on Abit VP6
Date: Tue, 13 Jan 2004 22:42:06 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4004C89E.60703@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

2.6.0 works fine on this hardware, including the twitchy built-in USB
controllers.

Loading the uhci-hcd module on 2.6.1 gives me the following:

drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface 
driver v2.1
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: irq 225, io base 00009400
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
uhci_hcd 0000:00:07.3: UHCI Host Controller
uhci_hcd 0000:00:07.3: irq 225, io base 00009800
uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
hub 1-0:1.0: new USB device on port 1, assigned address 2
APIC error on CPU1: 00(40)
APIC error on CPU1: 40(40)
APIC error on CPU1: 40(40)
APIC error on CPU1: 40(40)
APIC error on CPU1: 40(40)
APIC error on CPU1: 40(40)
APIC error on CPU1: 40(40)
APIC error on CPU0: 00(40)
APIC error on CPU1: 40(40)
APIC error on CPU1: 40(40)
APIC error on CPU1: 40(40)
APIC error on CPU1: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU1: 40(40)
APIC error on CPU1: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU1: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU1: 40(40)
irq 177: nobody cared!
Call Trace:
  [<c010d74a>] __report_bad_irq+0x2a/0x90
  [<c010d840>] note_interrupt+0x70/0xb0
  [<c010dc35>] do_IRQ+0x195/0x220
  [<c011b7ed>] smp_apic_timer_interrupt+0xdd/0x150
  [<c0105000>] rest_init+0x0/0x80
  [<c010bc24>] common_interrupt+0x18/0x20
  [<c0108ac0>] default_idle+0x0/0xc0
  [<c0105000>] rest_init+0x0/0x80
  [<c0108a19>] hlt_idle+0x29/0x40
  [<c0108bbb>] cpu_idle+0x3b/0x50
  [<c03aa4a0>] unknown_bootoption+0x0/0x120
  [<c03aa940>] start_kernel+0x1b0/0x200
  [<c03aa4a0>] unknown_bootoption+0x0/0x120

handlers:
[<c0263d00>] (ide_intr+0x0/0x2c0)
[<c0263d00>] (ide_intr+0x0/0x2c0)
Disabling IRQ #177
usb 1-1: control timeout on ep0out
uhci_hcd 0000:00:07.2: Unlink after no-IRQ?  Different ACPI or APIC 
settings may help.

And so on, until I shut down the system.

The 20031203 ACPI patch fixes the problem.

-- 
========================================================================
Ian Pilcher                                        i.pilcher-Wuw85uim5zDR7s880joybQ@public.gmane.org
========================================================================



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
