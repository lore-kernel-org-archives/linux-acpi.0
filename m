From: majie <china.majie@gmail.com>
Subject: can't shut down
Date: Tue, 15 Apr 2008 22:09:42 +0800
Message-ID: <1c0ea1cc0804150709u3c4274fbq39467e6a1d704642@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0708.google.com ([209.85.198.241]:5493 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755912AbYDOOJm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Apr 2008 10:09:42 -0400
Received: by rv-out-0506.google.com with SMTP id k29so885666rvb.1
        for <linux-acpi@vger.kernel.org>; Tue, 15 Apr 2008 07:09:42 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi all,

I'm using Linux kernel 2.6.21.5-smp(Slackware 12). I experience an
error when I turn off my computer. It doesn't turn off itself (maybe
called going into G2/S5 Soft Off in the specification) after printing
a message "acpi_power_off called". I have to press the power button
for several seconds to turn it off. I think the CPUs may be running in
full speed because I hear my fan running in high speed.

I tried to find out the problem by adding some printk()'s to the
function acpi_enter_sleep_state()(in
linux-2.6.21.5\drivers\acpi\hardware\hwsleep.c). And It shows that it
runs into the final do-while loop in the function and doing an
infinite loop. Maybe this is why my CPUs are running in full speed.

I don't have the ability to debug the kernel. So this is the only
information I can provide about the code. If you want me to post my
hardware spec or anything else, I'm very glad to, but please tell me
which command and arguments should I use to get the info.

I have tried the kernel options, but they don't work for me. My laptop
can shut down flawlessly when using windows xp.

By the way, It's a linux distribution independent problem because I
also experienced it in kubuntu 7.10.

I'm truly grateful for your help.
Thank you very much.

-----
Best regards,
	majie
