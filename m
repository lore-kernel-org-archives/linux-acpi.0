From: mthkirschner <mthkirschner@web.de>
Subject: acpidump for information
Date: Thu, 08 Jan 2009 15:20:40 +0100
Message-ID: <49660BB8.8090300@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmmailgate01.web.de ([217.72.192.221]:56011 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759665AbZAHOUo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Jan 2009 09:20:44 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id 632B8FB7D31C
	for <linux-acpi@vger.kernel.org>; Thu,  8 Jan 2009 15:20:42 +0100 (CET)
Received: from [79.199.86.23] (helo=[192.168.123.2])
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #273)
	id 1LKvkY-0008C3-00
	for linux-acpi@vger.kernel.org; Thu, 08 Jan 2009 15:20:42 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

 From System log - OpenSUSE 11.1
...
Oct 13 21:19:55 linux-j4ex kernel: ACPI Exception (thermal-0459): AE_ERROR, ACPI thermal 
trip point state changed
Oct 13 21:19:55 linux-j4ex kernel: Please send acpidump to linux-acpi@vger.kernel.org
Oct 13 21:19:55 linux-j4ex kernel:  [20070126]
Oct 13 21:19:55 linux-j4ex kernel: klogd 1.4.1, ---------- state change ----------
...
The attached file is acpidump.output (redirected from stdout)

Some further information:
-------------------------
It's a Noname?-Motherboard (ATI/AMD) from Conrad (www.conrad.de)
Athlon 64 3000+
Chipset ATI 690V
Graphics ATI Radeon X1200

(The cheapest one 99.- Euro or so)

OpenSuse 11.1 x86_64 isos downloaded and burned
to DVD-RW and CD-R (MD5 sums ok)

System updated via DVD / CD (OSS / non OSS)
from a reliable runnung OpenSuse 11.0 KDE 3.5

Short initial tests gave the folloing results:
1st installation failed (freeze on Kernel boot
after selecting any Startup Menu option - Tests/
Standard/Failsafe/Rescue/Repair/...)

2nd with boot option:
acpi=oldboot
the system boots and the upgrade installation
succeeded.

Also the system boots now with the 'acpi=oldboot' option appended,
Other options not tested

Greetings

Michael


-- 
<**********************************************>
Michael Thomas Kirschner
E-Mail:  mthkirschner -at- web.de
