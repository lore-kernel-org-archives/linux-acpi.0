From: Robert Richter <robert.richter@caviumnetworks.com>
Subject: Re: [PATCH v3 06/12] acpi, numa: Enable ACPI based NUMA on ARM64
Date: Fri, 29 Jan 2016 17:37:36 +0100
Message-ID: <20160129163736.GZ4914@rric.localdomain>
References: <1453541967-3744-1-git-send-email-guohanjun@huawei.com>
 <1453541967-3744-7-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453541967-3744-7-git-send-email-guohanjun@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Shannon Zhao <shannon.zhao@linaro.org>, Steve Capper <steve.capper@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>
List-Id: linux-acpi@vger.kernel.org

On 23.01.16 17:39:21, Hanjun Guo wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
> 
> Add function needed for cpu to node mapping, and enable
> ACPI based NUMA for ARM64 in Kconfig
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  drivers/acpi/Kconfig |  2 +-
>  drivers/acpi/numa.c  | 35 +++++++++++++++++++++++++++++++++++
>  include/linux/acpi.h | 17 ++++++++++++++++-
>  3 files changed, 52 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index d6d5749..31875ab 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -283,7 +283,7 @@ config ACPI_THERMAL
>  config ACPI_NUMA
>  	bool "NUMA support"
>  	depends on NUMA
> -	depends on (X86 || IA64)
> +	depends on (X86 || IA64 || ARM64)
>  	default y if IA64_GENERIC || IA64_SGI_SN2

This should be default enabled here for arm64 to have it enabled with
NUMA.

-Robert
