From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [patch] ACPI / tables: test the correct variable
Date: Fri, 25 Sep 2015 02:23:34 +0200
Message-ID: <5197324.W7Zx4mc8dA@vostro.rjw.lan>
References: <20150922122925.GA27407@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:44470 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751123AbbIXXzV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Sep 2015 19:55:21 -0400
In-Reply-To: <20150922122925.GA27407@mwanda>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Tuesday, September 22, 2015 03:29:25 PM Dan Carpenter wrote:
> The intent was to test "proc[i].handler" instead of "proc->handler".
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index c1ff58d..6c0f079 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -268,7 +268,8 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
>  		for (i = 0; i < proc_num; i++) {
>  			if (entry->type != proc[i].id)
>  				continue;
> -			if (!proc->handler || proc[i].handler(entry, table_end))
> +			if (!proc[i].handler ||
> +			     proc[i].handler(entry, table_end))
>  				return -EINVAL;
>  
>  			proc->count++;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Applied, thanks!

