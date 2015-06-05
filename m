From: "Zhang, Jonathan Zhixiong" <zjzhang@codeaurora.org>
Subject: Re: [PATCH V2 3/3] acpi, apei: use EFI memmap to map GHES memory
Date: Fri, 05 Jun 2015 14:43:27 -0700
Message-ID: <557217FF.9000508@codeaurora.org>
References: <1433185940-24770-1-git-send-email-zjzhang@codeaurora.org> <1433185940-24770-4-git-send-email-zjzhang@codeaurora.org> <20150605095701.GA20042@codeblueprint.co.uk> <20150605102556.GC3679@pd.tnic> <5571D6C9.10903@codeaurora.org> <20150605171210.GM3679@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:45884 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726AbbFEVna (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Jun 2015 17:43:30 -0400
In-Reply-To: <20150605171210.GM3679@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Matt Fleming <matt@codeblueprint.co.uk>, rjw@rjwysocki.net, lenb@kernel.org, ying.huang@intel.com, leif.lindholm@linaro.org, al.stone@linaro.org, fu.wei@linaro.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linaro-acpi@lists.linaro.org, vgandhi@codeaurora.org, Tony Luck <tony.luck@gmail.com>



On 6/5/2015 10:12 AM, Borislav Petkov wrote:
> On Fri, Jun 05, 2015 at 10:05:13AM -0700, Zhang, Jonathan Zhixiong wrote:
>>> What is DDR?
>>>
>>> I think this needs to be clarified first before we go any further.
>> I thought the word "memory" might be confusing, because there are
>
> So you mean normal RAM here?
Yes, exactly. I should use this word RAM instead.
>
>> memories on the system that is not accessible by Linux. In this
>> context, the APEI error data is accessed (read and write) by both Linux
>> and platform firmware; hence both sides should access the memory using
>> same cache attribute. I wanted to emphasize the idea that even though
>> normally DDR is cachable, but in this case when platform access it with
>> un-cached attribute, Linux should do the same.
>
> Makes sense.
>
> Btw, do we need synchronization between firmware and Linux then? Does
> Linux need to know when it is ok to touch that memory?
Good question. Linux zeros out error status code in the error data
after the data is consumed, this is good; but it alone does not solve
the synchronization concern.

For interrupt notification type (SCI or NMI) error source, this may not
be an issue since both sides can operate under the rule that the error
data is only overwritten but never appended. But what about poll
notification type? In this case, platform gathers error, updates the
memory region as needed; Linux checks the same memory region
periodically.

An ACPI APEI proposal intended to solve this concern has been discussed
in UEFI forum. The idea is to have OS to send platform a signal (through
updating a designated register) after error data is consumed. Therefore,
when OS is accessing the memory region, platform does not try to access
the same memory region in the mean time.

After this proposal is approved and published, I will submit a patch
to implement it.

-- 
Jonathan (Zhixiong) Zhang
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
