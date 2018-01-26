From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [Patch v1 3/8] ACPI / LPIT: Export lpit_read_residency_count_address()
Date: Fri, 26 Jan 2018 11:48:39 +0200
Message-ID: <CAHp75VezHm3h5WRsm8ep=179qwCz=gep0hbUAcT3+qbH=_8dXQ@mail.gmail.com>
References: <1516352307-20123-1-git-send-email-rajneesh.bhardwaj@intel.com> <1516352307-20123-4-git-send-email-rajneesh.bhardwaj@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1516352307-20123-4-git-send-email-rajneesh.bhardwaj@intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Cc: Platform Driver <platform-driver-x86@vger.kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vishwanath Somayaji <vishwanath.somayaji@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Jan 19, 2018 at 10:58 AM, Rajneesh Bhardwaj
<rajneesh.bhardwaj@intel.com> wrote:
> From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>
> Export lpit_read_residency_count_address(), so that it can be used from
> drivers built as module. With the recent changes, the builtin_pci
> functionality of the intel_pmc_core driver is removed and now it can be
> built as a module to read this exported interface to calculate the PMC base
> address.
>

This needs Ack from ACPI maintainer(s).

Rafael, are you OK with exporting this method?

> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
>
> Tested-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>
>  drivers/acpi/acpi_lpit.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/acpi_lpit.c b/drivers/acpi/acpi_lpit.c
> index e94e478dd18b..cf4fc0161164 100644
> --- a/drivers/acpi/acpi_lpit.c
> +++ b/drivers/acpi/acpi_lpit.c
> @@ -100,6 +100,7 @@ int lpit_read_residency_count_address(u64 *address)
>
>         return 0;
>  }
> +EXPORT_SYMBOL_GPL(lpit_read_residency_count_address);
>
>  static void lpit_update_residency(struct lpit_residency_info *info,
>                                  struct acpi_lpit_native *lpit_native)
> --
> 2.7.4
>



-- 
With Best Regards,
Andy Shevchenko
