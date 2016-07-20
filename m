From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH 4/5] ACPI/CPPC: set a non-zero value for
 transition_latency
Date: Wed, 20 Jul 2016 17:44:12 -0600
Message-ID: <4013caab-6917-9340-7422-e640510d92a0@codeaurora.org>
References: <1467309758-26536-1-git-send-email-pprakash@codeaurora.org>
 <1467309758-26536-5-git-send-email-pprakash@codeaurora.org>
 <20160720155117.GA6572@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:35940 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290AbcGTXoQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Jul 2016 19:44:16 -0400
In-Reply-To: <20160720155117.GA6572@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Klimov <alexey.klimov@arm.com>
Cc: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, hotran@apm.com, cov@codeaurora.org

Hi Alexey,

On 7/20/2016 9:51 AM, Alexey Klimov wrote:
> Hi Prashanth,
>
> On Thu, Jun 30, 2016 at 12:02:37PM -0600, Prashanth Prakash wrote:
>> Compute the expected transition latency for frequency transitions
>> using the values from the PCCT tables when the desired perf
>> register is in PCC.
>>
>> Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
>> ---
>>  drivers/acpi/cppc_acpi.c       | 47 ++++++++++++++++++++++++++++++++++++++++--
>>  drivers/cpufreq/cppc_cpufreq.c |  1 +
>>  include/acpi/cppc_acpi.h       |  1 +
>>  3 files changed, 47 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index 8dee6d5..7844e4c 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -85,7 +85,7 @@ static void __iomem *pcc_comm_addr;
>>  static int pcc_subspace_idx = -1;
>>  static bool pcc_channel_acquired;
>>  static ktime_t deadline;
>> -static unsigned int pcc_mpar, pcc_mrtt;
>> +static unsigned int pcc_mpar, pcc_mrtt, pcc_nominal;
>>  
>>  /* pcc mapped address + header size + offset within PCC subspace */
>>  #define GET_PCC_VADDR(offs) (pcc_comm_addr + 0x8 + (offs))
>> @@ -462,7 +462,6 @@ static int register_pcc_channel(int pcc_subspace_idx)
>>  			return -ENODEV;
>>  		}
>>  
>> -
>>  		/*
>>  		 * cppc_ss->latency is just a Nominal value. In reality
>>  		 * the remote processor could be much slower to reply.
>> @@ -472,6 +471,7 @@ static int register_pcc_channel(int pcc_subspace_idx)
>>  		deadline = ns_to_ktime(usecs_lat * NSEC_PER_USEC);
>>  		pcc_mrtt = cppc_ss->min_turnaround_time;
>>  		pcc_mpar = cppc_ss->max_access_rate;
>> +		pcc_nominal = cppc_ss->latency;
>>  
>>  		pcc_comm_addr = acpi_os_ioremap(cppc_ss->base_address, cppc_ss->length);
>>  		if (!pcc_comm_addr) {
>> @@ -1034,3 +1034,46 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>>  	return ret;
>>  }
>>  EXPORT_SYMBOL_GPL(cppc_set_perf);
>> +
>> +/**
>> + * cppc_get_transition_latency - returns frequency transition latency in ns
>> + *
>> + * ACPI CPPC does not explicitly specifiy how a platform can specify the
>> + * transition latency for perfromance change requests. The closest we have
>> + * is the timing information from the PCCT tables which provides the info
>> + * on the number and frequency of PCC commands the platform can handle.
>> + */
>> +unsigned int cppc_get_transition_latency(int cpu_num)
>> +{
>> +	/*
>> +	 * Expected transition latency is based on the PCCT timing values
>> +	 * Below are definition from ACPI spec:
>> +	 * pcc_nominal- Expected latency to process a command, in microseconds
>> +	 * pcc_mpar   - The maximum number of periodic requests that the subspace
>> +	 *              channel can support, reported in commands per minute. 0
>> +	 *              indicates no limitation.
>> +	 * pcc_mrtt   - The minimum amount of time that OSPM must wait after the
>> +	 *              completion of a command before issuing the next command,
>> +	 *              in microseconds.
>> +	 */
>> +	unsigned int latency_ns = 0;
>> +	struct cpc_desc *cpc_desc;
>> +	struct cpc_register_resource *desired_reg;
>> +
>> +	cpc_desc = per_cpu(cpc_desc_ptr, cpu_num);
>> +	if (!cpc_desc)
>> +		return CPUFREQ_ETERNAL;
>> +
>> +	desired_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
>> +	if (!CPC_IN_PCC(desired_reg))
>> +		return CPUFREQ_ETERNAL;
>> +
>> +	if (pcc_mpar)
>> +		latency_ns = 60 * (1000 * 1000 * 1000 / pcc_mpar);
>> +
>> +	latency_ns = max(latency_ns, pcc_nominal * 1000);
>> +	latency_ns = max(latency_ns, pcc_mrtt * 1000);
> How transition latency is used?
transition latency ends up deciding the sampling_rate in case of ondemand
governor and in case of schedutil it sets up minimum period between 2 requests.
> If it is used in the sense of "wait this amount of time before sending next request"
> or this behaviour is inherited because of using this latency as a sample time,
> then I would say it should be a sum of pcc_nominal and pcc_mrtt here.
Yes, that makes sense. I will update it in next version, so we will have
latency_ns = max ( mrtt+nominal, value from mpar)

Thanks,
Prashanth
