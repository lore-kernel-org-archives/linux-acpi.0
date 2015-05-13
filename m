From: Gianluca Anzolin <gianluca@sottospazio.it>
Subject: Debugging spurious wakeup
Date: Wed, 13 May 2015 08:58:25 +0200
Message-ID: <20150513065825.GA10680@sottospazio.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from m-r2.th.seeweb.it ([5.144.164.171]:49758 "EHLO
	m-r2.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752162AbbEMHHK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 May 2015 03:07:10 -0400
Received: from fseek.strangled.net (host112-190-dynamic.24-79-r.retail.telecomitalia.it [79.24.190.112])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 1AB6B3EF54
	for <linux-acpi@vger.kernel.org>; Wed, 13 May 2015 08:58:27 +0200 (CEST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,

I have a curious problem with my system: whenever I wake up the PC with a WOL
magic packet and then power it off the systems comes back to life after a
couple of seconds, by itself.

I can reproduce the problem 100% of the times.

I've been having this problems for years. I remember this same issue occurred
also with my previous computer, with a different mainboard. My current system
has an ASUS P8B-WS mb with a Xeon 1275v2 CPU.

I've ruled out in the time many factors: traffic on the net (by disconnecting
the cable), RTC alarms (by disabling them)... long story short: I'm stuck.

While I'm not the only one with this issue (see[1]), some people have reported
mixed success by blacklisting some components (xhci-pci) or by setting
unrelated BIOS options. Unfortunately these workarounds never worked for me.

So I'm here to ask if there is a way to get the source/cause of the last wakeup
by setting some ACPI debug option. This way I could at least pinpoint the
device/interface that caused the spontaneous wakeup and then debug further or
at least disable it.

I've tried to enable the ACPI hardware-related messages with the kernel
arguments: acpi.debug_layer=0x2 acpi.debug_level=0xffffffff

Unfortunately I can't see the information I'm looking for in the resulting
output. Should I enable some other debug_layer? Could anybody point me in the
right direction?

Thank you and best regards,

Gianluca

[1] https://bbs.archlinux.org/viewtopic.php?id=173648
