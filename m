From: Mike Perry <mikepery@fscked.org>
Subject: Idle loop causes speaker whine/buzz (!)
Date: Tue, 23 Jan 2007 04:40:10 -0600
Message-ID: <20070123104010.GB7135@fscked.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from sparky.fscked.org ([69.12.145.164]:50248 "EHLO fscked.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932902AbXAWLS2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 23 Jan 2007 06:18:28 -0500
Received: from mikepery by fscked.org with local (Exim 4.43)
	id 1H9J4U-0002Dw-Gh
	for linux-acpi@vger.kernel.org; Tue, 23 Jan 2007 04:40:10 -0600
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Throw this one in the running for strangest bug ever:

For some reason, on 2.6.17-2.6.19(+others?) the acpi_processor_idle
loop enabled by CONFIG_ACPI_PROCESSOR is causing my laptop's speakers
to buzz.. If the option is disabled or built as a module (or if I run
both my CPUs' usage up to 100%), the speakers are silent.

I drilled a little further down, and it seems to have something to do
with the busmastering code. If I hack drivers/acpi/processor_core.c to
always set bm_control = 0, the whine goes away. Of course, disabling
bustmastering disables all C2 to C3 transitions, so maybe it is an
unrelated matter still..

Another datapoint: If I boot into single user mode, I can get an
(almost) silent mode of operation by removing uhci_ocd, or if I turn
off bluetooth via the switch on my laptop. However, other drivers are
involved in the buzz as well because if I do a full boot, killing
USB+bluetooth does not help.

proc is telling me the latency value for C3 is 57. To see if it was
perhaps rapid state transitions, I tried doubling the threshold.count
values for every state. Didn't seem to change the pitch or volume of
the whine...


So, any ideas? Is this a bug in linux-acpi, or my laptop's ACPI
support? Any way to tell? Windows doesn't whine, but Linux in VMware
in Windows does (again, only if the CPU is idle).


-- 
Mike Perry
Mad Computer Scientist
fscked.org evil labs
