From: Soenke Huels <huels@ph4.physik.uni-goettingen.de>
Subject: ACPI Problem on resuming from disk on Samsung X05
Date: Mon, 25 Sep 2006 13:31:29 +0200
Message-ID: <4517BE11.2080302@ph4.physik.uni-goettingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from enterprise.noxa.de ([212.60.197.71]:57026 "EHLO
	enterprise.noxa.de") by vger.kernel.org with ESMTP id S1751403AbWIYLbr
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Sep 2006 07:31:47 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi!

For some time, I have had some problems with suspend to disk on my
laptop (Samsung X05 XTC 1400c).
When suspending to disk (tried suspend2 as well as in-kernel swsusp),
ACPI gives the following error after resume (PM debug enabled):

Sep 22 19:46:49 paula kernel:      osl-0822 [30] os_wait_semaphore     :
Failed to acquire semaphore[c145e6a0|1|0], AE_TIME

Sep 22 19:46:49 paula kernel:      osl-0822 [30] os_wait_semaphore     :
Failed to acquire semaphore[c145e6a0|1|1000], AE_TIME

Sep 22 19:46:49 paula kernel:      osl-0822 [30] os_wait_semaphore     :
Failed to acquire semaphore[c145e6a0|1|0], AE_TIME

Sep 22 19:46:49 paula kernel:      osl-0822 [30] os_wait_semaphore     :
Failed to acquire semaphore[c145e6a0|1|1000], AE_TIME

Sep 22 19:46:49 paula kernel:      osl-0822 [30] os_wait_semaphore     :
Failed to acquire semaphore[c145e6a0|1|0], AE_TIME

Sep 22 19:46:49 paula kernel:      osl-0822 [30] os_wait_semaphore     :
Failed to acquire semaphore[c145e6a0|1|1000], AE_TIME

Sep 22 19:46:49 paula kernel:      osl-0822 [30] os_wait_semaphore     :
Failed to acquire semaphore[c145e6a0|1|0], AE_TIME

Sep 22 19:46:49 paula kernel:      osl-0822 [30] os_wait_semaphore     :
Failed to acquire semaphore[c145e6a0|1|1000], AE_TIME

Sep 22 19:46:49 paula kernel: ACPI Exception (evregion-0409):
AE_NOT_FOUND, Returned by Handler for [EmbeddedControl] [20060127]

Sep 22 19:46:49 paula kernel: ACPI Exception (dswexec-0458):
AE_NOT_FOUND, While resolving operands for [ShiftRight] [20060127]

Sep 22 19:46:49 paula kernel: ACPI Error (psparse-0517): Method
parse/execution failed [\_WAK] (Node df6d5168), AE_NOT_FOUND



After this error, it is not possible to read the battery state. Also,
the system hangs on shutdown while disabling the laptop-mode.

Suspend to RAM works very well on this machine. Also it seems that if
the system is put into S3, woken up and suspended to disk later, the
error does sometimes not occur.

The error is reproducible with several kernel versions from 2.6.15 to
2.6.18-rc7. I tried the DSDT for the most recent bios (11QK) from
acpi.sf.net, but without success.

I also filed a bug report with more information (complete dmesg,
acpidump) here:
http://bugzilla.kernel.org/show_bug.cgi?id=7185

Suspend to disk used to work some time ago, but I don't recall with
which kernel version.
Any help with this is appreciated. If more info is needed, I will gladly
supply it.

Regards,

Soenke
