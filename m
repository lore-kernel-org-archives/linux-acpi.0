From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 3/7] ACPI / APEI: add OSC APEI bit check for ghes_edac
Date: Fri, 4 Aug 2017 05:44:17 +0200
Message-ID: <20170804034417.GC12082@nazgul.tnic>
References: <20170803215753.30553-1-toshi.kani@hpe.com>
 <20170803215753.30553-4-toshi.kani@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:39542 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751968AbdHDDo7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 3 Aug 2017 23:44:59 -0400
Content-Disposition: inline
In-Reply-To: <20170803215753.30553-4-toshi.kani@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toshi Kani <toshi.kani@hpe.com>
Cc: rjw@rjwysocki.net, mchehab@kernel.org, tony.luck@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Aug 03, 2017 at 03:57:49PM -0600, Toshi Kani wrote:
> When 'osc_sb_apei_support_acked' is set, it indicates that
> the platform supports APEI, firmware-first mode, as ACPI _OSC
> capability bit 4, APEI Support, was set in query.  While _OSC
> is an optional method, platforms with APEI support should
> implement it to inform its capability to the OS properly.
> 
> Add check to 'osc_sb_apei_support_acked' before calling
> ghes_edac_register() to restrict that ghes_edac is enabled
> on platforms with APEI support capability set in _OSC.
> 
> Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Tony Luck <tony.luck@intel.com>
> ---
>  drivers/acpi/apei/ghes.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index d661d45..49d75eb 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1139,9 +1139,11 @@ static int ghes_probe(struct platform_device *ghes_dev)
>  		goto err;
>  	}
>  
> -	rc = ghes_edac_register(ghes, &ghes_dev->dev);
> -	if (rc < 0)
> -		goto err;
> +	if (osc_sb_apei_support_acked) {

What for when we have the whitelist?

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
