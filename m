From: lists_acpi <lists_acpi@bigpizza.co.uk>
Subject: Re: Hardlock during boot on Supermicro C2SBA BIOS v1.1
Date: Mon, 07 Apr 2008 16:24:16 +0100
Message-ID: <47FA3CA0.4080400@bigpizza.co.uk>
References: <47F9DE3F.1050702@bigpizza.co.uk> <1207578108.4700.82.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 78-105-172-173.zone3.bethere.co.uk ([78.105.172.173]:54229 "EHLO
	debian.bigpizza.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751804AbYDGPYu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Apr 2008 11:24:50 -0400
Received: from [192.168.0.10] (unknown [192.168.0.10])
	by debian.bigpizza.co.uk (Postfix) with ESMTP id 132C82F06F
	for <linux-acpi@vger.kernel.org>; Mon,  7 Apr 2008 17:57:32 +0100 (BST)
In-Reply-To: <1207578108.4700.82.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Thomas Renninger wrote:
> On Mon, 2008-04-07 at 09:41 +0100, lists_acpi wrote:
>   
>> Hello all,
>>
>> I recently upgraded the BIOS to v1.1 on my Supermicro C2SBA and found 
>> that the system would hardlock on boot.  The last message printed on the 
>> screen was:
>>
>>     tbxface-0587 [00] tb_load_namespace : ACPI Tables successfully acquired
>>     
> >From another machine with 2.6.22 kernel:
>  tbxface-0587 [00] tb_load_namespace     : ACPI Tables successfully acquired
> evxfevnt-0091 [00] enable                : Transition to ACPI mode successful
> If your machine really freezes when switching to ACPI mode, I expect
> something goes wrong in the depth of SMM BIOS operations?
> Not much one can do from OS then..., still maybe something below helps.
>
>   
>> which lead me to think the problem was caused by some changes to the 
>> ACPI tables in the new version of the BIOS.  Booting the system with 
>> "acpi=off irqpoll" then allowed me to boot the system but the system 
>> would randomly drop off the network. 
>>     
> AFAIK it should still be possible to dump ACPI tables with acpidump?
>
> If yes, best is you do this with the working and the not working BIOS,
> open a bug on bugzilla.kernel.org and attach both.
>
>   
What format should I use to create the acpi dumps?  I know nothing of 
acpi tables so I don't know what information is useful to a developer.  
I tried "acpidump -o acpidump --binary" but was unable to disassemble it 
using iasl.  I then tried "acpidump --t DSDT -o acpidump_dsdt --binary" 
and was able to disassemble it using iasl. 

> Maybe pci=noacpi or noapic also helps instead of switching off whole
> acpi?
> Can you switch off Cstate/C1E/processor deeper sleep states in the new
> BIOS? Just a guess, maybe it's that?
>
>    Thomas
>
>   
When I get a free window with the machine I'll get the ACPI dumps for as 
many BIOS versions as I can and see if I can change the sleep state with 
the newest BIOS.

Thanks,

Steve.
