From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/2] mce: acpi/apei: Honour Firmware First for MCA
 banks listed in APEI HEST CMC
Date: Fri, 21 Jun 2013 13:16:50 +0530
Message-ID: <51C404EA.10906@linux.vnet.ibm.com>
References: <20130619175438.2852.93449.stgit@localhost.localdomain> <20130620073943.GE32694@pd.tnic> <51C3531D.3000600@linux.vnet.ibm.com> <20130620192928.GD19877@pd.tnic> <51C36288.4050405@linux.vnet.ibm.com> <20130620205726.GA20863@pd.tnic> <51C37291.40303@linux.vnet.ibm.com> <20130621073419.GC22006@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e28smtp07.in.ibm.com ([122.248.162.7]:53707 "EHLO
	e28smtp07.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072Ab3FUHrE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Jun 2013 03:47:04 -0400
Received: from /spool/local
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
	Fri, 21 Jun 2013 13:10:06 +0530
In-Reply-To: <20130621073419.GC22006@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, ananth@in.ibm.com, masbock@linux.vnet.ibm.com, lcm@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, ying.huang@intel.com

On 06/21/2013 01:04 PM, Borislav Petkov wrote:
> On Fri, Jun 21, 2013 at 02:52:25AM +0530, Naveen N. Rao wrote:
>> Exactly, but mce_poll_banks also doesn't have bits set for banks on
>> which CMCI is enabled.
>>
>> Let's say we have a cpu with 2 banks (not shared), none of which work
>> in FF mode. Both these banks support CMCI, so mce_poll_banks won't
>> have these bits set.
>>
>> On cpu offline, we call cmci_clear() which disables CMCI on these two
>> banks before offlining it. When this cpu is brought online again, we
>> call cmci_discover() which sees that mce_poll_banks doesn't have these
>> two banks enabled and will skip enabling CMCI thinking these are in
>> FF.
>
> Hmm, mce_intel has yet another bitfield - mce_banks_owned. (Btw, this is
> why I have a problem with adding yet another bitfield).
>
> The way I understand it is, if a bit is set in the owned bitfield, those
> banks belong to CMCI and are not polled.
>
> Now, can we use both mce_banks_owned and mce_poll_banks? If a bit in
> both bifields is cleared, the corresponding bank is not polled *and* is
> not owned by CMCI => it is in FF mode.
>
> Makes sense?
>

Yes, but I'm afraid this won't work either - mce_banks_owned is cleared 
during cpu offline. This is necessary since a cmci rediscover is 
triggered on cpu offline, so that if this bank is shared across cores, a 
different cpu can claim ownership of this bank.

The difference between the new bitfield and the existing bitfields is 
that the new one is not per-cpu. This is a global list of banks across 
cpus that we do not want enabled.


Thanks,
Naveen

