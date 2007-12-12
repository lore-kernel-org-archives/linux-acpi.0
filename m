From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: 2.6.24-rc4-mm1: acpi reboots machine... solved
Date: Wed, 12 Dec 2007 13:38:01 +0300
Message-ID: <475FBA09.7060907@gmail.com>
References: <20071209075001.GA4686@gollum.tnic> <200712111300.24841.bjorn.helgaas@hp.com> <20071211205255.GB5013@gollum.tnic> <200712111709.00313.bjorn.helgaas@hp.com> <20071212101123.GA5619@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:18525 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758622AbXLLKhX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Dec 2007 05:37:23 -0500
Received: by ug-out-1314.google.com with SMTP id z38so516975ugc.16
        for <linux-acpi@vger.kernel.org>; Wed, 12 Dec 2007 02:37:17 -0800 (PST)
In-Reply-To: <20071212101123.GA5619@gollum.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: bbpetkov@yahoo.de, Bjorn Helgaas <bjorn.helgaas@hp.com>, Andrew Morton <akpm@linux-foundation.org>, len.brown@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Borislav Petkov wrote:
> On Tue, Dec 11, 2007 at 05:08:59PM -0700, Bjorn Helgaas wrote:
>   
>> On Tuesday 11 December 2007 01:52:55 pm Borislav Petkov wrote:
>>     
>>> From what i can roughly tell so far it seems like an resource conflict between acpi and
>>> the pnp requested regions in your patch which result in the acpi_thermal code
>>> to read the wrong (0xff) temperature value and halt the machine, but i might be
>>> wrong on the details since acpi is such a big code chunk to swallow.
>>>       
>> I don't see any obvious conflict from the log you posted.  For the sake
>> of comparison, can you post the corresponding dmesg log after you removed
>> the patch?
>>     
>
> The only difference i see is that ACPI finds EC in DSDT in the working kernel
> and in the broken case something silently fails. Please find attached the 2 bootlogs
> and a disassembled DSDT.
>
>   
This seems to be the start of trouble...
    PCI: Cannot allocate resource region 4 of device 0000:00:1f.3

