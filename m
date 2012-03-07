From: Jiang Liu <liuj97@gmail.com>
Subject: Re: [RESEND PATCH v3] Fix a copy & paste error in erst.c.
Date: Wed, 07 Mar 2012 22:06:14 +0800
Message-ID: <4F576B56.9020607@gmail.com>
References: <1331051359-21539-1-git-send-email-jiang.liu@huawei.com> <CAErSpo4svRTqJcRAUaEwykQ_d1-ONpXW0m9x6aAMM2_i4XF52g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:63743 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758618Ab2CGOGY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Mar 2012 09:06:24 -0500
Received: by yhmm54 with SMTP id m54so2879302yhm.19
        for <linux-acpi@vger.kernel.org>; Wed, 07 Mar 2012 06:06:24 -0800 (PST)
In-Reply-To: <CAErSpo4svRTqJcRAUaEwykQ_d1-ONpXW0m9x6aAMM2_i4XF52g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Len Brown <lenb@kernel.org>, Huang Ying <ying.huang@intel.com>, Jiang Liu <jiang.liu@huawei.com>, linux-acpi@vger.kernel.org

Thanks, Bjorn.
Will send another version with clear patch description.

On 03/07/2012 12:55 AM, Bjorn Helgaas wrote:
> On Tue, Mar 6, 2012 at 9:29 AM, Jiang Liu <liuj97@gmail.com> wrote:
>> This patch fixes a copy & paste error in erst.c and it applies
>> to v3.3-rc6.
> 
> It'd be nice if the subject line gave a hint about what sort of
> problem this patch fixes.  It doesn't matter *how* the original error
> was made; it's a question of what behavior we're changing.
> 
> Distro and stable kernel maintainers have to decide whether this is
> important enough to be backported, and "fix copy & paste error"
> doesn't tell them anything useful.
> 
> Maybe something like:
> 
>     ACPI, APEI, Fix ERST header length check
> 
>     This fixes the ERST header length check.  Without this patch, we
>     mistakenly ignore the ERST table, and hardware errors can't be saved
>     in the persistent store.
> 
> 
>> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
>> Acked-by: Huang Ying <ying.huang@intel.com>
>> ---
>>  drivers/acpi/apei/erst.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
>> index eb9fab5..e4d9d24 100644
>> --- a/drivers/acpi/apei/erst.c
>> +++ b/drivers/acpi/apei/erst.c
>> @@ -917,7 +917,7 @@ static int erst_check_table(struct acpi_table_erst *erst_tab)
>>  {
>>        if ((erst_tab->header_length !=
>>             (sizeof(struct acpi_table_erst) - sizeof(erst_tab->header)))
>> -           && (erst_tab->header_length != sizeof(struct acpi_table_einj)))
>> +           && (erst_tab->header_length != sizeof(struct acpi_table_erst)))
>>                return -EINVAL;
>>        if (erst_tab->header.length < sizeof(struct acpi_table_erst))
>>                return -EINVAL;
>> --
>> 1.7.5.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

