From: Tejun Heo <htejun@gmail.com>
Subject: Re: ACPI Exception triggered by pata_amd driver in 2.6.24, is this
 an ACPI bug?
Date: Fri, 26 Oct 2007 10:16:45 +0900
Message-ID: <47213FFD.8060507@gmail.com>
References: <35314.86.7.220.119.1193248814.squirrel@wmbeta.mxes.net> <1193309591.4590.271.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:4490 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752351AbXJZBQy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Oct 2007 21:16:54 -0400
Received: by rv-out-0910.google.com with SMTP id k20so640533rvb
        for <linux-acpi@vger.kernel.org>; Thu, 25 Oct 2007 18:16:53 -0700 (PDT)
In-Reply-To: <1193309591.4590.271.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: Andrew <andrew@nelless.net>, linux-acpi@vger.kernel.org

Thomas Renninger wrote:
> On Wed, 2007-10-24 at 19:00 +0100, Andrew wrote:
>> Hi,
>>
>> This is probably nothing since there seems to be no ill effects
>> but I thought someone should know because...well it bothers me.
>>
>> Heres a diff of the kernel boot log between 2.6.23 and 2.6.24:
>>
>>  scsi4 : pata_amd
>>  scsi5 : pata_amd
>> -ata5: PATA max UDMA/133 cmd 0x00000000000101f0 ctl 0x00000000000103f6 bmdma
>> 0x000000000001ffa0 irq 14
>> -ata6: PATA max UDMA/133 cmd 0x0000000000010170 ctl 0x0000000000010376 bmdma
>> 0x000000000001ffa8 irq 15
>> +ata5: PATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0xffa0 irq 14
>> +ata6: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xffa8 irq 15
>> +ACPI Exception (exoparg2-0442): AE_AML_PACKAGE_LIMIT, Index (0FFFFFFFF) is beyond end of
>> object [20070126]
>> +ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.GTM_] (Node
>> ffff810002001740), AE_AML_PACKAGE_LIMIT
>> +ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.CHN1._GTM] (Node
>> ffff810002001620), AE_AML_PACKAGE_LIMIT
>> +ata6: ACPI get timing mode failed (AE 0x300d)
>>  ata6.00: ATAPI: HL-DT-ST DVDRAM GSA-4167B, DL13, max UDMA/33
>>  ata6.00: configured for UDMA/33
> I doubt the ACPI interpreter broke between those kernels...
> Is this the same message as seen when _GTM/_STM were invoked in wrong
> order (or the one not invoked at all)?
> Tejun might be interested in this one...

ATA ACPI is now turned on by default.  It's quite likely that ATA part 
of the ACPI table on that machine is broken.  Can you try to update the 
BIOS?

-- 
tejun
