From: "Morten Friesgaard" <friesgaard@gmail.com>
Subject: Re: daylight saving makes computer wake up late
Date: Wed, 18 Apr 2007 19:15:43 +0200
Message-ID: <135ab3ff0704181015u371da251ye16e613252dc7fac@mail.gmail.com>
References: <135ab3ff0704080512k2bcf3973m46c8153ff6a6f7df@mail.gmail.com>
	 <20070408141040.GA14308@khazad-dum.debian.net>
	 <135ab3ff0704081118g3bebd25bj7394483a50549dea@mail.gmail.com>
	 <20070408215037.425b4883@localhost>
	 <135ab3ff0704140306j33ac1efat116c2a215f2b5d1c@mail.gmail.com>
	 <20070414184639.79fb4835@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.249]:19853 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992880AbXDRRPo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Apr 2007 13:15:44 -0400
Received: by an-out-0708.google.com with SMTP id b33so279160ana
        for <linux-acpi@vger.kernel.org>; Wed, 18 Apr 2007 10:15:43 -0700 (PDT)
In-Reply-To: <20070414184639.79fb4835@localhost>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dominique Michel <dominique.michel@citycable.ch>, linux-acpi@vger.kernel.org

Hi again.
when I installed Gentoo i copied the timezone with

# cp /usr/share/zoneinfo/Europe/Copenhagen /etc/localtime

last week i did a diff on the files, and the differed, so I changed it
to a symbolic link
# ln -sf /usr/share/zoneinfo/Europe/Copenhagen /etc/localtime

well I still got the same problem...

Don't see any way to solve it but my temporary script...
/Morten

On 14/04/07, Dominique Michel <dominique.michel@citycable.ch> wrote:
> Le Sat, 14 Apr 2007 12:06:49 +0200,
> "Morten Friesgaard" <friesgaard@gmail.com> a =E9crit :
>
> > Hi again.
> >
> > I have the following settings:
> > CLOCK=3D"UTC"
> > TIMEZONE=3D"Europe/Copenhagen"
> > CLOCK_SYSTOHC=3D"yes"
> >
> On gentoo, I also have to copy one file as /etc/localtime. It the fil=
e
> in /usr/zoneinfo that correspond to your local time. Don't copy the f=
iles
> in /usr/zoneinfo/Etc, but the one that correspond to your geographica=
l
> location, as example /usr/zoneinfo/Europe/London and rename it
> to /etc/localtime.
>
> But those settings can differ between different distributions. If it =
still
> doesn't work, take a look in the doc or in a forum for your distribut=
ion. Some
> bios also have a setting for this.
>
> Dominique
>
> > but still nothing works correctly, so until it is fixed, i going to
> > use the following script (now it works)
> >
> > hope anyone else can benefit from it :)
> > /Morten
> >
> > -------------------------------------------------------------------=
-----
> > #script /usr/sbin/mythsettime
> > #sudo chmod u+x /usr/sbin/mythsettime
> >
> > d=3D$1
> > t=3D$2
> >
> > #AT=3D`cat /proc/acpi/alarm`
> > RT=3D`date -d "${d} ${t} 2 hours ago" +'%Y-%m-%d %H:%M:%S'`
> >
> > echo $RT > /home/mythtv/myth.time
> > echo $RT > /proc/acpi/alarm
> > #echo $AT
> > -------------------------------------------------------------------=
-----
> >
> >
> > On 08/04/07, Dominique Michel <dominique.michel@citycable.ch> wrote=
:
> > > Le Sun, 8 Apr 2007 20:18:28 +0200,
> > > "Morten Friesgaard" <friesgaard@gmail.com> a =E9crit :
> > >
> > > > I'm not sure what to do, how do I make these changes?
> > > >
> > > > when I run the following it gives me somewhat the same values, =
but it
> > > > seems the BIOS clock i different (?!)
> > > > # hwclock ; date
> > > > Sun Apr  8 20:13:56 2007  -0.069330 seconds
> > > > Sun Apr  8 20:13:55 CEST 2007
> > > >
> > > > it worked before daylight savings, is it something I can ignore=
 and
> > > > still get it to wake up the corret time?
> > > >
> > > > should I change
> > > > TIMEZONE=3D"Europe/Copenhagen"
> > > >
> > > > to
> > > > TIMEZONE=3D"UTC"
> > > > ??
> > > >
> > > > /Morten
> > > >
> > >
> > > You must have 2 things:
> > >
> > > CLOCK=3D"UTC"
> > > TIMEZONE=3D"Europe/Copenhagen"
> > >
> > > The first one tell the OS that the rtc use UTC time, the second o=
ne at it
> > > must convert the UTC time into Europe/Copenhagen time to get the =
current
> > > system time.
> > >
> > > On gentoo I also have an option that set the Hardware Clock to th=
e current
> > > System Time during shutdown:
> > >
> > > CLOCK_SYSTOHC=3D"yes"
> > >
> > > Some linux distributions use CLOCK=3D"local" because, I guess, th=
ey are
> > > thinking at it is best to do so when you are double booting with =
windows.
> > > It is wrong because when the rtc use local time, the system have =
to change
> > > the time in the rtc (read in the hardware) when the daylight is c=
hanging,
> > > and each OS will change the time in the rtc.
> > >
> > > So, you will get the correct time after booting the first OS, a s=
hift of one
> > > hour after booting the second OS, and so on. It is much simpler t=
o use UTC
> > > with all the OS in the box, and that even with window$ (it is an =
option in
> > > the register base, I don't remember where but a google search wil=
l give you
> > > the reference.)
> > >
> > > With CLOCK=3D"UTC", the time in the rtc (in the hardware) will ne=
ver change,
> > > the OS will just interpret it with the value of TIMEZONE.
> > >
> > > Ciao,
> > > Dominique
> > >
> > > >
> > > > On 08/04/07, Henrique de Moraes Holschuh <hmh@hmh.eng.br> wrote=
:
> > > > > On Sun, 08 Apr 2007, Morten Friesgaard wrote:
> > > > > > I'm running a mythbox, and ever since we had our yearly cha=
nge of
> > > > > > daylight savings (summer time) my computer wakes up late. A=
t first it
> > > > > > was only an hour, then I set the time with hwclock (realise=
d that
> > > > > > CLOCK_SYSTOHC=3D"no"), now it is 2 hours late. And it is re=
ally precise
> > > > > > (1-2 hours later), and it is certainly because of daylight =
savings.
> > > > > >
> > > > > > Any ideas?
> > > > >
> > > > > My guess is that you have to set ACPI wake times to *exactly*=
 the time
> > > > > zone you use your RTC in.  Typically UTC, but semi-broken MS-=
compatible
> > > > > setups use the local time zone.
> > > > >
> > > > > The kernel can know the timezone, but almost nobody ever sets=
 that
> > > > > right, and it is not summer-time aware anyway (too complex). =
 It is
> > > > > best to just keep everything UTC as far as the kernel goes, *=
including*
> > > > > the RTC.
> > > > >
> > > > > --
> > > > >   "One disk to rule them all, One disk to find them. One disk=
 to bring
> > > > >   them all and in the darkness grind them. In the Land of Red=
mond
> > > > >   where the shadows lie." -- The Silicon Valley Tarot
> > > > >   Henrique Holschuh
> > > > >
> > > > -
> > > > To unsubscribe from this list: send the line "unsubscribe linux=
-acpi" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.h=
tml
> > >
> > >
> > > --
> > > Dominique Michel
> > >
> > > --
> > > N.B.: Tous les emails que je re=E7ois sont filtr=E9s par spamassa=
ssin avant de
> > > me parvenir.
> > >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-acp=
i" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> --
> Dominique Michel
>
> --
> N.B.: Tous les emails que je re=E7ois sont filtr=E9s par spamassassin=
 avant de me
> parvenir.
>
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
