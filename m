From: Arkadiusz Miskiewicz <arekm-k0Z414SquRyhPH1hqNUYSQ@public.gmane.org>
Subject: Re: ACPI: S3 and PAE do not like each other for now, S3 disabled.
Date: Tue, 27 Jul 2004 01:27:23 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200407270127.23507.arekm@pld-linux.org>
References: <200407252330.05542.arekm@pld-linux.org> <1090874983.2325.13.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1090874983.2325.13.camel-D2Zvc0uNKG8@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Monday 26 of July 2004 22:49, Len Brown wrote:
> On Sun, 2004-07-25 at 17:30, Arkadiusz Miskiewicz wrote:
> > Is this ,,ACPI: S3 and PAE do not like each other for now, S3 disabled.=
''
> > generic S3 and PAE issue or just Linux issue only?
> >
> > The case is ,,NX (Execute Disable)'' needs PAE to work on x86 but having
> > S3 working at the same time would be nice.
>
> This may be bit-rot.
> The last time somebody tested this IIR  S3 worked
> exactly the same in PAE as it did in conventional MMU mode.
It didn't work for me unfortunately.

My laptop went into sleep, fan turned off but LCD turned all white. After=20
closing and opeing LID, fan started again, LCD turned back to live but scre=
en=20
was corrupted, random characters in different places.

Unfortunately I never tested S3 on PAE-disabled kernel so it's possible tha=
t=20
my problems are unrelated to PAE (I hope that's the case).

> -Len

=2D-=20
Arkadiusz Mi=B6kiewicz     CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org, 1024/3DB19BBD, JID: arekm.jabber.org, PLD/Linux


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
