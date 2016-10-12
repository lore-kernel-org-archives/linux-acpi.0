From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH] ACPI: fix the process flow for 0 which return from
 acpi_register_gsi
Date: Wed, 12 Oct 2016 10:05:53 +0800
Message-ID: <57FD9A81.5020701@huawei.com>
References: <1476235256-10744-1-git-send-email-majun258@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:65492 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754283AbcJLCHP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Oct 2016 22:07:15 -0400
In-Reply-To: <1476235256-10744-1-git-send-email-majun258@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: MaJun <majun258@huawei.com>, linux-kernel@vger.kernel.org, marc.zyngier@arm.com, linux-acpi@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org
Cc: dingtianhong@huawei.com

On 2016/10/12 9:20, MaJun wrote:
> The return value 0 from acpi_register_gsi() means irq mapping failed.
> So, we should process this case in else branch.
>
> Signed-off-by: MaJun <majun258@huawei.com>
> ---
>  drivers/acpi/resource.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 56241eb..9918326 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -416,7 +416,7 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
>  
>  	res->flags = acpi_dev_irq_flags(triggering, polarity, shareable);
>  	irq = acpi_register_gsi(NULL, gsi, triggering, polarity);
> -	if (irq >= 0) {
> +	if (irq > 0) {

On x86 or IA64, irq 0 is a valid irq number as far as I know.

Thanks
Hanjun

