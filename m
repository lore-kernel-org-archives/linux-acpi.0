From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI: Remove unused flags in acpi_device_flags
Date: Wed, 12 Jun 2013 00:24:12 +0200
Message-ID: <1929531.s4Kmz37sNk@vostro.rjw.lan>
References: <1370382985-12163-1-git-send-email-toshi.kani@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1370382985-12163-1-git-send-email-toshi.kani@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Toshi Kani <toshi.kani@hp.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday, June 04, 2013 03:56:25 PM Toshi Kani wrote:
> suprise_removal_ok and performance_manageable in struct
> acpi_device_flags are not used by any code.  So, remove
> them.
> 
> Signed-off-by: Toshi Kani <toshi.kani@hp.com>

Queued up for 3.11.

Thanks,
Rafael


> ---
>  include/acpi/acpi_bus.h |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 1a681ee..9efc52f 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -156,12 +156,10 @@ struct acpi_device_flags {
>  	u32 dynamic_status:1;
>  	u32 removable:1;
>  	u32 ejectable:1;
> -	u32 suprise_removal_ok:1;
>  	u32 power_manageable:1;
> -	u32 performance_manageable:1;
>  	u32 eject_pending:1;
>  	u32 match_driver:1;
> -	u32 reserved:24;
> +	u32 reserved:26;
>  };
>  
>  /* File System */
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
