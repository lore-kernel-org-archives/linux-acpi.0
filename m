From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Tarting up my ACER 1703 ACPI spec
Date: Wed, 14 Jan 2004 12:06:53 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8401720CCB@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Sarjeant <greg-QNIYhHqVzB9kr2E5YSwMOQ@public.gmane.org>, Dirk Koopman <djk-ovDUel0N34n10XsdtD+oqA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> Actually, we need to solve the _CRS issue first.  I have=20
> roughly looked into \_SB_.PCI0.LPCB.LNKA._CRS.
> But the method looks well. Maybe there is ACPCA bug somewhere.
>=20
>=20

  Actually an IRQ resource descriptor is expected to return from
below method, but If And(\_SB.PCI0.LPCB.PIRA,0x80) is zero, which
means this link device is not disalbed, then the following And
statement will store a integer into Local0 , and that will cause
type mis-matched as shown in dmesg. So this is BIOS bug.
 But kernel can tolerate this buggy BIOS, because kernel will
choose an IRQ from its possible IRQ list.

Thanks,
Luming



			   Method (_CRS, 0, NotSerialized)
                    {
                        Store (Z007, Local0)
                        CreateWordField (Local0, 0x01, IRA0)
                        If (LEqual (And (\_SB.PCI0.LPCB.PIRA, 0x80),
Zero))
                        {
                            And (\_SB.PCI0.LPCB.PIRA, 0x0F, Local0)
                            ShiftLeft (0x01, Local0, IRA0)
                        }
                        Else
                        {
                            Store (0x00, IRA0)
                        }

                        Return (Local0)
                    }


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
