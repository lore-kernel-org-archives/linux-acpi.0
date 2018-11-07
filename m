From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI / PMIC: xpower: fix IOSF_MBI dependency
Date: Wed, 7 Nov 2018 13:22:35 +0100
Message-ID: <CAJZ5v0grpLSh=QAO3iwwrX0MPzJVxFenFo3j7V+JpeYEu63CjA@mail.gmail.com>
References: <20181102110653.118257-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181102110653.118257-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Nov 2, 2018 at 12:07 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
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
> ---
>  drivers/acpi/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 18851e7eedd5..31a3c4a03f61 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -514,7 +514,7 @@ config CRC_PMIC_OPREGION
>
>  config XPOWER_PMIC_OPREGION
>         bool "ACPI operation region support for XPower AXP288 PMIC"
> -       depends on MFD_AXP20X_I2C && IOSF_MBI
> +       depends on MFD_AXP20X_I2C && IOSF_MBI=y
>         help
>           This config adds ACPI operation region support for XPower AXP288 PMIC.
>
> --

At this point I'm inclined to apply the patch as is as a short-term
fix and improvements can be made on top of it.

Any objections?
