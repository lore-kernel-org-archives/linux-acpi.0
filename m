From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: suspend-to-ram hangs on HP NX7010
Date: Wed, 9 Jun 2004 20:33:22 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8404991407@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pierre Ossman <drzeus-list-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>I've been spending a few days trying to get suspend-to-ram to=20
>work on my=20
>new HP NX7010 laptop. Haven't had much success though so I thought I=20
>might get some help from the more experienced.
>

Can you post the detailed HW info, as well as BIOS vendor/version?

>I'm running FC2 with linux 2.6.6. S3 has been tested using vanilla=20
>kernel and with the patch from acpi.sf.net. I've also included a patch=20
>from the ACPI bugzilla to be able to control which devices can=20
>wake the=20
>unit. The behaviour has been the same for all tests.
>

What about S4?

>I don't think the unit actually gets all the way into S3 though. If I=20
>turn on ACPI debug in the kernel I can see a debug message that says=20
>'Entering S3' but the laptop doesn't power down anything. After this=20
>point the only way to get control of the machine again is to hold down=20
>the power button for a couple of seconds, bypassing the OS. Also, for=20
>some strange reason I have to do this twice because the machine hangs=20
>during POST after the first reset (after a failed suspend-to-ram that=20
>is, works fine otherwise).
>

This is unusual. Now, the most S3 failure focus on resuming from ram.
Can you track down which driver might causes the problem?

>I've started looking in the ACPI spec. since I suspect the bug=20
>might be=20
>in the DSDT. I doesn't even compile cleanly with Intel's=20

Did you find error message from ACPI? =20

You know, AML interpreter is capable of catching AML bug. Although,
sometimes, we have to fix interpreter , rather than AML code. :)

Thanks
Luming


-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
