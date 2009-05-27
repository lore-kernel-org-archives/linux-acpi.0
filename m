From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [Intel-gfx] [RFC] i915/acpi: add lid status notification and
 detection
Date: Wed, 27 May 2009 01:58:01 -0700
Message-ID: <20090527015801.2f47089f@jbarnes-x200>
References: <20090513115734.338b7d55@jbarnes-g45>
	<1242264144.3773.415.camel@localhost.localdomain>
	<20090519171545.GA17801@srcf.ucam.org>
	<1242896273.32574.10.camel@rzhang-dt>
	<20090521093418.3f1a03d5@jbarnes-g45>
	<4A15FE57.7040002@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-02.bluehost.com ([69.89.21.12]:51955 "HELO
	outbound-mail-02.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758896AbZE0I6I (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 May 2009 04:58:08 -0400
In-Reply-To: <4A15FE57.7040002@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Fu Michael <michael_fu@linux.intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, lenb@kernel.org, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, 22 May 2009 09:22:31 +0800
Fu Michael <michael_fu@linux.intel.com> wrote:

> Jesse Barnes wrote:
> > On Thu, 21 May 2009 16:57:53 +0800
> > Zhang Rui <rui.zhang@intel.com> wrote:
> >
> >   
> >> On Wed, 2009-05-20 at 01:15 +0800, Matthew Garrett wrote:
> >>     
> >>>>> There's also a policy question here.  On some machines, a lid
> >>>>> close will cause the ACPI firmware to program the GPU,
> >>>>> disabling the pipe associated with the panel.  Should we detect
> >>>>> this and turn it back on at open time?  That could be dangerous
> >>>>> if userspace has received the LVDS hotplug event and changed
> >>>>> the config out from under us...
> >>>>>
> >>>>> Comments?
> >>>>>           
> >>>> It seems that the LID status is used to determine whether the
> >>>> LVDS is connected.
> >>>> It is not reliable. On some boxes the initial LID status is
> >>>> incorrect. Maybe the LID status is open. But the ACPI returns
> >>>> that the LID is close. In such case the LVDS is not initialized
> >>>> and user can't get the output.
> >>>>         
> >>> Really? I haven't seen any cases of this. They'll fail in all
> >>> sorts of fun ways with modern userland.
> >>>
> >>>       
> >> This is rare, and if this happens, a bug should be filed against
> >> ACPI. BTW: we have fixed/root caused all such kind of bugs that
> >> have been reported.
> >> So I think it makes sense to trust the Lid state reported by ACPI
> >> button driver.
> >>     
> >
> > So is that two acks for the patch?  If so, should it be split or
> > can it just go in through the i915 driver tree?
> >
> > Len?  (Patch attached for reference.)
> >
> > Thanks,
> >   
> Jesse, Just talked with Rui,  the above status is based on "BIOS
> upgrade or FW fix is acceptable as a bug fix solution". are you ok
> with this? :) Many lid status has to be fixed via action such as DSDT
> upgrade...

Yeah, I think that's ok, even if we need quirks for some platforms.  I
really hate relying on BIOS vendors/OEMs to provide BIOS updates in
general:  if Windows works on a given platform, why should Linux
require a BIOS "fix" on it?  In this case though, we can work around
broken platforms by just returning "open" all the time, if it comes to
that.

Jesse
