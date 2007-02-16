From: Corey Minyard <minyard@acm.org>
Subject: Re: acpi_find_bmc() and acpi_get_table()
Date: Thu, 15 Feb 2007 23:15:10 -0600
Message-ID: <45D53DDE.5000300@acm.org>
References: <200702102327.28312.lenb@kernel.org> <200702152103.54960.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mta9.adelphia.net ([68.168.78.199]:47699 "EHLO
	mta9.adelphia.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423254AbXBPFPR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Feb 2007 00:15:17 -0500
In-Reply-To: <200702152103.54960.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, minyard@mvista.com, linux-acpi@vger.kernel.org

Bjorn Helgaas wrote:
> On Saturday 10 February 2007 21:27, Len Brown wrote:
>   
>> acpi_find_bmc() appears to be searching for 
>> multiple SPMI tables in the RSDT and running
>> try_init_acpi() on each of them
>> until it doesn't find any more.
>>     
>
> I can't remember why we look at the SPMI table(s) rather than
> registering a normal ACPI (or even PNP) driver.  Unless we
> need to poke the BMC very early, wouldn't it be better to
> rely on the device description in the namespace?
>   
For some strange reason the normal ACPI information does not
have all the information needed by the driver.  It doesn't have
register size or spacing information.

-Corey
