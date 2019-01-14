From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 2/3] ACPI / LPSS: Get rid of custom ICPU() macro
Date: Mon, 14 Jan 2019 12:08:54 +0100
Message-ID: <20190114110854.GK2773@zn.tnic>
References: <20190109165754.90072-1-andriy.shevchenko@linux.intel.com>
 <20190109165754.90072-2-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190109165754.90072-2-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jan 09, 2019 at 06:57:53PM +0200, Andy Shevchenko wrote:
> Replace custom grown macro with generic INTEL_CPU_FAM6_NODATA() one.
> 
> No functional change intended.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/acpi_lpss.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index 5f94c35d165f..633a528bb6ea 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -311,11 +311,9 @@ static const struct lpss_device_desc bsw_spi_dev_desc = {
>  	.setup = lpss_deassert_reset,
>  };
>  
> -#define ICPU(model)	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, }
> -
>  static const struct x86_cpu_id lpss_cpu_ids[] = {
> -	ICPU(INTEL_FAM6_ATOM_SILVERMONT),	/* Valleyview, Bay Trail */

Sorry but the previous one was better: INTEL_FAM6_ATOM_SILVERMONT I can
find in the tree...

> -	ICPU(INTEL_FAM6_ATOM_AIRMONT),	/* Braswell, Cherry Trail */
> +	INTEL_CPU_FAM6_NODATA(ATOM_SILVERMONT),	/* Valleyview, Bay Trail */

For ATOM_SILVERMONT I find different things:

INTEL_CPU_FAM6(ATOM_SILVERMONT
X86_CSTATES_MODEL(INTEL_FAM6_ATOM_SILVERMONT
ICPU(INTEL_FAM6_ATOM_SILVERMONT
...

so you guys need to sit down and agree on a single form of usage and
stick with it.

And I'd advise against the first one which cuts off the
INTEL_FAM6_ATOM_SILVERMONT and other defines.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
