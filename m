From: David Giddy <d.giddy@bigpond.com>
Subject: Help request on S3 resume problems
Date: Tue, 16 May 2006 05:13:16 +0000 (UTC)
Message-ID: <loom.20060516T071205-244@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:16578 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751406AbWEPFZJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 May 2006 01:25:09 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Ffs3K-0005am-E0
	for linux-acpi@vger.kernel.org; Tue, 16 May 2006 07:25:03 +0200
Received: from CPE-155-143-208-3.vic.bigpond.net.au ([155.143.208.3])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Tue, 16 May 2006 07:25:02 +0200
Received: from d.giddy by CPE-155-143-208-3.vic.bigpond.net.au with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Tue, 16 May 2006 07:25:02 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I'm relatively new to ACPI and am having problems trying to get wake on LAN 
working from S3. I have managed to successfully get the machine to resume from 
S3 using the power button, and also to get the machine to wakeup using a magic 
packet, but not to a working state.

The machine is a small server running Debian Sarge with kernel version 
2.6.16.16 and the corresponding ACPI patch set. It has two Gigabit LAN ports 
(one on the motherboard - a Realtek 8110 and the other an Intel PRO 1000/MT 
PCI card). The e1000 driver has been patched according to bugzilla bug 5609.

The symptoms are that I put the machine to sleep 
(echo -n mem >/sys/power/state), send it a magic packet, the machine comes to 
life but there is no screen, no keyboard response and no response to ping. It 
seems to be off with the fairys.

The video card is Nvidia, but I have used the latest nvidia drivers (version 
1.0-8756), and these work fine for resume from S3 using the power button.

The one question mark I have is that /proc/acpi/wakeup has the following 
entries:

Device	Sleep state		status
PCI0			4		enabled
HUB0			4		enabled
USB0			3		disabled
USB1			3		disabled
USB2			3		disabled
USB3			3		disabled
USBE			3		disabled

Given I am trying to wake from S3, is this correct ? Do I need to/is it 
possible to change the wakeup state to S3 for the PCI0/HUB0 lines ? Note that 
enabling PCI0 enables HUB0 as well (not sure what the latter actually is, but 
there is a message saying that they share the same GPE).

Any suggestions on what's going on and how to fix it would be appreciated.

Regards,

David.
 


