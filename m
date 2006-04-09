From: Andreas Saur <saur@acmelabs.de>
Subject: Help: Can't resume an Abit NF7 (nForce2) from S3
Date: Sun, 09 Apr 2006 21:15:03 +0200
Message-ID: <44395D37.7060700@acmelabs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from natlemon.rzone.de ([81.169.145.170]:2179 "EHLO
	natlemon.rzone.de") by vger.kernel.org with ESMTP id S1750774AbWDITPG
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 9 Apr 2006 15:15:06 -0400
Received: from server.zuhause.xx (p5081405B.dip0.t-ipconnect.de [80.129.64.91])
	(authenticated bits=0)
	by post.webmailer.de (8.13.6/8.13.6) with ESMTP id k39JF4Lu007377
	for <linux-acpi@vger.kernel.org>; Sun, 9 Apr 2006 21:15:04 +0200 (MEST)
Received: from [192.168.1.39] (helo=[192.168.1.39])
	by server.zuhause.xx with esmtp (Exim 4.50)
	id 1FSfNb-00009I-M4
	for linux-acpi@vger.kernel.org; Sun, 09 Apr 2006 21:15:23 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Dear list.
I've got three Abit NF7 (nForce2) boards here, and hope I can make S3 
work for  them. I've tried a lot of patches and Vanilla (and -mm) 
Kernels. I've also published a bug report at Bugzilla 
(http://bugzilla.kernel.org/show_bug.cgi?id=6326).

The last kernel I've tried was 2.6.17-rc1-mm2 (at the very moment the 
most recent one). But nothing worked yet. My problem isn't a 
non-returning VGA screen, my whole box is dead after invoking '#echo -n 
mem > /sys/power/state' from the single user mode. After waking the 
mashine up, the CPU-Fan and the HDD come up, but the keyboard is dead, 
and all logs are empty after reset. And that is the bad part of it, I 
can't offer you a logging entry, because there is none.

Question 1: How can I get some logs out of my box? ( e.g. CONFIG_DEBUG_??? )
Question 2: Is anybody out there with a working 'resume from S3' on an 
Abit NF7?
Question 3: If NF7 is a notorious no go board for ACPI, could i at least 
get mental assistence? ;-)

Thank's for support in advance.

      Andreas

P.S.: detailled informations about my system see: 
http://bugzilla.kernel.org/show_bug.cgi?id=6326


