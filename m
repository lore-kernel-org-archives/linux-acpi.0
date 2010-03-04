From: JT Croteau <jt.n1ese@gmail.com>
Subject: ASUS Z8NA + E5530's = No Turboboost
Date: Thu, 4 Mar 2010 10:17:19 -0500
Message-ID: <574165611003040717x4c37443bie188341e1f4f6a4e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:63160 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300Ab0CDPRj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Mar 2010 10:17:39 -0500
Received: by pwj8 with SMTP id 8so1691874pwj.19
        for <linux-acpi@vger.kernel.org>; Thu, 04 Mar 2010 07:17:39 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi folks.  I have a client with a workstation using the Asus Z8NA
motherboard and two Xeon E5530s but it is unable to ever trigger
turboboost on any of the cores.  Len's turbostat tool shows that turbo
should be available but it never triggers.  I do not show any ACPI
errors in dmesg.  I have tried booting the kernel both with and
without acpi_osi=Linux and I have also tried the old
"processor.nocst=1" trick as well.  Could someone possibly help me
debug this problem on Linux?  The BIOS is configured properly for
turbo and turbo triggers under Windows.  I am able to run the same
kernel on a Core i7 rig and turbo engages under Linux so I am
beginning to suspect there might be something buggy with the BIOS on
this Asus board.  Below is the output of turbostat when all cores are
loaded to 100%.  When idle, the cores downclock just fine to 1.8 GHz
and all C-states are entered.

Thanks

- JT


CPUID GenuineIntel 11 levels family:model:stepping 6:26:5
Nehalem multiplier 18, TSC frequency 2400 MHz
Nehalem 4 cores active: 19 mult, max turbo frequency = 2533 MHz
Nehalem 3 cores active: 19 mult, max turbo frequency = 2533 MHz
Nehalem 2 cores active: 20 mult, max turbo frequency = 2667 MHz
Nehalem 1 core active: 20 mult, max turbo frequency = 2667 MHz
 CPU   GHz    TSC    %c0    %c1    %c3    %c6   %pc3   %pc6   %pc7
  0   2.40   2.40 100.00   0.00   0.00   0.00   0.00   0.00   0.00
  1   2.40   2.40 100.00   0.00   0.00   0.00   0.00   0.00   0.00
  2   2.40   2.40 100.00   0.00   0.00   0.00   0.00   0.00   0.00
  3   2.40   2.40 100.00   0.00   0.00   0.00   0.00   0.00   0.00
  4   2.40   2.40 100.00   0.00   0.00   0.00   0.00   0.00   0.00
  5   2.40   2.40 100.00   0.00   0.00   0.00   0.00   0.00   0.00
  6   2.40   2.40 100.00   0.00   0.00   0.00   0.00   0.00   0.00
  7   2.40   2.40 100.00   0.00   0.00   0.00   0.00   0.00   0.00
  8   2.40   2.40 100.00   0.00   0.00   0.00   0.00   0.00   0.00
  9   2.40   2.40 100.00   0.00   0.00   0.00   0.00   0.00   0.00
 10   2.40   2.40 100.00   0.00   0.00   0.00   0.00   0.00   0.00
 11   2.40   2.40 100.00   0.00   0.00   0.00   0.00   0.00   0.00
 12   2.40   2.40 100.00   0.00   0.00   0.00   0.00   0.00   0.00
 13   2.40   2.40 100.00   0.00   0.00   0.00   0.00   0.00   0.00
 14   2.40   2.40 100.00   0.00   0.00   0.00   0.00   0.00   0.00
 15   2.40   2.40 100.00   0.00   0.00   0.00   0.00   0.00   0.00
