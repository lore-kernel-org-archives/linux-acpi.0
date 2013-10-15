From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 8/8] ACPI / trace: Add trace interface for eMCA driver
Date: Tue, 15 Oct 2013 23:00:53 +0530
Message-ID: <525D7BCD.7080303@linux.vnet.ibm.com>
References: <1381473166-29303-1-git-send-email-gong.chen@linux.intel.com> <1381473166-29303-9-git-send-email-gong.chen@linux.intel.com> <20131015165435.GA2777@naverao1-tp.ibm.com> <20131015170039.GF7908@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e28smtp01.in.ibm.com ([122.248.162.1]:56779 "EHLO
	e28smtp01.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758936Ab3JORbM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Oct 2013 13:31:12 -0400
Received: from /spool/local
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
	Tue, 15 Oct 2013 23:01:09 +0530
In-Reply-To: <20131015170039.GF7908@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Chen, Gong" <gong.chen@linux.intel.com>, tony.luck@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, m.chehab@samsung.com

On 10/15/2013 10:30 PM, Borislav Petkov wrote:
> On Tue, Oct 15, 2013 at 10:24:35PM +0530, Naveen N. Rao wrote:
>> On 2013/10/11 02:32AM, Chen Gong wrote:
>>> Use trace interface to elaborate all H/W error related
>>> information.
>>>
>>> Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
>>> ---
>> <snip>
>>> +TRACE_EVENT(extlog_mem_event,
>>> +	TP_PROTO(u32 etype,
>>> +		char *dimm_loc,
>>> +		const uuid_le *fru_id,
>>> +		char *fru_text,
>>> +		u64 error_count,
>>> +		u32 severity,
>>> +		u64 phy_addr,
>>> +		char *mem_loc),
>>
>> [Adding Mauro...]
>>
>> This looks very similar to the trace event I wrote a while back,
>> which was similar to the one provided by ghes_edac:
>> http://thread.gmane.org/gmane.linux.kernel.pci/24616
>>
>> Seems to me this has the same issues we previously discussed w.r.t
>> EDAC conflicts...
>
> Right, I'm inclined to leave this trace_mc_event in ras_event.h to edac
> use alone because of all those layers which don't mean whit for GHES and
> eMCA error sources.
>
> And maybe define a trace_mem_event which is shared by GHES and eMCA and
> not use the edac tracepoint there not load ghes_edac on such systems
> which have sufficient decoding capability in firmware.
>
> Thoughts?

I thought the primary problem was the conflict with edac core itself. 
So, if I'm not mistaken, we would have to prevent all edac drivers from 
loading.

Thanks,
Naveen

