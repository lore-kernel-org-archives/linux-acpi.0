From: Yaroslav Rastrigin <yarick-343whMTK1pU@public.gmane.org>
Subject: ACPI (20030522, 20030619) breaks 3c59x in 2.4, 2.5
Date: Tue, 24 Jun 2003 13:09:55 +0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3EF81563.9080409@relex.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090404030903010509040701"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI-Devel mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------090404030903010509040701
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi ,

I've posted this message on lkml, but it went practically unnoticed.
Well, realising this list is a more appropriate place  - I'm (re)posting it
here, with some additional info.
The problem is:
with ACPI patches mentioned in Subject and ACPI enabled in kernel, NIC in my
laptop (3c556 Laptop Hurricane, according to driver output) fails to detect
proper card configuration, including, but not limited to, media it is working
with, availability of MII transceiver(s), and other important parameters.
Kernels tested:
2.4.20, 2.4.21-rc7, 2.4.21, 2.4.21-ac, 2.5.70, 2.5.72
What I've tried to fix this (apparently wrong) behaviour:
pci=noacpi and  pci=biosint kernel cmdline arguments,  enabling/disabling
different PCI access modes (BIOS/Direct/Any).

Disabling ACPI with acpi=off cures this problem completely.
Attached are dmesg excerpts from ACPI-enabled and -disabled boots with results of
insmod 3c59x debug=6

Full respective dmesgs, .config and lspci -vvv outputs are available at
http://www.relex.ru/~yarick/acpi/

I was very interested by
diff lspci.acpi lspci.acpi=off
output, and I want to provide it inlined, in case somebody could get or give
me a quick clue:
52c52

<   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
---

  >   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
54c54

<   Latency: 64 (2500ns min, 2500ns max)

---

  >   Latency: 80 (2500ns min, 2500ns max), cache line size 08

56,58c56,58

<   Region 0: I/O ports at 1400 [size=256]

<   Region 1: [virtual] Memory at 10000000 (32-bit, non-prefetchable)
[size=128]
<   Region 2: [virtual] Memory at 10000080 (32-bit, non-prefetchable)
[size=128]
---

  >   Region 0: I/O ports at 1800 [size=256]

  >   Region 1: Memory at e8101400 (32-bit, non-prefetchable) [size=128]

  >   Region 2: Memory at e8101000 (32-bit, non-prefetchable) [size=128]


Every line in this diff  is related to
00:03.0 Ethernet controller: 3Com Corporation 3c556B Hurricane CardBus (rev 20)

I could and gladly will provide additional information.
Or, at least, tell me where to start digging ?

--
With all the best, yarick at relex dot ru


--------------090404030903010509040701
Content-Type: text/plain;
 name="3c59x-acpi=off"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="3c59x-acpi=off"

PCI: Found IRQ 5 for device 00:03.0
PCI: Sharing IRQ 5 with 00:03.1
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
00:03.0: 3Com PCI 3c556B Laptop Hurricane at 0x1800. Vers LK1.1.19
 00:04:76:61:9a:bb, IRQ 5
  product code 0000 rev aa.8 date 03-01-00
00:03.0: CardBus functions mapped e8101000->d0aca000
  Internal config register is 80600040, transceivers 0x40.
  8K byte-wide RAM 5:3 Rx:Tx split, MII interface.
  MII transceiver found at address 0, status 7849.
  Enabling bus-master transmits and whole-frame receives.
00:03.0: scatter/gather enabled. h/w checksums enabled


--------------090404030903010509040701
Content-Type: text/plain;
 name="3c59x-pci=noacpi"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="3c59x-pci=noacpi"

PCI: Found IRQ 5 for device 00:03.0
PCI: Sharing IRQ 5 with 00:03.1
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
00:03.0: 3Com PCI 3c556B Laptop Hurricane at 0x1400. Vers LK1.1.19
 ff:ff:ff:ff:ff:ff, IRQ 5
  product code ffff rev ffff.15 date 15-31-127
00:03.0: CardBus functions mapped 10000080->d0ada080
Full duplex capable
  Internal config register is ffffffff, transceivers 0xffff.
  1024K word-wide RAM 3:5 Rx:Tx split, autoselect/<invalid transceiver> interface.
  ***WARNING*** No MII transceivers found!
  Enabling bus-master transmits and early receives.
00:03.0: scatter/gather enabled. h/w checksums enabled


--------------090404030903010509040701--



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
