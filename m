From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: b44 suspend/resume (Re: PCI not restored correctly after
	suspend to ram)
Date: 19 Mar 2004 15:35:00 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1079728500.7277.140.camel@dhcppc4>
References: <200403180935.09436.stefan.doesinger@gym-leoben.asn-graz.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200403180935.09436.stefan.doesinger-dYJrdcitkgg0+Ua9VpOLR6Q1ief8SNuKXqFh9Ls21Oc@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: stefan.doesinger-dYJrdcitkgg0+Ua9VpOLR6Q1ief8SNuKXqFh9Ls21Oc@public.gmane.org, davem-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, pp-YuCZbdju05vHOG6cAo2yLw@public.gmane.org
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2004-03-18 at 03:35, Stefan D=F6singer wrote:
> Hello list,
> I have the following problems with suspend to ram on my Acer Travelmate=
 803
> (Centrino) notebook:
> With the patch for radeon_driver.c(Xfree v. 4.4) I can suspend and resu=
me my=20
> notebook. After resume, the settings of most pci devices are not restor=
ed=20
> correctly and the devices do not work. See the attached lspci_before_su=
spend=20
> and lspci_after_suspend files for details.
> Devices not working are:
> *Soundcard(00:1f.5)
> *All devices on bus 02
> *The modem, but there's only a non-GPL driver available.
>=20
> I can get most devices devies to work by setting the pci registers with=
 setpci=20
> after resume. I use the attached fixpci.sh script to do so. I can get m=
y=20
> soundcard, the ethernet card(02:02.0) ...

02:02.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T (rev
01)

#broadcom ethernet controller
DEV=3D02:02.0
echo "Configuring $DEV"
$SETPCI -s $DEV  04.w=3D0x0106
$SETPCI -s $DEV  08.w=3D0x0810
$SETPCI -s $DEV  0c.w=3D0x4000
$SETPCI -s $DEV  10.w=3D0x4000
$SETPCI -s $DEV  12.w=3D0xd020

I think this is the b44. Looking at b44_suspend/b44_resume, I don't see
any calls to pci_save_state()/pci_restore_state() that I would expect,
so it comes back after resume with bus mastering disabled etc.

-Len
-----------
lspci_before_suspend:

02:02.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T (rev
01)
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort+
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at d0204000 (32-bit, non-prefetchable)
[size=3D8K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-
00: e4 14 01 44 06 01 10 08 01 00 00 02 00 40 00 00
10: 00 40 20 d0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 05 01 00 00

------------
lspci_after_suspend
02:02.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T (rev
01)
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 5
        Region 0: [virtual] Memory at d0204000 (32-bit,
non-prefetchable) [disabled] [size=3D8K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-
00: e4 14 01 44 00 00 10 00 01 00 00 02 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 01 00 00




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
