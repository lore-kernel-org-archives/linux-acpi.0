From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH V3] acpi: apei: clear error status before acknowledging
 the error
Date: Tue, 29 Aug 2017 10:16:10 +0200
Message-ID: <20170829081610.moq2dtxzz4vrbmo5@pd.tnic>
References: <1503939221-27732-1-git-send-email-tbaicar@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1503939221-27732-1-git-send-email-tbaicar@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tyler Baicar <tbaicar@codeaurora.org>
Cc: rjw@rjwysocki.net, lenb@kernel.org, will.deacon@arm.com, james.morse@arm.com, bp@suse.de, shiju.jose@huawei.com, geliangtang@gmail.com, andriy.shevchenko@linux.intel.com, tony.luck@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Aug 28, 2017 at 10:53:41AM -0600, Tyler Baicar wrote:
> Currently we acknowledge errors before clearing the error status.
> This could cause a new error to be populated by firmware in-between
> the error acknowledgment and the error status clearing which would
> cause the second error's status to be cleared without being handled.
> So, clear the error status before acknowledging the errors.
> 
> Also, make sure to acknowledge the error if the error status read
> fails.
> 
> V3: Seperate check for -ENOENT return value
> 
> V2: Only send error ack if there was an error populated
>     Remove curly braces that are no longer needed
> 
> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
> ---
>  drivers/acpi/apei/ghes.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
