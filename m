From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: Re: Machine shutdown after resume from S3
Date: Thu, 21 Feb 2008 19:21:01 -0300
Message-ID: <200802211921.01913.herton@mandriva.com.br>
References: <200802201837.22443.herton@mandriva.com.br> <20080221174643.32B0A3608D@smtp02.mtu.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from perninha.conectiva.com.br ([200.140.247.100]:33985 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760867AbYBUWVG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Feb 2008 17:21:06 -0500
In-Reply-To: <20080221174643.32B0A3608D@smtp02.mtu.ru>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Andrey Borzenkov <arvidjaar@mail.ru>

Em Thursday 21 February 2008 14:46:45 Andrey Borzenkov escreveu:
> Herton Ronaldo Krzesinski wrote:
> 
> > I have here an Intel Classmate hardware sample, and I have a weird problem
> > with suspend to ram, the machine does a power off when resuming.
> > 
> 
> Do you have acpid running? You may also be interested in this:
> http://qa.mandriva.com/show_bug.cgi?id=18998
> http://qa.mandriva.com/show_bug.cgi?id=23296
> http://article.gmane.org/gmane.linux.acpi.devel/17581/match=sup
> 
> 
> > I isolated the problem to the button acpi module, without loading it (or
> > just removing it before doing a s2ram) I don't get the problem. In the
> > specific machine I have here I can only resume it pressing the power
> > button, so I think this is related.
> > 
> 
> IIRC the issue was that button press that triggered resume was reported to
> user space. This apparently was fixed in the quoted patch; but may be this
> specific model goes via different code path?

In my case here is not an userspace issue. But the patch in the last link you
posted gave me an idea, to check code executed in resume, I managed to make
a quick hack that solved the issue:

diff --git a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
index 293a1cb..2255434 100644
--- a/drivers/acpi/sleep/main.c
+++ b/drivers/acpi/sleep/main.c
@@ -156,6 +156,8 @@ static int acpi_pm_enter(suspend_state_t pm_state)
 
 	local_irq_save(flags);
 	acpi_enable_wakeup_device(acpi_state);
+	(void) acpi_set_register(acpi_gbl_fixed_event_info[ACPI_EVENT_POWER_BUTTON].enable_register_id, 0);
+	(void) acpi_set_register(acpi_gbl_fixed_event_info[ACPI_EVENT_POWER_BUTTON].status_register_id, 0);
 	switch (acpi_state) {
 	case ACPI_STATE_S1:
 		barrier();

For some reason with this I don't have the power off problem in resume.
I'll try to check more the code and acpi spec, but does this could indicate a
bug in bios?

--
[]'s
Herton
