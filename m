From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: [RFC][PATCH] PM: Introduce new top level suspend and
	hibernation callbacks (rev. 6)
Date: Tue, 01 Apr 2008 19:15:41 +1100
Message-ID: <1207037741.23143.81.camel@nigel-laptop>
References: <200803292317.50218.rjw@sisk.pl>
	 <200803292320.38378.rjw@sisk.pl> <200803300454.26318.rjw@sisk.pl>
	 <200803312329.03455.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756732AbYDAIPn@vger.kernel.org>
In-Reply-To: <200803312329.03455.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Greg KH <greg@kroah.com>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Oliver Neukum <oliver@neukum.org>
List-Id: linux-acpi@vger.kernel.org

Hi Rafael.

Please excuse me, but I'm going to ask the questions you get from
someone who hasn't followed development to date, and is thus reading th=
e
explanation without prior knowledge. Hopefully that will be helpful whe=
n
you come to finalising the commit message.

On Mon, 2008-03-31 at 23:29 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>=20
> Introduce 'struct pm_ops' and 'struct pm_ext_ops' representing
> suspend and hibernation operations for bus types, device classes and
> device types.

Does ..._ext_... mean extended? (external?) If 'extended' (or if not),
does that imply that they're mutually exclusive alternatives for driver=
s
to use?

> Modify the PM core to use 'struct pm_ops' and 'struct pm_ext_ops'
> objects, if defined, instead of the ->suspend() and ->resume() or,
> respectively, ->suspend_late() and ->resume_early() callbacks that
> will be considered as legacy and gradually phased out.

'Respectively' doesn't look like the right word to use, but I'm not sur=
e
I understand correctly what you're trying to say. The way it's written
at the moment, it sounds to me like you're saying that suspend_late()
and resume_early are deprecated, but you're modifying the PM core to us=
e
them.

> Change the behavior of the PM core wrt the error codes returned by
> device drivers' ->resume() callbacks.  Namely, if an error code
> is returned by one of them, the device for which it's been returned
> is regarded as "invalid" by the PM core which will refuse to handle
> it from that point on (in particualr, suspend/hibernation will not
> be started if there is an "invalid" device in the system).

s/=EF=BB=BFparticualr,/particular

So drivers can never validly fail to resume. That sounds fair enough. I=
f
the hardware has gone away while in lower power mode (USB, say), should
the driver then just printk an error and return success?

> The main purpose of doing this is to separate suspend (aka S2RAM and
> standby) callbacks from hibernation callbacks in such a way that the
> new callbacks won't take arguments and the semantics of each of them
> will be clearly specified.  This has been requested for multiple
> times by many people, including Linus himself, and the reason is that
> within the current scheme if ->resume() is called, for example, it's
> difficult to say why it's been called (ie. is it a resume from RAM or
> from hibernation or a suspend/hibernation failure etc.?).
>=20
> The second purpose is to make the suspend/hibernation callbacks more
> flexible so that device drivers can handle more than they can within
> the current scheme.  For example, some drivers may need to prevent
> new children of the device from being registered before their
> ->suspend() callbacks are executed or they may want to carry out some
> operations requiring the availability of some other devices, not
> directly bound via the parent-child relationship, in order to prepare
> for the execution of ->suspend(), etc.

Do these changes allow for other power state possibilities besides
suspend to ram and hibernate (eg on other platforms)?

> Ultimately, we'd like to stop using the freezing of tasks for suspend
> and therefore the drivers' suspend/hibernation code will have to take
> care of the handling of the user space during suspend/hibernation.
> That, in turn, would be difficult within the current scheme, without
> the new ->prepare() and ->complete() callbacks.
>=20
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>=20
>  arch/x86/kernel/apm_32.c   |    4=20
>  drivers/base/power/main.c  |  706 ++++++++++++++++++++++++++++++++++=
-----------
>  drivers/base/power/power.h |    2=20
>  drivers/base/power/trace.c |    4=20
>  include/linux/device.h     |    9=20
>  include/linux/pm.h         |  318 ++++++++++++++++++--
>  kernel/power/disk.c        |   20 -
>  kernel/power/main.c        |    6=20
>  8 files changed, 870 insertions(+), 199 deletions(-)
>=20
> Index: linux-2.6/include/linux/pm.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/include/linux/pm.h
> +++ linux-2.6/include/linux/pm.h
> @@ -114,7 +114,9 @@ typedef struct pm_message {
>  	int event;
>  } pm_message_t;
> =20
> -/*
> +/**
> + * struct pm_ops - device PM callbacks
> + *
>   * Several driver power state transitions are externally visible, af=
fecting
>   * the state of pending I/O queues and (for drivers that touch hardw=
are)
>   * interrupts, wakeups, DMA, and other hardware state.  There may al=
so be
> @@ -122,6 +124,288 @@ typedef struct pm_message {
>   * to the rest of the driver stack (such as a driver that's ON gatin=
g off
>   * clocks which are not in active use).
>   *
> + * The externally visible transitions are handled with the help of t=
he following
> + * callbacks included in this structure:
> + *
> + * @prepare: Prepare the device for the upcoming transition, but do =
NOT change
> + *	its hardware state.  Prevent new children of the device from bein=
g
> + *	registered after @prepare() returns (the driver's subsystem and
> + *	generally the rest of the kernel is supposed to prevent new calls=
 to the
> + *	probe method from being made too once @prepare() has succeeded). =
 If
> + *	@prepare() detects a situation it cannot handle (e.g. registratio=
n of a
> + *	child already in progress), it may return -EAGAIN, so that the PM=
 core
> + *	can execute it once again (e.g. after the new child has been regi=
stered)
> + *	to recover from the race condition.  This method is executed for =
all
> + *	kinds of suspend transitions and is followed by one of the suspen=
d
> + *	callbacks: @suspend(), @freeze(), or @poweroff().
> + *	The PM core executes @prepare() for all devices before starting t=
o
> + *	execute suspend callbacks for any of them, so drivers may assume =
all of
> + *	the other devices to be present and functional while @prepare() i=
s being
> + *	executed.  In particular, it is safe to make GFP_KERNEL memory
> + *	allocations from within @prepare(), although they are likely to f=
ail in
> + *	case of hibernation, if a substantial amount of memory is request=
ed.

Why?

> + *	However, drivers may NOT assume anything about the availability o=
f the
> + *	user space at that time and it is not correct to request firmware=
 from
> + *	within @prepare() (it's too late to do that).

That doesn't sound good. It would be good to be able to get drivers to
request firmware early in the process.

> + * @complete: Undo the changes made by @prepare().  This method is e=
xecuted for
> + *	all kinds of resume transitions, following one of the resume call=
backs:
> + *	@resume(), @thaw(), @restore().  Also called if the state transit=
ion
> + *	fails before the driver's suspend callback (@suspend(), @freeze()=
,
> + *	@poweroff()) can be executed (e.g. if the suspend callback fails =
for one
> + *	of the other devices that the PM core has unsucessfully attempted=
 to

s/=EF=BB=BFunsucessfully/=EF=BB=BFunsuccessfully

Regards,

Nigel
