From: liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Subject: Please comment on poweroff-patch
Date: Sat, 13 Mar 2004 12:01:10 +0100 (CET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.58.0403131152490.1228@frog.athome>
References: <1079031999.3679.1.camel@darkstar> <20040311230047.GA20345@stikine.ucs.sfu.ca>
 <Pine.LNX.4.58.0403121055010.1203@frog.athome> <20040312193716.GC25056@stikine.ucs.sfu.ca>
Reply-To: liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040312193716.GC25056-0ze2hujOWYhqr3d4nwidZ7Dks+cytr/Z@public.gmane.org>
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Salut list,
I posted 10days ago a patch to this list. I have positive feedback from
users who had the same problem as I had. But as I only traced down, which
part of the change in the hwsleep.c (v 1.23) had broken powering-off, I
would like verry much to hear, why this regressing changes were done in
the first place. Please comment on my patch. I am verry intressted to
hear, if the problems is BIOS-specific, or an Linux-acpi-issue.

http://bugme.osdl.org/show_bug.cgi?id=2183

Cheers
  hartwig felger

Hartwig Felger informatics

- -- 
1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Key fingerprint = FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
For the pulic keys, please visit my page.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFAUuoF9bBoTzOf1pMRAjDcAJ95xcX26fblgMBkZ78A0XFUmobBPQCgmHpO
hvFovkogRo5c31L6/WwOOBA=
=p5sx
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
