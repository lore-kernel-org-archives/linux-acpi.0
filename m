From: acme <saur@acmelabs.de>
Subject: Re: Failed resuming IDE from S3 on Abit NF7 (nForce2)
Date: Sat, 15 Apr 2006 04:57:32 +0200
Message-ID: <4440611C.10605@acmelabs.de>
References: <554C5F4C5BA7384EB2B412FD46A3BAD11206BE@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from natlemon.rzone.de ([81.169.145.170]:15336 "EHLO
	natlemon.rzone.de") by vger.kernel.org with ESMTP id S1030214AbWDOC5i
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 14 Apr 2006 22:57:38 -0400
Received: from server.zuhause.xx (p508136E5.dip0.t-ipconnect.de [80.129.54.229])
	(authenticated bits=0)
	by post.webmailer.de (8.13.6/8.13.6) with ESMTP id k3F2vUhO001043
	for <linux-acpi@vger.kernel.org>; Sat, 15 Apr 2006 04:57:30 +0200 (MEST)
Received: from [192.168.1.33] (helo=[192.168.1.33])
	by server.zuhause.xx with esmtp (Exim 4.50)
	id 1FUb0n-0006Wb-DP
	for linux-acpi@vger.kernel.org; Sat, 15 Apr 2006 04:59:49 +0200
In-Reply-To: <554C5F4C5BA7384EB2B412FD46A3BAD11206BE@pdsmsx411.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello Luming,

well, I've tried your patch and it work, - sort of. The system resumes 
from S3 now, but the generic ide driver seems to be DMA-less. This is of 
course a no go solution. I've also tried the amd74xx driver, and this 
one is running into a time out, and comes back after a while also 
without DMA. Setting DMA afterward doesn't work anymore. Is it possible 
to apply your patch into the amd74xx driver somehow?

And a very strange situation I do also have here. I've compiled the 
kernel without framebuffer (otherwise it doesn't work at all), then I've 
accidentaly booted the system with the following kernel parameters:
  "vga=0x317 screen=1024x768 splash root=/dev/hda1 init=/bin/bash"
The result was a blank screen, because I do not have a framebuffer. Now 
you perhaps begin to wonder, why do I mention that here? Well, this 
kernel parameters are my only possibility to S3 my system! When I leave 
out "vga=0x317 screen=1024x768" my keyboard is instantly dead after S3. 
In other words: I can only S3 the box with a black screen, and have to 
ssh into the box from another mashine. How can it be, that booting the 
box in text mode ( videomode 3 ) S3 doesn't work at all?

btw: I can't use vbetool (v5.1) to restore the video mode either. Here 
is the result:

  #root@(none):~# vbetool vbestate save
  #Get video state buffer size failed
  #Allocated buffer at 0x11010 (base is 0x0)
  #ES: 0x1101 EBX: 0x0000
  #Save video state failed

It seems that it doesn't work with radeon cards. I've tried this with a 
Radeon 9200 (RV280), Radeon 9550 SE (RV350) and an nVidia TI4200. Only 
the last one could save the state correctly. Perhapt the internet is 
full of warnigs and signs saying: "vbetool doesn't work with Radeon", 
and I was only to stupid to use google the right way ;-)

Three weeks ago, I said "Hi, let's try the S3 stuff, could be fun". Now 
I am lucky to S3 the box with a black screen, and my only wish is to 
have DMA working also, well a working display would be the suger on the 
top of it. ;-)

I feel like beeing in the wrong movie, and it makes me more and more 
wonder why all things I try do not work the way they should. Never the 
less, thank you very much for your support, and I certainly won't give 
up. Now it's a challange! ;-)

Thanks and bye


Yu, Luming schrieb:

 >>the bug you are refering to, seems pretty much the same bug like I do
 >>have here. But I've got two questions. Could you please help me? And I
 >>do asume, that this patch isn't in the resent kernel yet, isn't it?
 >
 >
 >I didn't check it, Probably Not.
 >
 >>1) If I want to adopt your patch, I should use the values from my
 >>acpidump, but I can't find anything reasonable. What should my values
 >>look like? (see here:
 >>http://bugzilla.kernel.org/attachment.cgi?id=7762&action=view )
 >>
 >\\_SB.PCI0.IDE0.PRI0  (It's zero)
 >\\_SB.PCI0.IDE0.SEC0 (It's zero)
 >
 >
 >>2) How do I ensure, that this native IDE driver is really used? Do I
 >>have to uncheck all non-native IDE drivers in the kernel
 >>config? (In my
 >>case it's the amd71xx, I guess)
 >>
 >
 >You can try only CONFIG_IDE_GENERIC.
 >
 >
 >>Please excuse the silly questions, but I am pretty new to game
 >>of kernel
 >>configuration and compilation, but steady learning :-)
 >
 >
 >happy hacking. :-)
 >
 >--Luming
 >


