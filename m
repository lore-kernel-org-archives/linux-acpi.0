From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: WARNING at kernel/workqueue.c:829 wq_worker_waking_up+0x53/0x70()
Date: Fri, 21 Feb 2014 10:34:22 +0800
Message-ID: <5306BB2E.7010007@intel.com>
References: <20140213124059.GA2908@krava.brq.redhat.com> <20140217171900.GB29173@redhat.com> <20140218224907.GG31892@mtj.dyndns.org> <530602FA.1020103@intel.com> <20140220143102.GA12948@krava.brq.redhat.com> <5306150C.4020202@intel.com> <20140220151317.GA32719@redhat.com> <20140220151721.GB32719@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:54335 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751845AbaBUCeS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Feb 2014 21:34:18 -0500
In-Reply-To: <20140220151721.GB32719@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>, Tejun Heo <tj@kernel.org>, Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 02/20/2014 11:17 PM, Oleg Nesterov wrote:
> On 02/20, Oleg Nesterov wrote:
>>
>> On 02/20, Lan Tianyu wrote:
>>>
>>> @@ -1096,7 +1112,6 @@ int acpi_processor_set_throttling(struct acpi_processor *pr,
>>>   		return -ENODEV;
>>>   	}
>>>
>>> -	cpumask_copy(saved_mask, &current->cpus_allowed);
>>
>> Yes, but the patch forgets to kill alloc_cpumask_var(&saved_mask)
>> and saved_mask itself ;
>
> And it seems that acpi_processor_set_throttling() doesn't need
> online_throttling_cpus at all. It could use
> for_each_cpu_and(cpu_online_mask, p_throttling->shared_cpu_map).
>


Yes, oops and will update soon. Thanks.


> Oleg.
>


-- 
Best Regards
Tianyu Lan
