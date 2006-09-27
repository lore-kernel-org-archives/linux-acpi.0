From: Soenke Huels <huels@ph4.physik.uni-goettingen.de>
Subject: Re: ACPI Problem on resuming from disk on Samsung X05
Date: Wed, 27 Sep 2006 10:54:39 +0200
Message-ID: <451A3C4F.8040100@ph4.physik.uni-goettingen.de>
References: <4517BE11.2080302@ph4.physik.uni-goettingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from emailer.gwdg.de ([134.76.10.24]:45775 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750896AbWI0Iym (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 Sep 2006 04:54:42 -0400
Received: from snake.ph4.physik.uni-goettingen.de ([134.76.90.13] helo=snail.ph4.physik.uni-goettingen.de)
	by mailer.gwdg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.60)
	(envelope-from <huels@ph4.physik.uni-goettingen.de>)
	id 1GSVBg-0000KB-10
	for linux-acpi@vger.kernel.org; Wed, 27 Sep 2006 10:54:41 +0200
Received: from huelsdesk.ph4.physik.uni-goettingen.de ([134.76.90.74])
	by snail.ph4.physik.uni-goettingen.de with esmtp (Exim 4.50)
	id 1GSVBj-00071u-D0
	for linux-acpi@vger.kernel.org; Wed, 27 Sep 2006 10:54:43 +0200
In-Reply-To: <4517BE11.2080302@ph4.physik.uni-goettingen.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi again!

In the last days, I did a bit of further testing on my problem.
It now seems that my first diagnosis was not entirely correct.
I observed that the error occurs when I exchanged the battery while the
system was running. If it is suspended to disk after that, it produces
the error mentioned before on resume.
If the battery is exchanged while the machine is powered off or
suspended, there is no acpi error.
Perhaps this behavior yields some clues as to what could be wrong?

Regards,

Soenke

Soenke Huels wrote:
> Hi!
> 
> For some time, I have had some problems with suspend to disk on my
> laptop (Samsung X05 XTC 1400c).
> When suspending to disk (tried suspend2 as well as in-kernel swsusp),
> ACPI gives the following error after resume (PM debug enabled):
> 
> Sep 22 19:46:49 paula kernel:      osl-0822 [30] os_wait_semaphore     :
> Failed to acquire semaphore[c145e6a0|1|0], AE_TIME
> 
> Sep 22 19:46:49 paula kernel:      osl-0822 [30] os_wait_semaphore     :
> Failed to acquire semaphore[c145e6a0|1|1000], AE_TIME
> 
> Sep 22 19:46:49 paula kernel:      osl-0822 [30] os_wait_semaphore     :
> Failed to acquire semaphore[c145e6a0|1|0], AE_TIME
> 
> Sep 22 19:46:49 paula kernel:      osl-0822 [30] os_wait_semaphore     :
> Failed to acquire semaphore[c145e6a0|1|1000], AE_TIME
> 
> Sep 22 19:46:49 paula kernel:      osl-0822 [30] os_wait_semaphore     :
> Failed to acquire semaphore[c145e6a0|1|0], AE_TIME
> 
> Sep 22 19:46:49 paula kernel:      osl-0822 [30] os_wait_semaphore     :
> Failed to acquire semaphore[c145e6a0|1|1000], AE_TIME
> 
> Sep 22 19:46:49 paula kernel:      osl-0822 [30] os_wait_semaphore     :
> Failed to acquire semaphore[c145e6a0|1|0], AE_TIME
> 
> Sep 22 19:46:49 paula kernel:      osl-0822 [30] os_wait_semaphore     :
> Failed to acquire semaphore[c145e6a0|1|1000], AE_TIME
> 
> Sep 22 19:46:49 paula kernel: ACPI Exception (evregion-0409):
> AE_NOT_FOUND, Returned by Handler for [EmbeddedControl] [20060127]
> 
> Sep 22 19:46:49 paula kernel: ACPI Exception (dswexec-0458):
> AE_NOT_FOUND, While resolving operands for [ShiftRight] [20060127]
> 
> Sep 22 19:46:49 paula kernel: ACPI Error (psparse-0517): Method
> parse/execution failed [\_WAK] (Node df6d5168), AE_NOT_FOUND
> 
> 
> 
> After this error, it is not possible to read the battery state. Also,
> the system hangs on shutdown while disabling the laptop-mode.
> 
> Suspend to RAM works very well on this machine. Also it seems that if
> the system is put into S3, woken up and suspended to disk later, the
> error does sometimes not occur.
> 
> The error is reproducible with several kernel versions from 2.6.15 to
> 2.6.18-rc7. I tried the DSDT for the most recent bios (11QK) from
> acpi.sf.net, but without success.
> 
> I also filed a bug report with more information (complete dmesg,
> acpidump) here:
> http://bugzilla.kernel.org/show_bug.cgi?id=7185
> 
> Suspend to disk used to work some time ago, but I don't recall with
> which kernel version.
> Any help with this is appreciated. If more info is needed, I will gladly
> supply it.
> 
> Regards,
> 
> Soenke
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

