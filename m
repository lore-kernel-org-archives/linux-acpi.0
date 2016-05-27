From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH] ACPI/CPPC: Support for batching CPPC requests
Date: Fri, 27 May 2016 11:49:43 -0600
Message-ID: <7d1abc8a-c6e0-9841-5c03-115efa2930c9@codeaurora.org>
References: <20160526220234.GA26524@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:52454 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932320AbcE0Rtq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 May 2016 13:49:46 -0400
In-Reply-To: <20160526220234.GA26524@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Klimov <alexey.klimov@arm.com>
Cc: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, ashwin.chaugule@linaro.org, hotran@apm.com



On 5/26/2016 4:02 PM, Alexey Klimov wrote:
> On Tue, May 17, 2016 at 12:39 AM, Prashanth Prakash <pprakash@codeaurora.org> wrote:
>> CPPC defined in section 8.4.7 of ACPI 6.1 specification suggests
>> "To amortize the cost of PCC transactions, OSPM should read or write
>> all PCC registers via a single read or write command when possible"
>> This patch enables opportunistic batching of frequency transition
>> requests whenever the request happen to overlap in time.
>>
>> Currently the access to pcc is serialized by a spin lock which does
>> not scale well as we increase the number of cores in the system. This
>> patch improves the scalability by allowing the differnt CPU cores to
>> update PCC subspace in parallel and by batching requests which will
>> reduce certain types of operation(checking command completion bit,
>> ringing doorbell) by a significant margin.
>>
>> Profiling shows significant improvement in the time to service freq.
>> transition request. Using a workload which includes multiple iteration
>> of configure+make of vim (with -j24 option):
>> Without batching requests(without this patch),
>>         6 domains: Avg=20us/request; 24 domains: Avg=52us/request
>> With batching requests(with this patch),
>>         6 domains: Avg=16us/request; 24 domains: Avg=19us/request
>> domain: An individual cpu or a set of related CPUs whose frequency can
>> be scaled independently
> With this approach sometimes you will send POSTCHANGE notifications about
> frequency change for some random CPUs before actual request to change
> frequency was sent (and received?) through PCC channel.
> Depending on platform/firmware/configuration this time difference might be high.
>
> How vital or important is to have POSTCHANGE notification in correct time
> order?  
Good catch. Yeah, we could end up notifying POSTCHANGE prior to ringing the doorbell.
I haven't thought about this a lot and not sure if there are clients that rely on the
accuracy of the notification.

Anyways, I suppose we can make cppc_set_perf return a value to indicate if a request
was delivered (i.e doorbell was rang) or batched (request updated, but doorbell will
be rung by a different CPU).  Using this return value cppc_cpufreq_set_target can
notify all the pending CPUs at once or queue to be notified. Sounds reasonable?

Also, if we think about CPPC, since we don't have a way to know exactly when platform
did the frequency/voltage transition, I suppose POSTCHANGE will be a little out of
order :)

Thanks,
Prashanth

> Best regards,
> Alexey.
>

