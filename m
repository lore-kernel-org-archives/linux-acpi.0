From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi: Return -ENOENT in acpi_table_parse() and fix wrong comment.
Date: Mon, 06 Jan 2014 12:50:24 +0100
Message-ID: <2420572.xQX3sn8lDK@vostro.rjw.lan>
References: <1388998079-28160-1-git-send-email-tangchen@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1388998079-28160-1-git-send-email-tangchen@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tang Chen <tangchen@cn.fujitsu.com>
Cc: rjw@sisk.pl, lenb@kernel.org, toshi.kani@hp.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Monday, January 06, 2014 04:47:59 PM Tang Chen wrote:
> The comment about return value of acpi_table_parse() is incorrect.
> This patch fix it.
> 
> Since all callers only check if the function succeeded or not, this
> patch simplifies the semantics by returning -errno for all failure
> cases. This will also simply the comment.
> 
> As suggested by Toshi Kani <toshi.kani@hp.com>, also change the stub
> in linux/acpi.h to return -ENODEV.
> 
> Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>

Queued up for 3.14 (but please use the e-mail address from MAINTAINERS next
time) with a modified subject.  Thanks!

> ---
>  drivers/acpi/tables.c | 7 ++++---
>  include/linux/acpi.h  | 2 +-
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 5a5263b..10022ae 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -278,12 +278,13 @@ acpi_table_parse_madt(enum acpi_madt_type id,
>  
>  /**
>   * acpi_table_parse - find table with @id, run @handler on it
> - *
>   * @id: table id to find
>   * @handler: handler to run
>   *
>   * Scan the ACPI System Descriptor Table (STD) for a table matching @id,
> - * run @handler on it.  Return 0 if table found, return on if not.
> + * run @handler on it.
> + *
> + * Return 0 if table found, -errno if not.
>   */
>  int __init acpi_table_parse(char *id, acpi_tbl_table_handler handler)
>  {
> @@ -306,7 +307,7 @@ int __init acpi_table_parse(char *id, acpi_tbl_table_handler handler)
>  		early_acpi_os_unmap_memory(table, tbl_size);
>  		return 0;
>  	} else
> -		return 1;
> +		return -ENODEV;
>  }
>  
>  /* 
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index d9099b1..fecfbcd 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -460,7 +460,7 @@ struct acpi_table_header;
>  static inline int acpi_table_parse(char *id,
>  				int (*handler)(struct acpi_table_header *))
>  {
> -	return -1;
> +	return -ENODEV;
>  }
>  
>  static inline int acpi_nvs_register(__u64 start, __u64 size)
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
