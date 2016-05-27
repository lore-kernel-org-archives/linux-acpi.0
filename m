From: Hoan Tran <hotran@apm.com>
Subject: Re: [PATCH] acpi: cppc: Prevent cpc_desc_ptr points to the invalid data
Date: Fri, 27 May 2016 09:41:40 -0700
Message-ID: <CAFHUOYw3vB9ZDZ-E=WsyceZEFnZKPe0D8zFCDr0qyjdqUKBL5g@mail.gmail.com>
References: <1464203363-20599-1-git-send-email-hotran@apm.com>
	<CAJ5Y-ebkd6rbQkegdYUREn775Nu5jZqB3TBex5Rj1JsQ6Sjs-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vk0-f50.google.com ([209.85.213.50]:35110 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbcE0Qlm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 May 2016 12:41:42 -0400
Received: by mail-vk0-f50.google.com with SMTP id f66so150715242vkh.2
        for <linux-acpi@vger.kernel.org>; Fri, 27 May 2016 09:41:41 -0700 (PDT)
In-Reply-To: <CAJ5Y-ebkd6rbQkegdYUREn775Nu5jZqB3TBex5Rj1JsQ6Sjs-Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Duc Dang <dhdang@apm.com>, Loc Ho <lho@apm.com>

Hi Ashwin,

Yes, I saw kernel crash.
As cpc_desc_ptr is not NULL, cppc_cpufreq_init() still can pass then
crash during cppc_get_perf_caps() access CPPC shared memory.

It's not only "PCC channel request fail" can create this issue but
"acpi_get_psd() fail" also creates it

Thanks
Hoan

On Fri, May 27, 2016 at 9:10 AM, Ashwin Chaugule
<ashwin.chaugule@linaro.org> wrote:
> On 25 May 2016 at 15:09, Hoan Tran <hotran@apm.com> wrote:
>> When CPPC fails to request PCC channel, the CPC data is freed
>> and cpc_desc_ptr points to the invalid data. This change prevents
>> this issue by moving cpc_desc_ptr assignment after PCC channel
>> request.
>>
>> Signed-off-by: Hoan Tran <hotran@apm.com>
>> ---
>>  drivers/acpi/cppc_acpi.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index 8adac69..85fd8f7 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -595,9 +595,6 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>>         /* Store CPU Logical ID */
>>         cpc_ptr->cpu_id = pr->id;
>>
>> -       /* Plug it into this CPUs CPC descriptor. */
>> -       per_cpu(cpc_desc_ptr, pr->id) = cpc_ptr;
>> -
>>         /* Parse PSD data for this CPU */
>>         ret = acpi_get_psd(cpc_ptr, handle);
>>         if (ret)
>> @@ -610,6 +607,9 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>>                         goto out_free;
>>         }
>>
>> +       /* Plug PSD data into this CPUs CPC descriptor. */
>> +       per_cpu(cpc_desc_ptr, pr->id) = cpc_ptr;
>> +
>
> Are you seeing a real problem without this change? I'm missing where
> this pointer is dereferenced if the PCC channel request fails.
>
> Thanks,
> Ashwin.
