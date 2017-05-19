From: "Baicar, Tyler" <tbaicar@codeaurora.org>
Subject: Re: [PATCH v3] ACPI / APEI: Boot Error Record Table processing was
 needlessly complicated
Date: Fri, 19 May 2017 15:39:29 -0600
Message-ID: <276be033-dcbb-bff3-fa52-9a84a57a9d2e@codeaurora.org>
References: <5174133f-2588-eda1-4f98-0e457f16af0d@codeaurora.org>
 <20170516225806.5702-1-tony.luck@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:38846 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756170AbdESVjg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 May 2017 17:39:36 -0400
In-Reply-To: <20170516225806.5702-1-tony.luck@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Huang Ying <ying.huang@intel.com>, Borislav Petkov <bp@suse.de>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Jonathan Zhang <zjzhang@codeaurora.org>, linux-acpi@vger.kernel.org

On 5/16/2017 4:58 PM, Luck, Tony wrote:
> From: Tony Luck <tony.luck@intel.com>
>
> Quoting version 6.1 of the ACPI specification. Section 18.3.1 "Boot
> Error Source" says:
>
>    The Boot Error Region is a range of addressable memory OSPM can access
>    during initialization to determine if an unhandled error condition
>    occurred. System firmware must report this memory range as firmware
>    reserved. The format of the Boot Error Region follow that of an Error
>    Status Block, this is defined in Section 18.3.2.7. The format of the
>    error status block is described by Table 18-342.
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
> relevant lines inline in "bert_init()".
>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> Cc: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
> Cc: Tyler Baicar <tbaicar@codeaurora.org>
> Cc: linux-acpi@vger.kernel.org
> Reviewed-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
Tested-by: Tyler Baicar <tbaicar@codeaurora.org>

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

