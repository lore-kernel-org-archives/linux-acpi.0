From: =?ISO-8859-1?Q?Marc_M=FCller?= <marc.muller-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: Centrino acpi issues (Issue 1 of 2)
Date: Mon, 22 Mar 2004 14:19:32 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <405EE7E4.50609@gmx.net>
References: <4059D0DA.5050901@gmx.net> <Pine.LNX.4.58.0403191037220.1356@frog.athome> <405ACA5E.1050906@pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <405ACA5E.1050906-wlebWZzHoyE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Thanks guys for your help!
Disabling APIC support fixed the issue for me (now I have to find out,
what stuff will not be working because i've disabled apic...)

For the other issue, the notebook not wakeing up after suspend to ram,
nobody has any hints?

greets,
Marc

Luca Capello wrote:
| Hello,
|
| on 03/19/04 10:41, liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org wrote:
|
|>>>I have some problems running kernel 2.6.4 acpi on my centrino notebook.
|>>>
|>>>1. When i issue a shutdown command I only get a message saying:
|>>>'acpi_power_off called'. Then the screen turns black and according to
|>>>the fan noise I think the cpu get in some kind of infinite loop. It
|>>>doesn't power off.
|
| I experienced the same problem on my Centrino ASUS M6842NWH.
|
|
|>for this issue you might want to follow
|>http://bugme.osdl.org/show_bug.cgi?id=2183
|>and see the duplicate at the end. Then you will find a patch:
|>"hwsleep.c revert part of v1.23 introduced cond. when S5".
|
| I tried this patch with no success and then I found that the problem
in my case
| is completely different: I disabled APIC support in the kernel (not even
| compiled) and then I've clean shutdown.
|
| So you've 2 tests:
| - Hartwig's patch
| - disabling APIC support
|
| Thx, bye,
| Gismo / Luca

- -------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAXufiTHwli514ylARAoM4AJ4mS8+z1rPVCw0tferkyAQqJ7T+EACfWH3z
r7JjMiXbfcsGS9uVopcmvPc=
=fTtB
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
