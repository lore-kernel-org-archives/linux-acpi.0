From: "Brian J. Murrell" <brian@interlinx.bc.ca>
Subject: Re: suspend/resume fails on second attempt in LNXVIDEO:00
Date: Tue, 16 Dec 2008 23:54:36 +0000 (UTC)
Message-ID: <gi9f3s$m5f$8@ger.gmane.org>
References: <gi247o$iog$1@ger.gmane.org> <200812161713.08451.rjw@sisk.pl>
	<gi8kc5$m5f$6@ger.gmane.org> <200812161722.41149.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:41882 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751567AbYLPXyq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Dec 2008 18:54:46 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LCjkR-0007gE-NI
	for linux-acpi@vger.kernel.org; Tue, 16 Dec 2008 23:54:44 +0000
Received: from d193-213-184.home3.cgocable.net ([67.193.213.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Tue, 16 Dec 2008 23:54:43 +0000
Received: from brian by d193-213-184.home3.cgocable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Tue, 16 Dec 2008 23:54:43 +0000
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

On Tue, 16 Dec 2008 17:22:40 +0100, Rafael J. Wysocki wrote:
> 
> Well, please remove as many modules as you can (using rmmod) and see if
> your second resume still fails.

OK.  I got the list of modules down to:

Module                  Size  Used by
ipv6                  254836  14 
ext3                  130568  1 
jbd                    53908  1 ext3
mbcache                16004  1 ext3
loop                   22540  2 
sd_mod                 41240  2 
crc_t10dif             10112  1 sd_mod
ahci                   37260  1 
libata                176160  1 ahci
scsi_mod              156948  2 sd_mod,libata
processor              49708  2 
fuse                   58780  3 

and that still failed the second resume.  Just to remind you, the first 
suspend/resume (echo mem >/sys/power/state) works, but the screen is 
black on returning from the resume.  I can then (blindly typing) do a
second suspend but resume still hangs the machine.

b.

