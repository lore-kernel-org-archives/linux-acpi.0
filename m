From: Michal Hocko <mhocko@kernel.org>
Subject: Re: A udev rule to serve the change event of ACPI container?
Date: Thu, 3 Aug 2017 11:31:53 +0200
Message-ID: <20170803093153.GG12521@dhcp22.suse.cz>
References: <20170714083713.GB2618@dhcp22.suse.cz>
 <20170714144414.GM2901@linux-l9pv.suse>
 <20170717090525.GF12888@dhcp22.suse.cz>
 <20170719090910.GK26098@linux-l9pv.suse>
 <20170724085702.GE25221@dhcp22.suse.cz>
 <20170724092921.GF3034@linux-l9pv.suse>
 <20170725124837.GH26723@dhcp22.suse.cz>
 <20170731073845.GC2946@linux-l9pv.suse>
 <20170802090143.GG2524@dhcp22.suse.cz>
 <20170803092237.GC5730@linux-l9pv.suse>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39850 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751161AbdHCJbz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 3 Aug 2017 05:31:55 -0400
Content-Disposition: inline
In-Reply-To: <20170803092237.GC5730@linux-l9pv.suse>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: joeyli <jlee@suse.com>
Cc: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Thu 03-08-17 17:22:37, Joey Lee wrote:
> On Wed, Aug 02, 2017 at 11:01:43AM +0200, Michal Hocko wrote:
> > On Mon 31-07-17 15:38:45, Joey Lee wrote:
[...]
> > > So, the behavior is:
> > > 
> > > Kernel received ejection event, set _Eject_ flag on container object
> > >   -> Kernel sends offline events to all children devices
> > >     -> User space performs cleaning jobs and offlines each child device
> > >       -> Kernel detects all children offlined
> > > 	-> Kernel removes objects and calls power off(_EJ0)
> > 
> > Yes this is what I've had in mind. It is the "kernel detects..." part
> > which is not implemented now and that requires us to do the explicit
> > eject from userspace, correct?
> >
> 
> Yes, the _Eject_ flag and _detects_ part are not implemented now. 
> 
> In this approach, kernel still relies on user space to trigger the
> offline. The ejection process is still not transparent to user space.
> Is it what you want?

But as long as there is no auto-offlining then there is no other choice
no? Besides that userspace even shouldn't care about the fact that the
eject is in progress. That is a BIOS->OS deal AFAIU. All the userspace
cares about is the proper cleanup of the resources and that happens at
the offline time.

> > > If anyone onlined one of the children devices in the term of waiting
> > > userland offlines all children, then the _Eject_ flag will be clean
> > > and ejection process will be interrupted. In this situation, administrator
> > > needs to trigger ejection event again.
> > 
> > yes
> > 
> > > Do you think that the race hurts anything?
> > 
> > What kind of race?
> 
> User space set a child online before all childreen offlined, then
> the _Eject_ flag is cleaned and the ejection process is interrupted.

Is this really a race though? Kernel will always have a full picture and
if userspace wants to online some part then the eject cannot succeed.
This is something that a userspace driver eject cannot possibly handle.
-- 
Michal Hocko
SUSE Labs
