From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: Can't poweroff anymore.
Date: Sun, 07 Mar 2004 19:43:48 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <404B6D64.3060604@pca.it>
References: <20040304180301.GA1754@conectiva.com.br> <Pine.LNX.4.58.0403050113230.3779@frog.athome> <Pine.LNX.4.58.0403061054120.1146@frog.athome> <4049E76D.4030000@pca.it> <404A30A5.6070802@pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <404A30A5.6070802-wlebWZzHoyE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

on 03/06/04 21:12, Luca Capello wrote:
<cut>
> I found the problem: the patch Hartwig attached lacks the first line of
> comparison, while the same patch on http://bugme.osdl.org/show_bug.cgi?id=2109
> is correct:
<cut>
> With this latest patch, kernel 2.6.3 compiles correctly, but anyway I get the
> same problem: 2.6.3 doesn't shutdown.
as I was running with 'preempt' and 'APIC/IO-APIC' and with my last ASUS
Centrino M3N 'APIC/IO-APIC' had cause some problems, I tried 3 new configurations:
- - no preempt and no APIC > shutdown works ok
- - preempt and no APIC > shutdown works again
- - preempt and APIC > shutdown doesn't work :-(

So, the real problem is APIC, sorry for the missunderstanding of the real problem.

Thx, bye,
Gismo / Luca

PS I'm posting the same message on my first thread about this problem on ASUS
M6800N, as it's an ASUS M6800N specific problem ;-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFAS21jVAp7Xm10JmkRAgfUAKCD/7I9mXKoLY83yggKhneQCKODDwCfU7zb
CXnzKdyQey/sPleFug4ofJs=
=9vsk
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
