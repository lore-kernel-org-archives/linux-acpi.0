From: Martijn Pieters <mj-a5Jd59zECFiB+jHODAdFcQ@public.gmane.org>
Subject: Re: ASL fixing questions
Date: Fri, 13 Feb 2004 09:20:29 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <402CDD2D.9050808@zopatista.com>
References: <3ACA40606221794F80A5670F0AF15F8401CBB6AE@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDC26DBBD0DDC1F3D0EAED005"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401CBB6AE-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDC26DBBD0DDC1F3D0EAED005
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Yu, Luming wrote:
>>Okay, so I have a nice new eMachines M6805, but ACPI support 
>>is screwed. 
> 
> 
> I want to know the error messages that give you impression that
> ACPI support is screwed. Or some expected functionality has 
> broken.  It's very important to judge whether we need to hack 
> ASL , and give you a hint to hack which part of ASL.

Just starting on my ACPI journey. My first tries to get an ACPI kernel 
working have led to a plethora of probems, and at the time I didn't have 
enough experience to be able to seperate ACPI problems from others.

I'll get back to those problems later, if/when I have time (next 3-5 
weeks are going to be absolutely more than hecktic, I am moving across 
the Atlantic again).

>>I am trying fix the AML the bios provided me, and iron out all the 
>>errors and warnings. Attached my DSDT.dsl, as fixed so far.
>>
>>So far I got rid of the warnings (_WAK didn't return anything; fixed 
>>with examples from working DSTS-es, _BTS method didn't return 
>>anything 
>>on some control paths; move return out of if statement down).
> 
> 
> I'm not sure this kind of hack could solve the problem you have.

No, but they were a start. I am hopeful that the Field error encountered 
may have something to do with it. But again, I have no time right now to 
experiment and find out. This laptop has got a job to do right now.

Martijn

--------------enigDC26DBBD0DDC1F3D0EAED005
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFALN0t3xaj2GOvgP0RAkgxAKCPSuJ3Dbx/4j8yJzob/2tQxcGCzACfWqSf
1Ib9b/2YDMoNPyv3XcMp0rU=
=fYXi
-----END PGP SIGNATURE-----

--------------enigDC26DBBD0DDC1F3D0EAED005--


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
