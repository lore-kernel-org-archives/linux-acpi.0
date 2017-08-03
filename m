From: joeyli <jlee@suse.com>
Subject: Re: A udev rule to serve the change event of ACPI container?
Date: Thu, 3 Aug 2017 17:52:57 +0800
Message-ID: <20170803095257.GD5730@linux-l9pv.suse>
References: <20170714144414.GM2901@linux-l9pv.suse>
 <20170717090525.GF12888@dhcp22.suse.cz>
 <20170719090910.GK26098@linux-l9pv.suse>
 <20170724085702.GE25221@dhcp22.suse.cz>
 <20170724092921.GF3034@linux-l9pv.suse>
 <20170725124837.GH26723@dhcp22.suse.cz>
 <20170731073845.GC2946@linux-l9pv.suse>
 <20170802090143.GG2524@dhcp22.suse.cz>
 <20170803092237.GC5730@linux-l9pv.suse>
 <20170803093153.GG12521@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:48644 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751775AbdHCJxI (ORCPT
        <rfc822;groupwise-linux-acpi@vger.kernel.org:0:0>);
        Thu, 3 Aug 2017 05:53:08 -0400
Content-Disposition: inline
In-Reply-To: <20170803093153.GG12521@dhcp22.suse.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>

On Thu, Aug 03, 2017 at 11:31:53AM +0200, Michal Hocko wrote:
> On Thu 03-08-17 17:22:37, Joey Lee wrote:
> > On Wed, Aug 02, 2017 at 11:01:43AM +0200, Michal Hocko wrote:
> > > On Mon 31-07-17 15:38:45, Joey Lee wrote:
> [...]
> > > > So, the behavior is:
> > > > 
> > > > Kernel received ejection event, set _Eject_ flag on container object
> > > >   -> Kernel sends offline events to all children devices
> > > >     -> User space performs cleaning jobs and offlines each child device
> > > >       -> Kernel detects all children offlined
> > > > 	-> Kernel removes objects and calls power off(_EJ0)
> > > 
> > > Yes this is what I've had in mind. It is the "kernel detects..." part
> > > which is not implemented now and that requires us to do the explicit
> > > eject from userspace, correct?
> > >
> > 
> > Yes, the _Eject_ flag and _detects_ part are not implemented now. 
> > 
> > In this approach, kernel still relies on user space to trigger the
> > offline. The ejection process is still not transparent to user space.
> > Is it what you want?
> 
> But as long as there is no auto-offlining then there is no other choice
> no? Besides that userspace even shouldn't care about the fact that the

If Yasuaki's problem is already fixed in mainline, then the auto-offlining
will be possible.  

> eject is in progress. That is a BIOS->OS deal AFAIU. All the userspace
> cares about is the proper cleanup of the resources and that happens at
> the offline time.
>

I agree! User space doesn't need to know the detail of kobject cleaning
and ejection stages.
 
> > > > If anyone onlined one of the children devices in the term of waiting
> > > > userland offlines all children, then the _Eject_ flag will be clean
> > > > and ejection process will be interrupted. In this situation, administrator
> > > > needs to trigger ejection event again.
> > > 
> > > yes
> > > 
> > > > Do you think that the race hurts anything?
> > > 
> > > What kind of race?
> > 
> > User space set a child online before all childreen offlined, then
> > the _Eject_ flag is cleaned and the ejection process is interrupted.
> 
> Is this really a race though? Kernel will always have a full picture and
> if userspace wants to online some part then the eject cannot succeed.
> This is something that a userspace driver eject cannot possibly handle.

Then I agree.

I am waiting Yasuaki's response and want to know Rafael's and
Yasuaki's opinions about the _Eject_ flag approach.

Thanks a lot!
Joey Lee
