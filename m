From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH] ACPI/CPPC: Support for batching CPPC requests
Date: Tue, 28 Jun 2016 09:53:08 -0600
Message-ID: <6f15a12a-f4f5-e8e9-4652-962b79291a46@codeaurora.org>
References: <1463441951-13207-1-git-send-email-pprakash@codeaurora.org>
 <20160526220234.GA26524@arm.com>
 <CAFHUOYyi4k5JuP5unxKyYH=tdxBE1BNm7zW9cjQchcnrmFNg9A@mail.gmail.com>
 <aee2936a-a9ec-d594-3f62-19de3ab1a38a@codeaurora.org>
 <CAFHUOYztBoB=_AbD3GVnbeZGqTn1y3rbHMxUzSdcbdHVo=-jxA@mail.gmail.com>
 <1b3e7901-845d-0652-cc03-8ef6c35ec8fc@codeaurora.org>
 <CAFHUOYyP4AdmdCiXMaJDeBaiA7qdT6V2kF_oGvvuwOix1uoebA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:57532 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944AbcF1PxM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Jun 2016 11:53:12 -0400
In-Reply-To: <CAFHUOYyP4AdmdCiXMaJDeBaiA7qdT6V2kF_oGvvuwOix1uoebA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hoan Tran <hotran@apm.com>
Cc: Alexey Klimov <alexey.klimov@arm.com>, linux acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ashwin Chaugule <ashwin.chaugule@linaro.org>

Hi Hoan/Alexey,

Based on your inputs, I have updated the patch to use a rw_semaphore and
introduced a wait_q for the threads whose request gets batched. The thread that
rings the doorbell will wake up all other threads. That way we can make sure the
POSTCHANGE notification happens only after triggering the doorbell, while allowing
us to support batching with or without completion interrupts.

I have few other cppc related patches, so I am planning to pull this one into
that patch set and post it.

Thanks,
Prashanth

On 6/10/2016 3:45 PM, Hoan Tran wrote:
> Hi Prashanth,
>
> On Fri, Jun 10, 2016 at 2:22 PM, Prakash, Prashanth
> <pprakash@codeaurora.org> wrote:
>> Hi Hoan,
>>
>> On 6/9/2016 8:25 PM, Hoan Tran wrote:
>>> Hi Prashanth,
>>>
>>> On Thu, Jun 9, 2016 at 3:46 PM, Prakash, Prashanth
>>> <pprakash@codeaurora.org> wrote:
>>>> Hi Hoan,
>>>>
>>>>
>>>> On 6/9/2016 11:22 AM, Hoan Tran wrote:
>>>>> Hi Prashanth,
>>>>>
>>>>> On Thu, May 26, 2016 at 3:02 PM, Alexey Klimov <alexey.klimov@arm.com> wrote:
>>>>>> On Tue, May 17, 2016 at 12:39 AM, Prashanth Prakash <pprakash@codeaurora.org> wrote:
>>>>>>> CPPC defined in section 8.4.7 of ACPI 6.1 specification suggests
>>>>>>> "To amortize the cost of PCC transactions, OSPM should read or write
>>>>>>> all PCC registers via a single read or write command when possible"
>>>>>>> This patch enables opportunistic batching of frequency transition
>>>>>>> requests whenever the request happen to overlap in time.
>>>>>>>
>>>>>>> Currently the access to pcc is serialized by a spin lock which does
>>>>>>> not scale well as we increase the number of cores in the system. This
>>>>>>> patch improves the scalability by allowing the differnt CPU cores to
>>>>>>> update PCC subspace in parallel and by batching requests which will
>>>>>>> reduce certain types of operation(checking command completion bit,
>>>>>>> ringing doorbell) by a significant margin.
>>>>>>>
>>>>>>> Profiling shows significant improvement in the time to service freq.
>>>>>>> transition request. Using a workload which includes multiple iteration
>>>>>>> of configure+make of vim (with -j24 option):
>>>>>>> Without batching requests(without this patch),
>>>>>>>         6 domains: Avg=20us/request; 24 domains: Avg=52us/request
>>>>>>> With batching requests(with this patch),
>>>>>>>         6 domains: Avg=16us/request; 24 domains: Avg=19us/request
>>>>>>> domain: An individual cpu or a set of related CPUs whose frequency can
>>>>>>> be scaled independently
>>>>>> With this approach sometimes you will send POSTCHANGE notifications about
>>>>>> frequency change for some random CPUs before actual request to change
>>>>>> frequency was sent (and received?) through PCC channel.
>>>>>> Depending on platform/firmware/configuration this time difference might be high.
>>>>>>
>>>>>> How vital or important is to have POSTCHANGE notification in correct time
>>>>>> order?
>>>>>>
>>>>>> Best regards,
>>>>>> Alexey.
>>>>>>
>>>>>>
>>>>>>
>>>>>>> Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
>>>>>>> ---
>>>>>>>  drivers/acpi/cppc_acpi.c | 166 ++++++++++++++++++++++++++++++++++++++++-------
>>>>>>>  1 file changed, 141 insertions(+), 25 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>>>>>>> index 8adac69..3edfd50 100644
>>>>>>> --- a/drivers/acpi/cppc_acpi.c
>>>>>>> +++ b/drivers/acpi/cppc_acpi.c
>>>>>>> @@ -43,12 +43,34 @@
>>>>>>>
>>>>>>>  #include <acpi/cppc_acpi.h>
>>>>>>>  /*
>>>>>>> - * Lock to provide mutually exclusive access to the PCC
>>>>>>> - * channel. e.g. When the remote updates the shared region
>>>>>>> - * with new data, the reader needs to be protected from
>>>>>>> - * other CPUs activity on the same channel.
>>>>>>> + * Lock to provide controlled access to the PCC channel.
>>>>>>> + *
>>>>>>> + * For performance critical usecases(currently cppc_set_perf)
>>>>>>> + *     We need to take read_lock and check if channel belongs to OSPM before
>>>>>>> + * reading or writing to PCC subspace
>>>>>>> + *     We need to take write_lock before transferring the channel ownership to
>>>>>>> + * the platform via a Doorbell
>>>>>>> + *
>>>>>>> + * For non-performance critical usecases(init)
>>>>>>> + *     Take write_lock for all purposes which gives exclusive access
>>>>>>> + *
>>>>>>> + * Why not use spin lock?
>>>>>>> + *     One of the advantages of CPPC is that we can batch/group a large number
>>>>>>> + * of requests from differnt CPUs and send one request to the platform. Using a
>>>>>>> + * read-write spinlock allows us to do this in a effecient manner.
>>>>>>> + *     On larger multicore systems, if we get a large group of cppc_set_perf
>>>>>>> + * calls they all serialize behind a spin lock, but using a rwlock we can
>>>>>>> + * execute the requests in a much more scalable manner.
>>>>>>> + *     See cppc_set_perf() for more details
>>>>>>> + */
>>>>>>> +static DEFINE_RWLOCK(pcc_lock);
>>>>> Any chance to use mutex instead of spinlock ?
>>>>> In some cases such as (cmd = CMD_READ || pcc_mrtt), because of waiting
>>>>> for command completion,this spinlock is kept for a while before
>>>>> unlock. It could waste CPU time to acquire the spinlock.
>>>>>
>>>>> Thanks
>>>>> Hoan
>>>> The CMD_READ is primarily used during the init, so the returns on optimizing
>>>> that path is very limited. Since the CPPC protocol requires only an ack for
>>>> delivery of request from the platform and the platform can take its own time
>>>> to do actual Freq. and Voltage transition, the time we are holding the lock
>>>> should be very limited.  At least, in the profiling I have done, I haven't noticed
>>>> any issues.
>>> When pcc_mrtt is not zero, CPPC still have to wait for the command completion.
>>> For CMD_READ, if we support to read performance feedback from CPPC
>>> counters, it's not only used during init.
>> Looks like there was some discussion on why spinlocks earlier as well:
>> https://lists.linaro.org/pipermail/linaro-acpi/2015-September/005797.html
>>
>> One could make an argument that pcc_mrtt and nominal command latency are
>> typically quite low(in very low us) as platform only acks or provides some info.
> With CMD_READ, firmware updates a full CPPC table. I don't think it's
> fast enough.
>
>> Since the spec doesn't put any restriction on pcc_mrtt, theoretically one could
>> design a platform with high pcc_mrtt, then the current implementation will be
>> sub-optimal on those.
>>
>> My hesitation for changing this to mutex/semaphore is primarily due to lack
>> profiling.
> You can profile the opensource version, simply change spinlock to mutex.
> I think it's good if we can use mutex/semaphore.
>
> Thanks
> Hoan
>
>> How about we do this,  I will post v2 of this patch fixing the issue
>> Alexey pointed out about POSTCHANGE notification.
>> Following that, I can change this read-write spinlock into a read-write semaphore,
>> profile it and  if it looks good I can submit another patch.
>>
>> If you have any profiling data from a different platform that suggest one way
>> is better than the other, please share it as well.
>>
>> Thanks,
>> Prashanth
>>> Thanks
>>> Hoan
>>>
>>>> Having said that, I haven't done profiling to compare spinlocks vs. mutex for
>>>> this scenario. Ashwin might have some background on why spinlocks were
>>>> used initially.
>>>>
>>>> Thanks,
>>>> Prashanth
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

