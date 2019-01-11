From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/3] x86/cpu: Introduce INTEL_CPU_FAM*_NODATA() helper macros
Date: Fri, 11 Jan 2019 11:35:01 +0100
Message-ID: <CAJZ5v0hzUAYDxneYUNjcpvN5H+F+=fH1PnVcHP5TgLr-5Jc6YA@mail.gmail.com>
References: <20190109165754.90072-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190109165754.90072-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, the arch/x86 maintainers <x86@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jan 9, 2019 at 5:57 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> These macros are often used by the drivers and we have already a lot of
> duplication as ICPU() macro across them.
>
> Provide a generic x86 macro for users.
>
> This adds no driver data variants.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

If you want me to apply the series, I need an ACK for this one.

Alternatively, if you want to apply it yourself, please feel free to
add ACKs from me to the ACPI-related patches in it.

> ---
>  arch/x86/include/asm/intel-family.h | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
> index 25b28760fada..afd70055a750 100644
> --- a/arch/x86/include/asm/intel-family.h
> +++ b/arch/x86/include/asm/intel-family.h
> @@ -86,10 +86,16 @@
>         .family         = _family,                              \
>         .model          = _model,                               \
>         .feature        = X86_FEATURE_ANY,                      \
> -       .driver_data    = (kernel_ulong_t)&_driver_data         \
> +       .driver_data    = (kernel_ulong_t)_driver_data          \
>  }
>
>  #define INTEL_CPU_FAM6(_model, _driver_data)                   \
> -       INTEL_CPU_FAM_ANY(6, INTEL_FAM6_##_model, _driver_data)
> +       INTEL_CPU_FAM_ANY(6, INTEL_FAM6_##_model, &_driver_data)
> +
> +#define INTEL_CPU_FAM_ANY_NODATA(_family, _model)              \
> +       INTEL_CPU_FAM_ANY(_family, _model, 0)
> +
> +#define INTEL_CPU_FAM6_NODATA(_model)                          \
> +       INTEL_CPU_FAM_ANY_NODATA(6, INTEL_FAM6_##_model)
>
>  #endif /* _ASM_X86_INTEL_FAMILY_H */
> --
> 2.20.1
>
