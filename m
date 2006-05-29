From: Andreas Saur <saur@acmelabs.de>
Subject: 2.6.17-rc5 - S3 & WOL working
Date: Mon, 29 May 2006 20:24:58 +0000
Message-ID: <447B589A.2030004@acmelabs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from natlemon.rzone.de ([81.169.145.170]:39100 "EHLO
	natlemon.rzone.de") by vger.kernel.org with ESMTP id S1751276AbWE2USi
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 29 May 2006 16:18:38 -0400
Received: from server.zuhause.xx (p5081012D.dip0.t-ipconnect.de [80.129.1.45])
	(authenticated bits=0)
	by post.webmailer.de (8.13.6/8.13.6) with ESMTP id k4TKIZHm016225
	for <linux-acpi@vger.kernel.org>; Mon, 29 May 2006 22:18:35 +0200 (MEST)
Received: from [192.168.1.38] (helo=[192.168.1.38])
	by server.zuhause.xx with esmtp (Exim 4.50)
	id 1FklUD-0004oR-Ox
	for linux-acpi@vger.kernel.org; Mon, 29 May 2006 19:25:01 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi All,

first of all a big thanks to all. I had a big problem to wake my system 
from S3 via WOL (magig packet). I've installed kernel-2.6.17-rc5 and it 
seems(*) all problems are gone.
I confirm a working S3 in combination with wake on lan (WOL).
My system is an Abit NF7 with an nVidia 5200. Driver is 
'NVIDIA-Linux-x86-1.0-8762-pkg1.run'. NvAGP is set to "1" in xorg.conf, 
Agpgart is turned on in kernel though. Don't know whether one still need 
"CONFIG_X86_UP_IOAPIC=y" in kernel config, but if anybody has problems 
with WOL and S3, this setting seems to help at least one person, as far 
as I know. Btw. I've never managed to get a Radeon to work with S3 and 
KDE. Once I saw a very weird method to wake up a Radeon, I decided to 
buy an nNvidia.

Well, since I don't know the reason why it's working now, my thanks goes 
to Mr. Unknown.

Thanks again. Regards,

Andreas

--------
P.S. * have still to use this, else system is dead on resume from S3

####ide-acpi-udma6 patch for kernel 2.6.17-rc5####

--- drivers/ide/ide.c.orig      2006-05-29 20:12:37.000000000 +0000
+++ drivers/ide/ide.c   2006-05-29 20:14:04.000000000 +0000
@@ -1248,7 +1248,8 @@
        rqpm.pm_step = ide_pm_state_start_resume;
        rqpm.pm_state = PM_EVENT_ON;

-       return ide_do_drive_cmd(drive, &rq, ide_head_wait);
+       (void) ide_do_drive_cmd(drive, &rq, ide_head_wait);
+       return set_xfer_rate(drive, XFER_UDMA_6);

 }

#################################
