From: Andreas Saur <saur@acmelabs.de>
Subject: 2.6.17-rc4-mm2 - kernel panic
Date: Sat, 20 May 2006 21:12:48 +0000
Message-ID: <446F8650.2080201@acmelabs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from natfrord.rzone.de ([81.169.145.161]:7598 "EHLO
	natfrord.rzone.de") by vger.kernel.org with ESMTP id S932353AbWETVMn
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 20 May 2006 17:12:43 -0400
Received: from server.zuhause.xx (p50814843.dip0.t-ipconnect.de [80.129.72.67])
	(authenticated bits=0)
	by post.webmailer.de (8.13.6/8.13.6) with ESMTP id k4KLCfkM012236
	for <linux-acpi@vger.kernel.org>; Sat, 20 May 2006 23:12:41 +0200 (MEST)
Received: from [192.168.1.42] (helo=[192.168.1.42])
	by server.zuhause.xx with esmtp (Exim 4.50)
	id 1FhVzS-00076W-K1
	for linux-acpi@vger.kernel.org; Sat, 20 May 2006 20:15:50 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,

tried the 2.6.17-rc4-mm2, still kernel panic, like the last three 
mm-patches. One screen-shot and sys-infos are here 
http://as68.homeip.net/2.6.17-rc4-mm2/
I think it's acpi-related, because there is something about 
acpi-namespace or so.

And another issue: I'm still using this ugly two-liner in order to be 
able to resume from S3. Is there a clean solution for it?

####################
/usr/src/linux/drivers/ide/ide.c - line 1483
.
.
-       return ide_do_drive_cmd(drive, &rq, ide_head_wait);
+     (void) ide_do_drive_cmd(drive, &rq, ide_head_wait);
+     return set_xfer_rate(drive, XFER_UDMA_6);
.
.
####################

Resume from S3 using WOL (magic packet) doesn't work reliably ( in 
combination with USB(in BIOS) doesn't work at all).

Regards,

Andreas

