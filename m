From: Martijn Pieters <mj-a5Jd59zECFiB+jHODAdFcQ@public.gmane.org>
Subject: Re: ASL fixing questions
Date: Thu, 12 Feb 2004 12:24:23 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <402BB6C7.9030305@zopatista.com>
References: <402AF9FF.3020706@zopatista.com> <20040212093732.GP13262@poupinou.org> <402B9313.9000701@zopatista.com> <402BAABC.5040706@zopatista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig55D88FD925CEC3296064FF0F"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <402BAABC.5040706-a5Jd59zECFiB+jHODAdFcQ@public.gmane.org>
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
--------------enig55D88FD925CEC3296064FF0F
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Martijn Pieters wrote:
> Okay, I decompiled the SSDT table by hand (small table anyway), find it 
> attached (really!). It doates indeed define the _PPC field and two other 
> names, which make little sense to me.
> 
> Which leads to my next question: I thought leading underscore names were 
> reserved by the ACPI spec. ACPI 1.0 doesn't define the names, and ACPI 
> 2.0 defines them differently. Can this lead to problems with the Linux 
> ACPI implementation making assumptions about ACPI 1.0 code with 2.0 
> extensions?

Strike that; I misremembered the ACPI 2.0 spec; these fields are indeed 
ACPI 2.0 Processor fields.

Martijn

--------------enig55D88FD925CEC3296064FF0F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAK7bM3xaj2GOvgP0RAv+lAJ92fwfeoouOVRRq4GchaLpeLG8c2ACgzx9p
NfkoM6GBRiYWRHpP9WII8LA=
=f5qI
-----END PGP SIGNATURE-----

--------------enig55D88FD925CEC3296064FF0F--


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
