From: Arkadiusz Miskiewicz <arekm@maven.pl>
Subject: Re: 2.6.25-rc2 Regression Thinkpad acpi
Date: Fri, 14 Mar 2008 19:23:32 +0100
Message-ID: <200803141923.32544.arekm@maven.pl>
References: <20080225230035.GA14503@khazad-dum.debian.net> <20080313231738.GH30864@khazad-dum.debian.net> <20080314073012.GF17940@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.carme.maven.pl ([193.239.45.138]:36370 "EHLO
	main.carme.maven.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367AbYCNSYF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Mar 2008 14:24:05 -0400
In-Reply-To: <20080314073012.GF17940@kernel.dk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Lukas Hejtmanek <xhejtman@ics.muni.cz>, Alexey Starikovskiy <aystarik@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Friday 14 of March 2008, Jens Axboe wrote:
> On Thu, Mar 13 2008, Henrique de Moraes Holschuh wrote:
> > On Wed, 12 Mar 2008, Arkadiusz Miskiewicz wrote:
> > > > On Wed, Mar 12, 2008 at 10:35:29AM -0300, Henrique de Moraes Ho=
lschuh=20
wrote:
> > > > > You shouldn't need to do anything other than teach userspace =
to
> > > > > respond to them, as they generate the proper KEY_* events.  I=
f you
> > > > > are giving the AML _OSI(Linux), at least...
> > >
> > > I'm also seeing regression on my thinkpad z60m where with git tre=
e
> > > (tested again with 2 days old git) "thinkvantage" button stopped
> > > working (pressing it was previously seen by some userspace kde wh=
ich
> > > run konsole).
> > >
> > > On 2.6.24 presses are seen.
> >
> > There were no changes to thinkpad-acpi that should have caused this=
=2E  So
> > I need more data to find out what is happening.  Might be a problem
> > elsewhere in ACPI, or some bug in thinkpad-acpi.
> >
> > You DO have /proc/acpi/event, correct?  Please send me the debug ou=
tput
> > of thinkpad-acpi when it is loaded with "debug=3D0xffff" as a param=
eter
> > (and for extra bonus, please compile it with the verbose debug Kcon=
fig
> > option).
>
> Updated to current kernel (saw it had a bunch of acpi fixes), and it =
now
> works correctly! xev sees the events and the mixer sees mute/unmute a=
nd
> volume up+down events.

Same here, recent git works fine on z60m.

--=20
Arkadiusz Mi=B6kiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
