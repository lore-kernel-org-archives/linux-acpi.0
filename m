From: Jens Haug <haug-X6ztD3ggwzuBAmxm6OvjtTjhTm2NLCe8@public.gmane.org>
Subject: Re: SSDT on Sony VAIO
Date: Fri, 17 Jan 2003 08:37:53 +0100 (MET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200301170737.h0H7bsD14854@ikffws2.ikff.uni-stuttgart.de>
Reply-To: Jens Haug <haug-X6ztD3ggwzuBAmxm6OvjtTjhTm2NLCe8@public.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-MD5: PhynrC/L4c8sSPBjgXi0ag==
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: aileenja-dTzOdQ2U+/YAvxtiuMwx3w@public.gmane.org, linux-JhLEnvuH02M@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> On Fri, Jan 17, 2003 at 02:22:42AM +0900, Adachi, Kenichi wrote:
> > Incidentally I didn't know the existence of CpuFreq project when I made
> > the above statement. Dominik, if BIOS tells OS via ACPI _PCT to access
> > FFH to initiate FID/VID change (in AMD PowerNow!), how current code
> > coordinates it? I'm going to look into code soon, but I'd appreciate
> > very much if you give me some insight in advance.
>=20
> Currently, it fails with this error message. If you add your patch,
> frequency transitions will still fail - the ACPI processor driver doesn't
> know anything about the PowerNow internals. So loading of teh ACPI cpufre=
q
> driver will be aborted at latest in acpi_cpufreq_init, if not earlier.
>=20
> So, actually I can't think of any way to use the ACPI processr driver for
> CPU frequency transitions in these cases - you need to use the "legacy"=
=20
> powernow-k7.c driver instead (which is currently developed by Dave Jones)=
.

Did I understand this? I'm not sure.
ACPI P-States use the cpufreq infrastructure (in 2.5.x). Cpufreq
itself uses either the ACPI processor driver (for supported CPUs)=20
or a special driver (like powernow-k7).
So, in the future, ACPI P-States will use Cpufreq, Cpufreq will
use powernow-k7, and everybody will be happy. Or can't we use
P-States here at all, and everything will be done by Cpufreq like
on a non-ACPI system?


Jens

--=20
Jens Haug
IKFF Universit=E4t Stuttgart              Tel. 0711/685-6422
Pfaffenwaldring 9                       Fax  0711/685-6356
70550 Stuttgart=09                haug-X6ztD3ggwzuBAmxm6OvjtTjhTm2NLCe8@public.gmane.org



-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com
Understand how to protect your customers personal information by implementing
SSL on your Apache Web Server. Click here to get our FREE Thawte Apache 
Guide: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0029en
