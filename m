From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: AE_AML_REGION_LIMIT trouble
Date: Fri, 24 Oct 2003 09:14:09 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <CFF522B18982EA4481D3A3E23B83141C24B4E3@orsmsx407.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Eric <plukje-hi6Y0CQ0nG0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Looks like a problem, I was able to reproduce it with the code below.  I
will look into it.

Bob


-----Original Message-----
From: Ducrot Bruno [mailto:ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org]=20
Sent: Friday, October 24, 2003 8:52 AM
To: Eric; Moore, Robert
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: Re: [ACPI] AE_AML_REGION_LIMIT trouble

On Sun, Oct 19, 2003 at 03:24:18PM +0200, Eric wrote:
> Greetings everyone on this mailinglist,
>=20
> I seem to be having a small ACPI problem, of which I don't really know

> what it exactly means,
> or what I can do to fix it. I'm running linux kernel 2.6.0-test8 and=20
> I've seen this error from as early as
> 2.6.0-test1. The machine is a MSI-6728 motherboard with a P4 (with HT)

> on it. Below I've put the output of dmesg (up to where acpi messages
stop).
> Please let me know if there is anything else you might be interested
in=20
> to clarify this situation because I'm really curious if this is BIOS
problem
> or a possible bug in the ACPI code.
>=20


You have that in your ASL:

            OperationRegion (TMEM, PCI_Config, 0xC4, 0x02)
            Field (TMEM, ByteAcc, NoLock, Preserve)
            {
                    ,   3,
                TOUD,   13
            }

            Name (TOM, 0x00)
            Method (MDET, 0, NotSerialized)
            {
                If (TOM) {}
                Else
                {
                    If (FLAG)
                    {
                        ShiftLeft (TOUD, 0x13, TOM)
                    }
                    Else
                    {
                        Return (0x20000000)
                    }
                }

                Return (TOM)
            }


I am pretty sure that the root of your trouble is
the 'ShiftLeft (TOUD, 0x13, TOM)'.
(For info, FLAG is declared as Name (FLAG, 0x01), so
that is not the problem as well).

I think it is valid, and suspect more or less there is
a bug in ACPICA.  But I am not sure.  If a guru
can help me to determine that I am right or wrong (Bob?).

Cheers,

--=20
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
