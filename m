From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: Machine shutdown after resume from S3
Date: Wed, 20 Feb 2008 18:37:22 -0300
Message-ID: <200802201837.22443.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from perninha.conectiva.com.br ([200.140.247.100]:43413 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752841AbYBTVhZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Feb 2008 16:37:25 -0500
Received: from localhost (perninha.conectiva.com.br [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id E1DB33A984
	for <linux-acpi@vger.kernel.org>; Wed, 20 Feb 2008 18:37:23 -0300 (BRT)
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id AmIzX-ytkdNd for <linux-acpi@vger.kernel.org>;
	Wed, 20 Feb 2008 18:37:23 -0300 (BRT)
Received: from fox.conectiva (fox.conectiva [10.0.2.195])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 838D53A981
	for <linux-acpi@vger.kernel.org>; Wed, 20 Feb 2008 18:37:23 -0300 (BRT)
Received: from gotham.conectiva (gotham.conectiva [10.0.2.23])
	by fox.conectiva (Postfix) with ESMTP id 809082F01E
	for <linux-acpi@vger.kernel.org>; Wed, 20 Feb 2008 18:37:23 -0300 (BRT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I have here an Intel Classmate hardware sample, and I have a weird problem 
with suspend to ram, the machine does a power off when resuming.

I isolated the problem to the button acpi module, without loading it (or just 
removing it before doing a s2ram) I don't get the problem. In the specific 
machine I have here I can only resume it pressing the power button, so I 
think this is related.

I started looking into the kernel code and did some tests. The first thing I 
tried just as a test was to disable the code in acpi_button_notify function. 
As expected it stopped to send the power button key events 
to /proc/acpi/event, but I still got the same s2ram issues. But if I disable 
acpi_install_fixed_event_handler calls in acpi_button_install_notify_handlers 
the power off issue in s2ram was gone, of course also with power button not
notifying anything anymore :), but this was just a test.

After this tests then I went further to try to track down the problem and I 
saw acpi_ev_fixed_event_dispatch, that is the function that will call 
acpi_button_notify_fixed. First thing I noted: the comment about 
acpi_ev_fixed_event_dispatch says it will return INTERRUPT_HANDLED or 
INTERRUPT_NOT_HANDLED, but acpi_button_notify_fixed return AE_OK, is this 
right (comment is outdated) or am I missing something? Anyway I changed AE_OK 
to ACPI_INTERRUPT_HANDLED but this didn't change nothing. In the end I 
stopped there, doesn't seem to be anything wrong with the code at all, I also 
took a look at acpi_ev_fixed_event_detect and other code related to the table 
of fixed events (acpi_gbl_fixed_event_handlers), but didn't got more clues. 
Could be this a bios issue, or there is some hints to what I can try to look 
and prove that it's bios or code related?

PS.: with netconsole I don't get any message before power off after resume, I 
tried it to get more hints.

--
[]'s
Herton
