From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] ACPI / LPIT: Add Low Power Idle Table (LPIT) support
Date: Thu, 5 Oct 2017 21:39:07 +0300
Message-ID: <CAHp75Vcm1K_Tg0wZx9HXXLEOjHw__2LWrBEM75icadcx_z0SxA@mail.gmail.com>
References: <1507227395-64204-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:45626 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbdJESjJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Oct 2017 14:39:09 -0400
In-Reply-To: <1507227395-64204-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Zheng, Lv" <lv.zheng@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Oct 5, 2017 at 9:16 PM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> Added functionality to read LPIT table, which provides:
>
> - Sysfs interface to read residency counters via
> /sys/devices/system/cpu/cpuidle/low_power_idle_cpu_residency_us
> /sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us
>
> Here the count "low_power_idle_cpu_residency_us" shows the time spent
> by CPU package in low power state. This is read via MSR interface, which
> points to MSR for PKG C10.
>
> Here the count "low_power_idle_system_residency_us" show the count the
> system was in low power state. This is read via MMIO interface. This
> is mapped to SLP_S0 residency on modern Intel systems. This residency
> is achieved only when CPU is in PKG C10 and all functional blocks are
> in low power state.
>
> It is possible that none of the above counters present or anyone of the
> counter present or all counters present.
>
> For example: On my Kabylake system both of the above counters present.
> After suspend to idle these counts updated and prints:
> 6916179
> 6998564
>
> This counter can be read by tools like turbostat to display. Or it can
> be used to debug, if modern systems are reaching desired low power state.
>
> - Provides an interface to read residency counter memory address
> This address can be used to get the base address of PMC memory mapped IO.
> This is utilized by intel_pmc_core driver to print more debug information.

> +               switch (residency_info_mem.gaddr.bit_width) {
> +               case 8:
> +                       count = readb(residency_info_mem.iomem_addr);
> +                       break;
> +               case 16:
> +                       count = readw(residency_info_mem.iomem_addr);
> +                       break;
> +               case 32:
> +                       count = readl(residency_info_mem.iomem_addr);
> +                       break;
> +               case 64:
> +                       count = readq(residency_info_mem.iomem_addr);
> +                       break;
> +               default:
> +                       return -EINVAL;
> +               }

I saw something very similar already under drivers/acpi. Can we
utilize it (split a helper out of it and re-use)?

-- 
With Best Regards,
Andy Shevchenko
