From: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
Subject: regression 2.6.15. / 2.6.17.14 "lost interrupts..."
Date: Thu, 2 Nov 2006 14:02:52 +0200
Message-ID: <5d96567b0611020402v647abb1dgac01d86ca6ad9fb4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zeus2.kernel.org ([204.152.191.36]:3499 "EHLO zeus2.kernel.org")
	by vger.kernel.org with ESMTP id S1752115AbWKBMFF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Nov 2006 07:05:05 -0500
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.178])
	by zeus2.kernel.org (8.13.7/8.13.1) with ESMTP id kA2C4qq7029945
	for <linux-acpi@vger.kernel.org>; Thu, 2 Nov 2006 12:05:05 GMT
Received: by py-out-1112.google.com with SMTP id a73so90110pye
        for <linux-acpi@vger.kernel.org>; Thu, 02 Nov 2006 04:02:52 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Paul hello.
I hope i am too rude cci'ing you .
We're using rtc on a supermicro p8sct hw.
Our problem is that we are getting "lost interrupts"
messages in 2.6.17.14. we get it by a simple rtc tester
which reads in 8192hz rate.
we do not have this problem in 2.6.15.

I will appreciate any help.
The bellow is lspci of this machine.

00:00.0 Host bridge: Intel Corp.: Unknown device 2778 (rev 81)
00:01.0 PCI bridge: Intel Corp.: Unknown device 2779 (rev 81)
00:1c.0 PCI bridge: Intel Corp.: Unknown device 27d0 (rev 01)
00:1c.4 PCI bridge: Intel Corp.: Unknown device 27e0 (rev 01)
00:1c.5 PCI bridge: Intel Corp.: Unknown device 27e2 (rev 01)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev e1)
00:1f.0 ISA bridge: Intel Corp.: Unknown device 27b8 (rev 01)
00:1f.1 IDE interface: Intel Corp.: Unknown device 27df (rev 01)
00:1f.2 Class 0106: Intel Corp.: Unknown device 27c1 (rev 01)
00:1f.3 SMBus: Intel Corp.: Unknown device 27da (rev 01)
09:00.0 PCI bridge: Intel Corp.: Unknown device 032c (rev 09)
09:00.1 PIC: Intel Corp.: Unknown device 0326 (rev 09)
0a:01.0 Ethernet controller: Intel Corp.: Unknown device 1079 (rev 03)
0a:01.1 Ethernet controller: Intel Corp.: Unknown device 1079 (rev 03)
0d:00.0 Ethernet controller: Intel Corp.: Unknown device 108c (rev 03)
0e:00.0 Ethernet controller: Intel Corp.: Unknown device 109a
0f:00.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)


-- 
Raz
