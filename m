From: Adam Goode <adam@spicenitz.org>
Subject: For newer Mac, need SystemCMOS handler registered before _INI
Date: Sun, 26 Apr 2015 00:56:39 -0400
Message-ID: <CADN=WdqaXbMWs1cnpmQNjy+G2ZWwbmx=hYG=jAMY5pCM5D7v3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:34881 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920AbbDZE5A (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 26 Apr 2015 00:57:00 -0400
Received: by obcux3 with SMTP id ux3so63090981obc.2
        for <linux-acpi@vger.kernel.org>; Sat, 25 Apr 2015 21:56:59 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

(please CC me on replies)

Hi,

Newer Macs have BIOS support for Thunderbolt hotplug, so no
specialized kernel driver is needed. Unfortunately, there is a problem
with Linux ACPI support that aborts initialization of this support.

>From the debug output, I know it starts executing these lines in \_SB.PCI0._INI:

            Debug = "OSYS="
            Debug = OSYS /* \OSYS */
            Debug = \_SB.PCI0.LPCB.RTC.ISWI
            If (!OSDW ())
            {
                If ((OSYS >= 0x07DC))
                {
                    Debug = "Save Ridge Config on Boot"
                    R118 = UP18 /* External reference */
                    R119 = UP19 /* External reference */
...


The problem is that \_SB.PCI0._INI is executed before the RTC handler
is installed in scan.c. The read of \_SB.PCI0.LPCB.RTC.ISWI fails and
_INI aborts. (It is also read below, so just hacking out the Debug
line won't solve it.)

I think the solution is to remove the acpi_cmos_rtc driver and instead
use that code to implement generic support for SystemCMOS in
acpi_ex_cmos_space_handler in exregion.c.

Does this sound like the correct approach? I don't see a compelling
need to bind to the PNP0B* devices. It should be fine to implement
generic support.

Second, I believe the way to do this is move most of the code from
acpi_cmos_rtc.c to osl.c, and introduce something like
acpi_os_read_cmos and acpi_os_write_cmos. Does this sound correct?


Thanks,

Adam
