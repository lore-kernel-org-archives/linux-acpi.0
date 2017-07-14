From: Michal Hocko <mhocko@kernel.org>
Subject: Re: A udev rule to serve the change event of ACPI container?
Date: Fri, 14 Jul 2017 10:37:13 +0200
Message-ID: <20170714083713.GB2618@dhcp22.suse.cz>
References: <20170626062657.GE4229@linux-l9pv.suse>
 <20170626085907.GE11534@dhcp22.suse.cz>
 <20170711082532.GA6927@dhcp22.suse.cz>
 <20170713065806.GB2901@linux-l9pv.suse>
 <20170713070618.GC14492@dhcp22.suse.cz>
 <20170713124521.GE2901@linux-l9pv.suse>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49200 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750799AbdGNIhR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 Jul 2017 04:37:17 -0400
Content-Disposition: inline
In-Reply-To: <20170713124521.GE2901@linux-l9pv.suse>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: joeyli <jlee@suse.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>

On Thu 13-07-17 20:45:21, Joey Lee wrote:
> On Thu, Jul 13, 2017 at 09:06:19AM +0200, Michal Hocko wrote:
> > On Thu 13-07-17 14:58:06, Joey Lee wrote:
[...]
> > > If BIOS emits ejection event for a ACPI0004 container, someone needs
> > > to handle the offline/eject jobs of container. Either kernel or user
> > > space.
> > > 
> > > Only sending uevent to individual child device can simplify udev rule,
> > > but it also means that the kernel needs to offline/eject container
> > > after all children devices are offlined.
> > 
> > Why cannot kernel send this eject command to the BIOS if the whole
> > container is offline? If it is not then the kernel would send EBUSY to
> 
> Current kernel container hot-remove process:
> 
>   BIOS -> SCI event -> Kernel ACPI -> uevent -> userland
>               
> Then, kernel just calls _OST to expose state to BIOS, then process is
> stopped. Kernel doesn't wait there for userland to offline each child
> devices. Either BIOS or userland needs to trigger the container
> ejection.
> 
> > container is offline? If it is not then the kernel would send EBUSY to
> > the BIOS and BIOS would have to retry after some timeout. Or is it a
> 
> The d429e5c122 patch is merged to mainline. So kernel will send
> DEVICE_BUSY to BIOS after it emits uevent to userland. BIOS can choice
> to apply the retry approach until OS returns process failure exactly or
> BIOS timeout.
> 
> > problem that currently implemented BIOS firmwares do not implement this
> > retry?
> 
> Yes, we should consider the behavior of old BIOS. Old BIOS doesn't
> retry/resend the ejection event. So kernel or userland need to take the
> retry job. Obviously userland runs the retry since the caa73ea15 patch
> is merged.
> 
> IMHO there have two different expectation from user space application.
> 
> Applications like DVD player or Burner expect that kernel should
> info userspace for the ejection, then application can do their cleaning
> job and re-trigger ejection from userland.

I am not sure I understand the DVD example because I do not see how it
fits into the container and online/offline scenario.

> But, some other applications like database don't want that their service
> be stopped when the devices offline/eject. The hot-remove sholud be done by
> kernel transparently.
> 
> We need a way for fill two situations.

Hmm, so can we trigger the eject from the _kernel_ when the last child
is offlined?
-- 
Michal Hocko
SUSE Labs
