From: Alvaro Lopes <alvieboy-JkNoWtNHh5AAvxtiuMwx3w@public.gmane.org>
Subject: ACPI PCI bus mismatch ?
Date: Wed, 05 Feb 2003 16:36:24 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E413D88.2020001@alvie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi all

I was debugging ACPI in my laptop and was comparing 2.4.18 against=20
latest 2.4.19pre4-ac1+acpi, when I found this:

There's a method in my DSTD that looks like this:

        Method (_L08, 0, Serialized)
        {
            Store (\_SB.PCI0.PCIB.BRGB, Local0)
            ShiftLeft (Local0, 0x18, Local0)
            Or (Local0, 0x0020B10B, Local0)
            Store (0xAF, \_SB.MEM.IEDI)
=2E
=2E
=2E

When it runs on 2.4.18, I can see it working almost properly. I debugged=20
exregion and this was the result, with my comments:


Feb  5 16:18:09 supernova kernel: exregion-0353 [25]=20
Ex_pci_config_space_ha: Pci_config 0 (8) Seg(0000) Bus(0000) Dev(001e)=20
Func(0000) Reg(0019)
    This one is reading \_SB.PCI0.PCIB.BRGB,  device 0x1e @ bus #0,=20
which according to lspci, is my PCI bridge (which is correct):

    00:1e.0 PCI bridge: Intel Corp. 82820 820 (Camino 2) Chipset PCI=20
(-M) (rev 42)


But, when I boot 2.4.20pre4-ac1+acpi, the handler instead of using Bus=20
#0, uses Bus #2:

Feb  5 16:25:28 supernova kernel: exregion-0352 [25]=20
ex_pci_config_space_ha: pci_config 0 (8) Seg(0000) Bus(0002) Dev(001e)=20
Func(0000) Reg(0019)

.... and always reads 0xFF.

lspci with 2.4.20pre4-ac1+acpi is:

alvieboy@supernova:~$ uname -a
Linux supernova 2.4.21-pre4-ac1 #2 SMP Ter Fev 4 12:18:03 WET 2003 i686=20
unknown unknown GNU/Linux
alvieboy@supernova:~$ lspci
00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host=20
Bridge (rev 05)
00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge=20
(rev 05)
00:1d.0 USB Controller: Intel Corp.: Unknown device 2482 (rev 02)
00:1d.1 USB Controller: Intel Corp.: Unknown device 2484 (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82820 820 (Camino 2) Chipset PCI (-M)=20
(rev 42)
00:1f.0 ISA bridge: Intel Corp.: Unknown device 248c (rev 02)
00:1f.1 IDE interface: Intel Corp.: Unknown device 248a (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. AC'97 Audio Controller=20
(rev 02)
00:1f.6 Modem: Intel Corp.: Unknown device 2486 (rev 02)
01:00.0 VGA compatible controller: nVidia Corporation: Unknown device=20
0175 (rev a3)
02:08.0 Ethernet controller: Intel Corp. 82801CAM (ICH3) Chipset=20
Ethernet Controller (rev 42)
02:0b.0 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to=20
Cardbus Bridge with ZV Support (rev 32)
02:0b.1 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to=20
Cardbus Bridge with ZV Support (rev 32)


Anyone sees which might me causing this ?

TYA


--=20

=C1lvaro Lopes=20
---------------------
A .sig is just a .sig




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
