From: Martijn Pieters <mj-a5Jd59zECFiB+jHODAdFcQ@public.gmane.org>
Subject: Re: ASL fixing questions
Date: Thu, 12 Feb 2004 16:20:52 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <402BEE34.9050908@zopatista.com>
References: <402AF9FF.3020706@zopatista.com> <20040212093732.GP13262@poupinou.org> <402B9313.9000701@zopatista.com> <402BAABC.5040706@zopatista.com> <20040212204335.GU13262@poupinou.org> <402BE889.5090502@zopatista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig94A6F6E3D27758CDBBF52864"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <402BE889.5090502-a5Jd59zECFiB+jHODAdFcQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig94A6F6E3D27758CDBBF52864
Content-Type: multipart/mixed;
 boundary="------------080901010103060100080608"

This is a multi-part message in MIME format.
--------------080901010103060100080608
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Martijn Pieters wrote:
> Not enough experience with hand disassembly, that is. That is me not 
> realizing that the bytes are in the other order. And that 0E is my typo.
> 
> iasl just refuses to disassemble the SSDT table, maybe because 
> \_SB._PR.CPU0 should be declared an external?

Make that \_PR.CPU0.

Attached a cleaned up version where I also used another font on khexedit 
to avoid mistaking 'B' for '8'.

Now I only still have questions about the other errors in the DSDT in my 
earlier emails.

Martijn

--------------080901010103060100080608
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
        Name (_PSS, Package (0x03)
        {
            Package (0x06)
            {
                0x0708,
                0x6AB3,
                0x7D,
                0x09,
                0xE020298A,
                0x018A
            },
            Package (0x06)
            {
                0x0640,
                0x61A8,
                0x7D,
                0x09,
                0xE0202A88,
                0x0288
            },
            Package (0x06)
            {
                0x0320,
                0x3C7F,
                0x7D,
                0x09,
                0xE0202E,
                0x0600
            }
        })
        Name (_PPC, 0x00)
    }
}

--------------080901010103060100080608--

--------------enig94A6F6E3D27758CDBBF52864
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAK+403xaj2GOvgP0RAqL6AJ46fzUXTzJeZpEZn0yrmi3Xsmx2+wCeK+o4
Nihl3zQ+GYT/g02HchiVuo0=
=0KQO
-----END PGP SIGNATURE-----

--------------enig94A6F6E3D27758CDBBF52864--


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
