From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / DPTF: remove header search path to the parent directory
Date: Thu, 31 Jan 2019 00:56:49 +0100
Message-ID: <4055377.EWIQaDhOEO@aspire.rjw.lan>
References: <1548332163-17869-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548332163-17869-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thursday, January 24, 2019 1:16:03 PM CET Masahiro Yamada wrote:
> It is too much to add extra header search path for all files in
> drivers/acpi/dptf/.
> 
> Fix up one C file, and remove the header search path.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> My main motivation is to get rid of crappy header search path manipulation
> from Kbuild core.
> 
> Before that, I want to clean up as many useless paths as possible.
> 
> The full work of this is available at:
> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git build-test
> 
> 
>  drivers/acpi/dptf/Makefile          | 2 --
>  drivers/acpi/dptf/int340x_thermal.c | 2 +-
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/dptf/Makefile b/drivers/acpi/dptf/Makefile
> index 06ea880..e6032e4 100644
> --- a/drivers/acpi/dptf/Makefile
> +++ b/drivers/acpi/dptf/Makefile
> @@ -1,4 +1,2 @@
>  obj-$(CONFIG_ACPI)             += int340x_thermal.o
>  obj-$(CONFIG_DPTF_POWER)	+= dptf_power.o
> -
> -ccflags-y += -Idrivers/acpi
> diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/int340x_thermal.c
> index 8636409..0aa7c2e 100644
> --- a/drivers/acpi/dptf/int340x_thermal.c
> +++ b/drivers/acpi/dptf/int340x_thermal.c
> @@ -12,7 +12,7 @@
>  #include <linux/acpi.h>
>  #include <linux/module.h>
>  
> -#include "internal.h"
> +#include "../internal.h"
>  
>  #define INT3401_DEVICE 0X01
>  static const struct acpi_device_id int340x_thermal_device_ids[] = {
> 

Applied, thanks!
