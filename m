From: "Baicar, Tyler" <tbaicar@codeaurora.org>
Subject: Re: [PATCH V3] acpi: apei: clear error status before acknowledging
 the error
Date: Wed, 13 Sep 2017 08:40:43 -0600
Message-ID: <47ed1861-1bdb-7caf-3d6b-5304235c7e10@codeaurora.org>
References: <1503939221-27732-1-git-send-email-tbaicar@codeaurora.org>
 <20170829081610.moq2dtxzz4vrbmo5@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:47990 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751081AbdIMOkq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Sep 2017 10:40:46 -0400
In-Reply-To: <20170829081610.moq2dtxzz4vrbmo5@pd.tnic>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net
Cc: Borislav Petkov <bp@alien8.de>, lenb@kernel.org, will.deacon@arm.com, james.morse@arm.com, bp@suse.de, shiju.jose@huawei.com, geliangtang@gmail.com, andriy.shevchenko@linux.intel.com, tony.luck@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 8/29/2017 2:16 AM, Borislav Petkov wrote:
> On Mon, Aug 28, 2017 at 10:53:41AM -0600, Tyler Baicar wrote:
>> Currently we acknowledge errors before clearing the error status.
>> This could cause a new error to be populated by firmware in-between
>> the error acknowledgment and the error status clearing which would
>> cause the second error's status to be cleared without being handled.
>> So, clear the error status before acknowledging the errors.
>>
>> Also, make sure to acknowledge the error if the error status read
>> fails.
>>
>> V3: Seperate check for -ENOENT return value
>>
>> V2: Only send error ack if there was an error populated
>>      Remove curly braces that are no longer needed
>>
>> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
>> ---
>>   drivers/acpi/apei/ghes.c | 16 +++++++++-------
>>   1 file changed, 9 insertions(+), 7 deletions(-)
> Reviewed-by: Borislav Petkov <bp@suse.de>
Hello Rafael,

Were you able to apply this patch?

Thanks,
Tyler

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

