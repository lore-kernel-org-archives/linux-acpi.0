From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [for next][PATCH 2/2] x86/Kconfig: Select PCI_LOCKLESS_CONFIG if PCI is enabled
Date: Thu, 24 Jan 2019 11:51:19 +0100
Message-ID: <37767989.Gns3VtERSa@aspire.rjw.lan>
References: <20190121231958.28255-1-okaya@kernel.org> <20190121231958.28255-2-okaya@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190121231958.28255-2-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <okaya@kernel.org>
Cc: linux-next@vger.kernel.org, linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday, January 22, 2019 12:19:58 AM CET Sinan Kaya wrote:
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
> 

Is anyone taking this or should I?
