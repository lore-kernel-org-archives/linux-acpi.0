From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH 5/6] acpi: Check if @id is NULL in acpi_table_parse()
Date: Mon, 19 Aug 2013 13:29:03 -0600
Message-ID: <1376940543.10300.473.camel@misato.fc.hp.com>
References: <1376636809-10159-1-git-send-email-tangchen@cn.fujitsu.com>
	 <1376636809-10159-6-git-send-email-tangchen@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:2930 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080Ab3HSTaZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Aug 2013 15:30:25 -0400
In-Reply-To: <1376636809-10159-6-git-send-email-tangchen@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tang Chen <tangchen@cn.fujitsu.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, lenb@kernel.org, rjw@sisk.pl, liwanp@linux.vnet.ibm.com, tj@kernel.org, akpm@linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Fri, 2013-08-16 at 15:06 +0800, Tang Chen wrote:
> strncmp() does not check if the params are NULL. In acpi_table_parse(),
> if @id is NULL, the kernel will panic.
> 
> Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>

Acked-by: Toshi Kani <toshi.kani@hp.com>

-Toshi


> ---
>  drivers/acpi/tables.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
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


