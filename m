From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v9 03/21] ACPI: add arm64 to the platforms that use ioremap
Date: Wed, 04 Mar 2015 23:33:48 +0100
Message-ID: <2415033.fhZTq8sY1z@vostro.rjw.lan>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org> <1424853601-6675-4-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424853601-6675-4-git-send-email-hanjun.guo@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Al Stone <al.stone@linaro.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday, February 25, 2015 04:39:43 PM Hanjun Guo wrote:
> From: Graeme Gregory <graeme.gregory@linaro.org>
> 
> Now with the base changes to the arm memory mapping it is safe
> to convert to using ioremap to map in the tables after
> acpi_gbl_permanent_mmap is set.
> 
> CC: Rafael J Wysocki <rjw@rjwysocki.net>
> Tested-by: Robert Richter <rrichter@cavium.com>
> Acked-by: Robert Richter <rrichter@cavium.com>
> Signed-off-by: Al Stone <al.stone@linaro.org>
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/osl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index f9eeae8..39748bb 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -336,11 +336,11 @@ acpi_map_lookup_virt(void __iomem *virt, acpi_size size)
>  	return NULL;
>  }
>  
> -#ifndef CONFIG_IA64
> -#define should_use_kmap(pfn)   page_is_ram(pfn)
> -#else
> +#if defined(CONFIG_IA64) || defined(CONFIG_ARM64)
>  /* ioremap will take care of cache attributes */
>  #define should_use_kmap(pfn)   0
> +#else
> +#define should_use_kmap(pfn)   page_is_ram(pfn)
>  #endif
>  
>  static void __iomem *acpi_map(acpi_physical_address pg_off, unsigned long pg_sz)
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
