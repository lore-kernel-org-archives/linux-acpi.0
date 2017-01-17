From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] ACPI, APEI, EINJ: fix malformed newline escape
Date: Tue, 17 Jan 2017 16:44:30 +0100
Message-ID: <20170117154430.n3idzv6avjoxkbg3@pd.tnic>
References: <20170117145720.23998-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56039 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750855AbdAQPog (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 17 Jan 2017 10:44:36 -0500
Content-Disposition: inline
In-Reply-To: <20170117145720.23998-1-colin.king@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Dan Williams <dan.j.williams@intel.com>, Toshi Kani <toshi.kani@hpe.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jan 17, 2017 at 02:57:20PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The pr_warn message has a malformed newline escape, add in the
> missing \
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/acpi/apei/einj.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> index eebb7e3..ec50c32 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj.c
> @@ -711,7 +711,7 @@ static int __init einj_init(void)
>  
>  	rc = einj_check_table(einj_tab);
>  	if (rc) {
> -		pr_warn(FW_BUG "Invalid EINJ table.n");
> +		pr_warn(FW_BUG "Invalid EINJ table.\n");
>  		return -EINVAL;
>  	}
>  
> -- 

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
