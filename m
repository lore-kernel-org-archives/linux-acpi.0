From: Huang Ying <ying.huang@intel.com>
Subject: Re: [RFC 1/4] HWPoison: add memory_failure_queue()
Date: Thu, 21 Apr 2011 14:38:42 +0800
Message-ID: <4DAFD0F2.5080708@intel.com>
References: <1303177419-22466-1-git-send-email-ying.huang@intel.com> <20110420090305.GB3761@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:15425 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750858Ab1DUGio (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Apr 2011 02:38:44 -0400
In-Reply-To: <20110420090305.GB3761@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Wu, Fengguang" <fengguang.wu@intel.com>
Cc: Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, "Luck, Tony" <tony.luck@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>

Hi, Fengguang,

On 04/20/2011 05:03 PM, Wu, Fengguang wrote:
>> +	if (kfifo_put(&mf_cpu->fifo, &entry))
>> +		schedule_work_on(smp_processor_id(), &mf_cpu->work);
>> +	else
>> +		pr_err("Memory failure: buffer overflow when recovering memory failure at 0x%#lx\n",
>> +		       pfn);
> 
> nitpick: "buffer overflow when recording memory failure at PFN ..."?

Yes, in fact we are not recovering now.  Or "s/recording/queuing/"?

Best Regards,
Huang Ying
