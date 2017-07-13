From: joeyli <jlee@suse.com>
Subject: Re: A udev rule to serve the change event of ACPI container?
Date: Thu, 13 Jul 2017 20:45:21 +0800
Message-ID: <20170713124521.GE2901@linux-l9pv.suse>
References: <20170626062657.GE4229@linux-l9pv.suse>
 <20170626085907.GE11534@dhcp22.suse.cz>
 <20170711082532.GA6927@dhcp22.suse.cz>
 <20170713065806.GB2901@linux-l9pv.suse>
 <20170713070618.GC14492@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:33013 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751165AbdGMMpk (ORCPT
        <rfc822;groupwise-linux-acpi@vger.kernel.org:0:0>);
        Thu, 13 Jul 2017 08:45:40 -0400
Content-Disposition: inline
In-Reply-To: <20170713070618.GC14492@dhcp22.suse.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>

On Thu, Jul 13, 2017 at 09:06:19AM +0200, Michal Hocko wrote:
> On Thu 13-07-17 14:58:06, Joey Lee wrote:
> > Hi Michal, 
> > 
> > Sorry for my delay.
> > 
> > On Tue, Jul 11, 2017 at 10:25:32AM +0200, Michal Hocko wrote:
> > > On Mon 26-06-17 10:59:07, Michal Hocko wrote:
> > > > On Mon 26-06-17 14:26:57, Joey Lee wrote:
> > > > > Hi all,
> > > > > 
> > > > > If ACPI received ejection request for a ACPI container, kernel
> > > > > emits KOBJ_CHANGE uevent when it found online children devices
> > > > > below the acpi container.
> > > > > 
> > > > > Base on the description of caa73ea15 kernel patch, user space
> > > > > is expected to offline all devices below the container and the
> > > > > container itself. Then, user space can finalize the removal of
> > > > > the container with the help of its ACPI device object's eject
> > > > > attribute in sysfs.
> > > > > 
> > > > > That means that kernel relies on users space to peform the offline
> > > > > and ejection jobs to acpi container and children devices. The
> > > > > discussion is here:
> > > > > 	https://lkml.org/lkml/2013/11/28/520
> > > > > 
> > > > > The mail loop didn't explain why the userspace is responsible for
> > > > > the whole container offlining. Is it possible to do that transparently
> > > > > from the kernel? What's the difference between offlining memory and
> > > > > processors which happends without any cleanup and container which
> > > > > does essentially the same except it happens at once? 
> > > > >  
> > > > >  - After a couple of years, can we let the container hot-remove
> > > > >    process transparently?
> > > > >  - Except udev rule, does there have any other mechanism to trigger
> > > > >    auto offline/ejection?
> > > > 
> > > > I would be also interested whether the kernel can simply send an udev event
> > > > to all devices in the container.
> > > 
> > > Any opinion on this?
> > 
> > If BIOS emits ejection event for a ACPI0004 container, someone needs
> > to handle the offline/eject jobs of container. Either kernel or user
> > space.
> > 
> > Only sending uevent to individual child device can simplify udev rule,
> > but it also means that the kernel needs to offline/eject container
> > after all children devices are offlined.
> 
> Why cannot kernel send this eject command to the BIOS if the whole
> container is offline? If it is not then the kernel would send EBUSY to

Current kernel container hot-remove process:

  BIOS -> SCI event -> Kernel ACPI -> uevent -> userland
              
Then, kernel just calls _OST to expose state to BIOS, then process is
stopped. Kernel doesn't wait there for userland to offline each child
devices. Either BIOS or userland needs to trigger the container
ejection.

> container is offline? If it is not then the kernel would send EBUSY to
> the BIOS and BIOS would have to retry after some timeout. Or is it a

The d429e5c122 patch is merged to mainline. So kernel will send
DEVICE_BUSY to BIOS after it emits uevent to userland. BIOS can choice
to apply the retry approach until OS returns process failure exactly or
BIOS timeout.

> problem that currently implemented BIOS firmwares do not implement this
> retry?

Yes, we should consider the behavior of old BIOS. Old BIOS doesn't
retry/resend the ejection event. So kernel or userland need to take the
retry job. Obviously userland runs the retry since the caa73ea15 patch
is merged.

IMHO there have two different expectation from user space application.

Applications like DVD player or Burner expect that kernel should
info userspace for the ejection, then application can do their cleaning
job and re-trigger ejection from userland.

But, some other applications like database don't want that their service
be stopped when the devices offline/eject. The hot-remove sholud be done by
kernel transparently.

We need a way for fill two situations.

Thanks a lot!
Joey Lee
