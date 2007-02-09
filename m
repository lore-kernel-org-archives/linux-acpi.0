From: Len Brown <lenb@kernel.org>
Subject: sony-laptop vs sonypi (Re: [PATCH 1/2] Add new sony laptop drivers maintainer)
Date: Fri, 9 Feb 2007 11:58:18 -0500
Message-ID: <200702091158.18909.lenb@kernel.org>
References: <11709622011964-git-send-email-malattia@linux.it> <1171028098.6387.15.camel@localhost.localdomain> <56393.85.47.20.193.1171029689.squirrel@picard.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44211 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946630AbXBIQ7t convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Feb 2007 11:59:49 -0500
In-Reply-To: <56393.85.47.20.193.1171029689.squirrel@picard.linux.it>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Stelian Pop <stelian@popies.net>, linux-acpi@vger.kernel.org

On Friday 09 February 2007 09:01, Mattia Dongili wrote:
> On Fri, February 9, 2007 2:34 pm, Stelian Pop said:
> > Le vendredi 09 f=E9vrier 2007 =E0 01:44 -0500, Len Brown a =E9crit =
:
> >> On Thursday 08 February 2007 14:16, malattia@linux.it wrote:
> >> > From: Mattia Dongili <malattia@linux.it>
> >> >
> >> > Signed-off-by: Mattia Dongili <malattia@linux.it>
> >> > ---
> >> >  MAINTAINERS |    2 ++
> >> >  1 files changed, 2 insertions(+), 0 deletions(-)
> >> >
> >> > diff --git a/MAINTAINERS b/MAINTAINERS
> >> > index efca26a..ec97723 100644
> >> > --- a/MAINTAINERS
> >> > +++ b/MAINTAINERS
> >> > @@ -3012,6 +3012,8 @@ S:	Maintained
> >> >  SONY VAIO CONTROL DEVICE DRIVER
> >> >  P:	Stelian Pop
> >> >  M:	stelian@popies.net
> >> > +P:	Mattia Dongili
> >> > +M:	malattia@linux.it
> >> >  W:	http://popies.net/sonypi/
> >> >  S:	Maintained
> >>
> >> Stelian, are you still actively maintaining Sony support,
> >
> > Actively definately not, though I still answer a lot of support
> > questions about sonypi.
> >
> > I even receive patches from time to time :)
> >
> >> or should we simply replace your name here with Mattia?
> >
> >>From what I recall, Mattia took over sony_acpi but didn't want to h=
andle
> > sonypi as well, at least not for the time being.
> >
> > If he changed his mind I'm hapily handing over the maintenance to h=
im.
> >
> > If not, maybe the MAINTAINERS entry should be clarified to say that
> > Mattia maintains sony_acpi and sonypi is currently not maintained.
>=20
> Well, I'd hate losing possibly useful patches because the driver resu=
lts
> unmaintained. :)
> Sooo... updated MAINTAINERS patch will follow soon.

sonypi is an interesting beast, and I do mean beast.
It pre-dates Linux ACPI support by several years
and is chock-full of reverse engineered magic numbers.

It is much more complicated than sony-laptop.
It has a device file, ioctls, it registers for and handles irqs,
it tickles bluetooth, the camera, the hotkeys, jog dial --
and it also registers with ACPI on SONY6001
and talks to the ACPI EC -- with or without ACPI present.

Presumably there is some application that talks to those ioctls.

Happily it already registers all the input events with
the input layer.

I think one of the major decisions you need to make going forward
is if it makes sense to maintain the parts of sonypi
that are reverse engineered AML -- rather than simply
running in ACPI mode and invoking the AML in the BIOS.

To be effective at this, you need a machine on hand that
actually runs the sonypi features.  Lacking that, you need
active testers and a copy of their acpidump.

Personally, I think that invoking machine specific AML
has its risks, but invoking C-ized machine specific AML
sucked into a platform specific driver borders on the insane.
(but Linux didn't have ACPI in 2000, so maybe "determined"
would be a more appropriate word:-)

Stelian,
I think if you can list what you know actually works on what models,
and what may not work, and what you think about the code needs to
be changed, that would help Mattia enormously.

I suggest that the goal might be to have a single consolidated
sony-laptop driver.  Ie. port the working features one by one
from sonypi into sony-laptop, and when sony-laptop can do everything
that sonypi can do (though maybe not with the same ioctl interface etc)
the schedule sonypi for deletion.  But in the mean time, on the
assumption the people actually use sonypi to make their vaio's
dance in useful ways, I would leave it alone for their benefit.

Or, it may be possible to make a gradual transition --
this would spread the migration pain over a longer period,
but would also spread the testing over a longer period
and probably end up with a better driver in the end.
You'd have to convince both drivers to load at the same
time and to not conflict.  Maybe some shared state could
tell them which features are handled by which, so you could
test if the new driver is working by flipping some load-time
bits...  I don't know if this is possible or not -- depends on
how the features and the models interact with each other.

In any case, I think it would make sense to cook up a transition plan
and to let the users know what you are thinking before you do it.
If you don't have folks testing it on the models you don't have
then you'll be unable to make progress.

> One question though: which subsystem should sonypi patches flow throu=
gh?

In the interest of making ACPI use in the platform specific drivers
sane and uniform, I'll be happy to be the conduit to upstream
to clean this up.  In particular, I'd really like to see the
reverse engineered AML implemented as C IO reads and writes go away.

thanks,
-Len
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
