From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/2] mce: acpi/apei: Add a boot option to disable ff
 mode for corrected errors
Date: Wed, 19 Jun 2013 23:47:47 +0530
Message-ID: <51C1F5CB.9020005@linux.vnet.ibm.com>
References: <20130619175438.2852.93449.stgit@localhost.localdomain> <20130619175728.2852.73156.stgit@localhost.localdomain> <20130619180441.GK28300@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e28smtp02.in.ibm.com ([122.248.162.2]:59863 "EHLO
	e28smtp02.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934566Ab3FSSR5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Jun 2013 14:17:57 -0400
Received: from /spool/local
	by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
	Wed, 19 Jun 2013 23:40:12 +0530
In-Reply-To: <20130619180441.GK28300@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, ananth@in.ibm.com, masbock@linux.vnet.ibm.com, lcm@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, ying.huang@intel.com

On 06/19/2013 11:34 PM, Borislav Petkov wrote:
> On Wed, Jun 19, 2013 at 11:27:42PM +0530, Naveen N. Rao wrote:
>> Add a boot option to disable firmware first mode for corrected errors.
>>
>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>> ---
>>   Documentation/x86/x86_64/boot-options.txt |    5 +++++
>>   arch/x86/include/asm/acpi.h               |    2 ++
>>   arch/x86/kernel/acpi/boot.c               |    5 +++++
>>   drivers/acpi/apei/hest.c                  |    3 ++-
>>   4 files changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/x86/x86_64/boot-options.txt b/Documentation/x86/x86_64/boot-options.txt
>> index e9e8ddb..1228b22 100644
>> --- a/Documentation/x86/x86_64/boot-options.txt
>> +++ b/Documentation/x86/x86_64/boot-options.txt
>> @@ -176,6 +176,11 @@ ACPI
>>
>>     acpi=noirq	Don't route interrupts
>>
>> +  acpi=nocmcff	Disable firmware first mode for corrected errors. This
>> +		disables parsing the HEST CMC error source to check if
>> +		firmware has set the FF flag. This may result in
>> +		duplicate corrected error reports.
>
> Interesting, why? Why would we even need such an option? My impression
> is, if ACPI tells us FF, MCE code doesn't poll those banks anymore. So
> where do the duplicated reports come from?

This option is a way to revert to the existing behavior where we 
continue to enable CMCI/poll. If we enable this option, then we will 
receive error events from CMCI/polling as well as from the firmware 
through GHES.


Thanks,
Naveen

