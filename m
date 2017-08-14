From: "Baicar, Tyler" <tbaicar@codeaurora.org>
Subject: Re: [PATCH] acpi: apei: fix the wrongly parse generic error status
 block
Date: Mon, 14 Aug 2017 08:04:52 -0600
Message-ID: <571aed7f-39aa-b5f0-1ea2-2e57a588d22f@codeaurora.org>
References: <1502388412-20273-1-git-send-email-gengdongjiu@huawei.com>
 <9ea70eed-f743-0c8b-2a70-27ce4c0d8705@codeaurora.org>
 <ddb2070d-60c5-a476-c003-25814d0cf863@huawei.com>
 <1be489f7-c1c3-63dc-dc0d-af67e5fd03a1@huawei.com>
 <70ebfc99-0666-fa2b-8ed4-19e1f93194bd@codeaurora.org>
 <CAMj-D2DqEafgnOCsRjm8fSkj_R7_HWPnBxEijhoUV_LnU7VY6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:35392 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750876AbdHNOFA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Aug 2017 10:05:00 -0400
In-Reply-To: <CAMj-D2DqEafgnOCsRjm8fSkj_R7_HWPnBxEijhoUV_LnU7VY6Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: gengdongjiu <gengdj.1984@gmail.com>
Cc: gengdongjiu <gengdongjiu@huawei.com>, rjw@rjwysocki.net, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 8/11/2017 5:41 PM, gengdongjiu wrote:
> 2017-08-11 21:19 GMT+08:00 Baicar, Tyler <tbaicar@codeaurora.org>:
>> I removed the apei_estatus_for_each_section because it was only being used
>> in this one spot even though several other parts of the code do the same
>> iteration (it is done several times in the CPER code). I made this iteration
>> match the CPER iterations because the CPER iterations are verifying that the
>> structures are all valid and lengths are correct. If those checks are being
>> done this way, it makes the most sense to mimic that iteration here when
>> calling into EDAC and triggering trace events.
> I think the macro includes the verification for the structures and
> lengths correction, it it does not correct, it will breadk the loop.
> I do not see your modifcation does some special validation, it almost
> smilar with the macro does.
> in all the code there are three functions to do the iteration.
> ghes_do_proc/cper_estatus_print/cper_estatus_check
> the cper_estatus_check function is especial, because its  purpose is
> to validate CPER, so it will  check every length. but not all
> function's purpose is to check, for example cper_estatus_print, as
> shown below, so we can use this macro to clear the code. Now we can
> see there are two function use it, but in the future, if want to
> iterate CPER, we can use the macro if it does not want to do special
> thing.
>
> #define apei_estatus_for_each_section(estatus, section) \
> for (section = (struct acpi_hest_generic_data *)(estatus + 1); \
> (void *)section - (void *)(estatus + 1) < estatus->data_length; \
> ------> here it will check whether length is valid, if not,  it will
> break the loop
> section = acpi_hest_get_next(section))
>
>
> Original code:
> void cper_estatus_print(const char *pfx,
>     const struct acpi_hest_generic_status *estatus)
> {
>   struct acpi_hest_generic_data *gdata;
>   unsigned int data_len;
>   int sec_no = 0;
>   char newpfx[64];
>   __u16 severity;
>   severity = estatus->error_severity;
>   if (severity == CPER_SEV_CORRECTED)
>    printk("%s%s\n", pfx,
>           "It has been corrected by h/w "
>           "and requires no further action");
>   printk("%s""event severity: %s\n", pfx, cper_severity_str(severity));
>   data_len = estatus->data_length;
>   gdata = (struct acpi_hest_generic_data *)(estatus + 1);
>   snprintf(newpfx, sizeof(newpfx), "%s%s", pfx, INDENT_SP);
>   while (data_len >= acpi_hest_get_size(gdata)) {
>    cper_estatus_print_section(newpfx, gdata, sec_no);
>    data_len -= acpi_hest_get_record_size(gdata);
>    gdata = acpi_hest_get_next(gdata);
>    sec_no++;
>   }
> }
>
> Can change to:
> void cper_estatus_print(const char *pfx,
>     const struct acpi_hest_generic_status *estatus)
> {
>   struct acpi_hest_generic_data *gdata;
>   int sec_no = 0;
>   char newpfx[64];
>   __u16 severity;
>   severity = estatus->error_severity;
>   if (severity == CPER_SEV_CORRECTED)
>    printk("%s%s\n", pfx,
>           "It has been corrected by h/w "
>           "and requires no further action");
>   printk("%s""event severity: %s\n", pfx, cper_severity_str(severity));
>   snprintf(newpfx, sizeof(newpfx), "%s%s", pfx, INDENT_SP);
>   apei_estatus_for_each_section {
>    cper_estatus_print_section(newpfx, gdata, sec_no);
>    sec_no++;
>   }
> }
This change works too, I think it just makes sense to have the 
iterations in the CPER and GHES code match. Do you want to add a patch 
to your patch here to change the CPER code as well? If so, I'll wait for 
that and test it out.

Thanks,
Tyler

