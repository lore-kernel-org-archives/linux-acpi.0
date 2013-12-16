From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3] ACPI, APEI: Cleanup alignment related codes for APEI
Date: Mon, 16 Dec 2013 15:19:06 +0100
Message-ID: <20131216141906.GC4922@pd.tnic>
References: <20131114122956.GE13376@pd.tnic>
 <1384494356-4034-1-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:58657 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753685Ab3LPOTI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 16 Dec 2013 09:19:08 -0500
Content-Disposition: inline
In-Reply-To: <1384494356-4034-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, linux-acpi@vger.kernel.org

On Fri, Nov 15, 2013 at 12:45:56AM -0500, Chen, Gong wrote:
> diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
> index 26311f2..bf30a12 100644
> --- a/drivers/acpi/apei/erst.c
> +++ b/drivers/acpi/apei/erst.c
> @@ -611,7 +611,7 @@ static void __erst_record_id_cache_compact(void)
>  		if (entries[i] == APEI_ERST_INVALID_RECORD_ID)
>  			continue;
>  		if (wpos != i)
> -			memcpy(&entries[wpos], &entries[i], sizeof(entries[i]));
> +			entries[wpos] = entries[i];

Why is it ok to drop the memcpy here and do a normal access?

__erst_record_id_cache_add_one still has a memcpy-like access.

What is the difference with all those accesses to erst_record_id_cache
and why doesn't it need the unaligned helpers?

This all needs to be explained in detail in the commit message.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
