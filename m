From: Chris <temp2012@brindabella.org>
Subject: ACPI issue?
Date: Tue, 25 Dec 2012 13:36:18 +1100
Message-ID: <50D91122.3070200@brindabella.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:55704 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753385Ab2LYChZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Dec 2012 21:37:25 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id D567B20967
	for <linux-acpi@vger.kernel.org>; Mon, 24 Dec 2012 21:37:24 -0500 (EST)
Received: from [192.168.1.10] (unknown [124.171.110.225])
	by mail.messagingengine.com (Postfix) with ESMTPA id 0C7DB482669
	for <linux-acpi@vger.kernel.org>; Mon, 24 Dec 2012 21:37:23 -0500 (EST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Sorry, just a user here, not a dev.  I'm not even sure if this is the 
appropriate list...

Do the lines pasted below from /var/log/messages suggest an ACPI 
issue/bug that I ought to report?

Symptoms: my screen goes blank after a period of inactivity, when I 
start using the PC again the mouse cursor is super laggy and rebooting 
seems to be the only way to recover.  System hangs if I try and exit X 
windows.  System is Debian stable.

01:32 PM: uname -a
Linux last 2.6.32-5-686 #1 SMP Sun Sep 23 09:49:36 UTC 2012 i686 GNU/Linux

Thanks,
Chris

Dec 25 11:48:29 last kernel: [ 8214.356654] Pid: 0, comm: swapper Not 
tainted 2.6.32-5-686 #1
Dec 25 11:48:29 last kernel: [ 8214.356658] Call Trace:
Dec 25 11:48:29 last kernel: [ 8214.356667]  [<c106d91d>] ? 
__report_bad_irq+0x24/0x69
Dec 25 11:48:29 last kernel: [ 8214.356673]  [<c106d924>] ? 
__report_bad_irq+0x2b/0x69
Dec 25 11:48:29 last kernel: [ 8214.356678]  [<c106da49>] ? 
note_interrupt+0xe7/0x13e
Dec 25 11:48:29 last kernel: [ 8214.356683]  [<c106df77>] ? 
handle_fasteoi_irq+0x7a/0x97
Dec 25 11:48:29 last kernel: [ 8214.356689]  [<c1004dd7>] ? 
handle_irq+0x17/0x1b
Dec 25 11:48:29 last kernel: [ 8214.356694]  [<c1004659>] ? 
do_IRQ+0x38/0x89
Dec 25 11:48:29 last kernel: [ 8214.356699]  [<c10037f0>] ? 
common_interrupt+0x30/0x38
Dec 25 11:48:29 last kernel: [ 8214.356704]  [<c10300e0>] ? 
copy_process+0xeef/0xf2d
Dec 25 11:48:29 last kernel: [ 8214.356715]  [<f80bbe7c>] ? 
acpi_idle_enter_c1+0x7b/0x97 [processor]
Dec 25 11:48:29 last kernel: [ 8214.356721]  [<c11c75a1>] ? 
cpuidle_idle_call+0x68/0xbb
Dec 25 11:48:29 last kernel: [ 8214.356724]  [<c1002377>] ? 
cpu_idle+0x89/0xa2
