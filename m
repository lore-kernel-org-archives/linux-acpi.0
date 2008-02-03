From: matthieu castet <castet.matthieu@free.fr>
Subject: Re: suspend to ram problem
Date: Sun, 03 Feb 2008 16:31:44 +0100
Message-ID: <47A5DE60.1080402@free.fr>
References: <47A5C399.7010405@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2-g19.free.fr ([212.27.42.28]:41979 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751453AbYBCPbp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 3 Feb 2008 10:31:45 -0500
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 99D2F12B6E1
	for <linux-acpi@vger.kernel.org>; Sun,  3 Feb 2008 16:31:44 +0100 (CET)
Received: from [192.168.0.3] (cac94-1-81-57-151-96.fbx.proxad.net [81.57.151.96])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 74D1412B6BD
	for <linux-acpi@vger.kernel.org>; Sun,  3 Feb 2008 16:31:44 +0100 (CET)
In-Reply-To: <47A5C399.7010405@free.fr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

matthieu castet wrote:
> Hi,
> 
> I am trying to make work suspend to ram on a MSI MS-6380E with a 2.6.23 
> kernel.
> 
> Standby mode works.
> S2ram suspend seems to work : the computer turn off and I can wake up it 
> with the keyboard.
> 
> But when the computer wakeup, I see the video card POST on the screen, 
> but after that the computer hangs : black screen, no working numlock.
> 
> I tried to compile PM_TRACE, but it give no result. So this means the 
> resume hang very early.
> 
> What can I do to debug this ?
>
I play with the s2_beep feature and :
- echo 4 > /proc/sys/kernel/acpi_video_flags make the computer beep
- echo 4 > /proc/sys/kernel/acpi_video_flags make the computer not beep
- adding a beep in bogus_real_magic, make the computer not beep

So the hang seems located in wakeup_start.


Matthieu
