From: Jarek Zuk <j.zuk-QYlicCNJNu5TzFIbWlesCw@public.gmane.org>
Subject: Re: ACPI wake up event (alarm)
Date: Thu, 15 Apr 2004 21:03:59 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200404152103.59184.j.zuk@cetelembank.de>
References: <W4355214192244891082045497@webmail4>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <W4355214192244891082045497-Rg38Kg9s258@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dino Klein <zagzag-lists-zY4eFNvK5D9If6P1QZMOBw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


I have Intel 845 . S2 S3 S4  dont work , no reaction at all.=20
Only S5 does something.
Yes my script unmoutns the filesystems before going to S5, to avoid fsck on=
 boot .
I have noticed also that when i invoke alarm event before  going to S5 it a=
lso works, but=20
not always ( i tried scheduling it in rc.local , but this workaroud doesnt =
help) .
Any ideas why S3 or S4 doesnt work for me ?

Jarek Zuk=20


Dnia czw 15. kwietnia 2004 18:11, napisa=C5=82e=C5=9B:
> According to the specs the RTC must be able to wakeup a system from S1, S=
2,
> or S3, S4 is optional, and S5 is not even considered a sleep state, so the
> RTC is not required to support S5. (check ACPI 2.0c, section 4.7.2.4, and
> table 5-9) Even still, the chipset might support it, as my Via 686B which
> treats S4 & S5 the same way.
>
> This is just a guess, but perhaps the handling of the wakeup bits in the
> linux ACPI is inconsistent, so when you transition to S1, it does allow f=
or
> a wakeup from the RTC, and then doesn't clear it before entering S5 (as
> specified in the footnote). However, when you go directly to S5, the RTC =
is
> not set as wakup source, and that's why it doesn't work. If S3 or S4 work
> for you, then perhaps you should use them, thus avoiding this whole issue.
>
> One sidenote - are you unmounting the filesystems before putting the
> machine to S5? after all, that's the equivalent of pressing the power
> button.
>
> > -----Original Message-----
> > From: Jarek Zuk [mailto:j.zuk-QYlicCNJNu5TzFIbWlesCw@public.gmane.org]
> > Sent: Thursday, April 15, 2004 12:48 PM
> > To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > Subject: [ACPI] ACPI wake up event (alarm)
> >
> >
> > I have a question about ACPI alarm (/proc/acpi/alarm).
> >
> > I have a cron job  that runs early in the morning, so I need my machine
> > to be up at that time. I dont want to have it up all night, so I want to
> > use the alarm feature.
> >
> > I use kernel 2.4.25 with your corresponding patch. I read everything on
> > acpi page about /proc/acpi/sleep and /proc/acpi/alarm .
> > What I want to do is :
> > echo 2004-04-15 14:40:00 > /proc/acpi/alarm
> > echo 5 > /proc/acpi/sleep
> >
> > and get the computer up when the specified time comes.
> >
> > My problem is that it works  sometimes, well what I noticed is that it
> > works providing that before I put the system into sleep mode (5)  I do :
> > echo 1 > /proc/acpi/sleep
> > (the power button starts blinking)
> > press the button  ( system is awake )
> >
> > When I  dont do this  "echo 1 > /proc/acpi/sleep" thing , the computer
> > doesn't  turn on whet time comes. :(
> >
> > Looks like putting system into a sleep mode 1 changes something that
> > allows later to do proper wakeup.
> >
> > Does the system have to be in sleep mode to be woken up by alarm event ?
> > or it should work also after shutdown ?
> >
> > I want to have this procedure in a script and presing the power button=
=20
> > is kinda difficult from a script.
> >
> > Any pointers are welcome.
> > Jarek Zuk
> >
> >
> >
> > -------------------------------------------------------
> > This SF.Net email is sponsored by: IBM Linux Tutorials
> > Free Linux tutorial presented by Daniel Robbins, President and CEO of
> > GenToo technologies. Learn everything from fundamentals to system
> > administration.http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3Dc=
lick
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
