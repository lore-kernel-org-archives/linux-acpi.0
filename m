From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [for next][PATCH 1/2] mfd: Fix unmet dependency warning for MFD_TPS68470
Date: Thu, 24 Jan 2019 11:51:43 +0100
Message-ID: <2222147.2pZxjFhHIY@aspire.rjw.lan>
References: <20190121231958.28255-1-okaya@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190121231958.28255-1-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <okaya@kernel.org>
Cc: linux-next@vger.kernel.org, linux-acpi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday, January 22, 2019 12:19:57 AM CET Sinan Kaya wrote:
> After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
> CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
> satisfied implicitly through dependencies on CONFIG_ACPI have to be
> specified directly.
> 
> WARNING: unmet direct dependencies detected for I2C_DESIGNWARE_PLATFORM
>   Depends on [n]: I2C [=y] && HAS_IOMEM [=y] && (ACPI [=y] && COMMON_CLK [=n] || !ACPI [=y])
>   Selected by [y]:
>   - MFD_TPS68470 [=y] && HAS_IOMEM [=y] && ACPI [=y] && I2C [=y]=y
> 
> MFD_TPS68470 is an ACPI only device and selects I2C_DESIGNWARE_PLATFORM.
> I2C_DESIGNWARE_PLATFORM does not have any configuration today for ACPI
> support without CONFIG_PCI set.
> 
> For sake of a quick fix this introduces a new mandatory dependency to the
> driver which may survive without it. Otherwise we need to revisit the
> driver architecture to address this properly.
> 
> Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/mfd/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index f461460a2aeb..76f9909cf396 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1419,7 +1419,7 @@ config MFD_TPS65217
>  
>  config MFD_TPS68470
>  	bool "TI TPS68470 Power Management / LED chips"
> -	depends on ACPI && I2C=y
> +	depends on ACPI && PCI && I2C=y
>  	select MFD_CORE
>  	select REGMAP_I2C
>  	select I2C_DESIGNWARE_PLATFORM
> 

Is anyone taking this or should I?
