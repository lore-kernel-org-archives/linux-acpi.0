From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / LPIT: Add Low Power Idle Table (LPIT) support
Date: Thu, 05 Oct 2017 14:53:15 +0200
Message-ID: <2963401.h7Kb59fPkb@aspire.rjw.lan>
References: <1507160613-56852-1-git-send-email-srinivas.pandruvada@linux.intel.com> <CAJZ5v0ihPoqS0EKDMwEohCdu7EXsb4B+8EgBpaFs+waV+A9RmA@mail.gmail.com> <1507166834.13183.2.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:50047 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751280AbdJENCj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Oct 2017 09:02:39 -0400
In-Reply-To: <1507166834.13183.2.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lv <lv.zheng@intel.com>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thursday, October 5, 2017 3:27:14 AM CEST Srinivas Pandruvada wrote:
> On Thu, 2017-10-05 at 02:51 +0200, Rafael J. Wysocki wrote:
> > On Thu, Oct 5, 2017 at 2:39 AM, Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > > 
> > > On Thu, 2017-10-05 at 02:10 +0200, Rafael J. Wysocki wrote:
> > > > 
> > > > On Thu, Oct 5, 2017 at 1:43 AM, Srinivas Pandruvada
> > > > <srinivas.pandruvada@linux.intel.com> wrote:
> > > > > 
> > > > > 
> > > > > Added functionality to read LPIT table, which provides:
> > > > > 
> > > > > - Sysfs interface to read residency counters via
> > > > > /sys/devices/system/cpu/cpuidle/low_power_idle_cpu_residency_us
> > > > > /sys/devices/system/cpu/cpuidle/low_power_idle_system_residency
> > > > > _us
> > > > > 
> > > > > 
> > > [...]
> > > 
> > > > 
> > > > > 
> > > > > +int lpit_read_residency_count_address(u64 *address)
> > > > > +{
> > > > > +       if (!residency_info_mem.gaddr.address)
> > > > > +               return -EINVAL;
> > > > > +
> > > > > +       *address = residency_info_mem.gaddr.address;
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > I don't see users of this.  Are there any?
> > > The user will be pmc_core_driver which will go through platform x86
> > > drivers tree.
> > OK
> > 
> > > 
> > > Also some mei drivers will also need.
> > What for?
> They also need to get the PMC base address.

Fair enough.

> [...]
> > > > > +
> > > > > +#endif
> > > > > +#endif
> > > > The above can go into internal.h or sleep.h in drivers/acpi/ IMO.
> > > > There's not need to export it.
> > > The pmc core driver is in drivers/platform/x86. Do you want to
> > > include
> > > a local file from there?
> > So the _init() thing can go to internal.h and the one-line header of
> > the other one can go to include/linux/acpi.h just fine.
> OK.
> 
> > 
> > And it would be good to mention what is going to use it in the
> > changelog.
> It is already described in the change log for pmc core driver.

OK, I seem to have overlooked that, sorry.

Thanks,
Rafael

