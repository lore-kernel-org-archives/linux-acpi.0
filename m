From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi: The count field of counter_show() function should be an unsigned value
Date: Thu, 12 Mar 2015 23:41:35 +0100
Message-ID: <1699654.r9C5QRPvQq@vostro.rjw.lan>
References: <1425466115-26306-1-git-send-email-jlee@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64599 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751053AbbCLWRt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Mar 2015 18:17:49 -0400
In-Reply-To: <1425466115-26306-1-git-send-email-jlee@suse.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>, Len Brown <lenb@kernel.org>, Thomas Renninger <trenn@suse.de>, Nan Li <nli@suse.com>

On Wednesday, March 04, 2015 06:48:35 PM Lee, Chun-Yi wrote:
> From: Nan Li <nli@suse.com>
> 
> The count field is an unsigned 32bit value, and the
> counter_show() function should also treat it as a unsigned
> value.
> 
> Otherwise the counter may show negative number as we found on a
> machine:
> ...
> gpe23:        0   invalid
> gpe24: -2071733   enabled
> gpe25:        0   invalid
> ...
> gpe_all: -2070980
> sci: -2070949
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Thomas Renninger <trenn@suse.de>
> Signed-off-by: Nan Li <nli@suse.com>
> Signed-off-by: Lee, Chun-Yi <jlee@suse.com>

Queued up for 4.1, thanks!

> ---
>  drivers/acpi/sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> index 13e577c..0876d77 100644
> --- a/drivers/acpi/sysfs.c
> +++ b/drivers/acpi/sysfs.c
> @@ -527,7 +527,7 @@ static ssize_t counter_show(struct kobject *kobj,
>  	    acpi_irq_not_handled;
>  	all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_GPE].count =
>  	    acpi_gpe_count;
> -	size = sprintf(buf, "%8d", all_counters[index].count);
> +	size = sprintf(buf, "%8u", all_counters[index].count);
>  
>  	/* "gpe_all" or "sci" */
>  	if (index >= num_gpes + ACPI_NUM_FIXED_EVENTS)
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
