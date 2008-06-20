From: Cyrill Gorcunov <gorcunov@gmail.com>
Subject: Re: linux-next: Tree for June 13: IO APIC breakage on HP nx6325
Date: Fri, 20 Jun 2008 22:59:27 +0400
Message-ID: <20080620185927.GA11597@cvg>
References: <20080613232214.394fd6fd.sfr@canb.auug.org.au> <Pine.LNX.4.55.0806172206580.28110@cliff.in.clinika.pl> <200806172338.38318.rjw@sisk.pl> <200806180053.40044.rjw@sisk.pl> <Pine.LNX.4.55.0806180400070.28110@cliff.in.clinika.pl> <20080618190603.GB10431@cvg> <Pine.LNX.4.55.0806182308190.7802@cliff.in.clinika.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:58758 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752934AbYFTS7t (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 14:59:49 -0400
Received: by ug-out-1314.google.com with SMTP id h2so47874ugf.16
        for <linux-acpi@vger.kernel.org>; Fri, 20 Jun 2008 11:59:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0806182308190.7802@cliff.in.clinika.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Ingo Molnar <mingo@elte.hu>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

[Maciej W. Rozycki - Wed, Jun 18, 2008 at 11:36:16PM +0100]
| On Wed, 18 Jun 2008, Cyrill Gorcunov wrote:
| 
| > | 1. The 8259A interrupt actually escapes to the CPU somehow and is handled
| > |    as an ExtINTA interrupt.  This would make the code in check_timer()  
| > |    decide it has found a working configuration, while actually it has been
| > |    fooled.
| > 
| > Maciej, that is why we get 'received illegal vector'?
| > 
| > 	[  129.092151] APIC error on CPU1: 00(40)
| 
|  No, but that's an interesting observation, thank you -- well spotted!  
| 
|  ExtINTA stands for an "External INTA cycle" which is passed through from
| the CPU down to the system bus instead of being intercepted by the local
| APIC unit as usually.  In response to the INTA cycle one of the 8259A
| chips (either the master or the slave, depending on the source of the
| interrupt selected for handling) supplies the vector directly to the CPU
| through PCI (or whatever kind of bus links the legacy bridge with the host
| bridge) and then the FSB.  Therefore the vector bypasses all the APIC
| circuitry and cannot result in an APIC error interrupt.
| 
|  Instead the message quoted means an APIC input is misprogrammed
| somewhere.  This error happens if an interrupt is signalled to an unmasked
| APIC input which uses the Fixed or Lowest-Priority delivery mode and its
| vector implies priority below the minimum permitted, that is in the range
| from 0 to 15.
| 
|  We have code already in place in io_apic_{32,64}.c that can be used to
| find out the offender with a piece of code like this (#if 0 has to be
| deactivated for this to work and they may be bit rot bugs to be fixed):
| 
| int __init all_pic_dump(void)
| {
| 	int v = apic_verbosity;
| 
| 	apic_verbosity = APIC_DEBUG;
| 	print_IO_APIC();
| 	print_all_local_APICs();
| 	print_PIC();
| 	apic_verbosity = v;
| 
| 	return 0;
| }
| 
| late_initcall(all_pic_dump);
| 
| if somebody is willing to aid with debugging this problem.
| 
|   Maciej
| 

Thanks, Maciej,

i would really like to help... but I can't even hit this
bug on my laptop :(

		- Cyrill -
