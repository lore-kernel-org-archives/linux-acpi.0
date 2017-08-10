From: gengdongjiu <gengdongjiu@huawei.com>
Subject: Re: [PATCH] acpi: apei: fix the wrongly parse generic error status
 block
Date: Fri, 11 Aug 2017 05:37:50 +0800
Message-ID: <1be489f7-c1c3-63dc-dc0d-af67e5fd03a1@huawei.com>
References: <1502388412-20273-1-git-send-email-gengdongjiu@huawei.com>
 <9ea70eed-f743-0c8b-2a70-27ce4c0d8705@codeaurora.org>
 <ddb2070d-60c5-a476-c003-25814d0cf863@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:3058 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752440AbdHJVia (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Aug 2017 17:38:30 -0400
In-Reply-To: <ddb2070d-60c5-a476-c003-25814d0cf863@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Baicar, Tyler" <tbaicar@codeaurora.org>, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

may be directly remove the macro apei_estatus_for_each_section is not better, if other place code also
needs to iterate through the GHES estatus blocks, it will be repeated written again.


On 2017/8/11 5:31, gengdongjiu wrote:
> Hello,
> 
>    sorry, I do not see that. Just know I have reviewed your modification, may be my change can be simpleness and reserve the macro of apei_estatus_for_each_section
> can be used by other place to avoid duplicated code, such as prints the estatus blocks.
> 
> On 2017/8/11 1:48, Baicar, Tyler wrote:
>> Hello,
>>
>> I have already posted a patch fixing this. Please see:
>>
>> https://lkml.org/lkml/2017/8/3/824
>>
>> This makes the loop identical to the CPER code which prints the estatus blocks to the kernel logs.
>>
>> Thanks,
>>
>> Tyler
>>
>>
>> On 8/10/2017 12:06 PM, Dongjiu Geng wrote:
>>> The revision 0x300 generic error data entry is different with the old
>>> version. when ghes_do_proc traverses to get the data entry, it does not
>>> consider this difference. so when error status block has revision 0x300
>>> data entry, it will have issue.
>>>
>>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>>> ---
>>>   drivers/acpi/apei/apei-internal.h | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
>>> index 6e9f14c0a71b..6491f1c4a96e 100644
>>> --- a/drivers/acpi/apei/apei-internal.h
>>> +++ b/drivers/acpi/apei/apei-internal.h
>>> @@ -122,8 +122,8 @@ struct dentry *apei_get_debugfs_dir(void);
>>>     #define apei_estatus_for_each_section(estatus, section)            \
>>>       for (section = (struct acpi_hest_generic_data *)(estatus + 1);    \
>>> -         (void *)section - (void *)estatus < estatus->data_length;    \
>>> -         section = (void *)(section+1) + section->error_data_length)
>>> +         (void *)section - (void *)(estatus + 1) < estatus->data_length; \
>>> +         section = acpi_hest_get_next(section))
>>>     static inline u32 cper_estatus_len(struct acpi_hest_generic_status *estatus)
>>>   {
>>

