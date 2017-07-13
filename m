From: Michal Hocko <mhocko@kernel.org>
Subject: Re: A udev rule to serve the change event of ACPI container?
Date: Thu, 13 Jul 2017 09:06:19 +0200
Message-ID: <20170713070618.GC14492@dhcp22.suse.cz>
References: <20170626062657.GE4229@linux-l9pv.suse>
 <20170626085907.GE11534@dhcp22.suse.cz>
 <20170711082532.GA6927@dhcp22.suse.cz>
 <20170713065806.GB2901@linux-l9pv.suse>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50381 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750807AbdGMHGX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 13 Jul 2017 03:06:23 -0400
Content-Disposition: inline
In-Reply-To: <20170713065806.GB2901@linux-l9pv.suse>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: joeyli <jlee@suse.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>

On Thu 13-07-17 14:58:06, Joey Lee wrote:
> Hi Michal, 
> 
> Sorry for my delay.
> 
> On Tue, Jul 11, 2017 at 10:25:32AM +0200, Michal Hocko wrote:
> > On Mon 26-06-17 10:59:07, Michal Hocko wrote:
> > > On Mon 26-06-17 14:26:57, Joey Lee wrote:
> > > > Hi all,
> > > > 
> > > > If ACPI received ejection request for a ACPI container, kernel
> > > > emits KOBJ_CHANGE uevent when it found online children devices
> > > > below the acpi container.
> > > > 
> > > > Base on the description of caa73ea15 kernel patch, user space
> > > > is expected to offline all devices below the container and the
> > > > container itself. Then, user space can finalize the removal of
> > > > the container with the help of its ACPI device object's eject
> > > > attribute in sysfs.
> > > > 
> > > > That means that kernel relies on users space to peform the offline
> > > > and ejection jobs to acpi container and children devices. The
> > > > discussion is here:
> > > > 	https://lkml.org/lkml/2013/11/28/520
> > > > 
> > > > The mail loop didn't explain why the userspace is responsible for
> > > > the whole container offlining. Is it possible to do that transparently
> > > > from the kernel? What's the difference between offlining memory and
> > > > processors which happends without any cleanup and container which
> > > > does essentially the same except it happens at once? 
> > > >  
> > > >  - After a couple of years, can we let the container hot-remove
> > > >    process transparently?
> > > >  - Except udev rule, does there have any other mechanism to trigger
> > > >    auto offline/ejection?
> > > 
> > > I would be also interested whether the kernel can simply send an udev event
> > > to all devices in the container.
> > 
> > Any opinion on this?
> 
> If BIOS emits ejection event for a ACPI0004 container, someone needs
> to handle the offline/eject jobs of container. Either kernel or user
> space.
> 
> Only sending uevent to individual child device can simplify udev rule,
> but it also means that the kernel needs to offline/eject container
> after all children devices are offlined.

Why cannot kernel send this eject command to the BIOS if the whole
container is offline? If it is not then the kernel would send EBUSY to
the BIOS and BIOS would have to retry after some timeout. Or is it a
problem that currently implemented BIOS firmwares do not implement this
retry?
-- 
Michal Hocko
SUSE Labs
