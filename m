From: Arkadiusz Miskiewicz <arekm-k0Z414SquRyhPH1hqNUYSQ@public.gmane.org>
Subject: Re: ACPI: S3 and PAE do not like each other for now, S3 disabled.
Date: Wed, 28 Jul 2004 00:25:12 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200407280025.12449.arekm@pld-linux.org>
References: <29AC424F54821A4FB5D7CBE081922E400124E634@hdsmsx403.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <29AC424F54821A4FB5D7CBE081922E400124E634-N2PTB0HCzHJviC08c4yzC1DQ4js95KgL@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday 27 of July 2004 03:34, Brown, Len wrote:

> >Unfortunately I never tested S3 on PAE-disabled kernel so it's
> >possible that
> >my problems are unrelated to PAE (I hope that's the case).
>
> Without testing the non-PAE case, this result is inconclusive.
Tested non-PAE case, it worked (with few USB related problems) but my lapto=
p=20
was able to resume and react to my commands (+ no screen corruptions).

> In either case, it would probably be a good idea to run the
> latest ACPI patch if you're experimenting with S3.
> http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/
Will test with them next time which will be probably tommorow.

> cheers,
> -Len

=2D-=20
Arkadiusz Mi=B6kiewicz     CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org, 1024/3DB19BBD, JID: arekm.jabber.org, PLD/Linux


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
