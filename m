From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Suspend-to-ram/disk signal
Date: Wed, 28 Nov 2007 02:10:14 -0200
Message-ID: <20071128041014.GA18131@khazad-dum.debian.net>
References: <474B4B35.6030800@tipisoft.dk> <200711270036.21884.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:43015 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751761AbXK1EKT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Nov 2007 23:10:19 -0500
Content-Disposition: inline
In-Reply-To: <200711270036.21884.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pascal d'Hermilly <pascal@tipisoft.dk>, linux-acpi@vger.kernel.org

On Tue, 27 Nov 2007, Rafael J. Wysocki wrote:
> On Monday, 26 of November 2007, Pascal d'Hermilly wrote:
> > When the computer suspends and comes back does it send a signal to =
the=20
> > running applications?
>=20
> No, it doesn't.  Applications aren't supposed to notice the suspend.

Except, of course, when they need to notice the suspend.  The clocks
changed, the hardware configuration may have changed, and something
certainly did happen, so "Applications aren't supposed to notice the
suspend" is a na=EFve proposition at best.  They need to *deal well* wi=
th it,
instead.

ntp needs to reset everything, for example.  A LOT of software really
dislikes large steps in the clocks (monotonic or gettimeofday()), and
misbehave.  Not notifying them they need to resync themselves is part o=
f the
breakage.  Multimedia applications and screen savers are often plagued =
by
this sort of problem.

A deskptop suite trying to emulate the ThinkVantage suite in a ThinkPad
might want to check that the user woke up the laptop just to eject the =
bay,
and ask him if he wants the box to go back to sleep, and maybe even off=
er to
do so automatically from now on.

The possibilities are endless...

> Your distribution surely uses some scripts that activate the kernel's=
 suspend
> code.  You can modify these scripts to notify your application.

Which is, of course, one way to work around the issue (and probably the=
 best
one, since trying to act upon a wakeup out-of-sync with whatever said s=
cript
might be doing is likely not going to be very wise).

But it would still be nice if we kicked userspace in the arse to let it=
 know
it was sleeping for a while and needs to resync, when we wake up each
userspace task.   The kernel makes that information available to kthrea=
ds
for a damn good reason.  Sounds like a job for a SIGCONT, but I don't k=
now
how well would that work.

--=20
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
