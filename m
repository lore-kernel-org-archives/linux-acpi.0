From: joeyli <jlee@suse.com>
Subject: Re: A udev rule to serve the change event of ACPI container?
Date: Thu, 13 Jul 2017 14:58:06 +0800
Message-ID: <20170713065806.GB2901@linux-l9pv.suse>
References: <20170626062657.GE4229@linux-l9pv.suse>
 <20170626085907.GE11534@dhcp22.suse.cz>
 <20170711082532.GA6927@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:57817 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750854AbdGMG6T (ORCPT
        <rfc822;groupwise-linux-acpi@vger.kernel.org:0:0>);
        Thu, 13 Jul 2017 02:58:19 -0400
Content-Disposition: inline
In-Reply-To: <20170711082532.GA6927@dhcp22.suse.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>

Hi Michal, 

Sorry for my delay.

On Tue, Jul 11, 2017 at 10:25:32AM +0200, Michal Hocko wrote:
> On Mon 26-06-17 10:59:07, Michal Hocko wrote:
> > On Mon 26-06-17 14:26:57, Joey Lee wrote:
> > > Hi all,
> > > 
> > > If ACPI received ejection request for a ACPI container, kernel
> > > emits KOBJ_CHANGE uevent when it found online children devices
> > > below the acpi container.
> > > 
> > > Base on the description of caa73ea15 kernel patch, user space
> > > is expected to offline all devices below the container and the
> > > container itself. Then, user space can finalize the removal of
> > > the container with the help of its ACPI device object's eject
> > > attribute in sysfs.
> > > 
> > > That means that kernel relies on users space to peform the offline
> > > and ejection jobs to acpi container and children devices. The
> > > discussion is here:
> > > 	https://lkml.org/lkml/2013/11/28/520
> > > 
> > > The mail loop didn't explain why the userspace is responsible for
> > > the whole container offlining. Is it possible to do that transparently
> > > from the kernel? What's the difference between offlining memory and
> > > processors which happends without any cleanup and container which
> > > does essentially the same except it happens at once? 
> > >  
> > >  - After a couple of years, can we let the container hot-remove
> > >    process transparently?
> > >  - Except udev rule, does there have any other mechanism to trigger
> > >    auto offline/ejection?
> > 
> > I would be also interested whether the kernel can simply send an udev event
> > to all devices in the container.
> 
> Any opinion on this?

If BIOS emits ejection event for a ACPI0004 container, someone needs
to handle the offline/eject jobs of container. Either kernel or user
space.

Only sending uevent to individual child device can simplify udev rule,
but it also means that the kernel needs to offline/eject container
after all children devices are offlined. Maybe adding a ejection flag
on the ACPI0004 object to indicate the container state. But, if userland
doesn't do his job, then the timing to reset the flag will be the problem. 

Thanks a lot!
Joey Lee 
