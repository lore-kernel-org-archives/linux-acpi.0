From: Martijn Pieters <mj-a5Jd59zECFiB+jHODAdFcQ@public.gmane.org>
Subject: Re: ASL fixing questions
Date: Thu, 12 Feb 2004 09:52:03 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <402B9313.9000701@zopatista.com>
References: <402AF9FF.3020706@zopatista.com> <20040212093732.GP13262@poupinou.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig329DDDBD2AA494D1D2892C51"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040212093732.GP13262-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
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
--------------enig329DDDBD2AA494D1D2892C51
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

(Resend to all, corrected address, sorry Bruno, 
one-hand-typing-with-baby-error, she's-asleep-and-so-am-I-failure)

Bruno Ducrot wrote:
>>dsdt.dsl  2035: Store (Zero, \_PR.CPU0._PPC)
>>Error    1022 -     Object does not exist ^  (\_PR.CPU0._PPC)
> 
> 
> Do you have a SSDT table ?  If so, this object may be in that SSDT
> instead.

SSDT decompilation fails with:

    dswload-0264: *** Error: Looking up [\_PR_.CPU0] in namespace,
AE_NOT_FOUND
    psparse-1283: *** Error: [NULL NAME], AE_NOT_FOUND
Could not parse ACPI tables, AE_NOT_FOUND

How can I decompile the SSDT table with the DSDT namespace available? Ue
an Include in the DSDT AML? Your suspicion could be right,  hexedit of
the SSDT code does show a _PPC declaration.

> Well, actually there is a lot of AML's that claims to be only 1.0
> compliant but have a lot of 2.0 extensions...

Hmmm,but _PPC is a AML 2.0 method to query possible states, not a field
to set the state, such as this code does.

>>dsdt.dsl  2953: PWST,   2,
>>Error    1051 -    ^ Access width of Field Unit extends beyond region limit
> 
> 
> You can fix it by compiling the kernel with CONFIG_ACPI_RELAX option.
> I will read your the ASL, though, to be sure.

Okay, the email with the ASL attached to the list was released by the
moderators already.

>>Last but not least, tehre is one Field declaration that wants to define 
>>AnyAcc to a OperationRegion, something that apparently isn't possible:
>>
>>dsdt.dsl  3235: Field (ERAM, AnyAcc, NoLock, Preserve)
>>Error    1048 -           ^ Host Operation Region requires ByteAcc access
> 
> > s/AnyAcc/ByteAcc on the faulty line, perhaps ;)

There are two Field definitions referring to that OperationRegion; one
ByteAcc and one AnyAcc. It is clear the author expected this to work and
needed the behaviour..

Martijn



--------------enig329DDDBD2AA494D1D2892C51
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAK5MT3xaj2GOvgP0RAtE3AKC7sZNc9BctRUpeEVlY5gGdVoVQZgCfWleX
9cvN7+0EQ+ZK8mjCdokj6is=
=J/f3
-----END PGP SIGNATURE-----

--------------enig329DDDBD2AA494D1D2892C51--


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
