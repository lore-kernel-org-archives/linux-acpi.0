From: Lukas Schrangl <schrangl-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: Bad: scheduling while atomic!
Date: Thu, 1 Apr 2004 08:46:01 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200404010846.02216.schrangl@gmx.net>
References: <200403311054.55536.schrangl@gmx.net> <200403311107.02570.schrangl@gmx.net> <20040331135925.GF28355@dreamcraft.com.au>
Reply-To: schrangl-hi6Y0CQ0nG0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040331135925.GF28355-+XVqjN4+fIJfbCVcMT5z6Ydd74u8MsAO@public.gmane.org>
Content-Disposition: inline
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

Am Mittwoch, 31. M=E4rz 2004 15:59 schrieb Tomasz Ciolek:
>  I get the same error with suspend to disk on a Fujitsu P2120. Ali 1535
>  chipset is the common bit...
>
>  Whats the network card you use?
>

Broadcom BCM 4401

>  Tomasz Ciolek
>
> On Wed, Mar 31, 2004 at 11:07:02AM +0200, Lukas Schrangl wrote:
> > Am Mittwoch, 31. M?rz 2004 10:54 schrieb Lukas Schrangl:
> > > Hi!
> > >
> > > I've been trying to get S4 working for several weeks now using kernel
> > > 2.6.4 and it still does not work.
> > > Going to sleep with "echo -n 4 > /proc/acpi/sleep" works - but i get
> > > some APIC error (don't know exactly - can't read that fast).
> > > When powering on again it first start normal, but then there is an
> > > endless loop displaying "Bad: Scheduling while atomic!" and a call
> > > trace again and again very fast. I can only hard- poweroff my compute=
r.
> > > Disabling local APIC does not help.
> > >
> > > S3 does not wake up either (fan and hd spin up and then silence). Onc=
e,
> > > with minimal kernel configuration I managed to get a picture again on
> > > the screen, showing the same "Bad: Scheduling while atomic!" thing.
> > >
> > > Maybe someone can help me getting S4 working!
> > > Lukas
> >
> > I forgot:
> > ALi M1533 Chipset
> > ATI IGP 320M Northbridge
> > Ahlon XP 2500+ Northbridge
> > SuSE 9.0
> > Kernel 2.6.4
> >
> >
> > -------------------------------------------------------
> > This SF.Net email is sponsored by: IBM Linux Tutorials
> > Free Linux tutorial presented by Daniel Robbins, President and CEO of
> > GenToo technologies. Learn everything from fundamentals to system
> > administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=3Dclick
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel

Lukas


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
