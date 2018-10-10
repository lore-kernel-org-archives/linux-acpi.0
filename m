From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 16/23] ACPI: remove unused __acpi_handle_debug macro
Date: Wed, 10 Oct 2018 11:38:49 +0200
Message-ID: <CAJZ5v0jA8-5gpWR0spqLzBi-hQeXvt4u4Bie9BgOLWfhgErqBA@mail.gmail.com>
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
 <20181009112013.14238-1-linux@rasmusvillemoes.dk> <20181009112013.14238-17-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181009112013.14238-17-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: jbaron@akamai.com, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Oct 9, 2018 at 1:20 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> If CONFIG_DYNAMIC_DEBUG is not set, acpi_handle_debug directly invokes
> acpi_handle_printk (if DEBUG) or does a no-printk (if !DEBUG). So this
> macro is never used.
>
> Cc: linux-acpi@vger.kernel.org
> Acked-by: Jason Baron <jbaron@akamai.com>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  include/linux/acpi.h | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 21e03aa32aae..e12d5ef1a054 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -948,9 +948,6 @@ acpi_handle_printk(const char *level, void *handle, const char *fmt, ...) {}
>  #if defined(CONFIG_ACPI) && defined(CONFIG_DYNAMIC_DEBUG)
>  __printf(3, 4)
>  void __acpi_handle_debug(struct _ddebug *descriptor, acpi_handle handle, const char *fmt, ...);
> -#else
> -#define __acpi_handle_debug(descriptor, handle, fmt, ...)              \
> -       acpi_handle_printk(KERN_DEBUG, handle, fmt, ##__VA_ARGS__);
>  #endif
>
>  /*
> --
> 2.19.1.3.g1d92a00e68
>
