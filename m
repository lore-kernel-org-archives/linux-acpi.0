From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [Patch 0/4]  ACPI : several patches for EC
Date: Mon, 03 Nov 2008 16:52:11 +0800
Message-ID: <1225702331.26020.49.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:46998 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754594AbYKCIpj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 3 Nov 2008 03:45:39 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, astarikovskiy@suse.de

Hi, All
 
    Two people report the following warning messages on the 2.6.28-rc2 kernel.    
    >ACPI: EC: missing confirmations, switch off interrupt mode.
    >ACPI Exception (evregion-0419): AE_TIME, Returned by Handler for
[EmbeddedControl] [20080926]
    (One happens on Asus EEEPC901. Another happens on HP laptop).
     The info on eeepc901 can be found in 
    http://marc.info/?l=linux-acpi&m=122514911228758&w=2
    The detailed info about HP laptop can be found in 
     http://marc.info/?t=122491944100001&r=1&w=2
    
    
    The following is the patch set that is to fix the above issue.
    Patch 01: EC transaction is explicitly divided into different phases. 
And EC access is realized in process context. 
    At the same time EC driver will be started in EC GEP mode. And when 
there is no EC GPE confirmation for some EC transaction on some broken laptops,
the EC driver will be switched to polling mode. But EC GPE is still enabled.
    
    Patch 02: Add the 2 us delay before starting check EC status while in 
polling mode
      According to the ACPI spec when the host writes data to the command or data
register of the embedded controller, the input buffer flag (IBF) in the
status register is set within 1 microsecond.  On most laptosp it
is unnecessary to add the delay as EC device is connected with the slow
peripherial bus.
      But it is safe to add the delay of 2 microseconds before starting loop
check the EC status while EC is in polling mode.

    Patch 03: Add some delay in EC GPE handler to avoid EC interrupt storm on some
broken BIOS.
     The delay won't be added for most laptops.Only when more than five
interrupts happen in the same jiffies and EC status are the same, OS will add
some delay in the EC GPE handler. If the same issue still happens after adding
delay,the delay time will be increased.But the max delay time is ten
microseconds.
    Patch 04: EC cleanup: delete the unused code after the above three patches are applied

    After applying the patch, the problem disappears on ASUS EEEPC901 and HP laptop.

Welcome the comments.


Best regards.
  Yakui


