From: Julius Volz <illuminatus23-S0/GAf8tV78@public.gmane.org>
Subject: ACPI too sensitive about critical temperature
Date: Tue, 20 Jan 2004 22:11:41 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1074633101.3769.213.camel@egardia>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi ACPI developers,

these emails between me and Paul may be of interest to some of you.
Sorry for the messed up quoting, I hope it's still readable. My original
email is at the bottom.

It's basically about ACPI being too quick to shut down the computer when
you have a mainboard that occasionally delivers bogus values.
Andy has already provided me with a patch to try out, but since the
problem is not on my computer, it will take some time.

-----Forwarded Message-----
> From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> To: Julius Volz <julius.volz-cOr7zazyEW0f8UlNpKJ8ow@public.gmane.org>, "Diefenbaugh, Paul S" <paul=
.s.diefenbaugh-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Subject: RE: ACPI too sensitive about critical temperature
> Date: Tue, 20 Jan 2004 09:28:18 -0800
>=20
> Please take this to acpi-devel-5NWGOfrQmneRv+LV9MX5uti2KpX7p8Fi@public.gmane.org
>=20
> You may want to fwd this last email there, for starters.
>=20
> Regards -- Andy=20
>=20
> > -----Original Message-----
> > From: Julius Volz [mailto:julius.volz-cOr7zazyEW0f8UlNpKJ8ow@public.gmane.org]=20
> > Sent: Tuesday, January 20, 2004 9:27 AM
> > To: Diefenbaugh, Paul S
> > Cc: Grover, Andrew
> > Subject: Re: ACPI too sensitive about critical temperature
> >=20
> > Hi again,
> >=20
> > >Julius:
> > >
> > >Hmmm ... this would be dangerous to apply globally, but one=20
> > could allow some kind of positive hysteresis as an optional=20
> > attribute - e.g. amount of time in milliseconds to wait=20
> > before confirming a temperature event (_HOT, _CRT).  The=20
> > default should be zero (don't wait, don't confirm).  Most=20
> > good ;~) processors shutdown automatically in the case this=20
> > was real critical event and the OS waits too long ... but=20
> > there could be loss of data.
> > > =20
> > >
> >=20
> > Yes, true. The thing I'm a bit worried about though is that=20
> > this might=20
> > happen to people who just use the kernel of some big distribution and=20
> > will never hear about this option. Hard to make it right for=20
> > everyone :-(
> > Well, so waiting three seconds is much too long, but how fast can you=20
> > get consecutive measurements of the temperature? One should at least=20
> > look at more than just one value before shutting down, it seems...
> >=20
> > >The ACPI thermal zone driver must be seeing the transient=20
> > temperature properly or else it wouldn't attempt a shutdown;=20
> > the logged message must be from a separate code path (post-transient).
> > > =20
> > >
> >=20
> > I don't fully understand what you mean with this (no kernel=20
> > coder yet,=20
> > sorry), but I also noticed that my original assumption (that=20
> > the value=20
> > in the message must be from a next measurement) is apparently wrong.=20
> > When I look at thermal.c, I see that the same value=20
> > (tz->temperature) is=20
> > used for deciding the shutdown and the printing of the=20
> > message, and it=20
> > is not changed in between... so why did the messages say 45=B0C=20
> > and 43=B0C=20
> > when the BIOS crit. temp. was set to 85=B0C? Or am I missing something=20
> > (e.g. the tz struct being filled in by some mysterious background=20
> > thread...).
> >=20
> > >>From your data I'd guess this was a fault motherboard=20
> > and/or thermal sensor.
> > > =20
> > >
> >=20
> > I have the board type now: it is an Epox EP4-PDA2+ (Chipset:=20
> > Intel 865PE).
> > http://www.epox.nl/english/products/motherboard/4pda2.htm
> >=20
> > I hope I can help somehow, but since the board isn't mine I can't=20
> > experiment with it a lot.
> >=20
> > Julius
> >=20
> > >-----Original Message-----
> > >From: Julius Volz [mailto:julius.volz-cOr7zazyEW0f8UlNpKJ8ow@public.gmane.org]=20
> > >Sent: Sunday, January 18, 2004 6:26 AM
> > >To: Grover, Andrew; Diefenbaugh, Paul S
> > >Subject: ACPI too sensitive about critical temperature
> > >
> > >Hi,
> > >
> > >I didn't want to bug the whole lkml with this, so I'm=20
> > sending this to=20
> > >you guys who wrote "drivers/acpi/thermal.c". I hope that's okay...
> > >
> > >A friend of mine has a mainboard (I can find out the=20
> > specific type if=20
> > >you want to know) which reports inaccurately high=20
> > temperature "peaks"=20
> > >from time to time.
> > >Looking at /proc/acpi/thermal_zone/THR1/temperature every=20
> > second might=20
> > >look something like this: 45, 43, 47, 42, 90, 43, 41, 45
> > >
> > >This is of course bad when CONFIG_ACPI_THERMAL is enabled and the=20
> > >computer just randomly shuts down when you are working. The=20
> > problem with=20
> > >detecting this bug for normal users is that the temperature=20
> > reported in=20
> > >the shutdown message is already taken from a next=20
> > measurement and looks=20
> > >ok again.
> > >So you might get a shutdown message saying,
> > >"Critical temperature reached (43 C)..."
> > >and wonder why the system shuts down although you set critical=20
> > >temperature to 85=B0C in the BIOS.
> > >
> > >I've looked at thermal.c and thought that it would be better=20
> > to look at=20
> > >temperature measurements over a range of, say, three seconds=20
> > (if that is=20
> > >possible) to sort out these false peaks.
> > >
> > >As there might be many mainboards out there that do this and=20
> > >CONFIG_ACPI_THERMAL should normally be enabled, this could=20
> > turn out to=20
> > >be a problem for many people otherwise.
> > >
> > >What do you think?
> > >
> > >Julius



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
