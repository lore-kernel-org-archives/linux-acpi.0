From: "Baicar, Tyler" <tbaicar@codeaurora.org>
Subject: Re: [PATCH] acpi: apei: clear error status before acknowledging the
 error
Date: Mon, 31 Jul 2017 10:15:27 -0600
Message-ID: <fd826be1-50b0-1f82-3fb3-a32a356c45c4@codeaurora.org>
References: <1501280703-21471-1-git-send-email-tbaicar@codeaurora.org>
 <20170729065345.GA30608@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:51750 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751046AbdGaQPa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 31 Jul 2017 12:15:30 -0400
In-Reply-To: <20170729065345.GA30608@nazgul.tnic>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@suse.de>
Cc: rjw@rjwysocki.net, lenb@kernel.org, will.deacon@arm.com, james.morse@arm.com, shiju.jose@huawei.com, geliangtang@gmail.com, andriy.shevchenko@linux.intel.com, tony.luck@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 7/29/2017 12:53 AM, Borislav Petkov wrote:
> On Fri, Jul 28, 2017 at 04:25:03PM -0600, Tyler Baicar wrote:
>> Currently we acknowledge errors before clearing the error status.
>> This could cause a new error to be populated by firmware in-between
>> the error acknowledgment and the error status clearing which would
>> cause the second error's status to be cleared without being handled.
>> So, clear the error status before acknowledging the errors.
>>
>> Also, make sure to acknowledge the error if the error status read
>> fails.
>>
>> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
>> ---
>>   drivers/acpi/apei/ghes.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index d661d45..6a6895a 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -743,17 +743,15 @@ static int ghes_proc(struct ghes *ghes)
>>   	}
>>   	ghes_do_proc(ghes, ghes->estatus);
>>   
>> +out:
> If the first ghes_read_estatus() fails and we jump straight to that
> label...
>
>> +	ghes_clear_estatus(ghes);
>>   	/*
>>   	 * GHESv2 type HEST entries introduce support for error acknowledgment,
>>   	 * so only acknowledge the error if this support is present.
>>   	 */
>>   	if (is_hest_type_generic_v2(ghes)) {
>>   		rc = ghes_ack_error(ghes->generic_v2);
> ... and ACK the error anyway, even the status read failed, wouldn't that
> confuse the firmware?
Hello Boris,

I think the better thing to do in this case is still send the ack. If 
ghes_read_estatus() fails, then
either we are unable to read the estatus or the estatus is 
empty/invalid. For the first case, there's
not much that can be done. The second case would be a FW bug with 
populating the estatus.

If we do not send the ack, then we will be in a scenario where FW will 
not send any more errors.
I think it would be better to still have the FW send the errors and 
kernel complain about issues with
the errors populated rather than just have the kernel complain on the 
first error and then not be sent
any more errors.

If you don't agree with this, then I can change it back to not sending 
the ack if the read fails.
>
>> -		if (rc)
>> -			return rc;
>>   	}
> No need for the curly brackets anymore.
I'll remove these brackets in the next version.

Thanks,
Tyler

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

