From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: Re: PROBLEM: ACPI freezes 2.6.1 on boot
Date: Thu, 22 Jan 2004 15:28:09 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <400FDDF9.8020001@pca.it>
References: <7F740D512C7C1046AB53446D3720017361885C@scsmsx402.sc.intel.com> <m3u12pgfpr.fsf@reason.gnu-hamburg> <m3ptddgckg.fsf@reason.gnu-hamburg> <20040122120854.GB3534@hell.org.pl> <16399.55109.244040.516731@alkaid.it.uu.se> <20040122140546.GD5194@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040122140546.GD5194-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
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

on 01/22/04 15:05, Karol Kozimor wrote:
> I don't really know. I'm not the author of the patch, I just found it
on my
> disk and I remember it allowed me to boot with LAPIC compiled in, as the
> system would otherwise hang during _STA and _INI execution. I don't even
> know if the patch is still correct.
IIRC and AFAIK, I guess Georg has an ASUS Centrino notebook (M2N), so
this problem is common on all ASUS Centrino (M2N and M3N at least) and
it is known since a while in the ancient ACPI-support mailing-list:

http://sourceforge.net/mailarchive/forum.php?thread_id=3210431&forum_id=7803
http://sourceforge.net/mailarchive/forum.php?thread_id=3165365&forum_id=7803

So, should the patch maybe work even on my ASUS M3N?

Obviously, if I complete missunderstood the problem, please excuse me.

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFAD934VAp7Xm10JmkRAvnnAJ4/d26VPNw4LsRoWSr+Pre2HnchJwCfZKHu
gvIIn7cZ7568sybh45sfF/0=
=1tJU
-----END PGP SIGNATURE-----



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
