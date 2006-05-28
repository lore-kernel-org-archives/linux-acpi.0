From: Paul Surgeon <surgpub@telkomsa.net>
Subject: ACPI screwing up USB ehci_hcd with kernel 2.6.16.18
Date: Sun, 28 May 2006 21:50:24 +0200
Message-ID: <200605282150.24428.surgpub@telkomsa.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from juliet.telkomsa.net ([196.25.211.9]:37022 "EHLO
	mail.telkomsa.net") by vger.kernel.org with ESMTP id S1750868AbWE1Ttz
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 28 May 2006 15:49:55 -0400
Received: from unknown (HELO kubuntu) ([155.239.185.137])
          (envelope-sender <surgpub@telkomsa.net>)
          by O (qmail-ldap-1.03) with SMTP
          for <linux-acpi@vger.kernel.org>; 28 May 2006 19:49:52 -0000
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I had a problem with ACPI IRQ routing messing up the USB ehci module.
I have to disable the irq routing with apci=noirq in the bootloader config in 
order to use the ehci module.

Failing to do so results in :
usb 5-1: new high speed USB device using ehci_hcd and address 3
ehci_hcd 0000:00:10.4: Unlink after no-IRQ? Controller is probably using the 
wrong IRQ.

System :
Kernel 2.6.16.18
Chipset VIA KT400A

Regards
Paul
