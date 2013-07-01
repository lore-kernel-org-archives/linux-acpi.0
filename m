From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/2] mce: acpi/apei: Add a boot option to disable ff
 mode for corrected errors
Date: Mon, 01 Jul 2013 21:11:32 +0530
Message-ID: <51D1A32C.5060905@linux.vnet.ibm.com>
References: <20130621072725.GB22006@pd.tnic> <20130628120224.7781.45438.stgit@localhost.localdomain> <CA+8MBbJNY7G+q=kBgOA=+jVtugrfteoMvwLtfwvCno5xg+dm-Q@mail.gmail.com> <51D19B3F.3060405@linux.vnet.ibm.com> <20130701153805.GB23539@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147]:43136 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956Ab3GAPlm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Jul 2013 11:41:42 -0400
Received: from /spool/local
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
	Tue, 2 Jul 2013 01:35:27 +1000
In-Reply-To: <20130701153805.GB23539@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@gmail.com>, ananth@in.ibm.com, masbock@linux.vnet.ibm.com, lcm@linux.vnet.ibm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Huang Ying <ying.huang@intel.com>

On 07/01/2013 09:08 PM, Borislav Petkov wrote:
> On Mon, Jul 01, 2013 at 08:37:43PM +0530, Naveen N. Rao wrote:
>> On 06/28/2013 11:01 PM, Tony Luck wrote:
>>>> +                       if (sec_sev == GHES_SEV_CORRECTED &&
>>>> +                           (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED) &&
>>>> +                           (mem_err->validation_bits & CPER_MEM_VALID_PHYSICAL_ADDRESS)) {
>>>> +                               unsigned long pfn;
>>>> +                               pfn = mem_err->physical_addr >> PAGE_SHIFT;
>>>
>>> As Reagan said "Trust ... but verify" ... we should make sure BIOS
>>> gave us a good pfn
>>>                                      if (pfn_valid(pfn))
>>>                                           soft_memory_failure_queue(pfn, 0, 0);
>>>                                      else
>>>                                           printk( ...something about
>>> BIOS giving us bad pfn = %lu\n", pfn);
>>
>> Ah, nice catch - I thought soft_offline_page() takes care of this,
>> but it sure is good to point a finger at the firmware.
>
> While at it maybe make it pr_warning(FW_BUG or FW_WARN...

Yup - I've made it a pr_warning(FW_WARN... I just sent out a new version 
with these changes.

Thanks,
Naveen

