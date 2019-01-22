From: Borislav Petkov <bp@alien8.de>
Subject: Re: [for next][PATCH 2/2] x86/Kconfig: Select PCI_LOCKLESS_CONFIG if
 PCI is enabled
Date: Tue, 22 Jan 2019 13:54:41 +0100
Message-ID: <20190122125440.GG26587@zn.tnic>
References: <20190121231958.28255-1-okaya@kernel.org>
 <20190121231958.28255-2-okaya@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190121231958.28255-2-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <okaya@kernel.org>
Cc: linux-next@vger.kernel.org, linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Jan 21, 2019 at 11:19:58PM +0000, Sinan Kaya wrote:
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

AFAICT, this is not really fixing a random config build issue but only
correcting the dependency, right?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
