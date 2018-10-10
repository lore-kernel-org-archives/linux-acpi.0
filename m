From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 15/23] ACPI: use proper DYNAMIC_DEBUG_BRANCH macro
Date: Wed, 10 Oct 2018 11:38:29 +0200
Message-ID: <CAJZ5v0jmdnbhzPGbcFarQx-AfpLn72-BqDGowg=p=hEkB+J08w@mail.gmail.com>
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
 <20181009112013.14238-1-linux@rasmusvillemoes.dk> <20181009112013.14238-16-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181009112013.14238-16-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: jbaron@akamai.com, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Oct 9, 2018 at 1:21 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> dynamic debug may be implemented via static keys, but ACPI is missing
> out on that runtime benefit since it open-codes one possible definition
> of DYNAMIC_DEBUG_BRANCH.
>
> Cc: linux-acpi@vger.kernel.org
> Acked-by: Jason Baron <jbaron@akamai.com>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  include/linux/acpi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index de8d3d3fa651..21e03aa32aae 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -982,7 +982,7 @@ void __acpi_handle_debug(struct _ddebug *descriptor, acpi_handle handle, const c
>  #define acpi_handle_debug(handle, fmt, ...)                            \
>  do {                                                                   \
>         DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);                 \
> -       if (unlikely(descriptor.flags & _DPRINTK_FLAGS_PRINT))          \
> +       if (DYNAMIC_DEBUG_BRANCH(descriptor))                           \
>                 __acpi_handle_debug(&descriptor, handle, pr_fmt(fmt),   \
>                                 ##__VA_ARGS__);                         \
>  } while (0)
> --
> 2.19.1.3.g1d92a00e68
>
