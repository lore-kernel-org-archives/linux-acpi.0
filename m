From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH V2 3/5] ACPI/CPPC: support for batching CPPC requests
Date: Fri, 12 Aug 2016 15:30:51 -0600
Message-ID: <baf3560b-fd74-1a3d-bb51-6b54a9b78896@codeaurora.org>
References: <1469562328-10201-1-git-send-email-pprakash@codeaurora.org>
 <1469562328-10201-4-git-send-email-pprakash@codeaurora.org>
 <bf9134cd-3055-d4e3-652a-a8dee0aa9e26@codeaurora.org>
 <20160812124029.GA11926@arm.com>
 <32e1db55-9335-e755-97c6-daacf9403973@codeaurora.org>
 <20160812174236.GA19964@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:54368 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbcHLVay (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Aug 2016 17:30:54 -0400
In-Reply-To: <20160812174236.GA19964@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Klimov <alexey.klimov@arm.com>
Cc: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, hotran@apm.com, cov@codeaurora.org

Hi Alexey,

On 8/12/2016 11:42 AM, Alexey Klimov wrote:
> On Fri, Aug 12, 2016 at 10:27:55AM -0600, Prakash, Prashanth wrote:
>> Hi Alexey,
>>
>> On 8/12/2016 6:40 AM, Alexey Klimov wrote:
>>> Hi Prashanth,
>>>
>>> On Mon, Aug 08, 2016 at 06:09:56PM -0600, Prakash, Prashanth wrote:
>>>> Hi Alexey,
>>>>
>>>> On 7/26/2016 1:45 PM, Prashanth Prakash wrote:
>>>>> CPPC defined in section 8.4.7 of ACPI 6.0 specification suggests
>>>>> "To amortize the cost of PCC transactions, OSPM should read or write
>>>>> all PCC registers via a single read or write command when possible"
>>>>> This patch enables opportunistic batching of frequency transition
>>>>> requests whenever the request happen to overlap in time.
>>>>>
>>>>> Currently the access to pcc is serialized by a spin lock which does
>>>>> not scale well as we increase the number of cores in the system. This
>>>>> patch improves the scalability by allowing the differnt CPU cores to
>>>>> update PCC subspace in parallel and by batching requests which will
>>>>> reduce the certain types of operation(checking command completion bit,
>>>>> ringing doorbell) by a significant margin.
>>>>>
>>>>> Profiling shows significant improvement in the overall effeciency
>>>>> to service freq. transition requests. With this patch we observe close
>>>>> to 30% of the frequency transition requests being batched with other
>>>>> requests while running apache bench on a ARM platform with 6
>>>>> independent domains(or sets of related cpus).
>>>>>
>>>>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>>>>> Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
>>>>> ---
>>>>>  drivers/acpi/cppc_acpi.c | 176 +++++++++++++++++++++++++++++++++++++++--------
>>>>>  1 file changed, 147 insertions(+), 29 deletions(-)
>>>>>
>>>>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>>>>> index 93826c7..4a887d4 100644
>>>>> --- a/drivers/acpi/cppc_acpi.c
>>>>> +++ b/drivers/acpi/cppc_acpi.c
>>>>> @@ -40,15 +40,35 @@
>>>>>  #include <linux/cpufreq.h>
>>>>>  #include <linux/delay.h>
>>>>>  #include <linux/ktime.h>
>>>>> +#include <linux/rwsem.h>
>>>>> +#include <linux/wait.h>
>>>>>  
>>>>>  #include <acpi/cppc_acpi.h>
>>>>> +
>>>>>  /*
>>>>> - * Lock to provide mutually exclusive access to the PCC
>>>>> - * channel. e.g. When the remote updates the shared region
>>>>> - * with new data, the reader needs to be protected from
>>>>> - * other CPUs activity on the same channel.
>>>>> + * Lock to provide controlled access to the PCC channel.
>>>>> + *
>>>>> + * For performance critical usecases(currently cppc_set_perf)
>>>>> + *	We need to take read_lock and check if channel belongs to OSPM before
>>>>> + * reading or writing to PCC subspace
>>>>> + *	We need to take write_lock before transferring the channel ownership to
>>>>> + * the platform via a Doorbell
>>>>> + *	This allows us to batch a number of CPPC requests if they happen to
>>>>> + * originate in about the same time
>>>>> + *
>>>>> + * For non-performance critical usecases(init)
>>>>> + *	Take write_lock for all purposes which gives exclusive access
>>>>>   */
>>>>> -static DEFINE_SPINLOCK(pcc_lock);
>>>>> +static DECLARE_RWSEM(pcc_lock);
>>>>> +
>>>>> +/* Indicates if there are any pending/batched PCC write commands */
>>>>> +static bool pending_pcc_write_cmd;
>>>>> +
>>>>> +/* Wait queue for CPUs whose requests were batched */
>>>>> +static DECLARE_WAIT_QUEUE_HEAD(pcc_write_wait_q);
>>>>> +
>>>>> +/* Used to identify if a batched request is delivered to platform */
>>>>> +static unsigned int pcc_write_cnt;
>>>>>  
>>>> I haven't found a use-case(that would be used with CPPC) for POSTCHANGE
>>>> notification, that require us to be very accurate. Given that cpufreq_stats will not
>>>> be supported with CPPC and moreover CPPC protocol itself doesn't guarantee any
>>>> time bounds on when the actual request will be executed by the platform, I am
>>>> leaning towards getting rid of the wait queue that made sure delivery of request
>>>> to the platform before calling cpufreq_freq_transition_end, in the interest of better
>>>> performance and simpler code.
>>>>
>>>> Thoughts?
>>> Sorry for huge delay reacting on this.
>>>
>>> I was about to answer that everything looks ok apart from one minor change (not relevant
>>> now) but you put new comment that make me double-check everything again :)
>>>
>>> I don't have clear insight into how precise frequency change notifications should be
>>> (i guess it's main question) so I thought Rafael will comment on this. If Rafael will
>>> accept changes with potential out of time order notifications then it will be good to add
>>> noticeable comment about this at least.
>> Yes, I was planning to add a noticeable comment just in case in future we run into a
>> use case that need very precise notification(like upto single digit micro seconds).
>
> Good.
>
>>> About use-cases I see only two arguments for maintaining more or less precise notification
>>> arrival time:
>>> 1) Drivers and their friends that subscribed to such kind of notifications.
>>> Do they rely on accuracy?
>>> 2) EAS may rely on cpu freq change notification to be accurate. IIRC, EAS is not in
>>> mainline though.
>>>
>>> I suspect that platform's firmwares will split in two groups -- one group will only
>>> enqueue request to change freq and set command complete bit almost immediately and
>>> another group of firmwares will hold setting the cmd complete bit till real frequency
>>> change request be handled. I agree, we can't assume that cmd complete bit is set immediately
>>> after frequency was changed.
>>>
>>> Looks like we should make a trade-off.
>>>
>>> Rafael?
>> Sounds good. I will wait for Rafael's inputs and proceed accordingly.
> Hey Prashanth,
>
> If i remember correctly, CPPC/PCC has bit indicating error during execution of last command.
> Looks like current code doesn't detect it, right?
>
> Ideally if we detect error on cpu frequency change request we should go on error path and that
> error path should send PRE- and POST- notifications too (not only to local CPU but to others
> who "contributed" to shared mem). I didn't think over it but I hope it's possible to implement
> this with batching request.

To implement check for error bit we would need the wait queue based synchronization.
So, my initial comment about removing synchronized completion notification is no
longer valid :)

Since we not checking for error bit now, I will add another patch that introduces it.
I am planning to add a check for error bit in send_pcc_cmd().  So send_pcc_cmd() will
make sure the command is complete and then check for error bit. With this we can
remove the check for command completion bit from all other places and that should
make the code much simpler as well.

Sounds good?

Thanks,
Prashanth

> Best regards,
> Alexey
>
>


