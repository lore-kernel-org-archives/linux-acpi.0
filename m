From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Fw: [Bugme-new] [Bug 4496] New: Interrupt-problem depends on
 sound-playing: irq 10: nobody cared!
Date: Wed, 25 May 2005 22:43:28 -0700
Message-ID: <20050525224328.734adc03.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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


This IRQ routing bug appears to be an ACPI thing.  Could someone
please reassign it?



Begin forwarded message:

Date: Thu, 14 Apr 2005 14:27:34 -0700
From: bugme-daemon-3NddpPZAyC0@public.gmane.org
To: bugme-new-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Subject: [Bugme-new] [Bug 4496] New: Interrupt-problem depends on sound-playing: irq 10: nobody cared!


http://bugme.osdl.org/show_bug.cgi?id=4496

           Summary: Interrupt-problem depends on sound-playing: irq 10:
                    nobody cared!
    Kernel Version: 6.2.11/6.2.11.6/6.2.11.7
            Status: NEW
          Severity: high
             Owner: perex-/Fr2/VpizcU@public.gmane.org
         Submitter: hannes-diethelm-goEDY2E6dbVyDzI6CaY1VQ@public.gmane.org


Hello!

Distribution:
Debian Sarge

Hardware Environment:
http://www.ieiworld.com/en/product_IPC.asp?model=ROCKY-3732
Whith dual P3 860Mhz /512Mb RAM

Problem Description:
Whith the kernel-image-2.6.8 from debian i had no problem. But now i tryed to
install bootsplash-3.1.4-2.6.11 whit kernel 6.2.11 first and then whit kernel
6.2.11.6 and 6.2.11.7. I think its not e bug of Bootsplash, it's one of the
kernel, but if you think it's one of bootsplash, i would install a normal kernel
and try it again.

Whith kernel 2.6.11, the PC stopps imediatly to work when i started sound (echo
h > /dev/dsp is eneught). Whit kernel 2.6.11.6 the PC Plays sound, but when the
soundcard is not working abaut 2h 45min, in the syslog these strings apears:

Apr  8 04:47:48 localhost kernel: irq 10: nobody cared!
Apr  8 04:47:48 localhost kernel:  [<c013783a>] __report_bad_irq+0x2a/0xa0
Apr  8 04:47:48 localhost kernel:  [<c01371a0>] handle_IRQ_event+0x30/0x70
Apr  8 04:47:48 localhost kernel:  [<c0137940>] note_interrupt+0x70/0xb0
Apr  8 04:47:48 localhost kernel:  [<c0137313>] __do_IRQ+0x133/0x140
Apr  8 04:47:48 localhost kernel:  [<c0104cf9>] do_IRQ+0x19/0x30
Apr  8 04:47:48 localhost kernel:  [<c010322e>] common_interrupt+0x1a/0x20
Apr  8 04:47:48 localhost kernel:  [<c01006d3>] default_idle+0x23/0x30
Apr  8 04:47:48 localhost kernel:  [<c010077f>] cpu_idle+0x5f/0x70
Apr  8 04:47:48 localhost kernel:  [<c04ee99d>] start_kernel+0x17d/0x1c0
Apr  8 04:47:48 localhost kernel:  [<c04ee390>] unknown_bootoption+0x0/0x1e0
Apr  8 04:47:48 localhost kernel: handlers:
Apr  8 04:47:48 localhost kernel: [<c0347170>] (snd_via82xx_interrupt+0x0/0xd0)
Apr  8 04:47:48 localhost kernel: Disabling IRQ #10 

This is no problem, but later when i try to start sound, these string's apears
and USB and network is dead (No mouse, the keyboard works but when i tryed to
switch to the console, the PC frezez totally):

Apr  8 06:08:09 localhost kernel: irq 18: nobody cared!
Apr  8 06:08:09 localhost kernel:  [<c013783a>] __report_bad_irq+0x2a/0xa0
Apr  8 06:08:09 localhost kernel:  [<c01371a0>] handle_IRQ_event+0x30/0x70
Apr  8 06:08:09 localhost kernel:  [<c0137940>] note_interrupt+0x70/0xb0
Apr  8 06:08:09 localhost kernel:  [<c0137313>] __do_IRQ+0x133/0x140
Apr  8 06:08:09 localhost kernel:  [<c0104cf9>] do_IRQ+0x19/0x30
Apr  8 06:08:09 localhost kernel:  [<c010322e>] common_interrupt+0x1a/0x20
Apr  8 06:08:09 localhost kernel: handlers:
Apr  8 06:08:09 localhost kernel: [<c02e44d0>] (usb_hcd_irq+0x0/0x70)
Apr  8 06:08:09 localhost kernel: [<c02b6e70>] (speedo_interrupt+0x0/0x230)
Apr  8 06:08:09 localhost kernel: Disabling IRQ #18 
...
Apr  8 06:08:40 localhost kernel: NETDEV WATCHDOG: eth0: transmit timed out

I have also tryed to start with the pci=routeirq argument, but the problem was
the same...

Somthing from the syslog with kernel 2.6.11.6:
Apr  8 02:01:07 localhost kernel: PCI: Using ACPI for IRQ routing
Apr  8 02:01:07 localhost kernel: ** PCI interrupts are no longer routed
automatically.  If this
Apr  8 02:01:07 localhost kernel: ** causes a device to stop working, it is
probably because the
Apr  8 02:01:07 localhost kernel: ** driver failed to call pci_enable_device().
 As a temporary
Apr  8 02:01:07 localhost kernel: ** workaround, the "pci=routeirq" argument
restores the old
Apr  8 02:01:07 localhost kernel: ** behavior.  If this argument makes the
device work again,
Apr  8 02:01:07 localhost kernel: ** please email the output of "lspci" to
bjorn.helgaas-VXdhtT5mjnY@public.gmane.org
Apr  8 02:01:07 localhost kernel: ** so I can fix the driver.
...
Apr  8 02:01:07 localhost kernel: eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://www.scyld.com/network/eepro100.html
Apr  8 02:01:07 localhost kernel: eepro100.c: $Revision: 1.36 $ 2000/11/17
Modified by Andrey V. Savochkin <saw-5bpFXmC1L3aJ4eUNlOKu3Q@public.gmane.org> and others
Apr  8 02:01:07 localhost kernel: ACPI: PCI interrupt 0000:00:0f.0[A] -> GSI 18
(level, low) -> IRQ 18
Apr  8 02:01:07 localhost kernel: eth0: 0000:00:0f.0, 00:08:9B:09:A9:4B, IRQ 18.
Apr  8 02:01:07 localhost kernel:   Board assembly 729757-006, Physical
connectors present: RJ45
Apr  8 02:01:07 localhost kernel:   Primary interface chip i82555 PHY #1.
Apr  8 02:01:07 localhost kernel:   General self-test: passed.
Apr  8 02:01:07 localhost kernel:   Serial sub-system self-test: passed.
Apr  8 02:01:07 localhost kernel:   Internal registers self-test: passed.
Apr  8 02:01:07 localhost kernel:   ROM checksum self-test: passed (0x04f4518b).
Apr  8 02:01:07 localhost kernel: ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 17
(level, low) -> IRQ 17
Apr  8 02:01:07 localhost kernel: eth1: 0000:00:10.0, 00:08:9B:09:A9:4C, IRQ 17.
Apr  8 02:01:07 localhost kernel:   Board assembly 729757-006, Physical
connectors present: RJ45
Apr  8 02:01:07 localhost kernel:   Primary interface chip i82555 PHY #1.
Apr  8 02:01:07 localhost kernel:   General self-test: passed.
Apr  8 02:01:07 localhost kernel:   Serial sub-system self-test: passed.
Apr  8 02:01:07 localhost kernel:   Internal registers self-test: passed.
Apr  8 02:01:07 localhost kernel:   ROM checksum self-test: passed (0x04f4518b).
...
Apr  8 02:01:07 localhost kernel: ALSA device list:
Apr  8 02:01:07 localhost kernel:   #0: VIA 82C686A/B rev50 with ALC200/200P at
0xb800, irq 10
...
Apr  8 04:47:48 localhost kernel: irq 10: nobody cared!
Apr  8 04:47:48 localhost kernel:  [<c013783a>] __report_bad_irq+0x2a/0xa0
Apr  8 04:47:48 localhost kernel:  [<c01371a0>] handle_IRQ_event+0x30/0x70
Apr  8 04:47:48 localhost kernel:  [<c0137940>] note_interrupt+0x70/0xb0
Apr  8 04:47:48 localhost kernel:  [<c0137313>] __do_IRQ+0x133/0x140
Apr  8 04:47:48 localhost kernel:  [<c0104cf9>] do_IRQ+0x19/0x30
Apr  8 04:47:48 localhost kernel:  [<c010322e>] common_interrupt+0x1a/0x20
Apr  8 04:47:48 localhost kernel:  [<c01006d3>] default_idle+0x23/0x30
Apr  8 04:47:48 localhost kernel:  [<c010077f>] cpu_idle+0x5f/0x70
Apr  8 04:47:48 localhost kernel:  [<c04ee99d>] start_kernel+0x17d/0x1c0
Apr  8 04:47:48 localhost kernel:  [<c04ee390>] unknown_bootoption+0x0/0x1e0
Apr  8 04:47:48 localhost kernel: handlers:
Apr  8 04:47:48 localhost kernel: [<c0347170>] (snd_via82xx_interrupt+0x0/0xd0)
Apr  8 04:47:48 localhost kernel: Disabling IRQ #10
...
Apr  8 06:08:09 localhost kernel: irq 18: nobody cared!
Apr  8 06:08:09 localhost kernel:  [<c013783a>] __report_bad_irq+0x2a/0xa0
Apr  8 06:08:09 localhost kernel:  [<c01371a0>] handle_IRQ_event+0x30/0x70
Apr  8 06:08:09 localhost kernel:  [<c0137940>] note_interrupt+0x70/0xb0
Apr  8 06:08:09 localhost kernel:  [<c0137313>] __do_IRQ+0x133/0x140
Apr  8 06:08:09 localhost kernel:  [<c0104cf9>] do_IRQ+0x19/0x30
Apr  8 06:08:09 localhost kernel:  [<c010322e>] common_interrupt+0x1a/0x20
Apr  8 06:08:09 localhost kernel: handlers:
Apr  8 06:08:09 localhost kernel: [<c02e44d0>] (usb_hcd_irq+0x0/0x70)
Apr  8 06:08:09 localhost kernel: [<c02b6e70>] (speedo_interrupt+0x0/0x230)
Apr  8 06:08:09 localhost kernel: Disabling IRQ #18
...
Apr  8 06:08:40 localhost kernel: NETDEV WATCHDOG: eth0: transmit timed out 

The output of /proc/interrupts:
           CPU0       CPU1       
  0:     120184     129949    IO-APIC-edge  timer
  1:        113         54    IO-APIC-edge  i8042
  7:          0          0    IO-APIC-edge  parport0
  9:          0          0   IO-APIC-level  acpi
 10:       7038       3544   IO-APIC-level  VIA686A
 11:        858          0   IO-APIC-level  uhci_hcd, uhci_hcd
 14:       4404       3709    IO-APIC-edge  ide0
 15:       1015       1062    IO-APIC-edge  ide1
 18:       6497         17   IO-APIC-level  ohci_hcd, eth0
 19:        478         72   IO-APIC-level  radeon@PCI:2:7:0
NMI:          0          0
LOC:     249903     250532
ERR:          0
MIS:          0 

The output of lspci:

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x]
(rev c4)
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
MVP3/Pro133x AGP]
0000:00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 40)
0000:00:07.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:07.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 1a)
0000:00:07.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 1a)
0000:00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
0000:00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97
Audio Controller (rev 50)
0000:00:0f.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev08)
0000:00:10.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev08)
0000:00:11.0 PCI bridge: Texas Instruments PCI2031 (rev 01)
0000:00:13.0 USB Controller: OPTi Inc. 82C861 (rev 10)
0000:01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS]
86C3265598/6326 (rev 0b)
0000:02:07.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon
9200PRO] (rev 01)
0000:02:07.1 Display controller: ATI Technologies Inc: Unknown device 5940 (rev01)

Whit kernel 2.6.11.7 it's abaut 10 minutes between i stopp the sound and
interrupt 11 is disabled but the problem is the same.
The syslog with kernel 2.6.11.7 and the argument pci=routeirq:

Apr 14 21:44:19 localhost kernel: irq 11: nobody cared!
Apr 14 21:44:19 localhost kernel:  [<c013783a>] __report_bad_irq+0x2a/0xa0
Apr 14 21:44:19 localhost kernel:  [<c01371a0>] handle_IRQ_event+0x30/0x70
Apr 14 21:44:19 localhost kernel:  [<c0137940>] note_interrupt+0x70/0xb0
Apr 14 21:44:19 localhost kernel:  [<c0137313>] __do_IRQ+0x133/0x140
Apr 14 21:44:19 localhost kernel:  [<c0104cf9>] do_IRQ+0x19/0x30
Apr 14 21:44:19 localhost kernel:  [<c010322e>] common_interrupt+0x1a/0x20
Apr 14 21:44:19 localhost kernel:  [<c01006d3>] default_idle+0x23/0x30
Apr 14 21:44:19 localhost kernel:  [<c010077f>] cpu_idle+0x5f/0x70
Apr 14 21:44:19 localhost kernel:  [<c04ee99d>] start_kernel+0x17d/0x1c0
Apr 14 21:44:19 localhost kernel:  [<c04ee390>] unknown_bootoption+0x0/0x1e0
Apr 14 21:44:19 localhost kernel: handlers:
Apr 14 21:44:19 localhost kernel: [<c02e44e0>] (usb_hcd_irq+0x0/0x70)
Apr 14 21:44:19 localhost kernel: [<c02e44e0>] (usb_hcd_irq+0x0/0x70)
Apr 14 21:44:19 localhost kernel: Disabling IRQ #11
...
Apr 14 22:13:01 localhost kernel: irq 10: nobody cared!
Apr 14 22:13:01 localhost kernel:  [<c013783a>] __report_bad_irq+0x2a/0xa0
Apr 14 22:13:01 localhost kernel:  [<c01371a0>] handle_IRQ_event+0x30/0x70
Apr 14 22:13:01 localhost kernel:  [<c0137940>] note_interrupt+0x70/0xb0
Apr 14 22:13:01 localhost kernel:  [<c0137313>] __do_IRQ+0x133/0x140
Apr 14 22:13:01 localhost kernel:  [<c0104cf9>] do_IRQ+0x19/0x30
Apr 14 22:13:01 localhost kernel:  [<c010322e>] common_interrupt+0x1a/0x20
Apr 14 22:13:01 localhost kernel:  [<c01006d3>] default_idle+0x23/0x30
Apr 14 22:13:01 localhost kernel:  [<c010077f>] cpu_idle+0x5f/0x70
Apr 14 22:13:01 localhost kernel:  [<c04ee99d>] start_kernel+0x17d/0x1c0
Apr 14 22:13:01 localhost kernel:  [<c04ee390>] unknown_bootoption+0x0/0x1e0
Apr 14 22:13:01 localhost kernel: handlers:
Apr 14 22:13:01 localhost kernel: [<c03471d0>] (snd_via82xx_interrupt+0x0/0xd0)
Apr 14 22:13:01 localhost kernel: Disabling IRQ #10
Apr 14 22:13:44 localhost kernel: eth0: TX underrun, threshold adjusted.
Apr 14 22:14:24 localhost last message repeated 17 times
Apr 14 22:14:53 localhost last message repeated 2 times
...
Apr 14 22:18:23 localhost kernel: irq 18: nobody cared!
Apr 14 22:18:23 localhost kernel:  [<c013783a>] __report_bad_irq+0x2a/0xa0
Apr 14 22:18:23 localhost kernel:  [<c01371a0>] handle_IRQ_event+0x30/0x70
Apr 14 22:18:23 localhost kernel:  [<c0137940>] note_interrupt+0x70/0xb0
Apr 14 22:18:23 localhost kernel:  [<c0137313>] __do_IRQ+0x133/0x140
Apr 14 22:18:23 localhost kernel:  [<c0104cf9>] do_IRQ+0x19/0x30
Apr 14 22:18:23 localhost kernel:  [<c010322e>] common_interrupt+0x1a/0x20
Apr 14 22:18:23 localhost kernel: handlers:
Apr 14 22:18:23 localhost kernel: [<c02e44e0>] (usb_hcd_irq+0x0/0x70)
Apr 14 22:18:23 localhost kernel: [<c02b6e80>] (speedo_interrupt+0x0/0x230)
Apr 14 22:18:23 localhost kernel: Disabling IRQ #18
Apr 14 22:18:32 localhost kernel: NETDEV WATCHDOG: eth0: transmit timed out
Apr 14 22:18:32 localhost kernel: eth0: Transmit timed out: status f048  0c00 at
669781/669841 command 000ca000.
Apr 14 22:18:38 localhost kernel: NETDEV WATCHDOG: eth0: transmit timed out
Apr 14 22:18:38 localhost kernel: eth0: Transmit timed out: status e050  0c00 at
669841/669901 command 0001a000.

It looks like an overflow... I have seen in bugzilla that some other users have
reported bugs that look like mine but with other symptomes:4311, 3808, 3257 It
could be the same probleme.
I hope i help you to make the kernel better! Sorry abaut my bad english...

If you understand german: I have opened a thread in debianforum.de:
http://www.debianforum.de/forum/viewtopic.php?t=44055

Greetings,
H.Diethelm

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.


-------------------------------------------------------
SF.Net email is sponsored by: GoToMeeting - the easiest way to collaborate
online with coworkers and clients while avoiding the high cost of travel and
communications. There is no equipment to buy and you can meet as often as
you want. Try it free.http://ads.osdn.com/?ad_id=7402&alloc_id=16135&op=click
