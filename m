From: Hoan Tran <hotran@apm.com>
Subject: Re: [PATCH] mailbox: pcc: Add PCC request and free channel declarations
Date: Wed, 15 Jun 2016 15:18:27 -0700
Message-ID: <CAFHUOYwgj1gKezqjee07zoi0PJeUZHHjpXe4oU7JKu6uRZLwqQ@mail.gmail.com>
References: <1465945963-22353-1-git-send-email-hotran@apm.com>
	<a249986e-dcd2-5b51-4707-6bd38fa17912@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:34891 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933205AbcFOWS3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jun 2016 18:18:29 -0400
Received: by mail-vk0-f51.google.com with SMTP id j2so49329557vkg.2
        for <linux-acpi@vger.kernel.org>; Wed, 15 Jun 2016 15:18:28 -0700 (PDT)
In-Reply-To: <a249986e-dcd2-5b51-4707-6bd38fa17912@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Prakash, Prashanth" <pprakash@codeaurora.org>
Cc: Ashwin Chaugule <ashwin.chaugule@linaro.org>, Jassi Brar <jassisinghbrar@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, devel@acpica.org, Loc Ho <lho@apm.com>, Duc Dang <dhdang@apm.com>

Hi Prashanth,

On Wed, Jun 15, 2016 at 8:55 AM, Prakash, Prashanth
<pprakash@codeaurora.org> wrote:
> Hi Hoan,
>
> On 6/14/2016 5:12 PM, Hoan Tran wrote:
>> As PCC will be used by other clients not only CPPC.
>> This change exports pcc_mbox_request_channel() and pcc_mbox_free_channel()
>> declarations
>>
>> Signed-off-by: Hoan Tran <hotran@apm.com>
>> ---
>>  include/acpi/cppc_acpi.h       | 4 ----
>>  include/linux/mailbox_client.h | 4 ++++
>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
>> index dad8af3..819b4b9 100644
>> --- a/include/acpi/cppc_acpi.h
>> +++ b/include/acpi/cppc_acpi.h
>> @@ -130,8 +130,4 @@ extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
>>  extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
>>  extern int acpi_get_psd_map(struct cpudata **);
>>
>> -/* Methods to interact with the PCC mailbox controller. */
>> -extern struct mbox_chan *
>> -     pcc_mbox_request_channel(struct mbox_client *, unsigned int);
>> -
>>  #endif /* _CPPC_ACPI_H*/
>> diff --git a/include/linux/mailbox_client.h b/include/linux/mailbox_client.h
>> index 41e2af8..2758d18 100644
>> --- a/include/linux/mailbox_client.h
>> +++ b/include/linux/mailbox_client.h
>> @@ -50,4 +50,8 @@ void mbox_client_txdone(struct mbox_chan *chan, int r); /* atomic */
>>  bool mbox_client_peek_data(struct mbox_chan *chan); /* atomic */
>>  void mbox_free_channel(struct mbox_chan *chan); /* may sleep */
>>
>> +/* Methods to interact with the PCC mailbox controller. */
>> +struct mbox_chan *pcc_mbox_request_channel(struct mbox_client *, int);
>> +void pcc_mbox_free_channel(struct mbox_chan *chan);
>> +
> Since these APIs are specific to PCC, may be we should introduce a new header for pcc clients
> instead of adding to the common mailbox_client header.

Agreed, maybe I should create a "pcc.h" file inside "/include/acpi"
folder. If you have any suggestion about the location of this file,
please let me know.

Thanks
Hoan

>>  #endif /* __MAILBOX_CLIENT_H */
>
> Thanks,
> Prashanth
