From: Len Brown <lenb@kernel.org>
Subject: Re: ACPI fails on Panasonic Toughbook CF-52 - ACPI Error (exregion-0164): Could not map memory
Date: Thu, 7 Feb 2008 18:15:11 -0500
Message-ID: <200802071815.11757.lenb@kernel.org>
References: <200802072341.16523.sesmo@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35630 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757131AbYBGXP3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Feb 2008 18:15:29 -0500
In-Reply-To: <200802072341.16523.sesmo@gmx.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sebastian Smolorz <sesmo@gmx.net>
Cc: linux-acpi@vger.kernel.org

On Thursday 07 February 2008 17:41, Sebastian Smolorz wrote:
> Hi,
> 
> I am not able to start the kernel on a Panasonic Toughbook CF-52 successfully 
> with ACPI enabled. Only acpi=off or acpi=ht works. ACPI also fails with the 
> latest linux-acpi-2.6 git checkout from today. The attached file 
> failed_boot.txt shows the kernel log. After the last line the boot process 
> does not proceed.
> 
> Interestingly, I managed to boot the system twice a few days ago. The 
> successful dmesg output shows the attached file dmesg_acpi_osi_test. It shows 
> a lot of ACPI errors, though.
> 
> Please let me know if you need more information or how I can help to debug 
> this problem further.

ACPI Error (exregion-0164): Could not map memory at F7C1E118000001AC, size 1000 [20070126]
ACPI Exception (evregion-0420): AE_NO_MEMORY, Returned by Handler for [SystemMemory] [20070126]

I saw these appear on my HP nx6325 due to some changes in the x86 tree last week.

I bisected it down to 

commit 266b9f8727976769e2ed2dad77ac9295f37e321e
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Wed Jan 30 13:34:06 2008 +0100

    x86: fix ioremap RAM check

and reported it to Ingo.
He told me to test the latest x86 tree, which didn't have those messages.
Subsequently, these messages went away in Linus' tree for the nx6325.

but at least my box booted, your panasonic failure is much more severe.

Please file a bug report here:
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI

and attach the info you sent, plus the output from acpidump.

Also, if you can bisect and check out the commit above to see
if it was where things started to go bad, that would help.

thanks,
-Len



