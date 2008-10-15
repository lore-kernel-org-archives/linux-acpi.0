From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: New battery doesn't work under linux, but does under windows
Date: Thu, 16 Oct 2008 00:16:15 +0400
Message-ID: <48F64F8F.4070004@gmail.com>
References: <200810151359.58976.eric@certus.bz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:60581 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100AbYJOUQS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Oct 2008 16:16:18 -0400
Received: by ey-out-2122.google.com with SMTP id 6so1057847eyi.37
        for <linux-acpi@vger.kernel.org>; Wed, 15 Oct 2008 13:16:16 -0700 (PDT)
In-Reply-To: <200810151359.58976.eric@certus.bz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Eric Atkin <eric@certus.bz>
Cc: linux-acpi@vger.kernel.org

Eric Atkin wrote:
> So I bought a new battery for my laptop and installed it. I booted into Linux 
> (gentoo) and kpowersave recognized the new battery and for the next few hours 
> showed it charging up. The guy at the battery store said I should charge it 
> fully and then discharge fully to calibrate, so, once full, i disconnected AC 
> power and continued to work. kpowersave recognize that power had been removed 
> and showed the battery discharging at a normal rate. After about 1 minute, my 
> laptop just shut off. No warnings or attempts to suspend or hibernate or 
> anything. Power was just cut off. I tested several times and always got the 
> same result. I assumed it was a bad battery, but then I had to boot into 
> windows for something and decided to try it there. In windows, I waited till 
> the charge was at 100% then disconnected AC and let it run. It ran for about 
> two hours as expected before dying. But if I boot back into linux, it dies 
> again after just a minute or two. I don't even know where to begin. Any 
> ideas? $170 battery that I can't take back because it does actually work, and 
> anyway, it seems to be a software issue.
> Eric
>   
First, you should tell us your kernel version and loaded battery module
(battery.ko or sbs.ko)
Second, please do a "grep . /proc/acpi/battery/*/*" with attached AC
and try to do this with it disconnected.
It might be a good idea to open a new bug report in bugzilla.kernel.org 
for ACPI/battery and assign it to
astarikovskiy@suse.de (me).

Regards,
Alex.
