From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: Centrino acpi issues (Issue 1 of 2)
Date: Fri, 19 Mar 2004 11:24:30 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <405ACA5E.1050906@pca.it>
References: <4059D0DA.5050901@gmx.net> <Pine.LNX.4.58.0403191037220.1356@frog.athome>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.58.0403191037220.1356-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
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

Hello,

on 03/19/04 10:41, liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org wrote:
>>>I have some problems running kernel 2.6.4 acpi on my centrino notebook.
>>>
>>>1. When i issue a shutdown command I only get a message saying:
>>>'acpi_power_off called'. Then the screen turns black and according to
>>>the fan noise I think the cpu get in some kind of infinite loop. It
>>>doesn't power off.
I experienced the same problem on my Centrino ASUS M6842NWH.

> for this issue you might want to follow
> http://bugme.osdl.org/show_bug.cgi?id=2183
> and see the duplicate at the end. Then you will find a patch:
> "hwsleep.c revert part of v1.23 introduced cond. when S5".
I tried this patch with no success and then I found that the problem in my case
is completely different: I disabled APIC support in the kernel (not even
compiled) and then I've clean shutdown.

So you've 2 tests:
- - Hartwig's patch
- - disabling APIC support

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFAWspeVAp7Xm10JmkRAp6DAJ4ql59S23ilLSw3rwEFo1vz0lvBEQCfZhQS
LaNBTosU0neHwxJjFZxZttE=
=RrLf
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
