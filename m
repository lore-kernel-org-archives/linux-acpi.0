From: Fionn Behrens <fionn-ZPjJJ+sDHmfddJNmlsFzeA@public.gmane.org>
Subject: acer tm100 ACPI woes: "nobody cared" again & strange battery events
Date: Fri, 05 Nov 2004 14:47:41 +0100
Message-ID: <cmg0bt$7na$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
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


Hello all,

I am about to try to get my wife's slightly aged Acer tm100 to run with=20
2.6.9 and ACPI. Everything is smooth so far except for two things: One=20
real show stopper and one annoyance.

1) the show stopper:
Below you see the tm100 irq layout right after bootup:
root@samt:~# cat /proc/interrupts
            CPU0
   0:      36199          XT-PIC  timer
   1:          8          XT-PIC  i8042
   2:          0          XT-PIC  cascade
   3:        255          XT-PIC  eth1
   8:          1          XT-PIC  rtc
   9:          0          XT-PIC  acpi
  10:         11          XT-PIC  yenta, yenta, uhci_hcd, ohci1394, eth0
  11:          0          XT-PIC  Intel 440MX, Intel 440MX Modem
  12:         90          XT-PIC  i8042
  14:       2191          XT-PIC  ide0
NMI:          0
ERR:          3

As you can see, acpi is using IRQ 9. When I suspend (S3) and wakeup I get=
=20
the following messages:

Nov  5 12:49:00 samt kernel: PM: Preparing system for suspend
Nov  5 12:49:00 samt kernel: Stopping tasks:=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|
Nov  5 12:49:00 samt kernel: PM: Entering state.
Nov  5 12:49:00 samt kernel: Back to C!
Nov  5 12:49:00 samt kernel: irq 9: nobody cared!
Nov  5 12:49:00 samt kernel:  [<c010724a>] __report_bad_irq+0x2a/0x90
Nov  5 12:49:00 samt kernel:  [<c0107340>] note_interrupt+0x70/0xb0
Nov  5 12:49:00 samt kernel:  [<c01075f0>] do_IRQ+0x120/0x130
Nov  5 12:49:00 samt kernel:  [<c01053c8>] common_interrupt+0x18/0x20
Nov  5 12:49:00 samt kernel:  [<c013007b>] unqueue_me+0x3b/0xb0
Nov  5 12:49:00 samt kernel:  [<c012046e>] __do_softirq+0x2e/0x90
Nov  5 12:49:00 samt kernel:  [<c01204f7>] do_softirq+0x27/0x30
Nov  5 12:49:00 samt kernel:  [<c01075ca>] do_IRQ+0xfa/0x130
Nov  5 12:49:00 samt kernel:  [<c01053c8>] common_interrupt+0x18/0x20
Nov  5 12:49:00 samt kernel:  [<c0134ca8>] suspend_enter+0x38/0x50
Nov  5 12:49:00 samt kernel:  [<c0134d84>] enter_state+0x64/0xb0
Nov  5 12:49:00 samt kernel:  [<c02020c9>] acpi_suspend+0x3e/0x4d
Nov  5 12:49:00 samt kernel:  [<c0202478>] acpi_system_write_sleep+0x60/0=
x8b
Nov  5 12:49:00 samt kernel:  [<c020248d>] acpi_system_write_sleep+0x75/0=
x8b
Nov  5 12:49:00 samt kernel:  [<c0155a68>] vfs_write+0xb8/0x130
Nov  5 12:49:00 samt kernel:  [<c0154f99>] filp_close+0x59/0x90
Nov  5 12:49:00 samt cardmgr[1467]: executing: './network suspend eth1'
Nov  5 12:49:00 samt kernel:  [<c0155bb1>] sys_write+0x51/0x80
Nov  5 12:49:00 samt kernel:  [<c010525b>] syscall_call+0x7/0xb
Nov  5 12:49:00 samt kernel: handlers:
Nov  5 12:49:00 samt kernel: [<c01eb827>] (acpi_irq+0x0/0x16)
Nov  5 12:49:00 samt kernel: Disabling IRQ #9
Nov  5 12:49:00 samt kernel: PM: Finishing up.
Nov  5 12:49:00 samt kernel: ACPI: PCI interrupt 0000:00:00.1[B] -> GSI 1=
1=20
(level, low) -> IRQ 11
Nov  5 12:49:00 samt kernel: PCI: Setting latency timer of device=20
0000:00:00.1 to 64
Nov  5 12:49:00 samt kernel: ACPI: PCI interrupt 0000:00:00.2[B] -> GSI 1=
1=20
(level, low) -> IRQ 11
Nov  5 12:49:00 samt kernel: PCI: Setting latency timer of device=20
0000:00:00.2 to 64
Nov  5 12:49:00 samt kernel: eth0: link down
Nov  5 12:49:00 samt kernel: ACPI: PCI interrupt 0000:00:05.0[A] -> GSI 1=
0=20
(level, low) -> IRQ 10
Nov  5 12:49:00 samt kernel: hub 1-0:1.0: reactivate --> -22
Nov  5 12:49:00 samt kernel: Restarting tasks... done

As you can see, IRQ 9 gets lost here and consequently, the next ACPI even=
t=20
(e.g. lid button) causes a system freeze. I dug the ML and found the "irq=
=20
routing after s3 ssuspend patch by Nathan Bryant but it seems to be in=20
2.6.9 already. I also tried the "pci device resume" patch from Stefan=20
D=F6singer, with no effect. Last but not least I tried various (but proba=
bly=20
not all) kernel options like noapic, lapic and even acpi_sci - no luck.

I'd appreciate any hint on what I could try to circumvent this problem. I=
=20
guess mangling the DSDT could be helpful but I have no idea how to begin =

with that. So I you have an idea or patch for me to try, please dont=20
hesitate to write a note.

---------------

2) the annoyance: The tm100, as opposed to any other laptop I know, begin=
s=20
to emit lots of acpi battery events when the battery module is loaded. At=
=20
least once every SECOND events like this show up in the logs:

[Thu Oct 28 20:57:55] BEGIN HANDLER MESSAGES
[Thu Oct 28 20:57:55] END HANDLER MESSAGES
[Thu Oct 28 20:57:55] action exited with status 0
[Thu Oct 28 20:57:55] completed event "battery BAT0 00000080 00000001"
[Thu Oct 28 20:57:55] received event "battery BAT0 00000080 00000001"
[Thu Oct 28 20:57:55] executing action "/etc/acpi/actions/lm_battery.sh=20
battery BAT0 00000080 00000001"
[Thu Oct 28 20:57:55] BEGIN HANDLER MESSAGES
[Thu Oct 28 20:57:55] END HANDLER MESSAGES
[Thu Oct 28 20:57:55] action exited with status 0
[Thu Oct 28 20:57:55] completed event "battery BAT0 00000080 00000001"
[Thu Oct 28 20:57:56] received event "battery BAT0 00000080 00000001"
[Thu Oct 28 20:57:56] executing action "/etc/acpi/actions/lm_battery.sh=20
battery BAT0 00000080 00000001"

Is this a bug in the acpi code or in the laptop? Any idea how this could =

be toned down to a sensible amount of events?

---------------

I'll glady provide any extra information you might ask for. Thanks to you=
=20
all for doing such a great job with Linux-ACPI.

br,
	Fionn



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
