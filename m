From: =?ISO-8859-1?Q?Antti_M=E4kel=E4?= <zarhan-0XaaFOc9qNL1KXRcyAk9cg@public.gmane.org>
Subject: Fixed DSDT for IBM Thinkpad 600E?
Date: Fri, 5 Nov 2004 22:59:44 +0200 (EET)
Message-ID: <Pine.GSO.4.58.0411052247560.4483@viherkiuru.cs.tut.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
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

Hi,

  ACPI on Thinkpad is notoriously broken in Linux (however, works fine in
Windows). Has anyone tried to fix the DSDT (and succeeded?)

  Sleep state S3 does not work, and neither does hardware configuration..

  If I run with acpi=3Dnoirq or pci=3Dnoacpi, I can get most devices to w=
ork
however.

  I would like to use ACPI instead of APM, because with APM the fan is
constantly on despite the processor being completely cool and idle.

  I did notice a typo in the default DSDT (take a look at S3!)

    Name (\_S0, Package (0x04)
    {
        0x05,
        0x05,
        0x00,
        0x00
    })
    Name (\_S1, Package (0x04)
    {
        0x04,
        0x04,
        0x00,
        0x00
    })
    Method (_S3, 0, NotSerialized)
    {
        If (BXPT)
        {
            Return (Package (0x04)
            {
                0x06,
                0x06,
                0x00,
                0x00
            })
        }
        Else
        {
            Return (Package (0x04)
            {
                0x01,
                0x01,
                0x00,
                0x00
            })
        }
    }

    Name (\_S4, Package (0x04)
    {
        0x00,
        0x00,
        0x00,
        0x00
    })

  However, fixing the typo (and trying to fix some other things that give
compiler errors), only gives me loads of errors like this on boot:

ed [\_SB_.PCI0.DOCK.ISA1.DREG] (Node c9f1e828), AE_AML_NO_RETURN_VALUE
 psparse-1133: *** Error: Method execution failed [\_SB_.PCI0.DOCK.DREG]
(Node c
9f1c828), AE_AML_NO_RETURN_VALUE
 psparse-1133: *** Error: Method execution failed [\_SB_.PCI0.DOCK._REG]
(Node c
9f1c8e8), AE_AML_NO_RETURN_VALUE
 psparse-1133: *** Error: Method execution failed [\_SB_.PCI0.DOCK.GDID]
(Node c
9f1c0a8), AE_AML_NO_RETURN_VALUE
 psparse-1133: *** Error: Method execution failed
[\_SB_.PCI0.DOCK.ISA1.DREG] (N
ode c9f1e828), AE_AML_NO_RETURN_VALUE
 psparse-1133: *** Error: Method execution failed [\_SB_.PCI0.DOCK.DREG]
(Node c
9f1c828), AE_AML_NO_RETURN_VALUE
 psparse-1133: *** Error: Method execution failed [\_SB_.PCI0.DOCK._REG]
(Node c
9f1c8e8), AE_AML_NO_RETURN_VALUE
evrgnini-0242: *** Error: Could not install pci_config handler for Root
Bridge P
CI0, AE_AML_NO_RETURN_VALUE
 psparse-1133: *** Error: Method execution failed [\_SB_.LNKA._INI] (Node
c9faeb
88), AE_AML_REGION_LIMIT
 psparse-1133: *** Error: Method execution failed [\_SB_.LNKB._INI] (Node
c9fae5
e8), AE_AML_REGION_LIMIT
 psparse-1133: *** Error: Method execution failed [\_SB_.LNKC._INI] (Node
c9fae0
a8), AE_AML_REGION_LIMIT
 psparse-1133: *** Error: Method execution failed [\_SB_.LNKD._INI] (Node
c9fafa
c8), AE_AML_REGION_LIMIT
 psparse-1133: *** Error: Method execution failed [\_SB_.HKEY._STA] (Node
c9fb0e
88), AE_AML_REGION_LIMIT
  uteval-0158: *** Error: Method execution failed [\_SB_.HKEY._STA] (Node
c9fb0e
88), AE_AML_REGION_LIMIT
 psparse-1133: *** Error: Method execution failed [\_SB_.PCI0._INI] (Node
c9fb18
88), AE_AML_REGION_LIMIT
 psparse-1133: *** Error: Method execution failed
[\_SB_.PCI0.AGP0.VID0._INI] (N
ode c9fb11c8), AE_AML_REGION_LIMIT
 psparse-1133: *** Error: Method execution failed
[\_SB_.PCI0.ISA0.FDC0._INI] (N
ode c9fb66a8), AE_AML_REGION_LIMIT
 psparse-1133: *** Error: Method execution failed
[\_SB_.PCI0.ISA0.LPT_._STA] (N
ode c9fb7888), AE_AML_NO_RETURN_VALUE
  uteval-0158: *** Error: Method execution failed
[\_SB_.PCI0.ISA0.LPT_._STA] (N
ode c9fb7888), AE_AML_NO_RETURN_VALUE
 psparse-1133: *** Error: Method execution failed
[\_SB_.PCI0.ISA0.ECP_._STA] (N
ode c9fb7228), AE_AML_NO_RETURN_VALUE
  uteval-0158: *** Error: Method execution failed
[\_SB_.PCI0.ISA0.ECP_._STA] (N
ode c9fb7228), AE_AML_NO_RETURN_VALUE
 psparse-1133: *** Error: Method execution failed
[\_SB_.PCI0.ISA0.CS10._STA] (N
ode c9fb8708), AE_AML_REGION_LIMIT
  uteval-0158: *** Error: Method execution failed
[\_SB_.PCI0.ISA0.CS10._STA] (N
ode c9fb8708), AE_AML_REGION_LIMIT
 psparse-1133: *** Error: Method execution failed
[\_SB_.PCI0.ISA0.CS00._STA] (N
ode c9fb8288), AE_AML_REGION_LIMIT
  uteval-0158: *** Error: Method execution failed
[\_SB_.PCI0.ISA0.CS00._STA] (N
ode c9fb8288), AE_AML_REGION_LIMIT
 psparse-1133: *** Error: Method execution failed
[\_SB_.PCI0.ISA0.CS01._STA] (N
ode c9fb9d68), AE_AML_REGION_LIMIT
  uteval-0158: *** Error: Method execution failed
[\_SB_.PCI0.ISA0.CS01._STA] (N
ode c9fb9d68), AE_AML_REGION_LIMIT
 psparse-1133: *** Error: Method execution failed
[\_SB_.PCI0.ISA0.CS03._STA] (N
ode c9fb99a8), AE_AML_REGION_LIMIT
  uteval-0158: *** Error: Method execution failed
[\_SB_.PCI0.ISA0.CS03._STA] (N
ode c9fb99a8), AE_AML_REGION_LIMIT
 psparse-1133: *** Error: Method execution failed
[\_SB_.PCI0.ISA0.MWV0._STA] (N
ode c9fb9528), AE_AML_REGION_LIMIT

  When I run with the default DSDT, these errors do not appear, but S3
does not work, either. I also tried running with default DSDT and editing
the kernel source (file utglobal.c) so that the method for S3 would be
_S3_ instead of \_S3_ but that did not help.

  However, thermal zone reporting and similar stuff works ok with the
default one.

  Has anyone attempted completely fixing DSDT for TP600E and getting at
least the sleep states to work? I have the last BIOS version published by
IBM:

http://www-307.ibm.com/pc/support/site.wss/document.do?lndocid=3DDSHY-43D=
NQ5

  Thanks for any assistance..

--=20
- Antti M=E4kel=E4 - http://www.cs.tut.fi/~zarhan - zarhan-0XaaFOc9qNL1KXRcyAk9cg@public.gmane.org -
There is a theory which states that if ever anyone discovers exactly
what the Universe is for and why it is here,it will instantly disappear
and be replaced by something even more bizarre and inexplicable.



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
