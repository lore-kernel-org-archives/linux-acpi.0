From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: RE: \_PR\CPU\_INI not called during initialization
Date: Tue, 7 Oct 2003 09:02:50 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <D3A3AA459175A44CB5326F26DA7A189C1C3DE8@orsmsx405.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

We are going to add this support for the next version of ACPI CA.

The MS interpreter executes both _STA and _INI under processor objects.
Bob


-----Original Message-----
From: Ducrot Bruno [mailto:ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org]=20
Sent: Tuesday, October 07, 2003 12:53 AM
To: Moore, Robert
Cc: Nate Lawson; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: Re: [ACPI] RE: \_PR\CPU\_INI not called during initialization

On Mon, Oct 06, 2003 at 03:58:32PM -0700, Moore, Robert wrote:
> Nope. A Processor object is just that.  A Processor.  Not a Device.
> Just because something can appear under _SB does not imply that it is
a
> Device object.
>=20
> However, once again, we need to see what MS does.
> Bob
>=20

Some IBM laptops shipped with a Pentium have that,
or equivalent:

    Scope (\_PR)
    {
        Processor (CPU, 0x01, 0x00001010, 0x06)
        {
            Method (_INI, 0, NotSerialized)
            {
                Store (\P0FQ, Index (DerefOf (Index (_PSS, 0x00)),
0x00))
                Store (\P0PW, Index (DerefOf (Index (_PSS, 0x00)),
0x01))
                Store (\P1FQ, Index (DerefOf (Index (_PSS, 0x01)),
0x00))
                Store (\P1PW, Index (DerefOf (Index (_PSS, 0x01)),
0x01))
                If (\PCEL)
                {
                    Store (0xF6, Index (DerefOf (Index (_PSS, 0x01)),
0x05))
                    Store (0x00, Index (DerefOf (Index (_PSS, 0x01)),
0x05))
                }
            }

            Name (_PCT, Package (0x02)
            {
                ResourceTemplate ()
                {
                    Register (SystemIO, 0x08, 0x00, 0x00000000000000B2)
                },=20

                ResourceTemplate ()
                {
                    Register (SystemIO, 0x08, 0x00, 0x0000000000001050)
                }
            })
            Name (_PSS, Package (0x02)
            {
                Package (0x06)
                {
                    0x00,=20
                    0x00,=20
                    0x01F4,=20
                    0x00,=20
                    0xF6,=20
                    0x00
                },=20

                Package (0x06)
                {
                    0x00,=20
                    0x00,=20
                    0x01F4,=20
                    0x00,=20
                    0xF7,=20
                    0x01
                }
            })
            Method (_PPC, 0, NotSerialized)
            {
                If (LNot (\SPEN))
                {
                    Return (0x01)
                }

                If (\_SB.PCI0.LPC.EC.TT4F)
                {
                    Return (0x01)
                }
                Else
                {
                    Return (0x00)
                }
            }
        }
    }


--=20
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
