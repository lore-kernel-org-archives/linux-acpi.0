From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 1/2] arm/arm64: ACPI: Introduce CONFIG_ACPI_MUST_HAVE_CCA
Date: Wed, 29 Apr 2015 15:04:46 +0100
Message-ID: <20150429140445.GA18867@e104818-lin.cambridge.arm.com>
References: <1430315049-4663-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1430315049-4663-2-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1430315049-4663-2-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: rjw@rjwysocki.net, lenb@kernel.org, will.deacon@arm.com, al.stone@linaro.org, arnd@arndb.de, linaro-acpi@lists.linaro.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, leo.duran@amd.com, hanjun.guo@linaro.org, msalter@redhat.com, grant.likely@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 29, 2015 at 08:44:08AM -0500, Suravee Suthikulpanit wrote:
> From ACPIv6 (http://www.uefi.org/sites/default/files/resources/ACPI_6.0.pdf),
> section 6.2.17 _CCA states that ARM platforms require ACPI _CCA object to be
> specified for DMA-cabpable devices. This patch introduces ACPI_MUST_HAVE_CCA
> in arm and arm64 Kconfig to specify such requirement.
> 
> Note that when _CCA is required, if it is missing in the DSDT. ACPI driver
> will default to setting up devices as non-coherent.
> 
> Signed-off-by: Mark Salter <msalter@redhat.com>
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> ---
>  arch/arm/Kconfig     | 1 +
>  arch/arm64/Kconfig   | 1 +
>  drivers/acpi/Kconfig | 3 +++
>  3 files changed, 5 insertions(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 45df48b..2a0d036 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1,6 +1,7 @@
>  config ARM
>  	bool
>  	default y
> +	select ACPI_MUST_HAVE_CCA if ACPI
>  	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>  	select ARCH_HAS_ELF_RANDOMIZE
>  	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST

Any plans for ACPI on 32-bit ARM?

-- 
Catalin
