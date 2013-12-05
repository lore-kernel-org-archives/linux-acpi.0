From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC part3 PATCH 1/2] clocksource / arch_timer: Use ACPI GTDT
 table to initialize arch timer
Date: Thu, 5 Dec 2013 04:43:21 +0100
Message-ID: <201312050443.21858.arnd@arndb.de>
References: <1386088891-2917-1-git-send-email-hanjun.guo@linaro.org>
 <1386088891-2917-2-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1386088891-2917-2-git-send-email-hanjun.guo@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Bjorn Helgaas <bhelgaas@google.com>, linaro-kernel@lists.linaro.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, patches@linaro.org, Catalin Marinas <catalin.marinas@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linaro-acpi@lists.linaro.org, linux-acpi@vger.kernel.org, Amit Daniel Kachhap <amit.daniel@samsung.com>, Hanjun Guo <hanjun.guo@linaro.org>, Olof Johansson <olof@lixom.net>, Jon Masters <jonathan@jonmasters.org>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@linaro.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday 03 December 2013, Hanjun Guo wrote:

> +#ifdef CONFIG_ACPI
> +void __init arch_timer_acpi_init(void)
> +{
...
> +}
> +#else
> +void __init arch_timer_acpi_init(void) { return; };
> +#endif
>  

The #else clause is broken in combination with 

> diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
> index 6d26b40..2654edf 100644
> --- a/include/clocksource/arm_arch_timer.h
> +++ b/include/clocksource/arm_arch_timer.h
> @@ -66,6 +66,11 @@ static inline struct timecounter *arch_timer_get_timecounter(void)
>  	return NULL;
>  }
>  
> +static inline void arch_timer_acpi_init(void)
> +{
> +	return;
> +}
> +
>  #endif
>  

this inline function. Have you build-tested this with CONFIG_ACPI disabled?

	Arnd
