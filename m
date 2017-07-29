From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] acpi: apei: clear error status before acknowledging the
 error
Date: Sat, 29 Jul 2017 08:53:45 +0200
Message-ID: <20170729065345.GA30608@nazgul.tnic>
References: <1501280703-21471-1-git-send-email-tbaicar@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58322 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750912AbdG2GyY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 29 Jul 2017 02:54:24 -0400
Content-Disposition: inline
In-Reply-To: <1501280703-21471-1-git-send-email-tbaicar@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tyler Baicar <tbaicar@codeaurora.org>
Cc: rjw@rjwysocki.net, lenb@kernel.org, will.deacon@arm.com, james.morse@arm.com, shiju.jose@huawei.com, geliangtang@gmail.com, andriy.shevchenko@linux.intel.com, tony.luck@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jul 28, 2017 at 04:25:03PM -0600, Tyler Baicar wrote:
> Currently we acknowledge errors before clearing the error status.
> This could cause a new error to be populated by firmware in-between
> the error acknowledgment and the error status clearing which would
> cause the second error's status to be cleared without being handled.
> So, clear the error status before acknowledging the errors.
> 
> Also, make sure to acknowledge the error if the error status read
> fails.
> 
> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
> ---
>  drivers/acpi/apei/ghes.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index d661d45..6a6895a 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -743,17 +743,15 @@ static int ghes_proc(struct ghes *ghes)
>  	}
>  	ghes_do_proc(ghes, ghes->estatus);
>  
> +out:

If the first ghes_read_estatus() fails and we jump straight to that
label...

> +	ghes_clear_estatus(ghes);
>  	/*
>  	 * GHESv2 type HEST entries introduce support for error acknowledgment,
>  	 * so only acknowledge the error if this support is present.
>  	 */
>  	if (is_hest_type_generic_v2(ghes)) {
>  		rc = ghes_ack_error(ghes->generic_v2);

... and ACK the error anyway, even the status read failed, wouldn't that
confuse the firmware?

> -		if (rc)
> -			return rc;
>  	}

No need for the curly brackets anymore.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
