From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [Linaro-acpi] [RFC] ACPI: Add new function to get table entries
Date: Thu, 20 Mar 2014 16:25:45 +0800
Message-ID: <532AA609.8050400@linaro.org>
References: <1395270568-30021-1-git-send-email-ashwin.chaugule@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:63241 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753654AbaCTIZy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Mar 2014 04:25:54 -0400
Received: by mail-pa0-f49.google.com with SMTP id lj1so598673pab.36
        for <linux-acpi@vger.kernel.org>; Thu, 20 Mar 2014 01:25:53 -0700 (PDT)
In-Reply-To: <1395270568-30021-1-git-send-email-ashwin.chaugule@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: linaro-acpi@lists.linaro.org, linux-acpi@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org

Hi Ashwin,

On 2014-3-20 7:09, Ashwin Chaugule wrote:
> The acpi_table_parse() function has a callback that
> passes a pointer to a table_header. Add a new function
> which takes this pointer and parses its entries. This
> eliminates the need to re-traverse all the tables for
> each call. e.g. as in acpi_table_parse_madt() which is
> normally called after acpi_table_parse().
> 
> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> ---
>  drivers/acpi/tables.c | 69 +++++++++++++++++++++++++++++++++++----------------
>  include/linux/acpi.h  |  4 +++
>  2 files changed, 51 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 5837f85..b7bd6a3 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -199,19 +199,15 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
>  	}
>  }
>  
> -
>  int __init
> -acpi_table_parse_entries(char *id,
> -			     unsigned long table_size,
> -			     int entry_id,
> -			     acpi_tbl_entry_handler handler,
> -			     unsigned int max_entries)
> +acpi_parse_entries(unsigned long table_size,
> +		acpi_tbl_entry_handler handler,
> +		struct acpi_table_header *table_header,
> +		int entry_id, unsigned int max_entries)
>  {
> -	struct acpi_table_header *table_header = NULL;
>  	struct acpi_subtable_header *entry;
>  	unsigned int count = 0;
>  	unsigned long table_end;
> -	acpi_size tbl_size;
>  
>  	if (acpi_disabled)
>  		return -ENODEV;
> @@ -219,16 +215,14 @@ acpi_table_parse_entries(char *id,
>  	if (!handler)
>  		return -EINVAL;
>  
> -	if (strncmp(id, ACPI_SIG_MADT, 4) == 0)
> -		acpi_get_table_with_size(id, acpi_apic_instance, &table_header, &tbl_size);
> -	else
> -		acpi_get_table_with_size(id, 0, &table_header, &tbl_size);
> -
>  	if (!table_header) {
> -		printk(KERN_WARNING PREFIX "%4.4s not present\n", id);
> +		pr_warn(PREFIX "Table header not present\n");

Can you rebase this patch on the branch of linux-next of linux-pm tree?
PREFIX was removed by me and I used pr_fmt() instead.

Thanks
Hanjun
