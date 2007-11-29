From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Suspend-to-ram/disk signal
Date: Thu, 29 Nov 2007 01:28:22 +0100
Message-ID: <200711290128.22467.rjw@sisk.pl>
References: <474B4B35.6030800@tipisoft.dk> <200711270036.21884.rjw@sisk.pl> <20071128041014.GA18131@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:51152 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755812AbXK2AKR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Nov 2007 19:10:17 -0500
In-Reply-To: <20071128041014.GA18131@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Pascal d'Hermilly <pascal@tipisoft.dk>, linux-acpi@vger.kernel.org

On Wednesday, 28 of November 2007, Henrique de Moraes Holschuh wrote:
> On Tue, 27 Nov 2007, Rafael J. Wysocki wrote:
> > On Monday, 26 of November 2007, Pascal d'Hermilly wrote:
> > > When the computer suspends and comes back does it send a signal t=
o the=20
> > > running applications?
> >=20
> > No, it doesn't.  Applications aren't supposed to notice the suspend=
=2E
>=20
> Except, of course, when they need to notice the suspend.  The clocks
> changed, the hardware configuration may have changed, and something
> certainly did happen, so "Applications aren't supposed to notice the
> suspend" is a na=EFve proposition at best.  They need to *deal well* =
with it,
> instead.
>=20
> ntp needs to reset everything, for example.  A LOT of software really
> dislikes large steps in the clocks (monotonic or gettimeofday()), and
> misbehave.  Not notifying them they need to resync themselves is part=
 of the
> breakage.  Multimedia applications and screen savers are often plague=
d by
> this sort of problem.
>=20
> A deskptop suite trying to emulate the ThinkVantage suite in a ThinkP=
ad
> might want to check that the user woke up the laptop just to eject th=
e bay,
> and ask him if he wants the box to go back to sleep, and maybe even o=
ffer to
> do so automatically from now on.
>=20
> The possibilities are endless...

OTOH, there are applications that need not be notified in any way, so I=
 don't
think we should uncondtionally send signals to all of them, for example=
=2E

> > Your distribution surely uses some scripts that activate the kernel=
's suspend
> > code.  You can modify these scripts to notify your application.
>=20
> Which is, of course, one way to work around the issue (and probably t=
he best
> one, since trying to act upon a wakeup out-of-sync with whatever said=
 script
> might be doing is likely not going to be very wise).
>=20
> But it would still be nice if we kicked userspace in the arse to let =
it know
> it was sleeping for a while and needs to resync, when we wake up each
> userspace task.   The kernel makes that information available to kthr=
eads
> for a damn good reason.  Sounds like a job for a SIGCONT, but I don't=
 know
> how well would that work.

It wouldn't work very well, IMHO, unless the tasks in question are prep=
ared to
get an "out of order" SIGCONT.

However, sending SIGSTOP to selected tasks before the suspend and then =
SIGCONT
after the resume might do the trick.

Greetings,
Rafael
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
