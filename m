From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 5/5] ACPI: ARM64: support for ACPI_TABLE_UPGRADE
Date: Fri, 27 May 2016 18:14:25 +0100
Message-ID: <20160527171424.GG10909@e104818-lin.cambridge.arm.com>
References: <1463674518-22477-1-git-send-email-aleksey.makarov@linaro.org>
 <1463674518-22477-6-git-send-email-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1463674518-22477-6-git-send-email-aleksey.makarov@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Russell King <linux@arm.linux.org.uk>, Graeme Gregory <graeme.gregory@linaro.org>, Jon Masters <jcm@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linux-acpi@vger.kernel.org, "Zheng,
 Lv" <lv.zheng@intel.com>, linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, May 19, 2016 at 07:15:16PM +0300, Aleksey Makarov wrote:
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index aee323b..d75f6c7 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -113,4 +113,6 @@ static inline const char *acpi_get_enable_method(int cpu)
>  pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr);
>  #endif
>  
> +#define ACPI_TABLE_UPGRADE_MAX_PHYS PFN_PHYS(max_pfn)
> +
>  #endif /*_ASM_ACPI_H*/
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index feab2ee..4bce811 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -261,11 +261,13 @@ void __init setup_arch(char **cmdline_p)
>  	efi_init();
>  	arm64_memblock_init();
>  
> +	paging_init();
> +
> +	acpi_table_upgrade();
> +
>  	/* Parse the ACPI tables for possible boot-time configuration */
>  	acpi_boot_table_init();
>  
> -	paging_init();
> -
>  	if (acpi_disabled)
>  		unflatten_device_tree();

So ACPI_TABLE_UPGRADE_MAX_PHYS is defined in terms of max_pfn and
presumably used by acpi_table_upgrade(). max_pfn is only initialised in
the arm64 bootmem_init() called just below the last line of context in
the hunk above.

-- 
Catalin
