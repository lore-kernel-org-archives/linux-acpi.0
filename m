From: Adam Majer <adamm@zombino.com>
Subject: Opps in ACPI on VIA K7 (2.6.18)
Date: Sun, 29 Oct 2006 14:02:09 -0600
Message-ID: <454508C1.7030308@zombino.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from polaris.galacticasoftware.com ([216.55.199.131]:28323 "EHLO
	mail.lan.galacticasoftware.com") by vger.kernel.org with ESMTP
	id S1751814AbWJ2UCM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Oct 2006 15:02:12 -0500
Received: from mira.lan.galacticasoftware.com ([192.168.53.2])
	by mail.lan.galacticasoftware.com with esmtp (Exim 4.50)
	id 1GeGrC-0007qH-B6
	for linux-acpi@vger.kernel.org; Sun, 29 Oct 2006 14:02:10 -0600
Received: from localhost ([::1])
	by mira.lan.galacticasoftware.com with esmtp (Exim 4.63)
	(envelope-from <adamm@zombino.com>)
	id 1GeGrC-0002WG-8u
	for linux-acpi@vger.kernel.org; Sun, 29 Oct 2006 14:02:10 -0600
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi all,

I get the following Opps on my K7 VIA box with acpi=off. I use acpi=off
as with ACPI I have *very* high software interrupt (si) load,

top - 13:50:15 up  2:55,  6 users,  load average: 0.18, 0.23, 0.14
Tasks:  93 total,   1 running,  92 sleeping,   0 stopped,   0 zombie
Cpu(s): 13.9%us,  4.2%sy,  0.3%ni, 65.1%id,  1.5%wa,  0.0%hi, 15.0%si,
0.0%st
Mem:   1036644k total,   938000k used,    98644k free,     1092k buffers
Swap:   835296k total,       76k used,   835220k free,   432912k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND

 6240 adamm     15   0  9324 3256 2352 S  2.0  0.3   1:30.23 elinks

and elinks is not actually doing anything.


Anyway, the oops was captured via a null-modem cable. The kernel is the
current Debian kernel. The Opps occurs early in the boot processes soon
after io schedulers are registered and before any ide or nvidia modules
loaded. The oops is,

Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: Bypassing VIA 8237 APIC De-Assert Message
BUG: unable to handle kernel NULL pointer dereference at virtual address
0000009c
 printing eip:
c01e41ee
*pde = 00000000
Oops: 0000 [#1]
SMP
Modules linked in:
CPU:    0
EIP:    0060:[<c01e41ee>]    Not tainted VLI
EFLAGS: 00010202   (2.6.18-1-k7 #1)
EIP is at acpi_hw_low_level_read+0x7/0x6a
eax: 00000010   ebx: 00000001   ecx: 00000094   edx: c18e1f80
esi: c18e1f94   edi: 00000000   ebp: 00000000   esp: c18e1f68
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, ti=c18e0000 task=f7b44aa0 task.ti=c18e0000)
Stack: 00000001 c18e1f94 00000000 c01e42ae 00fb3c00 00000000 00000000
c02b670c
       f7fb3c00 c02b6834 c01c21b5 c02b66dc c01c1e26 f7fb3c00 c0344b6c
00000000
       c01c12d0 00000000 c01003e1 c0102b46 00000202 c01002d0 00000000
00000000
Call Trace:
 [<c01e42ae>] acpi_hw_register_read+0x5d/0x177
 [<c01c21b5>] quirk_via_abnormal_poweroff+0x11/0x36
 [<c01c1e26>] pci_fixup_device+0x68/0x73
 [<c01c12d0>] pci_init+0x11/0x28
 [<c01003e1>] init+0x111/0x28e
 [<c0102b46>] ret_from_fork+0x6/0x1c
 [<c01002d0>] init+0x0/0x28e
 [<c01002d0>] init+0x0/0x28e
 [<c0101005>] kernel_thread_helper+0x5/0xb
Code: a0 82 2d c0 76 1b 50 68 85 8c 2a c0 68 f3 00 00 00 ff 35 ac ef 28
c0 e8 c7 80 00 00 31 d2 83 c4 10 89 d0 c3 57 85 c9 56 53 74 5d <8b>
71 08 8b 59 04 89 f7 09 df 74 51 c7 02 00 00 00 00 8a 09 84
EIP: [<c01e41ee>] acpi_hw_low_level_read+0x7/0x6a SS:ESP 0068:c18e1f68
 <0>Kernel panic - not syncing: Attempted to kill init!


or,


Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: Bypassing VIA 8237 APIC De-Assert Message
BUG: unable to handle kernel NULL pointer dereference at virtual address
0000009c
 printing eip:
c01e2556
*pde = 00000000
Oops: 0000 [#1]
SMP
Modules linked in:
CPU:    0
EIP:    0060:[<c01e2556>]    Not tainted VLI
EFLAGS: 00010202   (2.6.18-1-k7 #1)
EIP is at acpi_hw_low_level_read+0x7/0x6a
eax: 00000010   ebx: 00000001   ecx: 00000094   edx: c18e1f80
esi: c18e1f94   edi: 00000000   ebp: 00000000   esp: c18e1f68
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, ti=c18e0000 task=f7b43ab0 task.ti=c18e0000)
Stack: 00000001 c18e1f94 00000000 c01e2616 00fb2c00 00000000 00000000
c02b46e8
       f7fb2c00 c02b4810 c01c0525 c02b46b8 c01c0196 f7fb2c00 c0341b68
00000000
       c01bf640 00000000 c01003dc c0102b46 00000202 c01002d0 00000000
00000000
Call Trace:
 [<c01e2616>] acpi_hw_register_read+0x5d/0x177
 [<c01c0525>] quirk_via_abnormal_poweroff+0x11/0x36
 [<c01c0196>] pci_fixup_device+0x68/0x73
 [<c01bf640>] pci_init+0x11/0x28
 [<c01003dc>] init+0x10c/0x289
 [<c0102b46>] ret_from_fork+0x6/0x1c
 [<c01002d0>] init+0x0/0x289
 [<c01002d0>] init+0x0/0x289
 [<c0101005>] kernel_thread_helper+0x5/0xb
Code: a0 5e 2d c0 76 1b 50 68 f4 6a 2a c0 68 f3 00 00 00 ff 35 4c cf 28
c0 e8 c7 80 00 00 31 d2 83 c4 10 89 d0 c3 57 85 c9 56 53 74 5d <8b>
71 08 8b 59 04 89 f7 09 df 74 51 c7 02 00 00 00 00 8a 09 84
EIP: [<c01e2556>] acpi_hw_low_level_read+0x7/0x6a SS:ESP 0068:c18e1f68
 <0>Kernel panic - not syncing: Attempted to kill init!



If ACPI is left with default value, then everything runs correctly.
Well, except for the high SI load. I disabled ACPI in 2.6.17 as that
corrected the SI load situation, but acpi=off causes that oops in 2.6.18
so....

With acpi default setting, the boot process continues though this spot
correctly,

Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: Bypassing VIA 8237 APIC De-Assert Message
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found


The kernel parameters that cause the Oops are,

Kernel command line: root=/dev/sdb3 acpi=off ro console=ttyS0

and it works correctly with,




Please let me know if you require additional information to diagnose
this error or to test a fix. I'm not on this ML so please CC me in replies.

Thank you,
Adam




adamm@mira:~$ lspci -v
00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP]
Host Bridge (rev 80)
        Subsystem: Elitegroup Computer Systems Unknown device 1884
        Flags: bus master, 66MHz, medium devsel, latency 8
        Memory at 40000000 (32-bit, prefetchable) [size=1024M]
        Capabilities: <access denied>

00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge (prog-if 00
[Normal decode])
        Flags: bus master, 66MHz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: b0000000-b1ffffff
        Prefetchable memory behind bridge: a0000000-afffffff
        Capabilities: <access denied>

00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID
Controller (rev 80)
        Subsystem: Elitegroup Computer Systems Unknown device 1884
        Flags: bus master, medium devsel, latency 32, IRQ 185
        I/O ports at 9000 [size=8]
        I/O ports at 9400 [size=4]
        I/O ports at 9800 [size=8]
        I/O ports at 9c00 [size=4]
        I/O ports at a000 [size=16]
        I/O ports at a400 [size=256]
        Capabilities: <access denied>

00:0f.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc.
VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
        Flags: bus master, medium devsel, latency 32, IRQ 185
        I/O ports at a800 [size=16]
        Capabilities: <access denied>

00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: Elitegroup Computer Systems Unknown device 1884
        Flags: bus master, medium devsel, latency 32, IRQ 177
        I/O ports at ac00 [size=32]
        Capabilities: <access denied>

00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: Elitegroup Computer Systems Unknown device 1884
        Flags: bus master, medium devsel, latency 32, IRQ 177
        I/O ports at b000 [size=32]
        Capabilities: <access denied>

00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: Elitegroup Computer Systems Unknown device 1884
        Flags: bus master, medium devsel, latency 32, IRQ 177
        I/O ports at b400 [size=32]
        Capabilities: <access denied>

00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: Elitegroup Computer Systems Unknown device 1884
        Flags: bus master, medium devsel, latency 32, IRQ 177
        I/O ports at b800 [size=32]
        Capabilities: <access denied>

00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86) (prog-if
20 [EHCI])
        Subsystem: Elitegroup Computer Systems Unknown device 1884
        Flags: bus master, medium devsel, latency 32, IRQ 177
        Memory at b2000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: <access denied>

00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge
[KT600/K8T800/K8T890 South]
        Subsystem: Elitegroup Computer Systems Unknown device 1884
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: <access denied>

00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
        Subsystem: Elitegroup Computer Systems Unknown device 1884
        Flags: medium devsel, IRQ 193
        I/O ports at bc00 [size=256]
        Capabilities: <access denied>

00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II]
(rev 78)
        Subsystem: VIA Technologies, Inc. VT6102 [Rhine II] Embeded
Ethernet Controller on VT8235
        Flags: bus master, medium devsel, latency 32, IRQ 169
        I/O ports at c400 [size=256]
        Memory at b2001000 (32-bit, non-prefetchable) [size=256]
        Capabilities: <access denied>

01:00.0 VGA compatible controller: nVidia Corporation NV31 [GeForce FX
5600] (rev a1) (prog-if 00 [VGA])
        Subsystem: ASUSTeK Computer Inc. Unknown device 80e7
        Flags: bus master, 66MHz, medium devsel, latency 248, IRQ 201
        Memory at b0000000 (32-bit, non-prefetchable) [size=16M]
        Memory at a0000000 (32-bit, prefetchable) [size=256M]
        [virtual] Expansion ROM at b1000000 [disabled] [size=128K]
        Capabilities: <access denied>


