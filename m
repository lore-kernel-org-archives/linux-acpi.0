From: Simon <devel@auctionANT.de>
Subject: acpi on thinkpad X30 / battery discharging during suspend2disk
Date: Thu, 22 Jun 2006 23:18:58 +0200
Message-ID: <200606222318.58861.devel@auctionANT.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from icebear.web4.hm ([81.3.4.70]:21675 "EHLO icebear.web4.hm")
	by vger.kernel.org with ESMTP id S932601AbWFVVTA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 Jun 2006 17:19:00 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi!

I have a Problem using the acpi system on my Ibm thinkpad X30 laptop.

Kernel: 2.6.16.5 from kernel.org
System: debian unstable
acpid: 1.0.4

The Problem: The Battery is discharging during suspend to disk 

Lets assume my battery is fully charged. If i suspend to disk everything seems to work. 
The data is written to the Harddisk and the notebook is switched off (automatically).
If i do not use the laptop for some days now the battery is no longer full (only 50% left for example!!).

BUT now the srtrange thing: If i
- suspend to disk
- remove the battery AND insert it again (just removed 1 sec is enough) 
the whole problem dissapears. The laptop can stay in suspend to disk for
days without discharging the battery so rapidly !
I can resume from suspend without any problems from disk 
(so i am sure i am using suspend2disk and NOT suspend2ram ;) )

strange... seems like something does not get switched off correctly. any hints/ideas ?

Thanks,

Simon
