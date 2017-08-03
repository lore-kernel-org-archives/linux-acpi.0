From: Michal Hocko <mhocko@kernel.org>
Subject: Re: A udev rule to serve the change event of ACPI container?
Date: Thu, 3 Aug 2017 13:25:27 +0200
Message-ID: <20170803112527.GM12521@dhcp22.suse.cz>
References: <20170717090525.GF12888@dhcp22.suse.cz>
 <20170719090910.GK26098@linux-l9pv.suse>
 <20170724085702.GE25221@dhcp22.suse.cz>
 <20170724092921.GF3034@linux-l9pv.suse>
 <20170725124837.GH26723@dhcp22.suse.cz>
 <20170731073845.GC2946@linux-l9pv.suse>
 <20170802090143.GG2524@dhcp22.suse.cz>
 <20170803092237.GC5730@linux-l9pv.suse>
 <20170803093153.GG12521@dhcp22.suse.cz>
 <20170803095257.GD5730@linux-l9pv.suse>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49671 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751914AbdHCLZ3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 3 Aug 2017 07:25:29 -0400
Content-Disposition: inline
In-Reply-To: <20170803095257.GD5730@linux-l9pv.suse>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: joeyli <jlee@suse.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>

On Thu 03-08-17 17:52:57, Joey Lee wrote:
> On Thu, Aug 03, 2017 at 11:31:53AM +0200, Michal Hocko wrote:
> > On Thu 03-08-17 17:22:37, Joey Lee wrote:
> > > On Wed, Aug 02, 2017 at 11:01:43AM +0200, Michal Hocko wrote:
> > > > On Mon 31-07-17 15:38:45, Joey Lee wrote:
> > [...]
> > > > > So, the behavior is:
> > > > > 
> > > > > Kernel received ejection event, set _Eject_ flag on container object
> > > > >   -> Kernel sends offline events to all children devices
> > > > >     -> User space performs cleaning jobs and offlines each child device
> > > > >       -> Kernel detects all children offlined
> > > > > 	-> Kernel removes objects and calls power off(_EJ0)
> > > > 
> > > > Yes this is what I've had in mind. It is the "kernel detects..." part
> > > > which is not implemented now and that requires us to do the explicit
> > > > eject from userspace, correct?
> > > >
> > > 
> > > Yes, the _Eject_ flag and _detects_ part are not implemented now. 
> > > 
> > > In this approach, kernel still relies on user space to trigger the
> > > offline. The ejection process is still not transparent to user space.
> > > Is it what you want?
> > 
> > But as long as there is no auto-offlining then there is no other choice
> > no? Besides that userspace even shouldn't care about the fact that the
> 
> If Yasuaki's problem is already fixed in mainline, then the auto-offlining
> will be possible.  

Kernel alone cannot do the memory offline in general. There might be
resources which need an explicit userspace action. But that is not
important. The eject process should be pretty much independent on who is
doing the offline. The only thing that matters is that the kernel ejects
_after_ all resources are offline. This is the case already so the only
case we need to settle down is how is the offline done on a container
which has multiple resources. I still maintain my opinion that all
associated resources should be notified for offline from the kernel
rather than relying on userspace do somehow find those resources and
offline them manually.
-- 
Michal Hocko
SUSE Labs
