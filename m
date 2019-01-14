From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 1/3] x86/cpu: Introduce INTEL_CPU_FAM*_NODATA() helper
 macros
Date: Mon, 14 Jan 2019 12:08:25 +0100
Message-ID: <20190114110825.GJ2773@zn.tnic>
References: <20190109165754.90072-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190109165754.90072-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Jan 09, 2019 at 06:57:52PM +0200, Andy Shevchenko wrote:
> These macros are often used by the drivers and we have already a lot of
> duplication as ICPU() macro across them.
> 
> Provide a generic x86 macro for users.
> 
> This adds no driver data variants.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/x86/include/asm/intel-family.h | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
> index 25b28760fada..afd70055a750 100644
> --- a/arch/x86/include/asm/intel-family.h
> +++ b/arch/x86/include/asm/intel-family.h
> @@ -86,10 +86,16 @@
>  	.family		= _family,				\
>  	.model		= _model,				\
>  	.feature	= X86_FEATURE_ANY,			\
> -	.driver_data	= (kernel_ulong_t)&_driver_data		\
> +	.driver_data	= (kernel_ulong_t)_driver_data		\
>  }
>  
>  #define INTEL_CPU_FAM6(_model, _driver_data)			\
> -	INTEL_CPU_FAM_ANY(6, INTEL_FAM6_##_model, _driver_data)
> +	INTEL_CPU_FAM_ANY(6, INTEL_FAM6_##_model, &_driver_data)
> +
> +#define INTEL_CPU_FAM_ANY_NODATA(_family, _model)		\

"ANY_NODATA" is confusing IMO, as I have no clue what that means. ICPU()
and the full model define was fine.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
