From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/2] mce: acpi/apei: Honour Firmware First for MCA
 banks listed in APEI HEST CMC
Date: Fri, 21 Jun 2013 02:52:25 +0530
Message-ID: <51C37291.40303@linux.vnet.ibm.com>
References: <20130619175438.2852.93449.stgit@localhost.localdomain> <20130620073943.GE32694@pd.tnic> <51C3531D.3000600@linux.vnet.ibm.com> <20130620192928.GD19877@pd.tnic> <51C36288.4050405@linux.vnet.ibm.com> <20130620205726.GA20863@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e28smtp08.in.ibm.com ([122.248.162.8]:47200 "EHLO
	e28smtp08.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758173Ab3FTVWg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Jun 2013 17:22:36 -0400
Received: from /spool/local
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
	Fri, 21 Jun 2013 02:44:05 +0530
In-Reply-To: <20130620205726.GA20863@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, ananth@in.ibm.com, masbock@linux.vnet.ibm.com, lcm@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, ying.huang@intel.com

On 06/21/2013 02:27 AM, Borislav Petkov wrote:
> On Fri, Jun 21, 2013 at 01:44:00AM +0530, Naveen N. Rao wrote:
>> This won't work across cpu offline/online, right? We will end up
>> _not_ enabling CMCI on certain banks where we should have.
>
> Huh, don't understand. cmci_discover runs on each CPU. After you've run
> hest_parse_cmc early during boot and cleared the mce_poll_banks bits,
> nothing will set them again so CPU hotplug doesn't matter...

Exactly, but mce_poll_banks also doesn't have bits set for banks on 
which CMCI is enabled.

Let's say we have a cpu with 2 banks (not shared), none of which work in 
FF mode. Both these banks support CMCI, so mce_poll_banks won't have 
these bits set.

On cpu offline, we call cmci_clear() which disables CMCI on these two 
banks before offlining it.  When this cpu is brought online again, we 
call cmci_discover() which sees that mce_poll_banks doesn't have these 
two banks enabled and will skip enabling CMCI thinking these are in FF.

Right?

>
>> Another thing: for hest_parse_cmc(), does the below look good?
>>
>>          cmc = (struct acpi_hest_ia_corrected *)hest_hdr;
>>          if (!cmc->enabled)
>>                  return 0;
>>
>> #define ACPI_HEST_PARSING_DONE 1
>>          /*
>>           * We expect HEST to provide a list of MC banks that
>>           * report errors in firmware first mode.
>>           */
>>          if (!(cmc->flags & ACPI_HEST_FIRMWARE_FIRST) ||
>> !cmc->num_hardware_banks)
>>                  return ACPI_HEST_PARSING_DONE;
>>
>> The return value doesn't really matter since we don't check it, but
>> returning an error looked like the wrong thing to do as well.
>
> I'd add a comment above the "return 1" statement to explain why I'm
> doing this. It is much more verbose even than a well-named macro :)

Okay :)

Thanks,
Naveen

