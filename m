From: Andreas Saur <saur@acmelabs.de>
Subject: Re: 2.6.17-rc4-mm3 - kernel panic
Date: Fri, 26 May 2006 23:14:35 +0000
Message-ID: <44778BDB.5010402@acmelabs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from natnoddy.rzone.de ([81.169.145.166]:39844 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S1751680AbWEZXNy
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 26 May 2006 19:13:54 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, kristen.c.accardi@intel.com

Hello Kristen,

your last patch booted fine. And I've also managed to compile nvidias 
NVIDIA-Linux-x86-1.0-8756-pkg1 driver. There were two little patches 
needed in order to compile against mm. But these patches seems to break 
S3, now S3 doesn't work at all with nvidias closed source drivers.
Even more bad news (well, only for me I guess ;) ). Resuming from S3 in 
single user mode w/o nvidias driver, using video post works with 
powerbutton and keyboard, but not with WOL. I've managed to wake up the 
system up to eight times using magic packet, the nineth time the box 
died. I wrote, that your first debugging patch seems to fix my WOL 
problem, but now I think, that I've just been lucky.
You ask me to activate the kernel-debugging option, well this could 
changed the behaviour. Perhaps I do have a kind of race condition, that 
just let my box die a little bit later now.
How ever, I'm back now on 2.6.17-rc4 with Lens latest acpi-release 
patch, and do have two lan0 entries in my /proc/interrupts again. Len 
sais, this is bad ;) (w/o Lens apci-patch there are also two lan0 
entries!). With 2.6.17-rc4-mm3 the two-lan0-entries problem was gone, 
but seems not to fix the WOL problem.

Since I've enabled kernel-debugging, I resend my dmesg from the 
2.6.17-rc4 with my two lan0 entries and a /proc/interrupts output. Here 
it is:
--> http://as68.homeip.net/kernel/2.6.17-rc4-len/

Actually this thread ("2.6.17-rc4-mm3 - kernel panic") could be closed 
with status "solved", since there is no more kernel panic with 
2.6.17-rc4-mm3 anymore. Thank You Kristen!

Thank You all very much for Your support!

Regards,

Andreas

