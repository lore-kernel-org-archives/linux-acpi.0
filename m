From: Martijn Pieters <mj-a5Jd59zECFiB+jHODAdFcQ@public.gmane.org>
Subject: Re: ASL fixing questions
Date: Thu, 12 Feb 2004 11:33:00 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <402BAABC.5040706@zopatista.com>
References: <402AF9FF.3020706@zopatista.com> <20040212093732.GP13262@poupinou.org> <402B9313.9000701@zopatista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE6C50A0F06FF08F1A9960285"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <402B9313.9000701-a5Jd59zECFiB+jHODAdFcQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE6C50A0F06FF08F1A9960285
Content-Type: multipart/mixed;
 boundary="------------030903060806020106040901"

This is a multi-part message in MIME format.
--------------030903060806020106040901
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

>> Do you have a SSDT table ?  If so, this object may be in that SSDT
>> instead.

> SSDT decompilation fails with:
> 
>    dswload-0264: *** Error: Looking up [\_PR_.CPU0] in namespace,
> AE_NOT_FOUND
>    psparse-1283: *** Error: [NULL NAME], AE_NOT_FOUND
> Could not parse ACPI tables, AE_NOT_FOUND
> 
> How can I decompile the SSDT table with the DSDT namespace available? Ue
> an Include in the DSDT AML? Your suspicion could be right,  hexedit of
> the SSDT code does show a _PPC declaration.

Okay, I decompiled the SSDT table by hand (small table anyway), find it 
attached (really!). It doates indeed define the _PPC field and two other 
names, which make little sense to me.

Which leads to my next question: I thought leading underscore names were 
reserved by the ACPI spec. ACPI 1.0 doesn't define the names, and ACPI 
2.0 defines them differently. Can this lead to problems with the Linux 
ACPI implementation making assumptions about ACPI 1.0 code with 2.0 
extensions?

Martijn

--------------030903060806020106040901
Content-Type: text/x-dsl;
 name="ssdt.dsl"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ssdt.dsl"

DefinitionBlock ("SSDT.aml", "SSDT", 1, "PTLTD ", "POWERNOW", 100925440)
{
    Scope (\_PR.CPU0)
    {
        Name (_PCT, Package (0x02)
        {
            Buffer (0x11)
            {
                0x82, 0x0C, 0x00, 0x7F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                0x00, 0x00, 0x00, 0x00, 0x00, 0x79, 0x00
            },
            Buffer (0x11)
            {
                0x82, 0x0C, 0x00, 0x7F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                0x00, 0x00, 0x00, 0x00, 0x00, 0x79, 0x00
            }
        })
        Name (_PSS, Package (0x03) // 102 (206)
        {
            Package (0x06)
            {
                0x08070000,
                0xB36A0000,
                0x7D000000,
                0x09000000,
                0x8A2920E0,
                0x8A010000
            },
            Package (0x06)
            {
                0x40060000,
                0xA8610000,
                0x7D000000,
                0x09000000,
                0xBB2A20E0,
                0xBBC20000
            },
            Package (0x06)
            {
                0x20030000,
                0x7F3C0000,
                0x7D000000,
                0x09000000,
                0x002E20E0,
                0x00060000
            }
        })
        Name (_PPC, 0x00)
    }
}

--------------030903060806020106040901--

--------------enigE6C50A0F06FF08F1A9960285
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAK6q83xaj2GOvgP0RAlx7AKDQ6qya4GV6ubbZ654bNYTK8EVE/wCfWvKx
yPT2+vHhZToplJxg6CVOLAo=
=u8j5
-----END PGP SIGNATURE-----

--------------enigE6C50A0F06FF08F1A9960285--


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
