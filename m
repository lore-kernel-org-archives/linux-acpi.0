From: Martijn Pieters <mj-a5Jd59zECFiB+jHODAdFcQ@public.gmane.org>
Subject: ASL fixing questions
Date: Wed, 11 Feb 2004 22:58:55 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <402AF9FF.3020706@zopatista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig141F0B9565EB0E6B582C7677"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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
--------------enig141F0B9565EB0E6B582C7677
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi list,

Okay, so I have a nice new eMachines M6805, but ACPI support is screwed. 
I am trying fix the AML the bios provided me, and iron out all the 
errors and warnings. Attached my DSDT.dsl, as fixed so far.

So far I got rid of the warnings (_WAK didn't return anything; fixed 
with examples from working DSTS-es, _BTS method didn't return anything 
on some control paths; move return out of if statement down).

However, I am still stuck with 3 different error classes I have trouble 
figuring out.

First of all, there are 7 references to a _PPC field on the CPU0 
Processor object:

dsdt.dsl  2035: Store (Zero, \_PR.CPU0._PPC)
Error    1022 -     Object does not exist ^  (\_PR.CPU0._PPC)

Now, _PPC is a ACPI 2.0 *Method*, not a field, and this ASL states it 
adheres to ACPI _version 1.0_. My question: Is this a Microsoft-only 
extension to the ACPI 1.0 spec and can I safely remove these _PPC lines 
for Linux? They appear to set the CPU power states, but I am not sure 
how to correctly set these from ASL otherwise.

The second error is that there are 3 Field declarations that seem to 
want to address more information than the OperationRegions they are 
attached to:

dsdt.dsl  2953: PWST,   2,
Error    1051 -    ^ Access width of Field Unit extends beyond region limit

I am not sure how to go about fixing these yet; I am not entirely sure 
what the syntax means yet.

Last but not least, tehre is one Field declaration that wants to define 
AnyAcc to a OperationRegion, something that apparently isn't possible:

dsdt.dsl  3235: Field (ERAM, AnyAcc, NoLock, Preserve)
Error    1048 -           ^ Host Operation Region requires ByteAcc access

Again, I have no clue yet how to go about fixing this error, if at all 
possible.

Any help or hints is greatly appreciated!

Martijn Pieters


--------------enig141F0B9565EB0E6B582C7677
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAKvoF3xaj2GOvgP0RAuGHAJ9KgIkgpX0SaIHy2ZmA853PQeTnmgCfaDsD
sLvpgBMoFxZnOgGe/KGEecU=
=aEC5
-----END PGP SIGNATURE-----

--------------enig141F0B9565EB0E6B582C7677--


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
