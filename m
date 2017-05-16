From: "Baicar, Tyler" <tbaicar@codeaurora.org>
Subject: Re: [PATCH v2 0/2] Clean up ACPI Boot Error Record Table code
Date: Tue, 16 May 2017 16:12:21 -0600
Message-ID: <5174133f-2588-eda1-4f98-0e457f16af0d@codeaurora.org>
References: <20170512120118.zwhgtcbf4u4zshbn@pd.tnic>
 <cover.1494624795.git.tony.luck@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:39244 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751300AbdEPWMY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 May 2017 18:12:24 -0400
In-Reply-To: <cover.1494624795.git.tony.luck@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Huang Ying <ying.huang@intel.com>, Borislav Petkov <bp@suse.de>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Jonathan Zhang <zjzhang@codeaurora.org>, linux-acpi@vger.kernel.org

On 5/12/2017 3:42 PM, Luck, Tony wrote:
> From: Tony Luck <tony.luck@intel.com>
>
> ACPI 6.1 spec clarified the structure of the Boot Error Record Table.
> Linux code was overly complex, and included a redundant structure
> definition of "acpi_bert_region".
>
> v2 changes:
> Rafael: Split the change to <acpi/actbl1.h> into a separate patch so
> 	it can be fed through ACPICA process.
> Boris:  Better wording for the comment about the "address" field in
> 	the acpi_table_bert structure.
>
> Tony Luck (2):
>    ACPI / APEI: Boot Error Record Table processing was needlessly
>      complicated
>    ACPI / APEI: No remaining users of struct acpi_bert_region
>
>   drivers/acpi/apei/bert.c | 54 +++++++-----------------------------------------
>   include/acpi/actbl1.h    | 16 +++++---------
>   2 files changed, 12 insertions(+), 58 deletions(-)
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
Hello Tony,

I tested this out and can see everything works properly as long as the 
BERT record is valid.

Previously, if I made the CPER section size too small then the kernel 
would just print the Firmware Bug: Invalid error record. Doing the same 
thing with this patch series I can see an unlimited stream of unknown 
error sections being printed out (I tested this with my ACPI 6.1/UEFI 
2.6 patches which include the non-standard error record support).

[   11.482831] [Hardware Error]:  Error 1, type: recoverable
[   11.482832] [Hardware Error]:   section type: unknown, 
00000000-0000-0000-0000-000000000000
[   11.482833] [Hardware Error]:   section length: 0x0
[   11.482834] [Hardware Error]:  Error 2, type: recoverable
[   11.482835] [Hardware Error]:   section type: unknown, 
00000000-0000-0000-0000-000000000000
[   11.482836] [Hardware Error]:   section length: 0x0
[   11.482837] [Hardware Error]:  Error 3, type: recoverable
[   11.482839] [Hardware Error]:   section type: unknown, 
00000000-0000-0000-0000-000000000000
[   11.482839] [Hardware Error]:   section length: 0x0
...

For that reason, I'd suggest leaving this check in:

if (cper_estatus_check(estatus)) {
     pr_err(FW_BUG "Invalid error record.\n");
     return;
}

Thanks,
Tyler

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

