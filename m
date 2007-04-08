From: Dominique Michel <dominique.michel@citycable.ch>
Subject: Re: daylight saving makes computer wake up late
Date: Sun, 8 Apr 2007 21:50:37 +0200
Message-ID: <20070408215037.425b4883@localhost>
References: <135ab3ff0704080512k2bcf3973m46c8153ff6a6f7df@mail.gmail.com>
 <20070408141040.GA14308@khazad-dum.debian.net>
 <135ab3ff0704081118g3bebd25bj7394483a50549dea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.alinto.citycable.ch ([85.218.0.111]:39454 "HELO
	citycable.ch" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751975AbXDHT5M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 8 Apr 2007 15:57:12 -0400
In-Reply-To: <135ab3ff0704081118g3bebd25bj7394483a50549dea@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Morten Friesgaard <friesgaard@gmail.com>, linux-acpi@vger.kernel.org

Le Sun, 8 Apr 2007 20:18:28 +0200,
"Morten Friesgaard" <friesgaard@gmail.com> a =C3=A9crit :

> I'm not sure what to do, how do I make these changes?
>=20
> when I run the following it gives me somewhat the same values, but it
> seems the BIOS clock i different (?!)
> # hwclock ; date
> Sun Apr  8 20:13:56 2007  -0.069330 seconds
> Sun Apr  8 20:13:55 CEST 2007
>=20
> it worked before daylight savings, is it something I can ignore and
> still get it to wake up the corret time?
>=20
> should I change
> TIMEZONE=3D"Europe/Copenhagen"
>=20
> to
> TIMEZONE=3D"UTC"
> ??
>=20
> /Morten
>=20

You must have 2 things:

CLOCK=3D"UTC"
TIMEZONE=3D"Europe/Copenhagen"

The first one tell the OS that the rtc use UTC time, the second one at =
it must
convert the UTC time into Europe/Copenhagen time to get the current sys=
tem
time.

On gentoo I also have an option that set the Hardware Clock to the curr=
ent
System Time during shutdown:

CLOCK_SYSTOHC=3D"yes"

Some linux distributions use CLOCK=3D"local" because, I guess, they are
thinking at it is best to do so when you are double booting with window=
s. It is
wrong because when the rtc use local time, the system have to change th=
e time
in the rtc (read in the hardware) when the daylight is changing, and ea=
ch OS
will change the time in the rtc.=20

So, you will get the correct time after booting the first OS, a shift o=
f one
hour after booting the second OS, and so on. It is much simpler to use =
UTC
with all the OS in the box, and that even with window$ (it is an option=
 in the
register base, I don't remember where but a google search will give you=
 the
reference.)

With CLOCK=3D"UTC", the time in the rtc (in the hardware) will never ch=
ange, the
OS will just interpret it with the value of TIMEZONE.

Ciao,
Dominique

>=20
> On 08/04/07, Henrique de Moraes Holschuh <hmh@hmh.eng.br> wrote:
> > On Sun, 08 Apr 2007, Morten Friesgaard wrote:
> > > I'm running a mythbox, and ever since we had our yearly change of
> > > daylight savings (summer time) my computer wakes up late. At firs=
t it
> > > was only an hour, then I set the time with hwclock (realised that
> > > CLOCK_SYSTOHC=3D"no"), now it is 2 hours late. And it is really p=
recise
> > > (1-2 hours later), and it is certainly because of daylight saving=
s.
> > >
> > > Any ideas?
> >
> > My guess is that you have to set ACPI wake times to *exactly* the t=
ime zone
> > you use your RTC in.  Typically UTC, but semi-broken MS-compatible =
setups
> > use the local time zone.
> >
> > The kernel can know the timezone, but almost nobody ever sets that =
right,
> > and it is not summer-time aware anyway (too complex).  It is best t=
o just
> > keep everything UTC as far as the kernel goes, *including* the RTC.
> >
> > --
> >   "One disk to rule them all, One disk to find them. One disk to br=
ing
> >   them all and in the darkness grind them. In the Land of Redmond
> >   where the shadows lie." -- The Silicon Valley Tarot
> >   Henrique Holschuh
> >
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--=20
Dominique Michel

--
N.B.: Tous les emails que je re=C3=A7ois sont filtr=C3=A9s par spamassa=
ssin avant de me
parvenir.
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
