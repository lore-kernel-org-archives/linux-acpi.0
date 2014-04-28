From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [Linaro-acpi] [PATCH v3 part1 06/11] ARM64 / ACPI: Introduce
 lowlevel suspend function
Date: Mon, 28 Apr 2014 16:22:40 +0100
Message-ID: <20140428152240.GD31782@e102568-lin.cambridge.arm.com>
References: <1398432017-8506-1-git-send-email-hanjun.guo@linaro.org>
 <1398432017-8506-7-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:36765 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755333AbaD1PWp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Apr 2014 11:22:45 -0400
In-Reply-To: <1398432017-8506-7-git-send-email-hanjun.guo@linaro.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <Will.Deacon@arm.com>, Olof Johansson <olof@lixom.net>

On Fri, Apr 25, 2014 at 02:20:12PM +0100, Hanjun Guo wrote:
> acpi_wakeup_address is used on x86 as the address bios jumps into
> when machine wakes up from suspend. As arm64 does not have such a
> bios this mechanism will be provided by other means. But the define
> is still required inside the acpi core.
> 
> Introduce a null stub for acpi_suspend_lowlevel as this is also
> required by core. This will be filled in when standards are
> defined for arm64 ACPI global power states.
> 
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  arch/arm64/include/asm/acpi.h |    4 ++++
>  drivers/acpi/plat/arm-core.c  |    7 +++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index 3ac9dfb..60e3a72 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -85,6 +85,10 @@ static inline void acpi_disable_pci(void)
>   */ 
>  #define cpu_physical_id(cpu) -1
>  
> +/* Low-level suspend routine. */
> +extern int (*acpi_suspend_lowlevel)(void);
> +#define acpi_wakeup_address (0)

I understand you want code to compile, but as I mentioned in another
thread, I would focus more on understanding if these macros/hooks are
really needed for ARM rather than defining them _just_ to make code
compile. The fact that you are forced to define them makes me think
there is something to be changed in ACPI core code instead of adding
empty and probably useless macros/hooks for ARM which I have no idea
whatsoever whether will ever be needed or not.

Lorenzo

