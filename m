From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: DSDT errors
Date: Tue, 15 Feb 2005 17:10:52 -0800
Message-ID: <971FCB6690CD0E4898387DBF7552B90E96D49D@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="windows-1255"
Content-Transfer-Encoding: quoted-printable
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Mark Eaton <meaton-tw97OP0PknkAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

7.3.7   \_WAK (System Wake)
After the system wakes from a sleeping state, it will invoke the \_WAK =
method and pass the sleeping state value that has ended. This operation =
occurs asynchronously with other driver notifications in the system and =
is not the first action to be taken when the system wakes. The AML code =
for this control method issues device, thermal, and other notifications =
to ensure that OSPM checks the state of devices, thermal zones, and so =
on, that could not be maintained during the system sleeping state. For =
example, if the system cannot determine whether a device was inserted or =
removed from a bus while in the S2 state, the _WAK method would issue a =
devicecheck type of notification for that bus when issued with the =
sleeping state value of 2 (for more information about types of =
notifications, see section =FD5.6.3, =93Device Object Notifications=94). =
Notice that a device check notification from the \_SB node will cause =
OSPM to re-enumerate the entire tree .
Hardware is not obligated to track the state needed to supply the =
resulting status; however, this method must return status concerning the =
last sleep operation initiated by OSPM. The result codes can be used to =
provide additional information to OSPM or user.=20
Arguments:
0	The value of the sleeping state (1 for S1, 2 for S2, and so on).
Result Code (2 DWORD package):
Status	Bit field of defined conditions that occurred during sleep.
	0x00000000	Wake was signaled and was successful
	0x00000001	Wake was signaled but failed due to lack of power.
	0x00000002	Wake was signaled but failed due to thermal condition.

	Other	Reserved
PSS	If non-zero, the effective S-state the power supply really entered.=20

This value is used to detect when the targeted S-state was not entered =
because of too much current being drawn from the power supply. For =
example, this might occur when some active device=92s current =
consumption pushes the system=92s power requirements over the low power =
supply mark, thus preventing the lower power mode from being entered as =
desired.

> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Mark Eaton
> Sent: Tuesday, February 15, 2005 5:01 PM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [ACPI] DSDT errors
>=20
> I am looking at my DSDT for an acer ferrari 300 laptop. It hangs on =
resume
> and
> I believe the problem (at least partially) is the _WAK function which
> doesn't
> return a value. The question is what should it return ?
>=20
> The method is as below.
>=20
>     Method (\_WAK, 1, NotSerialized)
>     {
>         Store (0x01, \_SB.PCI0.ISA.LIDP)
>         If (LEqual (Arg0, 0x03))
>         {
>             \_SB.Z001 (0x91)
>             Acquire (\_SB.PSMX, 0xFFFF)
>             Store (0x80, \_SB.BCMD)
>             Store (0x07, \_SB.DID)
>             Store (Zero, \_SB.SMIC)
>             Release (\_SB.PSMX)
>         }
>=20
>         If (LEqual (Arg0, 0x04))
>         {
>             Acquire (\_SB.PSMX, 0xFFFF)
>             Store (0x80, \_SB.BCMD)
>             Store (0x04, \_SB.DID)
>             Store (Zero, \_SB.SMIC)
>             Release (\_SB.PSMX)
>             Store (\_SB.INF, Local0)
>             If (LEqual (Local0, 0x07)) {}
>             Else
>             {
>                 Store (Local0, Local1)
>                 Store (Local0, Local2)
>                 Store (Local0, \_SB.PCI0.AGP.VGA.DABL)
>                 And (Local1, 0x01, \_SB.PCI0.AGP.VGA.CRTA)
>                 And (Local2, 0x02, \_SB.PCI0.AGP.VGA.LCDA)
>             }
>         }
>=20
>         Store (0xBA, \_SB.PCI0.ISA.Z002)
>         \_SB.Z001 (0x97)
>     }
>=20
>=20
> thanks.
> If this has nothing to do with my problem I can supply the entire dsdt =
for
> someone to have a look at.
>=20
> --
> Mark Eaton
> meaton-tw97OP0PknkAvxtiuMwx3w@public.gmane.org
>=20
>=20
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real =
users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
