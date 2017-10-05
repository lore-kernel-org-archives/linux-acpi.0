From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI / LPIT: Add Low Power Idle Table (LPIT) support
Date: Thu, 5 Oct 2017 02:51:19 +0200
Message-ID: <CAJZ5v0ihPoqS0EKDMwEohCdu7EXsb4B+8EgBpaFs+waV+A9RmA@mail.gmail.com>
References: <1507160613-56852-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <CAJZ5v0j21EMMEQ=BRxzjEeRGaifYSGaxFVzg3TWN63d0EDtJ-g@mail.gmail.com> <1507163979.53049.122.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34410 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751434AbdJEAvU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Oct 2017 20:51:20 -0400
In-Reply-To: <1507163979.53049.122.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lv <lv.zheng@intel.com>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Oct 5, 2017 at 2:39 AM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> On Thu, 2017-10-05 at 02:10 +0200, Rafael J. Wysocki wrote:
>> On Thu, Oct 5, 2017 at 1:43 AM, Srinivas Pandruvada
>> <srinivas.pandruvada@linux.intel.com> wrote:
>> >
>> > Added functionality to read LPIT table, which provides:
>> >
>> > - Sysfs interface to read residency counters via
>> > /sys/devices/system/cpu/cpuidle/low_power_idle_cpu_residency_us
>> > /sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us
>> >
>> >
>
> [...]
>
>> > +int lpit_read_residency_count_address(u64 *address)
>> > +{
>> > +       if (!residency_info_mem.gaddr.address)
>> > +               return -EINVAL;
>> > +
>> > +       *address = residency_info_mem.gaddr.address;
>> > +
>> > +       return 0;
>> > +}
>>
>> I don't see users of this.  Are there any?
> The user will be pmc_core_driver which will go through platform x86
> drivers tree.

OK

> Also some mei drivers will also need.

What for?

>
> [...]
>
>> >
>> > --- /dev/null+++ b/include/acpi/acpi_lpit.h
>> > @@ -0,0 +1,34 @@
>> > +/*
>> > + * acpi_lpit.h - LPIT table processing functions interface
>> > + *
>> > + * Copyright (C) 2017 Intel Corporation. All rights reserved.
>> > + *
>> > + * This program is free software; you can redistribute it and/or
>> > + * modify it under the terms of the GNU General Public License
>> > version
>> > + * 2 as published by the Free Software Foundation.
>> > + *
>> > + * This program is distributed in the hope that it will be useful,
>> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> > + * GNU General Public License for more details.
>> > + */
>> > +
>> > +#ifndef ACPI_LPIT_H
>> > +#define ACPI_LPIT_H
>> > +
>> > +#ifdef CONFIG_ACPI_LPIT
>> > +
>> > +void acpi_init_lpit(void);
>> > +int lpit_read_residency_count_address(u64 *address);
>> > +
>> > +#else
>> > +
>> > +static inline void acpi_init_lpit(void) { }
>> > +
>> > +static inline int lpit_read_residency_count_address(u64 *address)
>> > +{
>> > +       return -EINVAL;
>> > +}
>> > +
>> > +#endif
>> > +#endif
>>
>> The above can go into internal.h or sleep.h in drivers/acpi/ IMO.
>> There's not need to export it.
>
> The pmc core driver is in drivers/platform/x86. Do you want to include
> a local file from there?

So the _init() thing can go to internal.h and the one-line header of
the other one can go to include/linux/acpi.h just fine.

And it would be good to mention what is going to use it in the changelog.

Thanks,
Rafael
