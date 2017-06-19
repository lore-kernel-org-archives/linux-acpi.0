From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v4] ACPI / APEI: Boot Error Record Table processing was
 needlessly complicated
Date: Mon, 19 Jun 2017 17:58:54 +0200
Message-ID: <20170619155854.gtcowx3cityb3gqt@pd.tnic>
References: <20170615224121.23949-1-tony.luck@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50017 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751004AbdFSP7O (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 19 Jun 2017 11:59:14 -0400
Content-Disposition: inline
In-Reply-To: <20170615224121.23949-1-tony.luck@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Huang Ying <ying.huang@intel.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Jonathan Zhang <zjzhang@codeaurora.org>, Tyler Baicar <tbaicar@codeaurora.org>, linux-acpi@vger.kernel.org

On Thu, Jun 15, 2017 at 03:41:21PM -0700, Luck, Tony wrote:
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

Hmm, ok, so do we know whether some fw writers "misunderstood" the
previous version of the spec and actually added that separate table and
now we need to handle the different layout?

Probably not but I'm not going to be surprised someone did. At all.

> Also saying "follow that of *an* Error Status Block" makes it clear that
> there is just one block (which can still contain multiple "Generic Error
> Data Entry structures").
> 
> The loop inside bert_print_all() is unnecessary (but probably harmless
> as the "while (remain > sizeof(struct acpi_bert_region))" loop should
> terminate after we skipped over the first entry.
> 
> We can drop the "bert_print_all()" function and just move the four
> relevant lines inline in "bert_init()".
> 
> Also this driver clears the "block_status" status field of the error
> status block in ACPI memory. I can see no justification for doing this
> in the ACPI spec.  It is also highly kernel-ego-centric.  There are
> user mode BERT harvesting tools that dig into /sys/firmware/acpi/tables/BERT
> which might like to see this summary value.
> 
> Drop the:
> 	estatus->block_status = 0;

This whole treatise of the clearing of block_status should most likely
be a separate patch, though. As it is clearly a fix. Probably make it
the first patch and the second one removing bert_print_all().

Something like that.

Thanks.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
