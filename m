From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: RE: acpi-20031203-2.6.0.diff brokes the battery status readings with 2.6.0 in DELL Inspiron 8500
Date: Wed, 31 Dec 2003 18:31:34 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8401720C69@PDSMSX403.ccr.corp.intel.com>
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
To: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>, "Mark M." <maalox-XzQKRVe1yT0V+D8aMU/kSg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>>      -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
>>      -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
>>      -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
>>      -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
>
>Here is the bug info.  Note that Luming's patch does NOT fix the
problem
>but just silences the warnings.  If you use the ASL patch I have
attached
>that adds RefOf/DerefOf (credit Mark Santcroos), the problems are
fixed.
>You can also revert dsmthdat.c back to what it was pre-0619 and that
also
>fixes the problem.
>
>http://bugme.osdl.org/show_bug.cgi?id=3D1728
>
>The issue is, ACPI-CA is still not getting its argument-passing right
>after moving away from "always copy" semantics.

Please try patch filed at  http://bugme.osdl.org/show_bug.cgi?id=3D1766



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
