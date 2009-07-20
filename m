From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/8] introduce the device async action mechanism
Date: Mon, 20 Jul 2009 18:24:16 +0200
Message-ID: <200907201824.17755.rjw@sisk.pl>
References: <1247643516.26272.77.camel@rzhang-dt> <200907170312.00006.rjw@sisk.pl> <1247798643.26272.275.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:53381 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752602AbZGTQXx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Jul 2009 12:23:53 -0400
In-Reply-To: <1247798643.26272.275.camel@rzhang-dt>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>, Arjan van de Ven <arjan@linux.intel.com>

On Friday 17 July 2009, Zhang Rui wrote:
> On Fri, 2009-07-17 at 09:11 +0800, Rafael J. Wysocki wrote:
> > On Thursday 16 July 2009, Zhang Rui wrote:
> > > On Wed, 2009-07-15 at 21:00 +0800, Arjan van de Ven wrote:
> > > > On Wed, 15 Jul 2009 15:38:36 +0800
> > > > Zhang Rui <rui.zhang@intel.com> wrote:
> > > >=20
> > > > > Introduce the device async action mechanism.
> > > > >=20
> > > > > In order to speed up Linux suspend/resume/shutdown process,
> > > > > we introduce the device async action mechanism that allow dev=
ices
> > > > > to suspend/resume/shutdown asynchronously.
> > > > >=20
> > > > > The basic idea is that,
> > > > > if the suspend/resume/shutdown process of a device set,
> > > > > including a root device and its child devices, are independen=
t of
> > > > > other devices, we create an async domain for this device set,
> > > > > and make them suspend/resume/shutdown asynchronously.
> > > >=20
> > > > Hi,
> > > >=20
> > > > I have some concerns about having an async domain per device(gr=
oup)
> > > > rather than having one async domain for all of this,=20
> > >=20
> > > =EF=BB=BFwe create an async domain ONLY if we are sure that the d=
evice group is
> > > independent with the other devices.
> > >=20
> > > and IMO, using multiple async domains brings real device async ac=
tions.
> > > For example, in S3 resume case, there are two device groups:
> > > device group1: device1, device2, device3
> > > device group2: device4, device5, device6
> > >=20
> > > If they share the global domain, we may get:=EF=BB=BF
> > > device group1: device1(cookie 1), device2(cookie 4), device3(cook=
ie 5)
> > > device group2: device4(cookie 2), device5(cookie 3), device6(cook=
ie 6)
> > >=20
> > > this is not real asynchronous resume because
> > > device3 needs to call async_synchronize_cookie(5) before resume i=
tself.
> > > which means that device4 and device5 must be resumed before devic=
e3.
> > >=20
> > > But if multiple async domain is used, we get:
> > > =EF=BB=BFdevice group1: device1(cookie 1), device2(cookie 2), dev=
ice3(cookie 3)
> > > device group2: device4(cookie 1), device5(cookie 2), device6(cook=
ie 3)
> > >=20
> > > device group1 and group2 can be resumed asynchronously.
> > >=20
> > >=20
> > > Another example, in my previous test,
> > > 1. sata controller. takes 0.4s to resume.
> > > 2. usb, including uchi and ehci controller takes 1.4s to resume
> > > 3. ACPI battery takes 0.3s to resume.
> > > 3. all the other devices take 0.2s to resume.
> > >=20
> > > sata, usb and ACPI battery are independent device groups.
> > > If we use multiple async domains, we can reduce the total device =
resume
> > > time from 2.3s to a little more than 1.4s because there are a lot=
 of
> > > sleep in usb resume process.
> > > But if we share the global async domain, the total resume time ca=
n only
> > > be reduced to about 2.1s because sata, usb and ACPI battery are a=
ctually
> > > resumed synchronously.
> >=20
> > Well, first, I'm not really sure that using the async _boot_ infras=
tructure for
> > that is a good choice.
>=20
> IMO, kernel/async.c provides good interfaces that can be used not onl=
y
> in boot phrase.
> it's generic enough for suspend/resume.

Well, if that were not your opinion, you certainly wouldn't post patche=
s using
it. :-)

> >  During suspend-resume we know dependencies between
> > devices beforehand, at least in theory, so we can use them.
> >=20
> that's why I use multiple async domains. :)
> One domain for a device group.

And how exactly the device groups are defined?

> > In particular, we have to make sure that parent devices will not be=
 suspended
> > until all of their children have been suspended and children device=
s will not
> > be resumed before the parents.
>=20
> that's not enough.
> =EF=BB=BFFor examples,
> ACPI battery and EC are independent devices, but EC must be resumed
> before battery because battery driver may access some EC address spac=
e
> during resume time.
> Of course the problem I describe above doesn't exist because ACPI
> battery driver doesn't have .resume method right now.
> But this is the case that works well in the current code but can not =
be
> converted to async device resume.
>=20
> > The current code handles this quite
> > efficiently, so I wonder what you're going to do not to break it.
> >=20
> sorry I don't quite understand.
>=20
> > Second, you seem to think that it only makes sense to execute ->sus=
pend()
> > and ->resume() asynchronously (or in parallel), while for example i=
n the case
> > of PCI ->suspend_noirq() and ->resume_noirq() also contain code tha=
t
> > potentially can take quite some time to execute.
> >=20
> IMO, this patch set just provides a framework that can be used for
> suspend/resume/shutdown optimization, and it doesn't solve all the
> problem at one time.
>=20
> IMO, the next step we should do is:
> 1. analyze the suspend/resume/shutdown process and find out the hotsp=
ot,
>    i.e. which drivers suspend/resume slowly
> 2. If it's software problem that we can fix in the driver, fix it.
>    like commit 24920c8a6358bf5532f1336b990b1c0fe2b599ee
> 3. If the hardware is slow, try to do it asynchronously.
>    like I did in patch 8/8.
>=20
> This framework makes it quite easy to register an async device group.
>=20
> And even the suspend_noirq and resume_noirq can be covered easily wit=
h
> this framework.
> For example,
> 1. introduce two new device async actions.
>    =EF=BB=BFDEV_ASYNC_SUSPEND_NOIRQ/DEV_ASYNC_RESUME_NOIRQ
>    just like what I did in patch 4/8, 5/8 and 6/8.
> 2. find out which device is slow in ->suspend_noirq and ->resume_noir=
q
> 3. see if we can find an async device group that including this devic=
e.
> 4. if yes, register this new async device group,
>    with the type DEV_ASYNC_SUSPEND_NOIRQ/DEV_ASYNC_RESUME_NOIRQ
>=20
> > Finally, I don't really understand what the code in the $subject pa=
tch is
> > supposed to do.  In particular, what's the purpose of dev_action()?
> > It only seems to check if func is not NULL right now.  Also, you de=
fine
> > DEV_ASYNC_ACTIONS_ALL as 0, so the condition
> > if (!(DEV_ASYNC_ACTIONS_ALL & type)) in dev_async_register() is alw=
ays
> > satisfied.
>=20
> please refer to patch 4/8 and 5/8 and 6/8
>=20
> Patch 2/8 is just a framework. No device async action is support yet.

OK

So please remove the redundant return statements from there and please =
don't
use (void *) for passing function pointers.

> And in Patch 4, 5, 6, we introduced three different types of device
> async actions, DEV_ASYNC_SUSPEND, DEV_ASYNC_RESUME and
> DEV_ASYNC_SHUTDOWN.
> I tried to split a big patch into several small patches.
> And it suggests how to adding a new device async type, like
> DEV_ASYNC_SUSPEND_NOIRQ, DEV_ASYNC_RESUME_NO_IRQ, etc. :)
>=20
> > Can we please discuss this thoroughly before any new patches are se=
nt?
> >=20
> do I still need to resend the patch?

Yes, please.

> If yes, I'll resend patch 2/8, 3/8, 4/8, 5/8, 6/8 as a new big one. :=
)

Yes, please, I think that would help to understand the design.

Best,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
