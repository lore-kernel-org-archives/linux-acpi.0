From: Zhao Yakui <yakui.zhao@intel.com>
Subject: a problem about the the patch in the comment #118 of bug 10724
Date: Fri, 05 Sep 2008 09:51:50 +0800
Message-ID: <1220579510.4007.178.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53635 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752035AbYIEBh6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Sep 2008 21:37:58 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: astarikovskiy@suse.de
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

Hi, Alexey
    
    Maybe you misunderstand what I have done in the patch of bug 10724. 
    We should firstly make it clear why there exists EC GPE interrupt storm on some laptops. EC controller
uses the pulse interrupt model to trigger GPE interrupt and EC GPE is registered as Edge mode.
    If the EC interrupt pulse is too wide on some broken BIOS, several ACPI interrupts are triggered
although only one EC interrupt pulse is generated. Maybe on some broken BIOS the situation will be more serious.And
when EC GPE handler is served, OS will check the EC status by reading the EC status I/O port. On most laptops the 
EC and other controller(Keyboard, UART) are accessed through LPC bus. If the EC GPE interrupt is triggered too many times
( For example: 50000 per second), too much bandwith of LPC bus will be wasted on reading the EC status register. 
On the bug 9998 it causes that sometimes the keystrobes are lost. Sometimes it will cause that the info of the 
battery/SBS battery related with EC can't be obtained.
    
    If we can add some delays on the EC GPE handler, the number of EC GPE interrupt can be reduced very obviously, which 
makes the system work well. For example: the laptop in bug 9998 can work well and the EC working flowchart is also simple.

    My patch is only for the broken BIOS. For most laptops no delay is added in the EC GPE handler. 
    Only when five EC GPE interrupts happens in the same jiffies and the EC status is the same, OS will add some delay in 
the EC GPE handler. If the same thing still happens after the delay is added, the delay time will be increased. 
But the max delay time is 5 microseconds.
    
    At the same time IMO udelay is harmless. It is realized by repeat loop instead of halt. 

    
Thanks
   Yakui

    
    


