From: "Baicar, Tyler" <tbaicar@codeaurora.org>
Subject: Re: [PATCH V2] acpi: apei: clear error status before acknowledging
 the error
Date: Thu, 24 Aug 2017 10:42:48 -0600
Message-ID: <4ec78c65-5849-06ad-22fc-751de4c78992@codeaurora.org>
References: <1501798351-10337-1-git-send-email-tbaicar@codeaurora.org>
 <20170824081408.iwg7qyyr226btivo@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:34300 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753469AbdHXQmz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Aug 2017 12:42:55 -0400
In-Reply-To: <20170824081408.iwg7qyyr226btivo@pd.tnic>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@suse.de>
Cc: rjw@rjwysocki.net, lenb@kernel.org, will.deacon@arm.com, james.morse@arm.com, shiju.jose@huawei.com, geliangtang@gmail.com, andriy.shevchenko@linux.intel.com, tony.luck@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, austinwc@codeaurora.org

On 8/24/2017 2:14 AM, Borislav Petkov wrote:
> On Thu, Aug 03, 2017 at 04:12:31PM -0600, Tyler Baicar wrote:
>> Currently we acknowledge errors before clearing the error status.
>> This could cause a new error to be populated by firmware in-between
>> the error acknowledgment and the error status clearing which would
>> cause the second error's status to be cleared without being handled.
>> So, clear the error status before acknowledging the errors.
>>
>> Also, make sure to acknowledge the error if the error status read
>> fails.
>>
>> V2: Only send error ack if there was an error populated
>>      Remove curly braces that are no longer needed
>>
>> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
>> ---
>>   drivers/acpi/apei/ghes.c | 9 +++------
>>   1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index d661d45..cda4a4f 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -743,17 +743,14 @@ static int ghes_proc(struct ghes *ghes)
>>   	}
>>   	ghes_do_proc(ghes, ghes->estatus);
>>   
>> +out:
>> +	ghes_clear_estatus(ghes);
>>   	/*
>>   	 * GHESv2 type HEST entries introduce support for error acknowledgment,
>>   	 * so only acknowledge the error if this support is present.
>>   	 */
>> -	if (is_hest_type_generic_v2(ghes)) {
>> +	if (is_hest_type_generic_v2(ghes) && rc != -ENOENT)
> I think you should do something like this:
>
> out:
>          ghes_clear_estatus(ghes);
>
> 	if (rc == -ENOENT)
>                  return rc;
>
> 	/*
>           * GHESv2 type HEST entries introduce support for error acknowledgment,
>           * so only acknowledge the error if this support is present.
>           */
>          if (is_hest_type_generic_v2(ghes))
>                  return ghes_ack_error(ghes->generic_v2);
>
>          return rc;
>
>
> First check the -ENOENT because if there's no entry, you don't need to
> ACK anything anyway.
>
> And then only if it is an entry present and it is v2, you can ACK it.
>
> Hmmm?
Looks good to me, I'll send a v3 with this change.

Thanks,
Tyler

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

