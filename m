From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: [REGRESSION] 'pciehp' stops working since 2.6.10-rc2
Date: Mon, 27 Dec 2004 19:28:18 +0100
Message-ID: <41D05442.7070405@pca.it>
Reply-To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

I'm not sure this is the right place for my problem. I was wondering if
I should direcly fill a kernel bug and then I choose to post here as IMO
its an ACPI related problem.

I installed Debian unstable on my IBM ThinkPad T42p [1] and the
Debian-installer used the 2.6.8 kernel. Then, I upgraded to kernel
2.6.10-rc3 and now to 2.6.10 (both with the latest ACPI 20041210 patch).
Since my upgrade, the module 'pciehp' cannot be loaded anymore. I tried
different kernel (from 2.6.9 to 2.6.10) and the problem starts with a
vanilla kernel 2.6.10-rc2.

Here the output from /var/log/kern.log in the 2 cases (working and not):
=====
[2.6.8-1]
Dec 27 18:37:56 gismo kernel: agpgart: AGP aperture is 256M @ 0xd0000000
Dec 27 18:37:56 gismo kernel: cpci_hotplug: CompactPCI Hot Plug Core
version: 0.2
Dec 27 18:37:56 gismo kernel: pci_hotplug: PCI Hot Plug PCI Core
version: 0.5
Dec 27 18:37:56 gismo kernel: shpchp: acpi_shpchprm:\_SB_.PCI0.PCI1 _HPP
fail=0x5
Dec 27 18:37:56 gismo kernel: shpchp: acpi_pciehprm:\_SB_.PCI0.PCI1 OSHP
fails=0x5
Dec 27 18:37:56 gismo kernel: shpchp: acpi_shpchprm:   Slot sun(1) at
s:b:d:f=0x00:02:00:00
Dec 27 18:37:56 gismo kernel: shpchp: acpi_shpchprm:\_SB_.PCI0.PCI1 _HPP
fail=0x5
Dec 27 18:37:56 gismo kernel: shpchp: acpi_pciehprm:\_SB_.PCI0.PCI1 OSHP
fails=0x5
Dec 27 18:37:56 gismo kernel: shpchp: acpi_shpchprm:   Slot sun(2) at
s:b:d:f=0x00:02:00:01
Dec 27 18:37:56 gismo kernel: shpchp: shpc_init : shpc_cap_offset == 0
Dec 27 18:37:56 gismo kernel: shpchp: shpc_init : shpc_cap_offset == 0
Dec 27 18:37:56 gismo kernel: shpchp: Standard Hot Plug PCI Controller
Driver version: 0.4
Dec 27 18:37:56 gismo kernel: pciehp: acpi_pciehprm:\_SB_.PCI0.PCI1 _HPP
fail=0x5
Dec 27 18:37:56 gismo kernel: pciehp: acpi_pciehprm:\_SB_.PCI0.PCI1 OSHP
fails=0x5
Dec 27 18:37:56 gismo kernel: pciehp: acpi_pciehprm:   Slot sun(1) at
s:b:d:f=0x00:02:00:00
Dec 27 18:37:56 gismo kernel: pciehp: acpi_pciehprm:\_SB_.PCI0.PCI1 _HPP
fail=0x5
Dec 27 18:37:56 gismo kernel: pciehp: acpi_pciehprm:\_SB_.PCI0.PCI1 OSHP
fails=0x5
Dec 27 18:37:56 gismo kernel: pciehp: acpi_pciehprm:   Slot sun(2) at
s:b:d:f=0x00:02:00:01
Dec 27 18:37:56 gismo kernel: pciehp: PCI Express Hot Plug Controller
Driver version: 0.4
Dec 27 18:37:56 gismo kernel: hw_random hardware driver 1.0.0 loaded
Dec 27 18:37:56 gismo kernel: ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI
11 (level, low) -> IRQ 11

[2.6.10, latest ACPI 20041210]
Dec 27 18:40:32 gismo kernel: agpgart: AGP aperture is 256M @ 0xd0000000
Dec 27 18:40:32 gismo kernel: cpci_hotplug: CompactPCI Hot Plug Core
version: 0.2
Dec 27 18:40:32 gismo kernel: pci_hotplug: PCI Hot Plug PCI Core
version: 0.5
Dec 27 18:40:32 gismo kernel: Evaluate _OSC Set fails. Status = 0x0005
Dec 27 18:40:32 gismo kernel: pciehp: add_host_bridge: status 5
Dec 27 18:40:32 gismo kernel: pciehp: acpi_pciehprm:\_SB_.PCI0.PCI1 _HPP
fail=0x5
Dec 27 18:40:32 gismo kernel: pciehp: acpi_pciehprm:\_SB_.PCI0.PCI1 OSHP
fails=0x5
Dec 27 18:40:32 gismo kernel: pciehp: acpi_pciehprm:   Slot sun(1) at
s:b:d:f=0x00:02:00:00
Dec 27 18:40:32 gismo kernel: pciehp: acpi_pciehprm:\_SB_.PCI0.PCI1 _HPP
fail=0x5
Dec 27 18:40:32 gismo kernel: pciehp: acpi_pciehprm:\_SB_.PCI0.PCI1 OSHP
fails=0x5
Dec 27 18:40:32 gismo kernel: pciehp: acpi_pciehprm:   Slot sun(2) at
s:b:d:f=0x00:02:00:01
Dec 27 18:40:32 gismo kernel: pciehp: Fails to gain control of native
hot-plug
Dec 27 18:40:32 gismo kernel: shpchp: acpi_shpchprm:\_SB_.PCI0.PCI1 _HPP
fail=0x5
Dec 27 18:40:32 gismo kernel: shpchp: acpi_pciehprm:\_SB_.PCI0.PCI1 OSHP
fails=0x5
Dec 27 18:40:32 gismo kernel: shpchp: acpi_shpchprm:   Slot sun(1) at
s:b:d:f=0x00:02:00:00
Dec 27 18:40:32 gismo kernel: shpchp: acpi_shpchprm:\_SB_.PCI0.PCI1 _HPP
fail=0x5
Dec 27 18:40:32 gismo kernel: shpchp: acpi_pciehprm:\_SB_.PCI0.PCI1 OSHP
fails=0x5
Dec 27 18:40:32 gismo kernel: shpchp: acpi_shpchprm:   Slot sun(2) at
s:b:d:f=0x00:02:00:01
Dec 27 18:40:32 gismo kernel: shpchp: shpc_init : shpc_cap_offset == 0
Dec 27 18:40:32 gismo kernel: shpchp: shpc_init : shpc_cap_offset == 0
Dec 27 18:40:32 gismo kernel: shpchp: Standard Hot Plug PCI Controller
Driver version: 0.4
Dec 27 18:40:32 gismo kernel: hw_random hardware driver 1.0.0 loaded
Dec 27 18:40:32 gismo kernel: Evaluate _OSC Set fails. Status = 0x0005
Dec 27 18:40:32 gismo kernel: pciehp: add_host_bridge: status 5
Dec 27 18:40:32 gismo kernel: pciehp: acpi_pciehprm:\_SB_.PCI0.PCI1 _HPP
fail=0x5
Dec 27 18:40:32 gismo kernel: pciehp: acpi_pciehprm:\_SB_.PCI0.PCI1 OSHP
fails=0x5
Dec 27 18:40:32 gismo kernel: pciehp: acpi_pciehprm:   Slot sun(1) at
s:b:d:f=0x00:02:00:00
Dec 27 18:40:32 gismo kernel: pciehp: acpi_pciehprm:\_SB_.PCI0.PCI1 _HPP
fail=0x5
Dec 27 18:40:32 gismo kernel: pciehp: acpi_pciehprm:\_SB_.PCI0.PCI1 OSHP
fails=0x5
Dec 27 18:40:32 gismo kernel: pciehp: acpi_pciehprm:   Slot sun(2) at
s:b:d:f=0x00:02:00:01
Dec 27 18:40:32 gismo kernel: pciehp: Fails to gain control of native
hot-plug
Dec 27 18:40:32 gismo kernel: snd: Unknown parameter `device_mode'
Dec 27 18:40:32 gismo kernel: ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI
11 (level, low) -> IRQ 11
=====

I'm here for any other info or tests.

Thx bye,
Gismo / Luca

[1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=287274
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFB0FRCVAp7Xm10JmkRAvTXAJ4smiKuKckShaOhtDQfsHwvOxjgsACeMpLj
ExIWLhr6mDnCrMXkmuqdn98=
=A8rV
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
