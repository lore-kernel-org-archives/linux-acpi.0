From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: acpi_find_bmc() and acpi_get_table()
Date: Tue, 20 Feb 2007 09:46:09 +0300
Message-ID: <45DA9931.80605@linux.intel.com>
References: <200702102327.28312.lenb@kernel.org> <200702152103.54960.bjorn.helgaas@hp.com> <45D53DDE.5000300@acm.org> <200702192131.52947.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:39841 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964797AbXBTGqQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Feb 2007 01:46:16 -0500
In-Reply-To: <200702192131.52947.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Corey Minyard <minyard@acm.org>, Len Brown <lenb@kernel.org>, minyard@mvista.com, linux-acpi@vger.kernel.org

Bjorn Helgaas wrote:
> On Thursday 15 February 2007 22:15, Corey Minyard wrote:
>   
>> Bjorn Helgaas wrote:
>>     
>>> On Saturday 10 February 2007 21:27, Len Brown wrote:
>>>   
>>>       
>>>> acpi_find_bmc() appears to be searching for 
>>>> multiple SPMI tables in the RSDT and running
>>>> try_init_acpi() on each of them
>>>> until it doesn't find any more.
>>>>     
>>>>         
>>> I can't remember why we look at the SPMI table(s) rather than
>>> registering a normal ACPI (or even PNP) driver.  Unless we
>>> need to poke the BMC very early, wouldn't it be better to
>>> rely on the device description in the namespace?
>>>   
>>>       
>> For some strange reason the normal ACPI information does not
>> have all the information needed by the driver.  It doesn't have
>> register size or spacing information.
>>     
>
> I guess that would be a defect in the way ACPI is being used,
> wouldn't it?  A PNP ID should define the device programming
> model, including things like register size and spacing.  It
> sounds like somebody didn't define a new PNP ID when he should
> have.  I wonder whether it's worth trying to fix this.
>
>   
Yes, it is considered an ACPI fault. Could you please describe in 
detail, which registers miss the information? And probably your acpidump 
will help as well.
> Bjorn
> -
>   
Thanks,
    Alex.
