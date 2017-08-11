From: gengdongjiu <gengdj.1984@gmail.com>
Subject: Re: [PATCH] acpi: apei: fix the wrongly parse generic error status block
Date: Sat, 12 Aug 2017 07:41:48 +0800
Message-ID: <CAMj-D2DqEafgnOCsRjm8fSkj_R7_HWPnBxEijhoUV_LnU7VY6Q@mail.gmail.com>
References: <1502388412-20273-1-git-send-email-gengdongjiu@huawei.com>
 <9ea70eed-f743-0c8b-2a70-27ce4c0d8705@codeaurora.org> <ddb2070d-60c5-a476-c003-25814d0cf863@huawei.com>
 <1be489f7-c1c3-63dc-dc0d-af67e5fd03a1@huawei.com> <70ebfc99-0666-fa2b-8ed4-19e1f93194bd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ua0-f194.google.com ([209.85.217.194]:33252 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751675AbdHKXlu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Aug 2017 19:41:50 -0400
In-Reply-To: <70ebfc99-0666-fa2b-8ed4-19e1f93194bd@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Baicar, Tyler" <tbaicar@codeaurora.org>
Cc: gengdongjiu <gengdongjiu@huawei.com>, rjw@rjwysocki.net, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

2017-08-11 21:19 GMT+08:00 Baicar, Tyler <tbaicar@codeaurora.org>:
> I removed the apei_estatus_for_each_section because it was only being used
> in this one spot even though several other parts of the code do the same
> iteration (it is done several times in the CPER code). I made this iteration
> match the CPER iterations because the CPER iterations are verifying that the
> structures are all valid and lengths are correct. If those checks are being
> done this way, it makes the most sense to mimic that iteration here when
> calling into EDAC and triggering trace events.

I think the macro includes the verification for the structures and
lengths correction, it it does not correct, it will breadk the loop.
I do not see your modifcation does some special validation, it almost
smilar with the macro does.
in all the code there are three functions to do the iteration.
ghes_do_proc/cper_estatus_print/cper_estatus_check
the cper_estatus_check function is especial, because its  purpose is
to validate CPER, so it will  check every length. but not all
function's purpose is to check, for example cper_estatus_print, as
shown below, so we can use this macro to clear the code. Now we can
see there are two function use it, but in the future, if want to
iterate CPER, we can use the macro if it does not want to do special
thing.

#define apei_estatus_for_each_section(estatus, section) \
for (section = (struct acpi_hest_generic_data *)(estatus + 1); \
(void *)section - (void *)(estatus + 1) < estatus->data_length; \
------> here it will check whether length is valid, if not,  it will
break the loop
section = acpi_hest_get_next(section))


Original code:
void cper_estatus_print(const char *pfx,
   const struct acpi_hest_generic_status *estatus)
{
 struct acpi_hest_generic_data *gdata;
 unsigned int data_len;
 int sec_no = 0;
 char newpfx[64];
 __u16 severity;
 severity = estatus->error_severity;
 if (severity == CPER_SEV_CORRECTED)
  printk("%s%s\n", pfx,
         "It has been corrected by h/w "
         "and requires no further action");
 printk("%s""event severity: %s\n", pfx, cper_severity_str(severity));
 data_len = estatus->data_length;
 gdata = (struct acpi_hest_generic_data *)(estatus + 1);
 snprintf(newpfx, sizeof(newpfx), "%s%s", pfx, INDENT_SP);
 while (data_len >= acpi_hest_get_size(gdata)) {
  cper_estatus_print_section(newpfx, gdata, sec_no);
  data_len -= acpi_hest_get_record_size(gdata);
  gdata = acpi_hest_get_next(gdata);
  sec_no++;
 }
}

Can change to:
void cper_estatus_print(const char *pfx,
   const struct acpi_hest_generic_status *estatus)
{
 struct acpi_hest_generic_data *gdata;
 int sec_no = 0;
 char newpfx[64];
 __u16 severity;
 severity = estatus->error_severity;
 if (severity == CPER_SEV_CORRECTED)
  printk("%s%s\n", pfx,
         "It has been corrected by h/w "
         "and requires no further action");
 printk("%s""event severity: %s\n", pfx, cper_severity_str(severity));
 snprintf(newpfx, sizeof(newpfx), "%s%s", pfx, INDENT_SP);
 apei_estatus_for_each_section {
  cper_estatus_print_section(newpfx, gdata, sec_no);
  sec_no++;
 }
}



>
> Thanks,
>
> Tyler
>
>
> On 8/10/2017 3:37 PM, gengdongjiu wrote:
>>
>> may be directly remove the macro apei_estatus_for_each_section is not
>> better, if other place code also
>> needs to iterate through the GHES estatus blocks, it will be repeated
>> written again.
>>
>>
>> On 2017/8/11 5:31, gengdongjiu wrote:
>>>
>>> Hello,
>>>
>>>     sorry, I do not see that. Just know I have reviewed your
>>> modification, may be my change can be simpleness and reserve the macro of
>>> apei_estatus_for_each_section
>>> can be used by other place to avoid duplicated code, such as prints the
>>> estatus blocks.
>>>
>>> On 2017/8/11 1:48, Baicar, Tyler wrote:
>>>>
>>>> Hello,
>>>>
>>>> I have already posted a patch fixing this. Please see:
>>>>
>>>> https://lkml.org/lkml/2017/8/3/824
>>>>
>>>> This makes the loop identical to the CPER code which prints the estatus
>>>> blocks to the kernel logs.
>>>>
>>>> Thanks,
>>>>
>>>> Tyler
>>>>
>>>>
>>>> On 8/10/2017 12:06 PM, Dongjiu Geng wrote:
>>>>>
>>>>> The revision 0x300 generic error data entry is different with the old
>>>>> version. when ghes_do_proc traverses to get the data entry, it does not
>>>>> consider this difference. so when error status block has revision 0x300
>>>>> data entry, it will have issue.
>>>>>
>>>>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>>>>> ---
>>>>>    drivers/acpi/apei/apei-internal.h | 4 ++--
>>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/acpi/apei/apei-internal.h
>>>>> b/drivers/acpi/apei/apei-internal.h
>>>>> index 6e9f14c0a71b..6491f1c4a96e 100644
>>>>> --- a/drivers/acpi/apei/apei-internal.h
>>>>> +++ b/drivers/acpi/apei/apei-internal.h
>>>>> @@ -122,8 +122,8 @@ struct dentry *apei_get_debugfs_dir(void);
>>>>>      #define apei_estatus_for_each_section(estatus, section)
>>>>> \
>>>>>        for (section = (struct acpi_hest_generic_data *)(estatus + 1);
>>>>> \
>>>>> -         (void *)section - (void *)estatus < estatus->data_length;
>>>>> \
>>>>> -         section = (void *)(section+1) + section->error_data_length)
>>>>> +         (void *)section - (void *)(estatus + 1) <
>>>>> estatus->data_length; \
>>>>> +         section = acpi_hest_get_next(section))
>>>>>      static inline u32 cper_estatus_len(struct acpi_hest_generic_status
>>>>> *estatus)
>>>>>    {
>
>
> --
> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
> Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project.
>
