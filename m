From: Michal Hocko <mhocko@kernel.org>
Subject: Re: A udev rule to serve the change event of ACPI container?
Date: Tue, 11 Jul 2017 10:25:32 +0200
Message-ID: <20170711082532.GA6927@dhcp22.suse.cz>
References: <20170626062657.GE4229@linux-l9pv.suse>
 <20170626085907.GE11534@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38285 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754510AbdGKIZg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 Jul 2017 04:25:36 -0400
Content-Disposition: inline
In-Reply-To: <20170626085907.GE11534@dhcp22.suse.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: joeyli <jlee@suse.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>

On Mon 26-06-17 10:59:07, Michal Hocko wrote:
> On Mon 26-06-17 14:26:57, Joey Lee wrote:
> > Hi all,
> > 
> > If ACPI received ejection request for a ACPI container, kernel
> > emits KOBJ_CHANGE uevent when it found online children devices
> > below the acpi container.
> > 
> > Base on the description of caa73ea15 kernel patch, user space
> > is expected to offline all devices below the container and the
> > container itself. Then, user space can finalize the removal of
> > the container with the help of its ACPI device object's eject
> > attribute in sysfs.
> > 
> > That means that kernel relies on users space to peform the offline
> > and ejection jobs to acpi container and children devices. The
> > discussion is here:
> > 	https://lkml.org/lkml/2013/11/28/520
> > 
> > The mail loop didn't explain why the userspace is responsible for
> > the whole container offlining. Is it possible to do that transparently
> > from the kernel? What's the difference between offlining memory and
> > processors which happends without any cleanup and container which
> > does essentially the same except it happens at once? 
> >  
> >  - After a couple of years, can we let the container hot-remove
> >    process transparently?
> >  - Except udev rule, does there have any other mechanism to trigger
> >    auto offline/ejection?
> 
> I would be also interested whether the kernel can simply send an udev event
> to all devices in the container.

Any opinion on this?
-- 
Michal Hocko
SUSE Labs
