From: Keld =?iso-8859-1?Q?J=F8rn?= Simonsen <keld-6PR53cSIHaE@public.gmane.org>
Subject: Re: Critical temperature even when idle with 2.6.7+patch, works fine in 2.4.26
Date: Thu, 8 Jul 2004 15:06:50 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040708130650.GA19545@rap.rap.dk>
References: <20040702094846.GB2141@torni> <20040702122725.GD16229@rap.rap.dk> <200407021848.46872.kernelpenguin@hot.ee> <20040708071316.GB2455@torni>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040708071316.GB2455-WhBRsLHorrc@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ville =?iso-8859-1?Q?P=E4tsi?= <drc-gbHDUNYU5Z63CdJRPK1N2g@public.gmane.org>
Cc: Elver Loho <kernelpenguin-S7FoVGKkKTI@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Keld =?iso-8859-1?Q?J=F8rn?= Simonsen <keld-6PR53cSIHaE@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Jul 08, 2004 at 10:13:16AM +0300, Ville P=E4tsi wrote:
> > : I have the same problem on an Acer Travelmate 233 XC (same model).
> > : The system gets really heated under kernel 2.6.7, while under 2.6.3=
 it
> > : runs much cooler. Also I see from metering power consumption that
> > : it seems like the CPU does not do idle looping. It does not reach 8=
0
> > : degrees, but something like 65 degrees is common, while on 2.6.3 th=
e
> > : system stays about 48 degrees. I run X on the system, but the syste=
m is
> > : quite idle.
> > Similar problem here. 1.3ghz Celeron M. Anyone found the source of th=
e problem=20
> > yet?
>=20
> I opened a bug for this. http://bugzilla.kernel.org/show_bug.cgi?id=3D3=
008
> In there is atleast a workaround that works for me.

I set HZ to 100 in include/asm-i386/param.h but still my CPU goes to
62 degrees in stead of 46. But it does not go to 80 degrees, so maybe my
problem was another than yours (although it is the same make and model -
strange).

It is on a vanilla 2.6.7 kernel, and I did no patch on it.

I have a feeling that it may be because the kernel want to set it in C2
and that the machine only supports C2 - but this is a totally
unresearched hinch.

Best regards
keld


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
