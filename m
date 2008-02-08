From: Sebastian Smolorz <sesmo@gmx.net>
Subject: Re: ACPI fails on Panasonic Toughbook CF-52 - ACPI Error (exregion-0164):
 Could not map memory
Date: Fri, 08 Feb 2008 13:25:54 +0100
Message-ID: <47AC4A52.3010207@gmx.net>
References: <200802072341.16523.sesmo@gmx.net> <200802071815.11757.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:52412 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754526AbYBHMZ6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Feb 2008 07:25:58 -0500
In-Reply-To: <200802071815.11757.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Len Brown schrieb:
> On Thursday 07 February 2008 17:41, Sebastian Smolorz wrote:
>> Hi,
>>
>> I am not able to start the kernel on a Panasonic Toughbook CF-52 successfully 
>> with ACPI enabled. Only acpi=off or acpi=ht works. ACPI also fails with the 
>> latest linux-acpi-2.6 git checkout from today. The attached file 
>> failed_boot.txt shows the kernel log. After the last line the boot process 
>> does not proceed.
>>
>> Interestingly, I managed to boot the system twice a few days ago. The 
>> successful dmesg output shows the attached file dmesg_acpi_osi_test. It shows 
>> a lot of ACPI errors, though.
>>
>> Please let me know if you need more information or how I can help to debug 
>> this problem further.
> 
> ACPI Error (exregion-0164): Could not map memory at F7C1E118000001AC, size 1000 [20070126]
> ACPI Exception (evregion-0420): AE_NO_MEMORY, Returned by Handler for [SystemMemory] [20070126]
> 
> I saw these appear on my HP nx6325 due to some changes in the x86 tree last week.
> 
> I bisected it down to 
> 
> commit 266b9f8727976769e2ed2dad77ac9295f37e321e
> Author: Thomas Gleixner <tglx@linutronix.de>
> Date:   Wed Jan 30 13:34:06 2008 +0100
> 
>     x86: fix ioremap RAM check
> 
> and reported it to Ingo.
> He told me to test the latest x86 tree, which didn't have those messages.
> Subsequently, these messages went away in Linus' tree for the nx6325.
> 
> but at least my box booted, your panasonic failure is much more severe.
> 
> Please file a bug report here:
> http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
> 
> and attach the info you sent, plus the output from acpidump.

Done.

> Also, if you can bisect and check out the commit above to see
> if it was where things started to go bad, that would help.

The problem is that booting with ACPI enabled is not reproducable. I 
only managed to do it twice. ACPI failure appears also with plain kernel 
2.6.24 and 2.6.23.12 and these were before that commit.

-- 
Sebastian
