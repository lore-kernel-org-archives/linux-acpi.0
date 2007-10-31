From: Tomas Salfischberger <tomas@salfischberger.nl>
Subject: Acpi suspend to ram on Acer Aspire 5672
Date: Wed, 31 Oct 2007 10:15:14 +0100
Message-ID: <472847A2.9020901@salfischberger.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rs6.shcomputers.nl ([88.198.238.124]:60611 "EHLO
	rs6.shcomputers.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757769AbXJaKac (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Oct 2007 06:30:32 -0400
Received: from [192.168.1.5] (53533D4E.cable.casema.nl [83.83.61.78])
	(Authenticated sender: tomas@shcomputers.nl)
	by rs6.shcomputers.nl (Postfix) with ESMTP id C5E78E000F
	for <linux-acpi@vger.kernel.org>; Wed, 31 Oct 2007 09:56:53 +0000 (UTC)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi list,

I don't know what the correct approach to this is, but I need some help :-)

I have been trying to get my Acer Aspire 5672 to suspend to ram, using
kernel version 2.6.22 patched by Gentoo (r8). The ACPI functions work
for shutting down the machine, and (but I'm not sure of this) for
suspend to disk. When I set /sys/power/state to "disk" the power-led
switches to orange (which it also does when switching to suspend in
Windows).

>From the above I think that ACPI is working as it should, but when I try
to suspend to ram the machine switches to the correct state (orange
power-led) but is unable to resume. When resuming the machine hangs,
disk spins up but it's not reacting to for example the num-lock key.

I've read a lot about how suspend to ram is supposed to work, and if I
understand it correctly the ACPI functions from the BIOS are supposed to
jump to kernel code when resuming and the kernel should initialize all
hardware correct? Is there some way to check whether it is actually
reaching kernel-code, and thus if this might be fixable in kernel?

I have already tried to patch the DSDT, but to no avail. The errors:
Some reserved symbols being used and some methods that didn't return a
value for all controlpaths (notably _WAK which I changed to return
0x00,0x00 on the last line).

Is there anything else I can try?

Regards,
Tomas

P.S. I'm not a native English speaker, so sorry for some weird grammar
choices.

