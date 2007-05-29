From: Steve Evans <steve@netwaynetworks.com.au>
Subject: (Intel Core 2 Duo 2.4gig 4meg cache + Intel S3000AH + Linux) - ACPI
 kernel option = 1 core?
Date: Tue, 29 May 2007 11:15:58 +1000
Message-ID: <465B7ECE.9010308@netwaynetworks.com.au>
References: <465B7B7C.7080002@netwaynetworks.com.au>
Reply-To: steve@netwaynetworks.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fwrdsl.netwaynetworks.com.au ([202.138.214.82]:46481 "EHLO
	mailserv.netwaynetworks.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751786AbXE2BQe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 May 2007 21:16:34 -0400
Received: from [10.99.99.42] (juggs [10.99.99.42])
	by mailserv.netwaynetworks.com.au (8.13.8/8.13.4) with ESMTP id l4T1FxDO011890
	for <linux-acpi@vger.kernel.org>; Tue, 29 May 2007 11:15:59 +1000
In-Reply-To: <465B7B7C.7080002@netwaynetworks.com.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hey guys

I've been configuring up a Linux 2.6.21.1 kernel from Linus' trusty 
kernel.org. 

I configured it up and built it and noticed that the dual core CPU I was 
using is now a single core chip.

I've spent alittle time on this problem and think I found out how to 
enable or disable the single core.  My base config is:
- Processor - SMP On
- Processor - SMT/Hyperthreading scheduler On
- Processor - Multicore scheduler On
- Processor - Optimize for any CPU type (ie P4, Core2, i586) or base 
system (ie BigSMB/summit or PC-compatible)
- Power management support On
- All other power management pieces turned off
- All other options are set standard by 'make mrproper'

I compile the kernel with ACPI off and I get 1 cpu/cpu-core. 

I then recompile with just the ACPI turned on (ie havn't turned on 
Processor, Fan or any other modules there) and I get to see my second core.

This server will be well ventilated and will be running multiple VM's.  
To guarantee performance I'd like to have ACPI turned off. 

I can also say that this bug seems to be present in 2.6.18 as well.

So I guess my question is, has this issue been fixed?  Or how can I help 
to fix it?

Cheers,
Steve
