From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [Patch v2 0/5] platform/x86: intel_pmc_core: Add CFL/CNL Support
Date: Fri, 2 Feb 2018 22:14:31 +0200
Message-ID: <CAHp75Vdu1S9dLvfgUGQ+BMZ6rHfCNgPhSAqjqciqoA20nV0Nbw@mail.gmail.com>
References: <1517579017-19935-1-git-send-email-rajneesh.bhardwaj@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1517579017-19935-1-git-send-email-rajneesh.bhardwaj@intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Cc: Platform Driver <platform-driver-x86@vger.kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vishwanath Somayaji <vishwanath.somayaji@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, x86@kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Feb 2, 2018 at 3:43 PM, Rajneesh Bhardwaj
<rajneesh.bhardwaj@intel.com> wrote:
> This series contains the remaining (rebased) patches that were not applied
> to the pdx tree earlier. This also includes Acked-by / Reviewed-by tags from
> Rafael and Thomas.
>
> Rebased and tested on:
> http://git.infradead.org/linux-platform-drivers-x86.git/shortlog/refs/heads/review-andy
>

All 5 pushed to my review and testing queue.
Thanks!

> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
>
> Cc: linux-acpi@vger.kernel.org
> Cc: x86@kernel.org
>
> Rajneesh Bhardwaj (3):
>   x86/cpu: Add Cannonlake to Intel family
>   platform/x86: intel_pmc_core: Add CannonLake PCH support
>   platform/x86: intel_pmc_core: Special case for Coffeelake
>
> Srinivas Pandruvada (2):
>   ACPI / LPIT: Export lpit_read_residency_count_address()
>   platform/x86: intel_pmc_core: Read base address from LPIT
>
>  arch/x86/include/asm/intel-family.h   |   6 ++
>  drivers/acpi/acpi_lpit.c              |   1 +
>  drivers/platform/x86/intel_pmc_core.c | 108 +++++++++++++++++++++++++++++++++-
>  drivers/platform/x86/intel_pmc_core.h |  13 ++++
>  4 files changed, 127 insertions(+), 1 deletion(-)
>
> --
> 2.7.4
>



-- 
With Best Regards,
Andy Shevchenko
