From: gengdongjiu <gengdongjiu@huawei.com>
Subject: Re: [PATCH v3] acpi: apei: fix the wrongly iterate generic error
 status block
Date: Thu, 17 Aug 2017 11:09:31 +0800
Message-ID: <7b881329-3bde-bd7a-71a0-be75f2fc5c32@huawei.com>
References: <1502871290-28137-1-git-send-email-gengdongjiu@huawei.com>
 <1f5b068b-74a5-3be1-46ef-a1bb522c2791@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:3577 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751549AbdHQDMT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Aug 2017 23:12:19 -0400
In-Reply-To: <1f5b068b-74a5-3be1-46ef-a1bb522c2791@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Baicar, Tyler" <tbaicar@codeaurora.org>, bp@suse.de, james.morse@arm.com, geliangtang@gmail.com, andriy.shevchenko@linux.intel.com, tony.luck@intel.com, austinwc@codeaurora.org, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, john.garry@huawei.com, shiju.jose@huawei.com, zhengqiang10@huawei.com, wangxiongfeng2@huawei.com, will.deacon@arm.com, zjzhang@codeaurora.org, "catalin.marinas@arm.com" <catalin.marinas@arm.com>
Cc: huangshaoyu@huawei.com, wuquanming@huawei.com

CC Will and Jonathan


On 2017/8/16 21:55, Baicar, Tyler wrote:
> On 8/16/2017 2:14 AM, Dongjiu Geng wrote:
>> The revision 0x300 generic error data entry is different
>> from the old version, but currently iterating through the
>> GHES estatus blocks does not take into account this difference.
>> This will lead to failure to get the right data entry if GHES
>> has revision 0x300 error data entry.
>>
>> Update the GHES estatus iteration to properly increment using
>> acpi_hest_get_next, and correct the iteration termination condition
>> because the status block data length only includes error data length.
>> Clear the CPER estatus printing iteration logic to use same macro.
>>
>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>> CC: Tyler Baicar <tbaicar@codeaurora.org>
> Tested-by: Tyler Baicar <tbaicar@codeaurora.org>
> 
> Works good for me!
> 
> Thanks,
> Tyler
>> ---
>>   drivers/acpi/apei/apei-internal.h |  5 -----
>>   drivers/firmware/efi/cper.c       | 12 ++----------
>>   include/acpi/ghes.h               |  5 +++++
>>   3 files changed, 7 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
>> index 6e9f14c0a71b..cb4126051f62 100644
>> --- a/drivers/acpi/apei/apei-internal.h
>> +++ b/drivers/acpi/apei/apei-internal.h
>> @@ -120,11 +120,6 @@ int apei_exec_collect_resources(struct apei_exec_context *ctx,
>>   struct dentry;
>>   struct dentry *apei_get_debugfs_dir(void);
>>   -#define apei_estatus_for_each_section(estatus, section)            \
>> -    for (section = (struct acpi_hest_generic_data *)(estatus + 1);    \
>> -         (void *)section - (void *)estatus < estatus->data_length;    \
>> -         section = (void *)(section+1) + section->error_data_length)
>> -
>>   static inline u32 cper_estatus_len(struct acpi_hest_generic_status *estatus)
>>   {
>>       if (estatus->raw_data_length)
>> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
>> index 48a8f69da42a..bf3672a81e49 100644
>> --- a/drivers/firmware/efi/cper.c
>> +++ b/drivers/firmware/efi/cper.c
>> @@ -606,7 +606,6 @@ void cper_estatus_print(const char *pfx,
>>               const struct acpi_hest_generic_status *estatus)
>>   {
>>       struct acpi_hest_generic_data *gdata;
>> -    unsigned int data_len;
>>       int sec_no = 0;
>>       char newpfx[64];
>>       __u16 severity;
>> @@ -617,14 +616,10 @@ void cper_estatus_print(const char *pfx,
>>                  "It has been corrected by h/w "
>>                  "and requires no further action");
>>       printk("%s""event severity: %s\n", pfx, cper_severity_str(severity));
>> -    data_len = estatus->data_length;
>> -    gdata = (struct acpi_hest_generic_data *)(estatus + 1);
>>       snprintf(newpfx, sizeof(newpfx), "%s%s", pfx, INDENT_SP);
>>   -    while (data_len >= acpi_hest_get_size(gdata)) {
>> +    apei_estatus_for_each_section(estatus, gdata) {
>>           cper_estatus_print_section(newpfx, gdata, sec_no);
>> -        data_len -= acpi_hest_get_record_size(gdata);
>> -        gdata = acpi_hest_get_next(gdata);
>>           sec_no++;
>>       }
>>   }
>> @@ -653,15 +648,12 @@ int cper_estatus_check(const struct acpi_hest_generic_status *estatus)
>>       if (rc)
>>           return rc;
>>       data_len = estatus->data_length;
>> -    gdata = (struct acpi_hest_generic_data *)(estatus + 1);
>>   -    while (data_len >= acpi_hest_get_size(gdata)) {
>> +    apei_estatus_for_each_section(estatus, gdata) {
>>           gedata_len = acpi_hest_get_error_length(gdata);
>>           if (gedata_len > data_len - acpi_hest_get_size(gdata))
>>               return -EINVAL;
>> -
>>           data_len -= acpi_hest_get_record_size(gdata);
>> -        gdata = acpi_hest_get_next(gdata);
>>       }
>>       if (data_len)
>>           return -EINVAL;
>> diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
>> index 9f26e01186ae..9061c5c743b3 100644
>> --- a/include/acpi/ghes.h
>> +++ b/include/acpi/ghes.h
>> @@ -113,6 +113,11 @@ static inline void *acpi_hest_get_next(struct acpi_hest_generic_data *gdata)
>>       return (void *)(gdata) + acpi_hest_get_record_size(gdata);
>>   }
>>   +#define apei_estatus_for_each_section(estatus, section)            \
>> +    for (section = (struct acpi_hest_generic_data *)(estatus + 1);    \
>> +         (void *)section - (void *)(estatus + 1) < estatus->data_length; \
>> +         section = acpi_hest_get_next(section))
>> +
>>   int ghes_notify_sea(void);
>>     #endif /* GHES_H */
> 

