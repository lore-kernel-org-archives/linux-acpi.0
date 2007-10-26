From: Matej Laitl <strohel@gmail.com>
Subject: Re: ACPI: use select POWER_SUPPLY for AC, BATTERY and SBS (was: [2.624-rc1 regression] lost battery information)
Date: Fri, 26 Oct 2007 23:05:14 +0200
Message-ID: <200710262305.15495.strohel@gmail.com>
References: <200710262024.06012.arvidjaar@mail.ru> <47221C67.9050502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764468AbXJZVFe@vger.kernel.org>
In-Reply-To: <47221C67.9050502@gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Alexey Starikovskiy wrote:
> ACPI: use select POWER_SUPPLY for AC, BATTERY and SBS
>
> From: Alexey Starikovskiy <astarikovskiy@suse.de>
>
> POWER_SUPPLY is needed for AC, battery, and SBS sysfs support.
> Use 'select' instead of 'depends on', as it is will not be selected
> by anything else, leading to confusion.
>
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> ---
>
>  drivers/acpi/Kconfig |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 5d0e26a..ecd87d7 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -88,7 +88,8 @@ config ACPI_PROC_EVENT
>
>  config ACPI_AC
>         tristate "AC Adapter"
> -       depends on X86 && POWER_SUPPLY
> +       depends on X86
> +       select POWER_SUPPLY
>         default y
>         help
>           This driver adds support for the AC Adapter object, which
> indicates @@ -97,7 +98,8 @@ config ACPI_AC
>
>  config ACPI_BATTERY
>         tristate "Battery"
> -       depends on X86 && POWER_SUPPLY
> +       depends on X86
> +       select POWER_SUPPLY
>         default y
>         help
>           This driver adds support for battery information through
> @@ -352,7 +354,7 @@ config ACPI_HOTPLUG_MEMORY
>  config ACPI_SBS
>         tristate "Smart Battery System"
>         depends on X86
> -       depends on POWER_SUPPLY
> +       select POWER_SUPPLY
>         help
>           This driver adds support for the Smart Battery System, another
>           type of access to battery information, found on some laptops.

I'd love if this got merged, as I also lost my battery information by 
not-enabling POWER_SUPPLY (which looks like something unrelated to ACPI). (I 
know "select" is evil, but this use-case is appropriate, IMO)

Matej
