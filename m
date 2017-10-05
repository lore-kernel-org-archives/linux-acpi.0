From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] ACPI / LPIT: Add Low Power Idle Table (LPIT) support
Date: Wed, 04 Oct 2017 18:27:14 -0700
Message-ID: <1507166834.13183.2.camel@linux.intel.com>
References: <1507160613-56852-1-git-send-email-srinivas.pandruvada@linux.intel.com>
         <CAJZ5v0j21EMMEQ=BRxzjEeRGaifYSGaxFVzg3TWN63d0EDtJ-g@mail.gmail.com>
         <1507163979.53049.122.camel@linux.intel.com>
         <CAJZ5v0ihPoqS0EKDMwEohCdu7EXsb4B+8EgBpaFs+waV+A9RmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:58824 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751219AbdJEB1P (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 4 Oct 2017 21:27:15 -0400
In-Reply-To: <CAJZ5v0ihPoqS0EKDMwEohCdu7EXsb4B+8EgBpaFs+waV+A9RmA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lv <lv.zheng@intel.com>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, 2017-10-05 at 02:51 +0200, Rafael J. Wysocki wrote:
> On Thu, Oct 5, 2017 at 2:39 AM, Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > 
> > On Thu, 2017-10-05 at 02:10 +0200, Rafael J. Wysocki wrote:
> > > 
> > > On Thu, Oct 5, 2017 at 1:43 AM, Srinivas Pandruvada
> > > <srinivas.pandruvada@linux.intel.com> wrote:
> > > > 
> > > > 
> > > > Added functionality to read LPIT table, which provides:
> > > > 
> > > > - Sysfs interface to read residency counters via
> > > > /sys/devices/system/cpu/cpuidle/low_power_idle_cpu_residency_us
> > > > /sys/devices/system/cpu/cpuidle/low_power_idle_system_residency
> > > > _us
> > > > 
> > > > 
> > [...]
> > 
> > > 
> > > > 
> > > > +int lpit_read_residency_count_address(u64 *address)
> > > > +{
> > > > +       if (!residency_info_mem.gaddr.address)
> > > > +               return -EINVAL;
> > > > +
> > > > +       *address = residency_info_mem.gaddr.address;
> > > > +
> > > > +       return 0;
> > > > +}
> > > I don't see users of this.  Are there any?
> > The user will be pmc_core_driver which will go through platform x86
> > drivers tree.
> OK
> 
> > 
> > Also some mei drivers will also need.
> What for?
They also need to get the PMC base address.

[...]
> > > > +
> > > > +#endif
> > > > +#endif
> > > The above can go into internal.h or sleep.h in drivers/acpi/ IMO.
> > > There's not need to export it.
> > The pmc core driver is in drivers/platform/x86. Do you want to
> > include
> > a local file from there?
> So the _init() thing can go to internal.h and the one-line header of
> the other one can go to include/linux/acpi.h just fine.
OK.

> 
> And it would be good to mention what is going to use it in the
> changelog.
It is already described in the change log for pmc core driver.

Thanks,
Srinivas

