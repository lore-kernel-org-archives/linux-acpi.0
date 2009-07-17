From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/8] introduce the device async action mechanism
Date: Fri, 17 Jul 2009 03:11:59 +0200
Message-ID: <200907170312.00006.rjw@sisk.pl>
References: <1247643516.26272.77.camel@rzhang-dt> <20090715060006.71c2e2b6@infradead.org> <1247709910.26272.159.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:36829 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752718AbZGQBMB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Jul 2009 21:12:01 -0400
In-Reply-To: <1247709910.26272.159.camel@rzhang-dt>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@suse.cz>, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>

On Thursday 16 July 2009, Zhang Rui wrote:
> On Wed, 2009-07-15 at 21:00 +0800, Arjan van de Ven wrote:
> > On Wed, 15 Jul 2009 15:38:36 +0800
> > Zhang Rui <rui.zhang@intel.com> wrote:
> >=20
> > > Introduce the device async action mechanism.
> > >=20
> > > In order to speed up Linux suspend/resume/shutdown process,
> > > we introduce the device async action mechanism that allow devices
> > > to suspend/resume/shutdown asynchronously.
> > >=20
> > > The basic idea is that,
> > > if the suspend/resume/shutdown process of a device set,
> > > including a root device and its child devices, are independent of
> > > other devices, we create an async domain for this device set,
> > > and make them suspend/resume/shutdown asynchronously.
> >=20
> > Hi,
> >=20
> > I have some concerns about having an async domain per device(group)
> > rather than having one async domain for all of this,=20
>=20
> =EF=BB=BFwe create an async domain ONLY if we are sure that the devic=
e group is
> independent with the other devices.
>=20
> and IMO, using multiple async domains brings real device async action=
s.
> For example, in S3 resume case, there are two device groups:
> device group1: device1, device2, device3
> device group2: device4, device5, device6
>=20
> If they share the global domain, we may get:=EF=BB=BF
> device group1: device1(cookie 1), device2(cookie 4), device3(cookie 5=
)
> device group2: device4(cookie 2), device5(cookie 3), device6(cookie 6=
)
>=20
> this is not real asynchronous resume because
> device3 needs to call async_synchronize_cookie(5) before resume itsel=
f.
> which means that device4 and device5 must be resumed before device3.
>=20
> But if multiple async domain is used, we get:
> =EF=BB=BFdevice group1: device1(cookie 1), device2(cookie 2), device3=
(cookie 3)
> device group2: device4(cookie 1), device5(cookie 2), device6(cookie 3=
)
>=20
> device group1 and group2 can be resumed asynchronously.
>=20
>=20
> Another example, in my previous test,
> 1. sata controller. takes 0.4s to resume.
> 2. usb, including uchi and ehci controller takes 1.4s to resume
> 3. ACPI battery takes 0.3s to resume.
> 3. all the other devices take 0.2s to resume.
>=20
> sata, usb and ACPI battery are independent device groups.
> If we use multiple async domains, we can reduce the total device resu=
me
> time from 2.3s to a little more than 1.4s because there are a lot of
> sleep in usb resume process.
> But if we share the global async domain, the total resume time can on=
ly
> be reduced to about 2.1s because sata, usb and ACPI battery are actua=
lly
> resumed synchronously.

Well, first, I'm not really sure that using the async _boot_ infrastruc=
ture for
that is a good choice.  During suspend-resume we know dependencies betw=
een
devices beforehand, at least in theory, so we can use them.

In particular, we have to make sure that parent devices will not be sus=
pended
until all of their children have been suspended and children devices wi=
ll not
be resumed before the parents.  The current code handles this quite
efficiently, so I wonder what you're going to do not to break it.

Second, you seem to think that it only makes sense to execute ->suspend=
()
and ->resume() asynchronously (or in parallel), while for example in th=
e case
of PCI ->suspend_noirq() and ->resume_noirq() also contain code that
potentially can take quite some time to execute.

=46inally, I don't really understand what the code in the $subject patc=
h is
supposed to do.  In particular, what's the purpose of dev_action()?
It only seems to check if func is not NULL right now.  Also, you define
DEV_ASYNC_ACTIONS_ALL as 0, so the condition
if (!(DEV_ASYNC_ACTIONS_ALL & type)) in dev_async_register() is always
satisfied.  There are more things like that in this patch, not to menti=
on
excessive return statements and passing function pointers as (void *).

Can we please discuss this thoroughly before any new patches are sent?

Best,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
