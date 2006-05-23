From: Andreas Saur <saur@acmelabs.de>
Subject: 2.6.17-rc4-mm3 - kernel panic
Date: Tue, 23 May 2006 20:24:36 +0000
Message-ID: <44736F84.6030703@acmelabs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from natlemon.rzone.de ([81.169.145.170]:42685 "EHLO
	natlemon.rzone.de") by vger.kernel.org with ESMTP id S932123AbWEWUYn
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 23 May 2006 16:24:43 -0400
Received: from server.zuhause.xx (p50814C7D.dip0.t-ipconnect.de [80.129.76.125])
	(authenticated bits=0)
	by post.webmailer.de (8.13.6/8.13.6) with ESMTP id k4NKOeBd000636
	for <linux-acpi@vger.kernel.org>; Tue, 23 May 2006 22:24:41 +0200 (MEST)
Received: from [192.168.1.32] (helo=[192.168.1.32])
	by server.zuhause.xx with esmtp (Exim 4.50)
	id 1Fiagf-0005CK-VJ
	for linux-acpi@vger.kernel.org; Tue, 23 May 2006 19:28:54 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,

Still Kernel Panic in 2.6.17-rc4-mm3. Screen-shot here: 
http://as68.homeip.net/2.6.17-rc4-mm3/
Specs same as in here: http://as68.homeip.net/2.6.17-rc4-mm2/
Just config changed a bit:
#######
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
#######
Again a namespacing thing with ACPI.
What do I do wrong ?

Regards,

Andreas


