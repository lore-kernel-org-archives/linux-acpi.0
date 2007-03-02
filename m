From: =?ISO-8859-1?Q?Eduard_Gim=E9nez_Cerd=E0?= <edu@badopi.org>
Subject: C-States usage on 2.6.18 is ok, but fails on 2.6.{19,20,20.1} (was: C-States Usage/Accounting)
Date: Fri, 2 Mar 2007 11:11:57 +0100
Message-ID: <9DBD4DED-A68A-4E4B-8D02-04AAEAB99171@badopi.org>
References: <FE6DEEF0-61B3-44D4-AA62-E8CE04C7FD8E@badopi.org> <45DDEF99.40102@tzi.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:8998 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422999AbXCBKMC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Mar 2007 05:12:02 -0500
Received: by ug-out-1314.google.com with SMTP id 44so650380uga
        for <linux-acpi@vger.kernel.org>; Fri, 02 Mar 2007 02:12:01 -0800 (PST)
In-Reply-To: <45DDEF99.40102@tzi.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


On 22 Feb 2007, at 20:31, Janosch Machowinski wrote:

>
> Actually is could be, that nothing is broken. If the bios does not  
> export more than one C-State, than everything is (from the view of  
> linux) ok. If you want to find out, what C-States are exported by  
> the bios, decompile your DSDT (can be found under /proc/acpi/dsdt)  
> with the  IASL compiler (http://www.intel.com/technology/iapc/acpi/ 
> license2.htm), and search in the decompiled version for _CST. More  
> information about the _CST object can be found in the ACPI- 
> Specification (www.acpi.info)

That was just the problem. I upgraded the BIOS and now it provides C1  
and C2. And the 2.6.18 kernel is using them.

egimenez@watt:~$ dmesg | grep "power states"
ACPI: CPU0 (power states: C1[C1] C2[C2])

But still there are a couple of strange quirks.

First the DSDT does not provide the _CST object, so I suppose the  
kernel is using the P_LVL method. Another BIOS problem... :S

The second one intrigues me more. The 2.6.19, 2.6.20 and 2.6.20.1  
kernels does not use nor show the C1 and C2 states. I've been using  
the same config file with oldconfig and I've removed problematic  
drivers, such as USB.

I would like to solve this behaviour, or at least to find why is  
happening. I will start reviewing the dmesg output for each kernel,  
to see what changes. Any advice on what and where look for will be  
really welcomed :)

--  

edu
