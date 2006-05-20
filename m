From: Andreas Saur <saur@acmelabs.de>
Subject: RE: Help request on S3 resume problems
Date: Sat, 20 May 2006 00:13:01 +0000
Message-ID: <446E5F0D.9080105@acmelabs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from natlemon.rzone.de ([81.169.145.170]:4766 "EHLO
	natlemon.rzone.de") by vger.kernel.org with ESMTP id S1751445AbWETANP
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 May 2006 20:13:15 -0400
Received: from server.zuhause.xx (p50813B59.dip0.t-ipconnect.de [80.129.59.89])
	(authenticated bits=0)
	by post.webmailer.de (8.13.6/8.13.6) with ESMTP id k4K0DCO9017938
	for <linux-acpi@vger.kernel.org>; Sat, 20 May 2006 02:13:13 +0200 (MEST)
Received: from [192.168.1.41] (helo=[192.168.1.41])
	by server.zuhause.xx with esmtp (Exim 4.50)
	id 1FhCK9-0004DL-G5
	for linux-acpi@vger.kernel.org; Fri, 19 May 2006 23:15:53 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,

same here! (nForce2 chipset).

After many many trial and error scenarios, I cannot remember exactly what I've done to get it work (resume from s3 on WOL) at least partitially.

1) In a sort of combination of using X86_UP_IOAPIC with USB turned off in BIOS, the system always woke up after sending the magic packet.
2) After turning on USB in BIOS the system woke up exactly 3 times. The forth time always led to a dead keyboard and a black screen, no ping.
3) Turning off X86_UP_IOAPIC in the kernel leads always to a dead keyboard and black screen, no ping.

Except WOL, S3 works fine here using the PowerButton or Keyboard.

I've studied all the the logs I've turned on in kernel, but there is nothing of interest concerning this error, at least for me.
Btw. It didn't make a difference whether doing the test in single user mode or not. Results were the same. I've also turned off all devices I could in the BIOS to minimize the IRQ impact. Didn't make a difference either.

It's a pitty, I was so close to a very cool MediaCenterPC for my living-room. But at the moment I ran out of ideas. If anybody is interested in my specs, can look into a bugzilla report I've posted earlier (another problem), the hardware didn't change, except the kernel. It's 2.6.17-rc3 at the moment. the last three mm patches led to kernel panics. (here my specs: http://bugzilla.kernel.org/show_bug.cgi?id=6326)

Regards,

Andreas

>Len,
>
>Thanks for the quick response. Unfortunately, I think in this instance that
>the failure on resume IS related to the method of waking. Here are the
>results of testing as you imply below:
>
>Resume from S3 using power button	  -> 100% functional, both ttyS0 serial
>console and NVIDIA video card console
>Resume from S3 using WOL magic packet -> Fans run, disk activity, NO NVIDIA
>video card console response, NO ttyS0 serial console response, NO ping
>response
>Resume from S5 using power button	  -> Normal boot
>Resume from S5 using WOL magic packet -> Normal boot
>
>I haven't tried wake from S4 as I don't currently have a swap partition
>large enough to try it (1GB RAM).
>
>Regards,
>
>David.

