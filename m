From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 5/5] ACPI: Add configuration item to configure ACPICA
 error logs out
Date: Wed, 6 Jul 2016 01:43:06 +0200
Message-ID: <CAJZ5v0gS+hdnuLfGNzf-TJDvvtboaN3yD3QnxU-SMt_Zbm=gAA@mail.gmail.com>
References: <cover.1467717304.git.lv.zheng@intel.com> <cf654fead3c862ed1d9991a78d08d33f63f474aa.1467717305.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34512 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828AbcGEXnI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Jul 2016 19:43:08 -0400
In-Reply-To: <cf654fead3c862ed1d9991a78d08d33f63f474aa.1467717305.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Tue, Jul 5, 2016 at 1:18 PM, Lv Zheng <lv.zheng@intel.com> wrote:
> Sometimes, we need to disable ACPICA error logs to leave only ACPICA
> debug logs enabled for debugging purpose. This is useful when ACPICA error
> logs become a flood.
>
> Reference: https://bugzilla.kernel.org/show_bug.cgi?id=114201
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>

I seem to remember seeing this change once before and ISTR I said I
wouldn't apply it then.

Why would I say something different this time?

> ---
>  drivers/acpi/Kconfig            |    7 +++++++
>  include/acpi/platform/aclinux.h |    4 ++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 04af18f..939d235 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -324,6 +324,13 @@ config ACPI_TABLE_UPGRADE
>           initrd, therefore it's safe to say Y.
>           See Documentation/acpi/initrd_table_override.txt for details
>
> +config ACPI_NO_ERROR_MESSAGES
> +       bool "Disable error messages"
> +       default n
> +       help
> +         The ACPI subsystem can produce error messages. Saying Y disables
> +         this output.
> +
>  config ACPI_DEBUG
>         bool "Debug Statements"
>         default n
> diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
> index 93b61b1..ed27b52 100644
> --- a/include/acpi/platform/aclinux.h
> +++ b/include/acpi/platform/aclinux.h
> @@ -77,6 +77,10 @@
>  #define ACPI_MUTEX_DEBUG
>  #endif
>
> +#ifdef CONFIG_ACPI_NO_ERROR_MESSAGES
> +#define ACPI_NO_ERROR_MESSAGES
> +#endif
> +
>  #include <linux/string.h>
>  #include <linux/kernel.h>
>  #include <linux/ctype.h>
> --
