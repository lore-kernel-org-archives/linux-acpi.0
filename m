From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH 3/3] drivers/acpi: make pmic/intel_pmic_crc.c explicitly
 non-modular
Date: Wed, 17 Feb 2016 02:27:04 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BB4BD8B@SHSMSX101.ccr.corp.intel.com>
References: <1455514071-26368-1-git-send-email-paul.gortmaker@windriver.com>
 <1455514071-26368-4-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455514071-26368-4-git-send-email-paul.gortmaker@windriver.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Gortmaker, Paul (Wind River)" <paul.gortmaker@windriver.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "Lu, Aaron" <aaron.lu@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Paul Gortmaker
> Subject: [PATCH 3/3] drivers/acpi: make pmic/intel_pmic_crc.c explicitly non-
> modular
> 
> The Kconfig currently controlling compilation of this code is:
> 
> drivers/acpi/Kconfig:config CRC_PMIC_OPREGION
> drivers/acpi/Kconfig:   bool "ACPI operation region support for CrystalCove
> PMIC"
> 
> ...meaning that it currently is not being built as a module by anyone.
> 
> Lets remove the couple modular references, so that when reading
> the driver there is no doubt it is builtin-only.
> 
> Since module_init translates to device_initcall in the non-modular
> case, the init ordering remains unchanged with this commit.
> 
> We also delete the MODULE_LICENSE tag etc. since all that information
> is already contained at the top of the file in the comments.
[Lv Zheng] 
Especially, this can pass module test if it is built along with a workaround to fix the ACPICA defects.
The workaround is not upstreamed because it is just a workaround, real fix should be done inside of ACPICA.

Thanks and best regards
-Lv

> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Aaron Lu <aaron.lu@intel.com>
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  drivers/acpi/pmic/intel_pmic_crc.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/pmic/intel_pmic_crc.c
> b/drivers/acpi/pmic/intel_pmic_crc.c
> index 42df46a86c25..fcd1852dcdee 100644
> --- a/drivers/acpi/pmic/intel_pmic_crc.c
> +++ b/drivers/acpi/pmic/intel_pmic_crc.c
> @@ -13,7 +13,7 @@
>   * GNU General Public License for more details.
>   */
> 
> -#include <linux/module.h>
> +#include <linux/init.h>
>  #include <linux/acpi.h>
>  #include <linux/mfd/intel_soc_pmic.h>
>  #include <linux/regmap.h>
> @@ -205,7 +205,4 @@ static int __init
> intel_crc_pmic_opregion_driver_init(void)
>  {
>  	return platform_driver_register(&intel_crc_pmic_opregion_driver);
>  }
> -module_init(intel_crc_pmic_opregion_driver_init);
> -
> -MODULE_DESCRIPTION("CrystalCove ACPI operation region driver");
> -MODULE_LICENSE("GPL");
> +device_initcall(intel_crc_pmic_opregion_driver_init);
> --
> 2.6.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
