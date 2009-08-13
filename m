From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 0/3] PM: Asynchronous suspend and resume
Date: Thu, 13 Aug 2009 20:08:26 +0200
Message-ID: <200908132008.26508.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0908121702520.23954-100000@iolanthe.rowland.org> <200908122343.20554.rjw@sisk.pl> <1250151509.2906.61.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:35716 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751693AbZHMSHo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Aug 2009 14:07:44 -0400
In-Reply-To: <1250151509.2906.61.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Arjan van de Ven <arjan@linux.intel.com>

On Thursday 13 August 2009, Zhang Rui wrote:
> On Thu, 2009-08-13 at 05:43 +0800, Rafael J. Wysocki wrote:
> > On Wednesday 12 August 2009, Alan Stern wrote:
> > > On Wed, 12 Aug 2009, Rafael J. Wysocki wrote:
> > >=20
> > > > Hi,
> > > >=20
> > > > The following patches introduce a mechanism allowing us to exec=
ute device
> > > > drivers' suspend and resume callbacks asynchronously during sys=
tem sleep
> > > > transitions, such as suspend to RAM.  The idea is explained in =
the [1/1] patch
> > > > message.
> > > >=20
> > > > Comments welcome.
> > >=20
> > > I get the idea.  Not bad.
> >=20
> > Thanks!
> >=20
> > > Have you tried it in a serious way?  For example, turning on the
> > > async_suspend flag for every device?
> >=20
> > No, I've only tested it with a few selected drivers.  I'm going to =
try the
> > "async everyone" scenario, though.
> >=20
> > > In one way it isn't as efficient as it could be.  You fire off a =
bunch
> > > of async threads and then make many of them wait for parent or ch=
ild
> > > devices.  They could be doing useful work instead.
> >=20
> =EF=BB=BF=EF=BB=BFare you talking about this scenario, or I find anot=
her problem of this
> approach:
> there is a part of dpm_list, dev1->dev_aaa->...->dev_bbb->dev2
>=20
> dev2 is dev1's first child.
> dev1 resume takes 1s
> dev_aaa~dev_bbb resume takes 0.1s.
>=20
> if we call =EF=BB=BFdevice_enable_async_suspend(dev1, true) in order =
to resume
> device1 asynchronously, the real asynchronous resume only happens
> between dev1 and dev_aaa to dev_bbb because dev2 needs to wait until
> dev1 resume finished.

Yes, that's how it works, but I would call it a limitation rather than =
a
problem.  It partially stems from the fact that __async_schedule() exec=
utes
ptr() synchronously in some circumstances (e.g. async_enabled unset), s=
o the
suspend and resume callbacks have to be scheduled in the same order, in=
 which
they would have been called synchronously.

> so kernel schedules dev1 resume in an async thread first, and then ta=
kes
> 0.1s to finish the dev_aaa to dev_bbb resume, and then sleep 0.9s
>=20
> > I kind of agree, but then the patches would be more complicated.
> >=20
> The problem is that we need to invoke device_resume for every device
> synchronously.

Yes, we do.

> I wonder if we can make the child devices inherit the
> parent's =EF=BB=BFdev->power.async_suspend flag, so that devices that=
 need to
> wait are resumed asynchronously, i.e. we never wait/sleep when parsin=
g
> the dpm_list.
>=20
> this doesn't bring too much benefit in suspend case but it can speed =
up
> the resume process a lot.

We can do that at the core level, because there may be dependencies bet=
ween
the children the core doesn't know about.  Subsystems are free to set
async_suspend for the entire branches of device hierarchy if they are k=
nown
not to contain any off-tree dependencies, but the core has no informati=
on
about that.

> Of cause, this is not a problem if we turn on the async_suspend flag =
for
> every device.

Yes, but we cannot do that at this point.

> > > It would be interesting to invent a way of representing explicitl=
y the=20
> > > non-tree dependencies -- assuming there aren't too many of them! =
 (I=20
> > > can just hear the TI guys hollering about power and timer domains=
=2E..)
> >=20
> > I have an idea.
> >=20
> > Every such dependency involves two devices, one of which is a "mast=
er"
> > and the second of which is a "slave", meaning that the "slave" have=
 to be
> > suspended before the "master" and cannot be resumed before it.  In =
principle
> > we could give each device two lists of "dependency objects", one co=
ntaining
> > "dependency objects" where the device is the "master" and the other=
 containing
> > "dependency objects" where the device is the "slave".  Then, each "=
dependency
> > object" could be represented as
> >=20
> > struct pm_connection {
> >     struct device *master;
> >     struct list_head master_hook;
> >     struct device *slave;
> >     struct list_head slave_hook;
> > };
> >=20
> > Add some locking, helpers for adding / removing "dependency objects=
" etc.
> > and it should work.  Instead of checking the parent, walk the list =
of
> > "masters", instead of walking the list of children, walk the list o=
f "slaves".
> >=20
> > The core could create those objects for parent-child relationships
> > automatically, the other ones would have to be added by platforms /=
 bus types /
> > drivers etc.
> >=20
> =EF=BB=BFthis sounds great. :)

It can only be the next step, though, because it will affect the runtim=
e PM as
well,  among other things.

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
