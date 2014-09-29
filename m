From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH 1/1 linux-next] ACPI / SBS: fix sparse warning
Date: Mon, 29 Sep 2014 11:10:04 +0530
Message-ID: <20140929054004.GA4144@sudip-PC>
References: <1411929887-2440-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:54598 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbaI2FkS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Sep 2014 01:40:18 -0400
Content-Disposition: inline
In-Reply-To: <1411929887-2440-1-git-send-email-fabf@skynet.be>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Sun, Sep 28, 2014 at 08:44:47PM +0200, Fabian Frederick wrote:
> Adding parentheses around expression to avoid:
> drivers/acpi/sbs.c:444:28: warning: dubious: !x & y
> 
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
> ---
>  drivers/acpi/sbs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
> index 32aecea..a7a3edd 100644
> --- a/drivers/acpi/sbs.c
> +++ b/drivers/acpi/sbs.c
> @@ -441,7 +441,7 @@ static int acpi_ac_get_present(struct acpi_sbs *sbs)
>  	 * The spec requires that bit 4 always be 1. If it's not set, assume
>  	 * that the implementation doesn't support an SBS charger
>  	 */
> -	if (!(status >> 4) & 0x1)
> +	if (!((status >> 4) & 0x1))

i think the logic changed over here.
it was !x & y , but now it has become !(x & y)
! is having higher priority than & so !x & y will mean ((!x) & y)

thanks
sudip
>  		return -ENODEV;
>  
>  	sbs->charger_present = (status >> 15) & 0x1;
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
