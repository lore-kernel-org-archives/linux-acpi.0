From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi: Check if @id is NULL in acpi_table_parse()
Date: Mon, 06 Jan 2014 12:49:11 +0100
Message-ID: <1613518.D6bOWsShm6@vostro.rjw.lan>
References: <1388997834-28028-1-git-send-email-tangchen@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1388997834-28028-1-git-send-email-tangchen@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tang Chen <tangchen@cn.fujitsu.com>
Cc: rjw@sisk.pl, lenb@kernel.org, toshi.kani@hp.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Monday, January 06, 2014 04:43:54 PM Tang Chen wrote:
> strncmp() does not check if the params are NULL. In acpi_table_parse(),
> if @id is NULL, the kernel will panic.
> 
> Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
> Acked-by: Toshi Kani <toshi.kani@hp.com>

Queued up for 3.14 (but please use the e-mail address from MAINTAINERS next
time).  Thanks!

> ---
>  drivers/acpi/tables.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index d67a1fe..5a5263b 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -293,7 +293,7 @@ int __init acpi_table_parse(char *id, acpi_tbl_table_handler handler)
>  	if (acpi_disabled)
>  		return -ENODEV;
>  
> -	if (!handler)
> +	if (!id || !handler)
>  		return -EINVAL;
>  
>  	if (strncmp(id, ACPI_SIG_MADT, 4) == 0)
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
