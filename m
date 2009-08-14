From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 0/3] PM: Asynchronous suspend and resume
Date: Fri, 14 Aug 2009 13:58:54 +0200
Message-ID: <200908141358.54129.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0908121702520.23954-100000@iolanthe.rowland.org> <200908132008.26508.rjw@sisk.pl> <1250220244.1804.9.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:39398 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755553AbZHNL62 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Aug 2009 07:58:28 -0400
In-Reply-To: <1250220244.1804.9.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Arjan van de Ven <arjan@linux.intel.com>

On Friday 14 August 2009, Zhang Rui wrote:
> On Fri, 2009-08-14 at 02:08 +0800, Rafael J. Wysocki wrote:
> > On Thursday 13 August 2009, Zhang Rui wrote:
> > > On Thu, 2009-08-13 at 05:43 +0800, Rafael J. Wysocki wrote:
> > > > On Wednesday 12 August 2009, Alan Stern wrote:
> > > > > On Wed, 12 Aug 2009, Rafael J. Wysocki wrote:
> > > > >=20
> > > > > > Hi,
> > > > > >=20
> > > > > > The following patches introduce a mechanism allowing us to =
execute device
> > > > > > drivers' suspend and resume callbacks asynchronously during=
 system sleep
> > > > > > transitions, such as suspend to RAM.  The idea is explained=
 in the [1/1] patch
> > > > > > message.
> > > > > >=20
> > > > > > Comments welcome.
> > > > >=20
> > > > > I get the idea.  Not bad.
> > > >=20
> > > > Thanks!
> > > >=20
> > > > > Have you tried it in a serious way?  For example, turning on =
the
> > > > > async_suspend flag for every device?
> > > >=20
> > > > No, I've only tested it with a few selected drivers.  I'm going=
 to try the
> > > > "async everyone" scenario, though.
> > > >=20
> > > > > In one way it isn't as efficient as it could be.  You fire of=
f a bunch
> > > > > of async threads and then make many of them wait for parent o=
r child
> > > > > devices.  They could be doing useful work instead.
> > > >=20
> > > =EF=BB=BF=EF=BB=BFare you talking about this scenario, or I find =
another problem of this
> > > approach:
> > > there is a part of dpm_list, dev1->dev_aaa->...->dev_bbb->dev2
> > >=20
> > > dev2 is dev1's first child.
> > > dev1 resume takes 1s
> > > dev_aaa~dev_bbb resume takes 0.1s.
> > >=20
> > > if we call =EF=BB=BFdevice_enable_async_suspend(dev1, true) in or=
der to resume
> > > device1 asynchronously, the real asynchronous resume only happens
> > > between dev1 and dev_aaa to dev_bbb because dev2 needs to wait un=
til
> > > dev1 resume finished.
> >=20
> > Yes, that's how it works, but I would call it a limitation rather t=
han a
> > problem.  It partially stems from the fact that __async_schedule() =
executes
> > ptr() synchronously in some circumstances (e.g. async_enabled unset=
), so the
> > suspend and resume callbacks have to be scheduled in the same order=
, in which
> > they would have been called synchronously.
> >=20
> > > so kernel schedules dev1 resume in an async thread first, and the=
n takes
> > > 0.1s to finish the dev_aaa to dev_bbb resume, and then sleep 0.9s
> > >=20
> > > > I kind of agree, but then the patches would be more complicated=
=2E
> > > >=20
> > > The problem is that we need to invoke device_resume for every dev=
ice
> > > synchronously.
> >=20
> > Yes, we do.
> >=20
> > > I wonder if we can make the child devices inherit the
> > > parent's =EF=BB=BFdev->power.async_suspend flag, so that devices =
that need to
> > > wait are resumed asynchronously, i.e. we never wait/sleep when pa=
rsing
> > > the dpm_list.
> > >=20
> > > this doesn't bring too much benefit in suspend case but it can sp=
eed up
> > > the resume process a lot.
> >=20
> > We can do that at the core level,
>=20
> I think you mean we can't do that at the core level.

That's correct, sorry for the mistake.

> >  because there may be dependencies between
> > the children the core doesn't know about.  Subsystems are free to s=
et
> > async_suspend for the entire branches of device hierarchy if they a=
re known
> > not to contain any off-tree dependencies, but the core has no infor=
mation
> > about that.
> >=20
> hmm, but the current patch doesn't handle the off-tree dependencies
> neither.
> e.g.
> dev1, dev2, dev3
> dev2 depends on dev1, dev3 is dev1's first child,
> we only promise that dev1 has been resumed before resuming dev3 in th=
e
> current proposal.

Sure, and that's why I said "if they are known not to contain any off-t=
ree
dependencies".  IOW, if a subsystem (e.g. platform) knows that none of =
its
devices have any off-tree dependencies, it can safely set async_suspend=
 for
all of them.

> anyway, this is not a problem after the pm_connection stuff is
> implemented. :)

Well, that's going to take some time I guess.

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
