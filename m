From: Richard <tuxbox.guru@gmail.com>
Subject: ACPI on Compaq 6715b - BIOS from the wrong end of the planet
Date: Sun, 27 Apr 2008 10:06:17 +0100
Message-ID: <48144209.7080203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:24486 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752052AbYD0JGY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 27 Apr 2008 05:06:24 -0400
Received: by fg-out-1718.google.com with SMTP id l27so4415943fgb.17
        for <linux-acpi@vger.kernel.org>; Sun, 27 Apr 2008 02:06:23 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi all,

Pardon for the intrusion, I am trying to fault find a horrible wrong 
ACPI interface and fix it.

the problem is as follows... 

Kernel 2.6.23 works fine, except there is no stable clocksource.. 
acpi_pm, tsc doesnt work and jiffies .. well thats just jiffies. The 
kernel boots but time sources are erratic and this results in an 
unstable clock (Mp3's play at erratic speeds)

Kernel 2.6.25 hangs the system if I enable ACPI Timer and rebuild/boot 
the new linux kernel. The only clock sources are tsc and jiffies and TSC 
is disables due to being erratic. If I totally disable ACPI, the kernel 
boots and works with stable clocks..  but obviously Power management is 
gone.

The system is an ATI bridged AMD Sempron notebook. I have tried Millions 
of options in the kernel bootup and none seem to do clear the problem. 
This system seems to suffer from the Clocks fast bug. (the dmesg reports 
that the 8254 clock is disables, IO-APIC int0 fails and IO-APIC Vritual 
wire is OK.. if that means anything :D)

Any pointers.. and if anyone wants the AML/ACPI stuff, please feel free 
to shout.

Thanks in advance..
Richard



