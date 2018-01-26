From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [Patch v1 0/8] platform/x86: intel_pmc_core: Add CFL/CNL Support
Date: Fri, 26 Jan 2018 14:45:39 +0200
Message-ID: <CAHp75VcG4gh8GWjeAiqPt2xx2R0xfijbqksAZMzpEt42s=LhUQ@mail.gmail.com>
References: <1516352307-20123-1-git-send-email-rajneesh.bhardwaj@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42092 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751466AbeAZMpl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Jan 2018 07:45:41 -0500
In-Reply-To: <1516352307-20123-1-git-send-email-rajneesh.bhardwaj@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Cc: Platform Driver <platform-driver-x86@vger.kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vishwanath Somayaji <vishwanath.somayaji@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org

On Fri, Jan 19, 2018 at 10:58 AM, Rajneesh Bhardwaj
<rajneesh.bhardwaj@intel.com> wrote:
> This series is the successor to
> https://www.spinics.net/lists/platform-driver-x86/msg14524.html and adds
> support for Intel Coffeelake and Cannonlake SoCs.
>
> This also presents an alternative to https://lkml.org/lkml/2017/11/17/876
> and introduces Cannonlake SoC to intel-family.h
>
> The following patches,
>
>  '0003-ACPI-LPIT-Export-lpit_read_residency_count_address.patch' and
>  '0006-x86-cpu-Add-Cannonlake-to-Intel-family.patch'
>
> do not belong to platform-drivers-x86 subsystem but the other patches in the
> series depend on them so, requesting the respective MAINTAINERS for their
> review and ACK so that these two patches can also go through the
> platform-drivers-x86 subsystem.

I have applied 1,2, and 5 to my review and testing queue, thanks!

P.S. Please, rebase and sent new version when patches  3 and 6 will get ACKa

> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
>
> Tested on Coffeelake, Cannonlake and Kabylake with 4.15-rc8 kernel.
>
> Rajneesh Bhardwaj (5):
>   platform/x86: intel_pmc_core: Refactor debugfs entries
>   platform/x86: intel_pmc_core: Convert to ICPU macro
>   x86/cpu: Add Cannonlake to Intel family
>   platform/x86: intel_pmc_core: Add CannonLake PCH support
>   platform/x86: intel_pmc_core: Special case for Coffeelake
>
> Srinivas Pandruvada (3):
>   platform/x86: intel_pmc_core: Substitute PCI with CPUID enumeration
>   ACPI / LPIT: Export lpit_read_residency_count_address()
>   platform/x86: intel_pmc_core: Read base address from LPIT
>
>  arch/x86/include/asm/intel-family.h   |   6 +
>  drivers/acpi/acpi_lpit.c              |   1 +
>  drivers/platform/x86/intel_pmc_core.c | 242 +++++++++++++++++++++-------------
>  drivers/platform/x86/intel_pmc_core.h |  14 +-
>  4 files changed, 174 insertions(+), 89 deletions(-)


-- 
With Best Regards,
Andy Shevchenko
