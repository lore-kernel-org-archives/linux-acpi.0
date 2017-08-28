From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH V3] acpi: apei: clear error status before acknowledging
 the error
Date: Mon, 28 Aug 2017 20:01:00 +0300
Message-ID: <1503939660.25945.127.camel@linux.intel.com>
References: <1503939221-27732-1-git-send-email-tbaicar@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:1728 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750866AbdH1RHH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 28 Aug 2017 13:07:07 -0400
In-Reply-To: <1503939221-27732-1-git-send-email-tbaicar@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tyler Baicar <tbaicar@codeaurora.org>, rjw@rjwysocki.net, lenb@kernel.org, will.deacon@arm.com, james.morse@arm.com, bp@suse.de, shiju.jose@huawei.com, geliangtang@gmail.com, tony.luck@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 2017-08-28 at 10:53 -0600, Tyler Baicar wrote:
> Currently we acknowledge errors before clearing the error status.
> This could cause a new error to be populated by firmware in-between
> the error acknowledgment and the error status clearing which would
> cause the second error's status to be cleared without being handled.
> So, clear the error status before acknowledging the errors.
> 
> Also, make sure to acknowledge the error if the error status read
> fails.
> 


> +out:
> +	ghes_clear_estatus(ghes);
> +

> +	if (rc == -ENOENT)
> +		return rc;
> +


>  	/*
>  	 * GHESv2 type HEST entries introduce support for error
> acknowledgment,
>  	 * so only acknowledge the error if this support is present.
>  	 */
> 


> +	if (is_hest_type_generic_v2(ghes))

You can also do this here, like
	if (is_hest_type_generic_v2(ghes) && rc != -ENOENT)

though I left this for Rafael to choose which one is preferable.

> +		return ghes_ack_error(ghes->generic_v2);
> +


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
