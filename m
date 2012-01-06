From: "Tian, Kevin" <kevin.tian@intel.com>
Subject: RE: [Xen-devel] [PATCH 3/8] ACPI: processor: add
 __acpi_processor_[un]register_driver helpers.
Date: Fri, 6 Jan 2012 01:07:58 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D102D62B@SHSMSX102.ccr.corp.intel.com>
References: <1322673664-14642-1-git-send-email-konrad.wilk@oracle.com>
 <1322673664-14642-4-git-send-email-konrad.wilk@oracle.com>
 <20111216220342.GC9832@phenom.dumpdata.com>
 <625BA99ED14B2D499DC4E29D8138F1506E01AABC7A@shsmsx502.ccr.corp.intel.com>
 <20111219142626.GB27772@andromeda.dapyr.net>
 <625BA99ED14B2D499DC4E29D8138F1506E01AAC03A@shsmsx502.ccr.corp.intel.com>
 <20111220153145.GB13253@andromeda.dapyr.net>
 <625BA99ED14B2D499DC4E29D8138F1506E01AAC469@shsmsx502.ccr.corp.intel.com>
 <20111223030103.GA7218@andromeda.dapyr.net>
 <AADFC41AFE54684AB9EE6CBC0274A5D10145B9@SHSMSX102.ccr.corp.intel.com>
 <20120103205925.GI17472@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:22365 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758249Ab2AFBIQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Jan 2012 20:08:16 -0500
In-Reply-To: <20120103205925.GI17472@phenom.dumpdata.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Konrad Rzeszutek Wilk <konrad@darnok.org>, "jeremy@goop.org" <jeremy@goop.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "Ian.Campbell@citrix.com" <Ian.Campbell@citrix.com>, "mike.mcclurg@citrix.com" <mike.mcclurg@citrix.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stefan.bader@canonical.com" <stefan.bader@canonical.com>, "rjw@sisk.pl" <rjw@sisk.pl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "liang.tang@oracle.com" <liang.tang@oracle.com>, "Yu, Ke" <ke.yu@intel.com>, "konrad@kernel.org" <konrad@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>

> From: Konrad Rzeszutek Wilk [mailto:konrad.wilk@oracle.com]
> Sent: Wednesday, January 04, 2012 4:59 AM
> 
> On Mon, Dec 26, 2011 at 01:31:45AM +0000, Tian, Kevin wrote:
> > > From: Konrad Rzeszutek Wilk [mailto:konrad@darnok.org]
> > > Sent: Friday, December 23, 2011 11:01 AM
> > >
> > > > > OK. Lets put the # VCPU != PCPU aside. Say dom0 will boot with all
> > > > > CPUs and then later on the admin starts unplugging them.
> > > >
> > > > This should be communicated to major Xen based distributions, so that
> it's
> > > > an agreed approach since in majority case dom0 is configured as UP or
> > > > a few VCPUs.
> > >
> > > I am not saying that is it the agreed approach. There has to be
> > > flexibility in supporting both. But what I want to understand whether
> > > the requirement for VCPU != PCPU can be put aside and put in the drivers
> > > later on.
> >
> > sure. VCPU!=PCPU requirement is orthogonal to the basic part for gearing
> > ACPI information to Xen.
> >
> > >
> > > So that the first approach is not changing the generic drivers (much).
> > > The reason I am asking about this is two-fold:
> > >  1). For new distros (Ubuntu, Fedora), the default is all VCPUs.
> >
> > good to know that.
> >
> > >      Enterprising users might use dom0_max_vcpus to limit the VCPU
> count,
> > >      but most won't.
> > >      Which mean we can concentrate on bringing the _Pxx/_Cxx parsing
> > >      up to the hypervisor. Which is really neccessary on any chipset
> > >      which has the notion of TurboBoost (otherwise the Xen scheduler
> > >      won't pick this up and won't engage this mode in certain
> > >      workloads).
> > >  2). The ACPI maintainers are busy with ACPI 5.0. I don't know how
> > >      much work this is, but it probably means tons of stuff with
> > >      embedded platforms and tons of regression testing. So if there
> > >      is a patch that does not impact the generic code much (or any)
> > >      it will make their life easier. Which also means we can built
> > >      on top that for the VCPU != PCPU case.
> > >
> > > That is what I am trying to understand.
> >
> > no problem. this incremental approach should work.
> 
> Excellent. So now the big question  - is this something you would have the
> time to do?

yes, this is a big question. First, I'd like to give my sincere thanks to you and
Liang for help push this part to Linux upstream. You've done a great job. :-)
Unfortunately I can't afford the time in the short term, due to extremely busy
tasks in other projects, at least in the whole Q1. Really sorry about that. :/

I would very appreciate your help if you could continue lending some time here,
since you've done plenty of works on the cleanup. The majority of the tricky 
part is related to VCPU/PCPU handling. If putting that part aside, the remaining 
logic should be much simpler.

Thanks
Kevin
