From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH] ACPI/CPPC: Support for batching CPPC requests
Date: Thu, 9 Jun 2016 16:46:36 -0600
Message-ID: <aee2936a-a9ec-d594-3f62-19de3ab1a38a@codeaurora.org>
References: <1463441951-13207-1-git-send-email-pprakash@codeaurora.org>
 <20160526220234.GA26524@arm.com>
 <CAFHUOYyi4k5JuP5unxKyYH=tdxBE1BNm7zW9cjQchcnrmFNg9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:44824 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932077AbcFIWqp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Jun 2016 18:46:45 -0400
In-Reply-To: <CAFHUOYyi4k5JuP5unxKyYH=tdxBE1BNm7zW9cjQchcnrmFNg9A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hoan Tran <hotran@apm.com>, Alexey Klimov <alexey.klimov@arm.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ashwin Chaugule <ashwin.chaugule@linaro.org>

Hi Hoan,


On 6/9/2016 11:22 AM, Hoan Tran wrote:
> Hi Prashanth,
>
> On Thu, May 26, 2016 at 3:02 PM, Alexey Klimov <alexey.klimov@arm.com> wrote:
>> On Tue, May 17, 2016 at 12:39 AM, Prashanth Prakash <pprakash@codeaurora.org> wrote:
>>> CPPC defined in section 8.4.7 of ACPI 6.1 specification suggests
>>> "To amortize the cost of PCC transactions, OSPM should read or write
>>> all PCC registers via a single read or write command when possible"
>>> This patch enables opportunistic batching of frequency transition
>>> requests whenever the request happen to overlap in time.
>>>
>>> Currently the access to pcc is serialized by a spin lock which does
>>> not scale well as we increase the number of cores in the system. This
>>> patch improves the scalability by allowing the differnt CPU cores to
>>> update PCC subspace in parallel and by batching requests which will
>>> reduce certain types of operation(checking command completion bit,
>>> ringing doorbell) by a significant margin.
>>>
>>> Profiling shows significant improvement in the time to service freq.
>>> transition request. Using a workload which includes multiple iteration
>>> of configure+make of vim (with -j24 option):
>>> Without batching requests(without this patch),
>>>         6 domains: Avg=20us/request; 24 domains: Avg=52us/request
>>> With batching requests(with this patch),
>>>         6 domains: Avg=16us/request; 24 domains: Avg=19us/request
>>> domain: An individual cpu or a set of related CPUs whose frequency can
>>> be scaled independently
>> With this approach sometimes you will send POSTCHANGE notifications about
>> frequency change for some random CPUs before actual request to change
>> frequency was sent (and received?) through PCC channel.
>> Depending on platform/firmware/configuration this time difference might be high.
>>
>> How vital or important is to have POSTCHANGE notification in correct time
>> order?
>>
>> Best regards,
>> Alexey.
>>
>>
>>
>>> Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
>>> ---
>>>  drivers/acpi/cppc_acpi.c | 166 ++++++++++++++++++++++++++++++++++++++++-------
>>>  1 file changed, 141 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>>> index 8adac69..3edfd50 100644
>>> --- a/drivers/acpi/cppc_acpi.c
>>> +++ b/drivers/acpi/cppc_acpi.c
>>> @@ -43,12 +43,34 @@
>>>
>>>  #include <acpi/cppc_acpi.h>
>>>  /*
>>> - * Lock to provide mutually exclusive access to the PCC
>>> - * channel. e.g. When the remote updates the shared region
>>> - * with new data, the reader needs to be protected from
>>> - * other CPUs activity on the same channel.
>>> + * Lock to provide controlled access to the PCC channel.
>>> + *
>>> + * For performance critical usecases(currently cppc_set_perf)
>>> + *     We need to take read_lock and check if channel belongs to OSPM before
>>> + * reading or writing to PCC subspace
>>> + *     We need to take write_lock before transferring the channel ownership to
>>> + * the platform via a Doorbell
>>> + *
>>> + * For non-performance critical usecases(init)
>>> + *     Take write_lock for all purposes which gives exclusive access
>>> + *
>>> + * Why not use spin lock?
>>> + *     One of the advantages of CPPC is that we can batch/group a large number
>>> + * of requests from differnt CPUs and send one request to the platform. Using a
>>> + * read-write spinlock allows us to do this in a effecient manner.
>>> + *     On larger multicore systems, if we get a large group of cppc_set_perf
>>> + * calls they all serialize behind a spin lock, but using a rwlock we can
>>> + * execute the requests in a much more scalable manner.
>>> + *     See cppc_set_perf() for more details
>>> + */
>>> +static DEFINE_RWLOCK(pcc_lock);
> Any chance to use mutex instead of spinlock ?
> In some cases such as (cmd = CMD_READ || pcc_mrtt), because of waiting
> for command completion,this spinlock is kept for a while before
> unlock. It could waste CPU time to acquire the spinlock.
>
> Thanks
> Hoan

The CMD_READ is primarily used during the init, so the returns on optimizing
that path is very limited. Since the CPPC protocol requires only an ack for
delivery of request from the platform and the platform can take its own time
to do actual Freq. and Voltage transition, the time we are holding the lock
should be very limited.  At least, in the profiling I have done, I haven't noticed
any issues.
Having said that, I haven't done profiling to compare spinlocks vs. mutex for
this scenario. Ashwin might have some background on why spinlocks were
used initially.

Thanks,
Prashanth
