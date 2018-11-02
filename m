From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ACPI / PMIC: xpower: fix IOSF_MBI dependency
Date: Fri, 2 Nov 2018 12:09:34 +0100
Message-ID: <3c6ddd48-b419-52db-38d3-e0ebf9c46dfc@redhat.com>
References: <20181102110653.118257-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181102110653.118257-1-arnd@arndb.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,

On 02-11-18 12:06, Arnd Bergmann wrote:
> We still get a link failure with IOSF_MBI=m when the xpower driver
> is built-in:
> 
> drivers/acpi/pmic/intel_pmic_xpower.o: In function `intel_xpower_pmic_update_power':
> intel_pmic_xpower.c:(.text+0x4f2): undefined reference to `iosf_mbi_block_punit_i2c_access'
> intel_pmic_xpower.c:(.text+0x5e2): undefined reference to `iosf_mbi_unblock_punit_i2c_access'
> 
> This makes the dependency stronger, so we can only build when IOSF_MBI
> is built-in.
> 
> Fixes: 6a9b593d4b6f ("ACPI / PMIC: xpower: Add depends on IOSF_MBI to Kconfig entry")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Hmm, it is probably better to make IOSF_MBI a bool, it is selected by:
X86_INTEL_QUARK and X86_INTEL_LPSS which are both bools themselves.

Arguably it should also be hidden and only enabled through these selects.
Does someone from Intel have an opinion on making it hidden?

Regards,

Hans



> ---
>   drivers/acpi/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 18851e7eedd5..31a3c4a03f61 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -514,7 +514,7 @@ config CRC_PMIC_OPREGION
>   
>   config XPOWER_PMIC_OPREGION
>   	bool "ACPI operation region support for XPower AXP288 PMIC"
> -	depends on MFD_AXP20X_I2C && IOSF_MBI
> +	depends on MFD_AXP20X_I2C && IOSF_MBI=y
>   	help
>   	  This config adds ACPI operation region support for XPower AXP288 PMIC.
>   
> 
