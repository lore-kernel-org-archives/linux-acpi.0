From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/2] mce: acpi/apei: Honour Firmware First for MCA
 banks listed in APEI HEST CMC
Date: Fri, 21 Jun 2013 15:02:04 +0530
Message-ID: <51C41D94.1030201@linux.vnet.ibm.com>
References: <20130619175438.2852.93449.stgit@localhost.localdomain> <20130620073943.GE32694@pd.tnic> <51C3531D.3000600@linux.vnet.ibm.com> <20130620192928.GD19877@pd.tnic> <51C36288.4050405@linux.vnet.ibm.com> <20130620205726.GA20863@pd.tnic> <51C37291.40303@linux.vnet.ibm.com> <20130621073419.GC22006@pd.tnic> <51C404EA.10906@linux.vnet.ibm.com> <20130621083608.GE22006@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:34732 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758487Ab3FUJcS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Jun 2013 05:32:18 -0400
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
	Sat, 22 Jun 2013 06:28:38 +1000
In-Reply-To: <20130621083608.GE22006@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, ananth@in.ibm.com, masbock@linux.vnet.ibm.com, lcm@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, ying.huang@intel.com

On 06/21/2013 02:06 PM, Borislav Petkov wrote:
> On Fri, Jun 21, 2013 at 01:16:50PM +0530, Naveen N. Rao wrote:
>> Yes, but I'm afraid this won't work either - mce_banks_owned is
>> cleared during cpu offline. This is necessary since a cmci
>> rediscover is triggered on cpu offline, so that if this bank is
>> shared across cores, a different cpu can claim ownership of this
>> bank.
>
> What for? Sounds strange to me.

Look at section "15.5.1 CMCI Local APIC Interface" from Intel SDM Vol. 
3, and the subsequent section on "System Software Recommendation for 
Managing CMCI and Machine Check Resources":
"For example, if a corrected bit error in a cache shared by two logical 
processors caused a CMCI, the interrupt will be delivered to both 
logical processors sharing that microarchitectural sub-system."

In other words, some of the MC banks are shared across logical cpus in a 
core and some across all cores in a package. During initialization, the 
first cpu in a core ends up owning most of the banks specific to the 
core/package. When this cpu is offlined, we would want the second cpu in 
that core to discover and enable CMCI for those MC banks which it shares 
with the first cpu.

As an example, consider a hypothetical single-core Intel processor with 
Hyperthreading. On init, let's say the first cpu ends up owning banks 1, 
2, 3 and 4; and the second cpu ends up owning banks 1 and 2. This would 
mean that MC banks 1 and 2 are "hyperthread"-specific, while banks 3 and 
4 are shared. Now, if we offline the first cpu, it disables CMCI on all 
4 banks. However, banks 3 and 4 are shared. So, if we now do a cmci 
rediscovery, the second cpu will see that banks 3 and 4 don't have CMCI 
enabled and will then claim ownership of those so that we can continue 
to receive and process CMCIs from those subsystems.

Makes sense now?


Thanks,
Naveen

