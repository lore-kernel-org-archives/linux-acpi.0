From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH V2] acpi: apei: clear error status before acknowledging
 the error
Date: Thu, 24 Aug 2017 10:14:08 +0200
Message-ID: <20170824081408.iwg7qyyr226btivo@pd.tnic>
References: <1501798351-10337-1-git-send-email-tbaicar@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1501798351-10337-1-git-send-email-tbaicar@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tyler Baicar <tbaicar@codeaurora.org>
Cc: rjw@rjwysocki.net, lenb@kernel.org, will.deacon@arm.com, james.morse@arm.com, shiju.jose@huawei.com, geliangtang@gmail.com, andriy.shevchenko@linux.intel.com, tony.luck@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, austinwc@codeaurora.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Aug 03, 2017 at 04:12:31PM -0600, Tyler Baicar wrote:
> Currently we acknowledge errors before clearing the error status.
> This could cause a new error to be populated by firmware in-between
> the error acknowledgment and the error status clearing which would
> cause the second error's status to be cleared without being handled.
> So, clear the error status before acknowledging the errors.
> 
> Also, make sure to acknowledge the error if the error status read
> fails.
> 
> V2: Only send error ack if there was an error populated
>     Remove curly braces that are no longer needed
> 
> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
> ---
>  drivers/acpi/apei/ghes.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index d661d45..cda4a4f 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -743,17 +743,14 @@ static int ghes_proc(struct ghes *ghes)
>  	}
>  	ghes_do_proc(ghes, ghes->estatus);
>  
> +out:
> +	ghes_clear_estatus(ghes);
>  	/*
>  	 * GHESv2 type HEST entries introduce support for error acknowledgment,
>  	 * so only acknowledge the error if this support is present.
>  	 */
> -	if (is_hest_type_generic_v2(ghes)) {
> +	if (is_hest_type_generic_v2(ghes) && rc != -ENOENT)

I think you should do something like this:

out:
        ghes_clear_estatus(ghes);

	if (rc == -ENOENT)
                return rc;

	/*
         * GHESv2 type HEST entries introduce support for error acknowledgment,
         * so only acknowledge the error if this support is present.
         */
        if (is_hest_type_generic_v2(ghes))
                return ghes_ack_error(ghes->generic_v2);

        return rc;


First check the -ENOENT because if there's no entry, you don't need to
ACK anything anyway.

And then only if it is an entry present and it is v2, you can ACK it.

Hmmm?

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
