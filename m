From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Acpi: acpica: acmacros: fixed a semicolon formatting issue.
Date: Thu, 20 Jun 2013 02:07:22 +0200
Message-ID: <4489535.I8R2Jux4pG@vostro.rjw.lan>
References: <1371611860-21056-1-git-send-email-sageofredondo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:43476 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934375Ab3FSX6B (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Jun 2013 19:58:01 -0400
In-Reply-To: <1371611860-21056-1-git-send-email-sageofredondo@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "John B. Wyatt IV" <sageofredondo@gmail.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>, Bob Moore <robert.moore@intel.com>

On Tuesday, June 18, 2013 08:17:40 PM John B. Wyatt IV wrote:
> From: "John B. Wyatt IV" <sageofredondo@gmail.com>
> 
> Formatting patch: fixes all "space required after that ';'" errors in
> acmarcos.h.

That code comes from the ACPICA project and doesn't follow the usual Linux
kernel coding style.

> Please note this only fixes 12 out of 64 errors as reported by
> ./scripts/checkpatch.pl

Please do not run this on files under drivers/acpi/acpica/.

Thanks,
Rafael


> ---
>  drivers/acpi/acpica/acmacros.h | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/acmacros.h b/drivers/acpi/acpica/acmacros.h
> index 53666bd..b916eed 100644
> --- a/drivers/acpi/acpica/acmacros.h
> +++ b/drivers/acpi/acpica/acmacros.h
> @@ -93,15 +93,15 @@
>  /* 16-bit source, 16/32/64 destination */
>  
>  #define ACPI_MOVE_16_TO_16(d, s)        {((  u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[1];\
> -			  ((  u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[0];}
> +			  ((  u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[0]; }
>  
>  #define ACPI_MOVE_16_TO_32(d, s)        {(*(u32 *)(void *)(d))=0;\
>  					  ((u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[1];\
> -					  ((u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[0];}
> +					  ((u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[0]; }
>  
>  #define ACPI_MOVE_16_TO_64(d, s)        {(*(u64 *)(void *)(d))=0;\
>  							   ((u8 *)(void *)(d))[6] = ((u8 *)(void *)(s))[1];\
> -							   ((u8 *)(void *)(d))[7] = ((u8 *)(void *)(s))[0];}
> +							   ((u8 *)(void *)(d))[7] = ((u8 *)(void *)(s))[0]; }
>  
>  /* 32-bit source, 16/32/64 destination */
>  
> @@ -110,13 +110,13 @@
>  #define ACPI_MOVE_32_TO_32(d, s)        {((  u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[3];\
>  									  ((  u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[2];\
>  									  ((  u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[1];\
> -									  ((  u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[0];}
> +									  ((  u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[0]; }
>  
>  #define ACPI_MOVE_32_TO_64(d, s)        {(*(u64 *)(void *)(d))=0;\
>  										   ((u8 *)(void *)(d))[4] = ((u8 *)(void *)(s))[3];\
>  										   ((u8 *)(void *)(d))[5] = ((u8 *)(void *)(s))[2];\
>  										   ((u8 *)(void *)(d))[6] = ((u8 *)(void *)(s))[1];\
> -										   ((u8 *)(void *)(d))[7] = ((u8 *)(void *)(s))[0];}
> +										   ((u8 *)(void *)(d))[7] = ((u8 *)(void *)(s))[0]; }
>  
>  /* 64-bit source, 16/32/64 destination */
>  
> @@ -131,7 +131,7 @@
>  										 ((  u8 *)(void *)(d))[4] = ((u8 *)(void *)(s))[3];\
>  										 ((  u8 *)(void *)(d))[5] = ((u8 *)(void *)(s))[2];\
>  										 ((  u8 *)(void *)(d))[6] = ((u8 *)(void *)(s))[1];\
> -										 ((  u8 *)(void *)(d))[7] = ((u8 *)(void *)(s))[0];}
> +										 ((  u8 *)(void *)(d))[7] = ((u8 *)(void *)(s))[0]; }
>  #else
>  /*
>   * Macros for little-endian machines
> @@ -169,10 +169,10 @@
>  /* 16-bit source, 16/32/64 destination */
>  
>  #define ACPI_MOVE_16_TO_16(d, s)        {((  u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[0];\
> -										 ((  u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[1];}
> +										 ((  u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[1]; }
>  
> -#define ACPI_MOVE_16_TO_32(d, s)        {(*(u32 *)(void *)(d)) = 0; ACPI_MOVE_16_TO_16(d, s);}
> -#define ACPI_MOVE_16_TO_64(d, s)        {(*(u64 *)(void *)(d)) = 0; ACPI_MOVE_16_TO_16(d, s);}
> +#define ACPI_MOVE_16_TO_32(d, s)        {(*(u32 *)(void *)(d)) = 0; ACPI_MOVE_16_TO_16(d, s); }
> +#define ACPI_MOVE_16_TO_64(d, s)        {(*(u64 *)(void *)(d)) = 0; ACPI_MOVE_16_TO_16(d, s); }
>  
>  /* 32-bit source, 16/32/64 destination */
>  
> @@ -181,9 +181,9 @@
>  #define ACPI_MOVE_32_TO_32(d, s)        {((  u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[0];\
>  										 ((  u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[1];\
>  										 ((  u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[2];\
> -										 ((  u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[3];}
> +										 ((  u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[3]; }
>  
> -#define ACPI_MOVE_32_TO_64(d, s)        {(*(u64 *)(void *)(d)) = 0; ACPI_MOVE_32_TO_32(d, s);}
> +#define ACPI_MOVE_32_TO_64(d, s)        {(*(u64 *)(void *)(d)) = 0; ACPI_MOVE_32_TO_32(d, s); }
>  
>  /* 64-bit source, 16/32/64 destination */
>  
> @@ -196,7 +196,7 @@
>  										 ((  u8 *)(void *)(d))[4] = ((u8 *)(void *)(s))[4];\
>  										 ((  u8 *)(void *)(d))[5] = ((u8 *)(void *)(s))[5];\
>  										 ((  u8 *)(void *)(d))[6] = ((u8 *)(void *)(s))[6];\
> -										 ((  u8 *)(void *)(d))[7] = ((u8 *)(void *)(s))[7];}
> +										 ((  u8 *)(void *)(d))[7] = ((u8 *)(void *)(s))[7]; }
>  #endif
>  #endif
>  
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
