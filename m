From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [RFC][PATCH 0/3] PM: Asynchronous suspend and resume
Date: Fri, 14 Aug 2009 11:24:04 +0800
Message-ID: <1250220244.1804.9.camel@rzhang-dt>
References: <Pine.LNX.4.44L0.0908121702520.23954-100000@iolanthe.rowland.org>
	 <200908122343.20554.rjw@sisk.pl> <1250151509.2906.61.camel@rzhang-dt>
	 <200908132008.26508.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932185AbZHNDZS@vger.kernel.org>
In-Reply-To: <200908132008.26508.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2009-08-14 at 02:08 +0800, Rafael J. Wysocki wrote:
> On Thursday 13 August 2009, Zhang Rui wrote:
> > On Thu, 2009-08-13 at 05:43 +0800, Rafael J. Wysocki wrote:
> > > On Wednesday 12 August 2009, Alan Stern wrote:
> > > > On Wed, 12 Aug 2009, Rafael J. Wysocki wrote:
> > > >=20
> > > > > Hi,
> > > > >=20
> > > > > The following patches introduce a mechanism allowing us to ex=
ecute device
> > > > > drivers' suspend and resume callbacks asynchronously during s=
ystem sleep
> > > > > transitions, such as suspend to RAM.  The idea is explained i=
n the [1/1] patch
> > > > > message.
> > > > >=20
> > > > > Comments welcome.
> > > >=20
> > > > I get the idea.  Not bad.
> > >=20
> > > Thanks!
> > >=20
> > > > Have you tried it in a serious way?  For example, turning on th=
e
> > > > async_suspend flag for every device?
> > >=20
> > > No, I've only tested it with a few selected drivers.  I'm going t=
o try the
> > > "async everyone" scenario, though.
> > >=20
> > > > In one way it isn't as efficient as it could be.  You fire off =
a bunch
> > > > of async threads and then make many of them wait for parent or =
child
> > > > devices.  They could be doing useful work instead.
> > >=20
> > =EF=BB=BF=EF=BB=BFare you talking about this scenario, or I find an=
other problem of this
> > approach:
> > there is a part of dpm_list, dev1->dev_aaa->...->dev_bbb->dev2
> >=20
> > dev2 is dev1's first child.
> > dev1 resume takes 1s
> > dev_aaa~dev_bbb resume takes 0.1s.
> >=20
> > if we call =EF=BB=BFdevice_enable_async_suspend(dev1, true) in orde=
r to resume
> > device1 asynchronously, the real asynchronous resume only happens
> > between dev1 and dev_aaa to dev_bbb because dev2 needs to wait unti=
l
> > dev1 resume finished.
>=20
> Yes, that's how it works, but I would call it a limitation rather tha=
n a
> problem.  It partially stems from the fact that __async_schedule() ex=
ecutes
> ptr() synchronously in some circumstances (e.g. async_enabled unset),=
 so the
> suspend and resume callbacks have to be scheduled in the same order, =
in which
> they would have been called synchronously.
>=20
> > so kernel schedules dev1 resume in an async thread first, and then =
takes
> > 0.1s to finish the dev_aaa to dev_bbb resume, and then sleep 0.9s
> >=20
> > > I kind of agree, but then the patches would be more complicated.
> > >=20
> > The problem is that we need to invoke device_resume for every devic=
e
> > synchronously.
>=20
> Yes, we do.
>=20
> > I wonder if we can make the child devices inherit the
> > parent's =EF=BB=BFdev->power.async_suspend flag, so that devices th=
at need to
> > wait are resumed asynchronously, i.e. we never wait/sleep when pars=
ing
> > the dpm_list.
> >=20
> > this doesn't bring too much benefit in suspend case but it can spee=
d up
> > the resume process a lot.
>=20
> We can do that at the core level,

I think you mean we can't do that at the core level.

>  because there may be dependencies between
> the children the core doesn't know about.  Subsystems are free to set
> async_suspend for the entire branches of device hierarchy if they are=
 known
> not to contain any off-tree dependencies, but the core has no informa=
tion
> about that.
>=20
hmm, but the current patch doesn't handle the off-tree dependencies
neither.
e.g.
dev1, dev2, dev3
dev2 depends on dev1, dev3 is dev1's first child,
we only promise that dev1 has been resumed before resuming dev3 in the
current proposal.

anyway, this is not a problem after the pm_connection stuff is
implemented. :)

thanks,
rui
> > Of cause, this is not a problem if we turn on the async_suspend fla=
g for
> > every device.
>=20
> Yes, but we cannot do that at this point.
>=20
> > > > It would be interesting to invent a way of representing explici=
tly the=20
> > > > non-tree dependencies -- assuming there aren't too many of them=
!  (I=20
> > > > can just hear the TI guys hollering about power and timer domai=
ns...)
> > >=20
> > > I have an idea.
> > >=20
> > > Every such dependency involves two devices, one of which is a "ma=
ster"
> > > and the second of which is a "slave", meaning that the "slave" ha=
ve to be
> > > suspended before the "master" and cannot be resumed before it.  I=
n principle
> > > we could give each device two lists of "dependency objects", one =
containing
> > > "dependency objects" where the device is the "master" and the oth=
er containing
> > > "dependency objects" where the device is the "slave".  Then, each=
 "dependency
> > > object" could be represented as
> > >=20
> > > struct pm_connection {
> > >     struct device *master;
> > >     struct list_head master_hook;
> > >     struct device *slave;
> > >     struct list_head slave_hook;
> > > };
> > >=20
> > > Add some locking, helpers for adding / removing "dependency objec=
ts" etc.
> > > and it should work.  Instead of checking the parent, walk the lis=
t of
> > > "masters", instead of walking the list of children, walk the list=
 of "slaves".
> > >=20
> > > The core could create those objects for parent-child relationship=
s
> > > automatically, the other ones would have to be added by platforms=
 / bus types /
> > > drivers etc.
> > >=20
> > =EF=BB=BFthis sounds great. :)
>=20
> It can only be the next step, though, because it will affect the runt=
ime PM as
> well,  among other things.
>=20



> Thanks,
> Rafael
