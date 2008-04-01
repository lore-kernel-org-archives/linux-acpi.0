From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] PM: Introduce new top level suspend and hibernation callbacks (rev. 6)
Date: Tue, 1 Apr 2008 22:12:47 +0200
Message-ID: <200804012212.48609.rjw@sisk.pl>
References: <200803292317.50218.rjw@sisk.pl> <200803312329.03455.rjw@sisk.pl> <1207037741.23143.81.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:48128 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752492AbYDAUMx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Apr 2008 16:12:53 -0400
In-Reply-To: <1207037741.23143.81.camel@nigel-laptop>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Greg KH <greg@kroah.com>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Oliver Neukum <oliver@neukum.org>

On Tuesday, 1 of April 2008, Nigel Cunningham wrote:
> Hi Rafael.

Hi,

> Please excuse me, but I'm going to ask the questions you get from
> someone who hasn't followed development to date, and is thus reading =
the
> explanation without prior knowledge. Hopefully that will be helpful w=
hen
> you come to finalising the commit message.
>=20
> On Mon, 2008-03-31 at 23:29 +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> >=20
> > Introduce 'struct pm_ops' and 'struct pm_ext_ops' representing
> > suspend and hibernation operations for bus types, device classes an=
d
> > device types.
>=20
> Does ..._ext_... mean extended? (external?) If 'extended' (or if not)=
,
> does that imply that they're mutually exclusive alternatives for driv=
ers
> to use?

'ext' means 'extended'.  The idea is that the 'extended' version will b=
e used
by bus types / driver types that don't need to implement the _noirq cal=
lbacks.
Both the platform and PCI bus types generally allow drivers to use _noi=
rq
callbacks, so they use 'struct pm_ext_ops', as well as their correspond=
ing
driver types.

> > Modify the PM core to use 'struct pm_ops' and 'struct pm_ext_ops'
> > objects, if defined, instead of the ->suspend() and ->resume() or,
> > respectively, ->suspend_late() and ->resume_early() callbacks that
> > will be considered as legacy and gradually phased out.
>=20
> 'Respectively' doesn't look like the right word to use, but I'm not s=
ure
> I understand correctly what you're trying to say. The way it's writte=
n
> at the moment, it sounds to me like you're saying that suspend_late()
> and resume_early are deprecated, but you're modifying the PM core to =
use
> them.

Yes, the changelog is wrong, because I used a separate structure for th=
e
_noirq callbacks and (quite blindly) change the name of the structure i=
n the
changelog, instead of reworking it.=20

> > Change the behavior of the PM core wrt the error codes returned by
> > device drivers' ->resume() callbacks.  Namely, if an error code
> > is returned by one of them, the device for which it's been returned
> > is regarded as "invalid" by the PM core which will refuse to handle
> > it from that point on (in particualr, suspend/hibernation will not
> > be started if there is an "invalid" device in the system).
>=20
> s/=EF=BB=BFparticualr,/particular

Yes, thanks.
=20
> So drivers can never validly fail to resume. That sounds fair enough.=
 If
> the hardware has gone away while in lower power mode (USB, say), shou=
ld
> the driver then just printk an error and return success?

I think so.

IMO, an error code returned by a driver's ->resume() should mean "the d=
evice
hasn't resumed and is presumably dead".  Otherwise, ->resume() should r=
eturn
success.

> > The main purpose of doing this is to separate suspend (aka S2RAM an=
d
> > standby) callbacks from hibernation callbacks in such a way that th=
e
> > new callbacks won't take arguments and the semantics of each of the=
m
> > will be clearly specified.  This has been requested for multiple
> > times by many people, including Linus himself, and the reason is th=
at
> > within the current scheme if ->resume() is called, for example, it'=
s
> > difficult to say why it's been called (ie. is it a resume from RAM =
or
> > from hibernation or a suspend/hibernation failure etc.?).
> >=20
> > The second purpose is to make the suspend/hibernation callbacks mor=
e
> > flexible so that device drivers can handle more than they can withi=
n
> > the current scheme.  For example, some drivers may need to prevent
> > new children of the device from being registered before their
> > ->suspend() callbacks are executed or they may want to carry out so=
me
> > operations requiring the availability of some other devices, not
> > directly bound via the parent-child relationship, in order to prepa=
re
> > for the execution of ->suspend(), etc.
>=20
> Do these changes allow for other power state possibilities besides
> suspend to ram and hibernate (eg on other platforms)?

The other states fall into the "suspend" category.

> > Ultimately, we'd like to stop using the freezing of tasks for suspe=
nd
> > and therefore the drivers' suspend/hibernation code will have to ta=
ke
> > care of the handling of the user space during suspend/hibernation.
> > That, in turn, would be difficult within the current scheme, withou=
t
> > the new ->prepare() and ->complete() callbacks.
> >=20
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > ---
> >=20
> >  arch/x86/kernel/apm_32.c   |    4=20
> >  drivers/base/power/main.c  |  706 ++++++++++++++++++++++++++++++++=
++-----------
> >  drivers/base/power/power.h |    2=20
> >  drivers/base/power/trace.c |    4=20
> >  include/linux/device.h     |    9=20
> >  include/linux/pm.h         |  318 ++++++++++++++++++--
> >  kernel/power/disk.c        |   20 -
> >  kernel/power/main.c        |    6=20
> >  8 files changed, 870 insertions(+), 199 deletions(-)
> >=20
> > Index: linux-2.6/include/linux/pm.h
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-2.6.orig/include/linux/pm.h
> > +++ linux-2.6/include/linux/pm.h
> > @@ -114,7 +114,9 @@ typedef struct pm_message {
> >  	int event;
> >  } pm_message_t;
> > =20
> > -/*
> > +/**
> > + * struct pm_ops - device PM callbacks
> > + *
> >   * Several driver power state transitions are externally visible, =
affecting
> >   * the state of pending I/O queues and (for drivers that touch har=
dware)
> >   * interrupts, wakeups, DMA, and other hardware state.  There may =
also be
> > @@ -122,6 +124,288 @@ typedef struct pm_message {
> >   * to the rest of the driver stack (such as a driver that's ON gat=
ing off
> >   * clocks which are not in active use).
> >   *
> > + * The externally visible transitions are handled with the help of=
 the following
> > + * callbacks included in this structure:
> > + *
> > + * @prepare: Prepare the device for the upcoming transition, but d=
o NOT change
> > + *	its hardware state.  Prevent new children of the device from be=
ing
> > + *	registered after @prepare() returns (the driver's subsystem and
> > + *	generally the rest of the kernel is supposed to prevent new cal=
ls to the
> > + *	probe method from being made too once @prepare() has succeeded)=
=2E  If
> > + *	@prepare() detects a situation it cannot handle (e.g. registrat=
ion of a
> > + *	child already in progress), it may return -EAGAIN, so that the =
PM core
> > + *	can execute it once again (e.g. after the new child has been re=
gistered)
> > + *	to recover from the race condition.  This method is executed fo=
r all
> > + *	kinds of suspend transitions and is followed by one of the susp=
end
> > + *	callbacks: @suspend(), @freeze(), or @poweroff().
> > + *	The PM core executes @prepare() for all devices before starting=
 to
> > + *	execute suspend callbacks for any of them, so drivers may assum=
e all of
> > + *	the other devices to be present and functional while @prepare()=
 is being
> > + *	executed.  In particular, it is safe to make GFP_KERNEL memory
> > + *	allocations from within @prepare(), although they are likely to=
 fail in
> > + *	case of hibernation, if a substantial amount of memory is reque=
sted.
>=20
> Why?

Hmm, you're right.  This is the other way around - if a device allocate=
s too
much RAM, we won't have enough memory to create the image.

> > + *	However, drivers may NOT assume anything about the availability=
 of the
> > + *	user space at that time and it is not correct to request firmwa=
re from
> > + *	within @prepare() (it's too late to do that).
>=20
> That doesn't sound good. It would be good to be able to get drivers t=
o
> request firmware early in the process.

That will be possible when we drop the freezer.

> > + * @complete: Undo the changes made by @prepare().  This method is=
 executed for
> > + *	all kinds of resume transitions, following one of the resume ca=
llbacks:
> > + *	@resume(), @thaw(), @restore().  Also called if the state trans=
ition
> > + *	fails before the driver's suspend callback (@suspend(), @freeze=
(),
> > + *	@poweroff()) can be executed (e.g. if the suspend callback fail=
s for one
> > + *	of the other devices that the PM core has unsucessfully attempt=
ed to
>=20
> s/=EF=BB=BFunsucessfully/=EF=BB=BFunsuccessfully

Thanks, will fix.

Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
