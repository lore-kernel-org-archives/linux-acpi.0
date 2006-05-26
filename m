From: Andreas Saur <saur@acmelabs.de>
Subject: Re: 2.6.17-rc4-mm3 - kernel panic
Date: Fri, 26 May 2006 08:08:33 +0200
Message-ID: <44769B61.9020205@acmelabs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from natlemon.rzone.de ([81.169.145.170]:43740 "EHLO
	natlemon.rzone.de") by vger.kernel.org with ESMTP id S1030434AbWEZGIV
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 26 May 2006 02:08:21 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, kristen.c.accardi@intel.com

Hello Kristen,

Your patch seems also to solve my WOL-S3 problem. I've tried this from 
single user mode with a video post to my graphics adapter, since I can't 
use the nvidia driver(see last posting). I've tried it about 10 times. 
The system woke up perfectly. Never got that far!
What is going on here?

P.S.: but I still have to patch /usr/src/linux/drivers/ide/ide.c
#########
    .
    .
        //return ide_do_drive_cmd(drive, &rq, ide_head_wait);
        (void) ide_do_drive_cmd(drive, &rq, ide_head_wait);
        return set_xfer_rate(drive, XFER_UDMA_5);
    .
    .
#########
