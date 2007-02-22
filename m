From: =?ISO-8859-1?Q?Eduard_Gim=E9nez_Cerd=E0?= <edu@badopi.org>
Subject: C-States Usage/Accounting
Date: Thu, 22 Feb 2007 17:08:31 +0100
Message-ID: <FE6DEEF0-61B3-44D4-AA62-E8CE04C7FD8E@badopi.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:47694 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699AbXBVQIh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Feb 2007 11:08:37 -0500
Received: by ug-out-1314.google.com with SMTP id 44so151411uga
        for <linux-acpi@vger.kernel.org>; Thu, 22 Feb 2007 08:08:35 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,

I've two machines with the following configuration:
	Processor:	Intel Core Solo T1300 / Intel Celeron M 420
	Mainboard:	Asus N4L-VM DH with Intel 945GM Chipset with an AMI BIOS
	(I suppose the drives and the memory are not important)

With the vanilla kernels 2.6.18 and 2.6.19 the /proc/acpi/processor/ 
CPU1/info file shows that there is no bus mastering nor power  
management, and looking at /proc/acpi/processor/CPU1/power the states  
accounting only shows the C1 state but without any data (0 or -- on  
all the values), although it shows that the maximum C-State is C8.

Now, I'm trying to determine why ACPI does not work. Both processors  
and the mainboard chipset support ACPI, so perhaps it's the BIOS?  
I've been reading the ACPI documentation, the dmesg output, and  
googling but I can't find an answer.

How can I determine which is the faulty part in the system?

Thanks in advance!

--  

edu

