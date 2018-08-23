From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI: fix menuconfig presentation of ACPI submenu
Date: Thu, 23 Aug 2018 10:23:17 +0200
Message-ID: <CAJZ5v0gaWhTZFL+MP1D9tGsPAe0R6cqH1RiEjQ37mXE4P7g5Ng@mail.gmail.com>
References: <20180821203750.2394352-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180821203750.2394352-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Aug 21, 2018 at 10:38 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> My fix for a recursive Kconfig dependency caused another issue where the
> ACPI specific options end up in the top-level menu in 'menuconfig'. This
> was an unintended side-effect of having a silent option between
> 'menuconfig ACPI' and 'if ACPI'.
>
> Moving the ARCH_SUPPORTS_ACPI symbol ahead of the ACPI menu solves that
> problem and restores the previous presentation.
>
> Reported-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Fixes: 2c870e61132c ("arm64: fix ACPI dependencies")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks!

I'll push this to Linus tomorrow.

> ---
>  drivers/acpi/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 1edca05ee0ae..e92eab1e960c 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -3,6 +3,9 @@
>  # ACPI Configuration
>  #
>
> +config ARCH_SUPPORTS_ACPI
> +       bool
> +
>  menuconfig ACPI
>         bool "ACPI (Advanced Configuration and Power Interface) Support"
>         depends on ARCH_SUPPORTS_ACPI
> @@ -40,9 +43,6 @@ menuconfig ACPI
>           <http://www.acpi.info>
>           <http://www.uefi.org/acpi/specs>
>
> -config ARCH_SUPPORTS_ACPI
> -       bool
> -
>  if ACPI
>
>  config ACPI_LEGACY_TABLES_LOOKUP
> --
> 2.18.0
>
