From: James Morse <james.morse@arm.com>
Subject: Re: [PATCH] acpi: apei: clear error status before acknowledging the
 error
Date: Mon, 31 Jul 2017 18:11:41 +0100
Message-ID: <597F64CD.2010800@arm.com>
References: <1501280703-21471-1-git-send-email-tbaicar@codeaurora.org> <20170729065345.GA30608@nazgul.tnic> <fd826be1-50b0-1f82-3fb3-a32a356c45c4@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:55650 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751171AbdGaRMv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 31 Jul 2017 13:12:51 -0400
In-Reply-To: <fd826be1-50b0-1f82-3fb3-a32a356c45c4@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Baicar, Tyler" <tbaicar@codeaurora.org>
Cc: Borislav Petkov <bp@suse.de>, rjw@rjwysocki.net, lenb@kernel.org, will.deacon@arm.com, shiju.jose@huawei.com, geliangtang@gmail.com, andriy.shevchenko@linux.intel.com, tony.luck@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Tyler,

On 31/07/17 17:15, Baicar, Tyler wrote:
> On 7/29/2017 12:53 AM, Borislav Petkov wrote:
>> On Fri, Jul 28, 2017 at 04:25:03PM -0600, Tyler Baicar wrote:
>>> Currently we acknowledge errors before clearing the error status.
>>> This could cause a new error to be populated by firmware in-between
>>> the error acknowledgment and the error status clearing which would
>>> cause the second error's status to be cleared without being handled.
>>> So, clear the error status before acknowledging the errors.
>>>
>>> Also, make sure to acknowledge the error if the error status read
>>> fails.

>>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>>> index d661d45..6a6895a 100644
>>> --- a/drivers/acpi/apei/ghes.c
>>> +++ b/drivers/acpi/apei/ghes.c
>>> @@ -743,17 +743,15 @@ static int ghes_proc(struct ghes *ghes)
>>>       }
>>>       ghes_do_proc(ghes, ghes->estatus);
>>>   +out:
>> If the first ghes_read_estatus() fails and we jump straight to that
>> label...
>>
>>> +    ghes_clear_estatus(ghes);
>>>       /*
>>>        * GHESv2 type HEST entries introduce support for error acknowledgment,
>>>        * so only acknowledge the error if this support is present.
>>>        */
>>>       if (is_hest_type_generic_v2(ghes)) {
>>>           rc = ghes_ack_error(ghes->generic_v2);
>> ... and ACK the error anyway, even the status read failed, wouldn't that
>> confuse the firmware?

> I think the better thing to do in this case is still send the ack. If
> ghes_read_estatus() fails, then
> either we are unable to read the estatus or the estatus is empty/invalid. For
> the first case, there's
> not much that can be done. The second case would be a FW bug with populating the
> estatus.

Wouldn't this mean acking on a timer for ghes_poll_func()?

What happens if:
> kernel: read error-status-block
> kernel: nothing here
> firmware: error! write to error-status-block
> kernel: write to ack register

(this is probably only a problem for polling as there is no notification)


> If we do not send the ack, then we will be in a scenario where FW will not send
> any more errors.

Because we haven't yet handled the first one...

I thought GHESv2's ack was also used to catch errors that occur while an earlier
error is being handled. But from the text in ACPI 6.2's 18.3.2.8 the 'ack' is
only described as releasing the memory region, not completion of the error handler.


Thanks,

James


