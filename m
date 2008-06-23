From: "Null Ack" <nullack@gmail.com>
Subject: Via Rhine II Looses Eth0 After ACPI
Date: Mon, 23 Jun 2008 22:13:28 +1000
Message-ID: <40ef7d130806230513w10727e9cybec253c9cfd0c276@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.233]:35057 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752715AbYFWMN2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jun 2008 08:13:28 -0400
Received: by rv-out-0506.google.com with SMTP id k40so7035045rvb.1
        for <linux-acpi@vger.kernel.org>; Mon, 23 Jun 2008 05:13:28 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Gday everyone. I have an ASUS K8V-VM motherboard which uses the VIA
K8M890 / VIA VT8237A chipset and it has the Via Rhine II integrated
NIC. I have a problem where the kernel shuts down IRQ 23 as part of
ACPI activity and from there on in I get continued eth0 timeouts on my
NIC. The via-rhine module is on IRQ 23. My wired ethernet will not
come back from doing a network down / up, the module has to be
manually removed and reloaded or a reboot has to occur to fix it.
Currently Im on Ubuntu Hardy 2.6.24-19 but I also did my own compile
of a vanilla 2.6.25.8 kernel as a test - it has the same exact
problem.

I'm reluctant to turn off ACPI all together and was hoping a fix might
be able to be done please? I have spent some days looking for fixes
but none appeared. I'm learning Linux but I will follow any diagnostic
procedures that might be required to give people more information.

The kernel log looks like this:

Jun 21 03:04:07 ppp kernel: [ 57.447218] eth0: no IPv6 routers present
Jun 21 04:29:46 ppp kernel: [ 5193.747505] irq 23: nobody cared (try
booting with the "irqpoll" option)
Jun 21 04:29:46 ppp kernel: [ 5193.747514] Pid: 0, comm: swapper
Tainted: P 2.6.24-19-generic #1
Jun 21 04:29:46 ppp kernel: [ 5193.747516]
Jun 21 04:29:46 ppp kernel: [ 5193.747517] Call Trace:
Jun 21 04:29:46 ppp kernel: [ 5193.747519] <IRQ>
[__report_bad_irq+0x1e/0x80] __report_bad_irq+0x1e/0x80
Jun 21 04:29:46 ppp kernel: [ 5193.747550]
[note_interrupt+0x2ad/0x2e0] note_interrupt+0x2ad/0x2e0
Jun 21 04:29:46 ppp kernel: [ 5193.747562]
[handle_fasteoi_irq+0xa1/0x110] handle_fasteoi_irq+0xa1/0x110
Jun 21 04:29:46 ppp kernel: [ 5193.747571] [do_IRQ+0x7b/0x100] do_IRQ+0x7b/0x100
Jun 21 04:29:46 ppp kernel: [ 5193.747577] [ret_from_intr+0x0/0x0a]
ret_from_intr+0x0/0xa
Jun 21 04:29:46 ppp kernel: [ 5193.747583] [pci_conf1_read+0x0/0x100]
pci_conf1_read+0x0/0x100
Jun 21 04:29:46 ppp kernel: [ 5193.747596] [__do_softirq+0x60/0xe0]
__do_softirq+0x60/0xe0
Jun 21 04:29:46 ppp kernel: [ 5193.747609] [call_softirq+0x1c/0x30]
call_softirq+0x1c/0x30
Jun 21 04:29:46 ppp kernel: [ 5193.747614] [do_softirq+0x35/0x90]
do_softirq+0x35/0x90
Jun 21 04:29:46 ppp kernel: [ 5193.747618] [irq_exit+0x88/0x90]
irq_exit+0x88/0x90
Jun 21 04:29:46 ppp kernel: [ 5193.747621] [do_IRQ+0x80/0x100] do_IRQ+0x80/0x100
Jun 21 04:29:46 ppp kernel: [ 5193.747624] [default_idle+0x0/0x40]
default_idle+0x0/0x40
Jun 21 04:29:46 ppp kernel: [ 5193.747628] [default_idle+0x0/0x40]
default_idle+0x0/0x40
Jun 21 04:29:46 ppp kernel: [ 5193.747630] [ret_from_intr+0x0/0x0a]
ret_from_intr+0x0/0xa
Jun 21 04:29:46 ppp kernel: [ 5193.747633] <EOI>
[lapic_next_event+0x0/0x10] lapic_next_event+0x0/0x10
Jun 21 04:29:46 ppp kernel: [ 5193.747648] [default_idle+0x29/0x40]
default_idle+0x29/0x40
Jun 21 04:29:46 ppp kernel: [ 5193.747654] [cpu_idle+0x6f/0xc0]
cpu_idle+0x6f/0xc0
Jun 21 04:29:46 ppp kernel: [ 5193.747662] [start_kernel+0x2c5/0x350]
start_kernel+0x2c5/0x350
Jun 21 04:29:46 ppp kernel: [ 5193.747670] [x86_64_start_kernel+0x12e
/0x140] _sinittext+0x12e/0x140
Jun 21 04:29:46 ppp kernel: [ 5193.747678]
Jun 21 04:29:46 ppp kernel: [ 5193.747679] handlers:
Jun 21 04:29:46 ppp kernel: [ 5193.747680]
[usbcore:usb_hcd_irq+0x0/0x60] (usb_hcd_irq+0x0/0x60 [usbcore])
Jun 21 04:29:46 ppp kernel: [ 5193.747702]
[via_rhine:rhine_interrupt+0x0/0x7f0] (rhine_interrupt+0x0/0x7f0
[via_rhine])
Jun 21 04:29:46 ppp kernel: [ 5193.747710] Disabling IRQ #23
Jun 21 04:34:46 ppp kernel: [ 5493.104588] NETDEV WATCHDOG: eth0:
transmit timed out
Jun 21 04:34:46 ppp kernel: [ 5493.104738] eth0: Transmit timed out,
status 0003, PHY status 786d, resetting...
Jun 21 04:34:46 ppp kernel: [ 5493.105384] eth0: link up, 100Mbps,
full-duplex, lpa 0x45E1
Jun 21 05:05:02 ppp kernel: [ 7308.203455] NETDEV WATCHDOG: eth0:
transmit timed out
Jun 21 05:05:02 ppp kernel: [ 7308.203606] eth0: Transmit timed out,
status 1003, PHY status 786d, resetting...
Jun 21 05:05:02 ppp kernel: [ 7308.204254] eth0: link up, 100Mbps,
full-duplex, lpa 0x45E1
Jun 21 05:35:16 ppp kernel: [ 9121.303308] NETDEV WATCHDOG: eth0:
transmit timed out
Jun 21 05:35:16 ppp kernel: [ 9121.303457] eth0: Transmit timed out,
status 1003, PHY status 786d, resetting...
Jun 21 05:35:16 ppp kernel: [ 9121.304106] eth0: link up, 100Mbps,
full-duplex, lpa 0x45E1
Jun 21 06:05:32 ppp kernel: [10936.402170] NETDEV WATCHDOG: eth0:
transmit timed out

Lspci for Eth0:

00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 7c)
    Subsystem: ASUSTeK Computer Inc. Unknown device 80ed
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 64 (750ns min, 2000ns max), Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 23
    Region 0: I/O ports at 9400 [size=256]
    Region 1: Memory at dffff800 (32-bit, non-prefetchable) [size=256]
    Capabilities: [40] Power Management version 2
    Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
    Status: D0 PME-Enable- DSel=0 DScale=0 PME-
