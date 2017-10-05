From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2] ACPI / LPIT: Add Low Power Idle Table (LPIT) support
Date: Thu, 05 Oct 2017 13:43:33 -0700
Message-ID: <1507236213.53049.127.camel@linux.intel.com>
References: <1507227395-64204-1-git-send-email-srinivas.pandruvada@linux.intel.com>
         <CAHp75Vcm1K_Tg0wZx9HXXLEOjHw__2LWrBEM75icadcx_z0SxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:15020 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751350AbdJEUne (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 5 Oct 2017 16:43:34 -0400
In-Reply-To: <CAHp75Vcm1K_Tg0wZx9HXXLEOjHw__2LWrBEM75icadcx_z0SxA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Zheng, Lv" <lv.zheng@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, 2017-10-05 at 21:39 +0300, Andy Shevchenko wrote:
> On Thu, Oct 5, 2017 at 9:16 PM, Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > 
> > Added functionality to read LPIT table, which provides:
> > 
> > - Sysfs interface to read residency counters via
> > /sys/devices/system/cpu/cpuidle/low_power_idle_cpu_residency_us
> > /sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us
> > 
> > Here the count "low_power_idle_cpu_residency_us" shows the time
> > spent
> > by CPU package in low power state. This is read via MSR interface,
> > which
> > points to MSR for PKG C10.
> > 
> > Here the count "low_power_idle_system_residency_us" show the count
> > the
> > system was in low power state. This is read via MMIO interface.
> > This
> > is mapped to SLP_S0 residency on modern Intel systems. This
> > residency
> > is achieved only when CPU is in PKG C10 and all functional blocks
> > are
> > in low power state.
> > 
> > It is possible that none of the above counters present or anyone of
> > the
> > counter present or all counters present.
> > 
> > For example: On my Kabylake system both of the above counters
> > present.
> > After suspend to idle these counts updated and prints:
> > 6916179
> > 6998564
> > 
> > This counter can be read by tools like turbostat to display. Or it
> > can
> > be used to debug, if modern systems are reaching desired low power
> > state.
> > 
> > - Provides an interface to read residency counter memory address
> > This address can be used to get the base address of PMC memory
> > mapped IO.
> > This is utilized by intel_pmc_core driver to print more debug
> > information.
> 
> > 
> > +               switch (residency_info_mem.gaddr.bit_width) {
> > +               case 8:
> > +                       count =
> > readb(residency_info_mem.iomem_addr);
> > +                       break;
> > +               case 16:
> > +                       count =
> > readw(residency_info_mem.iomem_addr);
> > +                       break;
> > +               case 32:
> > +                       count =
> > readl(residency_info_mem.iomem_addr);
> > +                       break;
> > +               case 64:
> > +                       count =
> > readq(residency_info_mem.iomem_addr);
> > +                       break;
> > +               default:
> > +                       return -EINVAL;
> > +               }
> 
> I saw something very similar already under drivers/acpi. Can we
> utilize it (split a helper out of it and re-use)?
This functionality is probably not only for ACPI, but may be other
parts of the kernel too. So if there is a common function then it can
be more generic outside of ACPI.

Thanks,
Srinivas

