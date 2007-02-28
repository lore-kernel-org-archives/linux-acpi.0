From: Tejun Heo <htejun@gmail.com>
Subject: Re: Fw: ata-piix ACPI errors
Date: Thu, 01 Mar 2007 03:17:55 +0900
Message-ID: <45E5C753.106@gmail.com>
References: <20070223020856.641452a3.akpm@linux-foundation.org> <1172586557.10619.423.camel@d36.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.227]:60939 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932207AbXB1SR6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Feb 2007 13:17:58 -0500
Received: by wx-out-0506.google.com with SMTP id h31so213307wxd
        for <linux-acpi@vger.kernel.org>; Wed, 28 Feb 2007 10:17:57 -0800 (PST)
In-Reply-To: <1172586557.10619.423.camel@d36.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, Meelis Roos <mroos@linux.ee>, Adrian Bunk <bunk@stusta.de>

Hello, Thomas.

Thomas Renninger wrote:
> On Fri, 2007-02-23 at 02:08 -0800, Andrew Morton wrote:
>> I'm starting to think that big acpi merge came a bit too soon.
>>
>> Begin forwarded message:
>>
>> Date: Thu, 22 Feb 2007 15:29:42 +0200 (EET)
>> From: Meelis Roos <mroos@linux.ee>
>> To: Linux Kernel list <linux-kernel@vger.kernel.org>
>> Subject: ata-piix ACPI errors
>>
>>
>> Testbooted 2.6.21-rc1+todays git on a PC with Intel 845 chipset and PATA 
>> HDD. Works fine but I now have these ACPI errors in dmesg, maybe someone 
>> is interested:
>>
>> ata_piix 0000:00:1f.1: version 2.00ac7
>> PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
>> ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
>> PCI: Setting latency timer of device 0000:00:1f.1 to 64
>> ata1: PATA max UDMA/100 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x0001ffa0 irq 14
>> ata2: PATA max UDMA/100 cmd 0x00010170 ctl 0x00010376 bmdma 0x0001ffa8 irq 15
>> scsi0 : ata_piix
>> ACPI Error (dsopcode-0481): Attempt to CreateField of length zero [20070126]
>
> I expect this to be ACPI (interpreter) unrelated and the bug should be
> in drivers/ata/libata-acpi.c.
> The problem is that libata-acpi.c calls _GTF function before _STM has
> been called. This is forbidden by ACPI spec.

I can't find such wording in acpi 3.0a spec.  It says _STM may make
adjustments to the result of _GTF.  Hmmm... the suspend/resume order
does specify that _STM should be called before _GTF but nothing seems to
mandate use of _GTM and _STM.

I think libata-acpi has several issues here.

1. Missing _GTM/_STM support.  This is because mode programming is
essential to PATA controllers and we do it in more conventional way
(poking PCI / controller registers) regardless of ACPI, so this feature
is kind of redundant.

2. Doing _GTF on boot.  _GTF is supposed to configure the device as the
firmware would have configured it during a normal boot, so we shouldn't
be doing it during boot.  This too is in gray area as if we're doing
kexec, we might want to do _GTF during boot.

It would be the cleanest if _GTF can be modified by but doesn't depend
on _STM.  Oh, well, there seem to be enough motherboards out there hit
by this.  I'll cook something up.

Thanks.

-- 
tejun
