From: Ondrej Zary <linux@rainbow-software.org>
Subject: Debugging MSI EX600 suspend to RAM
Date: Thu, 18 Oct 2012 11:27:29 +0200
Message-ID: <201210181127.29257.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-1-out2.atlantis.sk ([80.94.52.71]:55119 "EHLO
	mail.atlantis.sk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754218Ab2JRJ1l (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Oct 2012 05:27:41 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-pm@vger.kernel.org

Hello,
I got a MSI EX600 laptop in my hands. These are famous for not working suspend 
to RAM in Linux (there are bug reports all over the web).

It suspends fine but when resuming, the power LED comes on (and also HDD LED) 
but nothing more. After a couple of seconds, power turns off for a few 
seconds. Then it turns back on but hangs with blank screen. It needs a power 
cycle to boot again.

All tests in /sys/power/pm_test pass without any problems.

PM_TRACE seems to be unable to detect anything - RTC date/time is not changed 
upon failed resume and kernel log does not contain any "hash matches" lines. 
It probably hangs very early in the resume process. Or maybe even in the 
BIOS?

There are no serial ports, only USB and firewire. What can I do more to debug 
it?

-- 
Ondrej Zary
