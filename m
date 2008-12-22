From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC PATCH 0/3] pm: device parallel resume mechanism
Date: Mon, 22 Dec 2008 21:19:32 +0100
Message-ID: <200812222119.32833.rjw@sisk.pl>
References: <1229668448.562.88.camel@rzhang-dt> <200812191815.11153.rjw@sisk.pl> <1229915522.562.164.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1229915522.562.164.camel@rzhang-dt>
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Barnes, Jesse" <jesse.barnes@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Monday, 22 of December 2008, Zhang Rui wrote:
> Hi, rafael=20

Hi,

> On Sat, 2008-12-20 at 01:15 +0800, Rafael J. Wysocki wrote:
> > On Friday, 19 of December 2008, Zhang Rui wrote:
> > > Hi, all,
> > >=20
> > > =EF=BB=BFThe resume process can be split into 3 parts, BIOS resum=
e time, kernel
> > > resume time and X/application resume time.
> > > And device resume takes most of the kernel resume time.
> > > this patch set introduces a new mechanism to resume device in par=
allel
> > > which can reduce the device resume time a lot.
> > >=20
> > > In this proposal, some devices can create its own workqueue for
> > > parallel resume. And for all the other devices that depends on th=
is
> > > device, their resume methods are queued in the same workqueue.
> > > And we flush all the workqueues before resuming X/applications.
> > >=20
> > > As the devices vary from different platforms. it's hard to give a=
n exact
> > > number of how much time it can reduce.
> > > Here are some of my test results:
> > > 1. eeepc901, kernel resume time can be reduced from about 2.1 sec=
onds to
> > > 1.6 seconds.
> > > 2. a SantaRosa testbox, kernel resume time can be reduced from ab=
out
> > > 3.5s to 2s.
> > >=20
> > > please review this patch. Any comments are welcome. :)
> >=20
> > Well, given that our single-thread resume is not exactly correct,
> you mean that the current serial resume mechanism still doesn't work
> stable, right?

Not exactly.  I mean it isn't _done_ right and not working correctly is=
 just a
consequence of this.

=46or this reason, we should first fix the current code and _then_ buil=
d add new
features like this, not the other way around.

>=20
> >  I think it's _way_ to early to indroduce things like this.
> Right, it's not for upstream.
> But it looks good in theory, and it does works without any side effec=
t
> in my case.
> So the patch was sent out here to see if there are some problems that
> are not covered by this patch, like the one Alan pointed out. :)

OK

Thanks,
Rafael
