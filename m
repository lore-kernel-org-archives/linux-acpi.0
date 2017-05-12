From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] ACPI / APEI: Boot Error Record Table processing was
 needlessly complicated
Date: Fri, 12 May 2017 14:01:18 +0200
Message-ID: <20170512120118.zwhgtcbf4u4zshbn@pd.tnic>
References: <20170505181037.31668-1-tony.luck@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:54358 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752439AbdELMB2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 12 May 2017 08:01:28 -0400
Content-Disposition: inline
In-Reply-To: <20170505181037.31668-1-tony.luck@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Huang Ying <ying.huang@intel.com>, Borislav Petkov <bp@suse.de>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Jonathan Zhang <zjzhang@codeaurora.org>, Tyler Baicar <tbaicar@codeaurora.org>, linux-acpi@vger.kernel.org

On Fri, May 05, 2017 at 11:10:37AM -0700, Luck, Tony wrote:
> From: Tony Luck <tony.luck@intel.com>
> 
> Quoting version 6.1 of the ACPI specification. Section 18.3.1 "Boot
> Error Source" says:
> 
>   The Boot Error Region is a range of addressable memory OSPM can access
>   during initialization to determine if an unhandled error condition
>   occurred. System firmware must report this memory range as firmware
>   reserved. The format of the Boot Error Region follow that of an Error
>   Status Block, this is defined in Section 18.3.2.7. The format of the
>   error status block is described by Table 18-342.
> 
> This clarifies some points that were obfuscated in earlier versions.
> E.g. there is no longer a separate table to describe the format of the
> "Boot Error Region" (which was identical to the "Error Status Block").
> Also saying "follow that of *an* Error Status Block" makes it clear that
> there is just one block (which can still contain multiple "Generic Error
> Data Entry structures").
> 
> The loop inside bert_print_all() is unnecessary (but probably harmless
> as the "while (remain > sizeof(struct acpi_bert_region))" loop should
> terminate after we skipped over the first entry.
> 
> We can drop the "bert_print_all()" function and just move the four
> relevant lines inline in "bert_init()". Since there are no remaining
> users of "struct acpi_bert_region" we delete it from <acpi/actbl1.h>
> 
> Cc: Len Brown <lenb@kernel.org>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> Cc: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
> Cc: Tyler Baicar <tbaicar@codeaurora.org>
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  drivers/acpi/apei/bert.c | 54 +++++++-----------------------------------------
>  include/acpi/actbl1.h    | 11 +---------
>  2 files changed, 8 insertions(+), 57 deletions(-)

...

> -struct acpi_bert_region {
> -	u32 block_status;	/* Type of error information */
> -	u32 raw_data_offset;	/* Offset to raw error data */
> -	u32 raw_data_length;	/* Length of raw error data */
> -	u32 data_length;	/* Length of generic error data */
> -	u32 error_severity;	/* Severity code */
> +				/* which is a struct acpi_hest_generic_status */

Just this nitpick: please merge this comment with the one above it into
a single:

        u64 address;            /*
				 * Physical address of the error region which is a Generic
				 * Error Status Block (struct acpi_hest_generic_status).
				 */

I would like to advocate to use the actual names from the spec too
because those are so many and so dumbly named, so that one's head
starts spinning pretty quickly, trying to keep 'em apart.

Other than that,

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
