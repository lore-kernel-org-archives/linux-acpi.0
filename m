From: Borislav Petkov <bp@alien8.de>
Subject: Re: [for-next][PATCH] x86/Kconfig: Select PCI_LOCKLESS_CONFIG if PCI
 is enabled
Date: Thu, 17 Jan 2019 17:37:22 +0100
Message-ID: <20190117163722.GE5023@zn.tnic>
References: <20190117161722.3945-1-okaya@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190117161722.3945-1-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <okaya@kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>
Cc: linux-next@vger.kernel.org, linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Jan 17, 2019 at 04:17:22PM +0000, Sinan Kaya wrote:
> After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
> CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
> satisfied implicitly through dependencies on CONFIG_ACPI have to be
> specified directly.
> 
> PCI_LOCKLESS_CONFIG depends on PCI but this dependency has not been
> mentioned in the Kconfig.
> 
> Add an explicit dependency here.
> 
> Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  arch/x86/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 568f339595ed..0519da6f8ee4 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -199,7 +199,7 @@ config X86
>  	select IRQ_FORCED_THREADING
>  	select NEED_SG_DMA_LENGTH
>  	select PCI_DOMAINS			if PCI
> -	select PCI_LOCKLESS_CONFIG
> +	select PCI_LOCKLESS_CONFIG		if PCI
>  	select PERF_EVENTS
>  	select RTC_LIB
>  	select RTC_MC146818_LIB
> -- 

Are there any more arch/x86/ fixes for the 5d32a66541c4 fallout floating
around?

If so, pls merge them all together into a single patch so that we're
done with this once and for all.

Also, I see a lot of build failures when doing randconfig builds for the
stuff in drivers/platform/x86/Kconfig. Is someone picking those up too?

If not, I'd take 'em too in a single patch, if Darren and Andy are fine
with it.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
