From: Cao jin <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH] acpi: drop useless function
Date: Tue, 11 Apr 2017 11:02:31 +0800
Message-ID: <58EC4747.8030804@cn.fujitsu.com>
References: <1491879441-32276-1-git-send-email-caoj.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:54115 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752176AbdDKCxB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Apr 2017 22:53:01 -0400
In-Reply-To: <1491879441-32276-1-git-send-email-caoj.fnst@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>

Re-CC RJW because wrong typing of the address

On 04/11/2017 10:57 AM, Cao jin wrote:
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> ---
>  drivers/acpi/tables.c | 15 ---------------
>  include/linux/acpi.h  |  4 ----
>  2 files changed, 19 deletions(-)
> 
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 2604189..7885339 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -310,21 +310,6 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
>  	return errs ? -EINVAL : count;
>  }
>  
> -int __init
> -acpi_parse_entries(char *id,
> -			unsigned long table_size,
> -			acpi_tbl_entry_handler handler,
> -			struct acpi_table_header *table_header,
> -			int entry_id, unsigned int max_entries)
> -{
> -	struct acpi_subtable_proc proc = {
> -		.id		= entry_id,
> -		.handler	= handler,
> -	};
> -
> -	return acpi_parse_entries_array(id, table_size, table_header,
> -			&proc, 1, max_entries);
> -}
>  
>  int __init
>  acpi_table_parse_entries_array(char *id,
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 9b05886..83abbfc 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -233,10 +233,6 @@ int acpi_numa_init (void);
>  
>  int acpi_table_init (void);
>  int acpi_table_parse(char *id, acpi_tbl_table_handler handler);
> -int __init acpi_parse_entries(char *id, unsigned long table_size,
> -			      acpi_tbl_entry_handler handler,
> -			      struct acpi_table_header *table_header,
> -			      int entry_id, unsigned int max_entries);
>  int __init acpi_table_parse_entries(char *id, unsigned long table_size,
>  			      int entry_id,
>  			      acpi_tbl_entry_handler handler,
> 

-- 
Sincerely,
Cao jin


