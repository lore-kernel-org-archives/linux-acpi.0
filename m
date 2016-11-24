From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi: remove redundant declare of acpi_table_parse_entries
Date: Thu, 24 Nov 2016 02:25:44 +0100
Message-ID: <4943562.KYlxKxvOdC@vostro.rjw.lan>
References: <1478659883-371928-1-git-send-email-longpeng2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:47521 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935908AbcKXBYi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 23 Nov 2016 20:24:38 -0500
In-Reply-To: <1478659883-371928-1-git-send-email-longpeng2@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, zhaoshenglong@huawei.com, wu.wubin@huawei.com

On Wednesday, November 09, 2016 10:51:23 AM Longpeng wrote:
> This function declared twice, so remove one.
> 
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
>  include/linux/acpi.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 689a8b9..017849e 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -220,10 +220,6 @@ int __init acpi_table_parse_entries(char *id, unsigned long table_size,
>  			      int entry_id,
>  			      acpi_tbl_entry_handler handler,
>  			      unsigned int max_entries);
> -int __init acpi_table_parse_entries(char *id, unsigned long table_size,
> -			      int entry_id,
> -			      acpi_tbl_entry_handler handler,
> -			      unsigned int max_entries);
>  int __init acpi_table_parse_entries_array(char *id, unsigned long table_size,
>  			      struct acpi_subtable_proc *proc, int proc_num,
>  			      unsigned int max_entries);
> 

Applied.

Thanks,
Rafael

