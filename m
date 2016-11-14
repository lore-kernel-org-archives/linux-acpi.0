From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] acpi: Use NULL from <linux/stddef.h>
Date: Mon, 14 Nov 2016 21:20:32 +0100
Message-ID: <CAJZ5v0jof4-JV+Fm_bBa+Fzxe2dLZ5KfoPNhZ_KfxvWX_NHDdg@mail.gmail.com>
References: <4f698429-49cf-689a-9eb5-978b182bb4bb@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33374 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936435AbcKNUUd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Nov 2016 15:20:33 -0500
Received: by mail-qt0-f195.google.com with SMTP id n6so6520538qtd.0
        for <linux-acpi@vger.kernel.org>; Mon, 14 Nov 2016 12:20:33 -0800 (PST)
In-Reply-To: <4f698429-49cf-689a-9eb5-978b182bb4bb@sandisk.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bart Van Assche <bart.vanassche@sandisk.com>, Lv <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, Nov 14, 2016 at 5:50 PM, Bart Van Assche
<bart.vanassche@sandisk.com> wrote:
> Use the definition of NULL from <linux/stddef.h> instead of
> redefining NULL. Additionally, change (void *)NULL into NULL.
>
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> ---
>  include/acpi/actypes.h | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
> index 1d798ab..f019641 100644
> --- a/include/acpi/actypes.h
> +++ b/include/acpi/actypes.h
> @@ -44,6 +44,8 @@
>  #ifndef __ACTYPES_H__
>  #define __ACTYPES_H__
>
> +#include <linux/stddef.h> /* NULL */

This is file is based on upstream ACPICA code and it should not
contain Linux-specific includes etc. as a rule.

> +
>  /* acpisrc:struct_defs -- for acpisrc conversion */
>
>  /*
> @@ -437,10 +439,6 @@ typedef u64 acpi_physical_address;
>  #endif
>  #define TRUE                            (1 == 1)
>
> -#ifndef NULL
> -#define NULL                            (void *) 0
> -#endif
> -
>  /*
>   * Miscellaneous types
>   */
> @@ -530,9 +528,9 @@ typedef u64 acpi_integer;
>
>  /* Pointer/Integer type conversions */
>
> -#define ACPI_TO_POINTER(i)              ACPI_ADD_PTR (void, (void *) NULL,(acpi_size) i)
> -#define ACPI_TO_INTEGER(p)              ACPI_PTR_DIFF (p, (void *) NULL)
> -#define ACPI_OFFSET(d, f)               ACPI_PTR_DIFF (&(((d *) 0)->f), (void *) NULL)
> +#define ACPI_TO_POINTER(i)              ACPI_ADD_PTR(void, NULL, (acpi_size) i)
> +#define ACPI_TO_INTEGER(p)              ACPI_PTR_DIFF(p, NULL)
> +#define ACPI_OFFSET(d, f)               ACPI_PTR_DIFF(&(((d *) 0)->f), NULL)
>  #define ACPI_PHYSADDR_TO_PTR(i)         ACPI_TO_POINTER(i)
>  #define ACPI_PTR_TO_PHYSADDR(i)         ACPI_TO_INTEGER(i)


Lv, Bob, can you have a look at this, please?

Thanks,
Rafael
