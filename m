From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpica: modify a commit error in file drivers/acpi/acpica/nsxfeval.c
Date: Mon, 13 Apr 2015 15:37:59 +0200
Message-ID: <1536129.vQOiq1xQa9@vostro.rjw.lan>
References: <1428915907-14302-1-git-send-email-gongzhaogang@inspur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50412 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754099AbbDMNN3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Apr 2015 09:13:29 -0400
In-Reply-To: <1428915907-14302-1-git-send-email-gongzhaogang@inspur.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhaogang Gong <gongzhaogang@inspur.com>
Cc: robert.moore@intel.com, lv.zheng@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, yanxiaofeng@inspur.com

On Monday, April 13, 2015 05:05:07 PM Zhaogang Gong wrote:
> Change "iff" in function acpi_evaluate_object() to "if".
> 
> Signed-off-by: Zhaogang Gong <gongzhaogang@inspur.com>
> ---
>  drivers/acpi/acpica/nsxfeval.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpica/nsxfeval.c b/drivers/acpi/acpica/nsxfeval.c
> index b6030a2..9571429 100644
> --- a/drivers/acpi/acpica/nsxfeval.c
> +++ b/drivers/acpi/acpica/nsxfeval.c
> @@ -214,7 +214,7 @@ acpi_evaluate_object(acpi_handle handle,
>  		info->prefix_node = NULL;
>  	} else if (!handle) {
>  		/*
> -		 * A handle is optional iff a fully qualified pathname is specified.
> +		 * A handle is optional if a fully qualified pathname is specified.

This is not a mistake.

>  		 * Since we've already handled fully qualified names above, this is
>  		 * an error.
>  		 */
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
