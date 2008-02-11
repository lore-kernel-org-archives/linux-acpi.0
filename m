From: Baeckham <baeckham@gmx.net>
Subject: power comsumption low and raise then
Date: Mon, 11 Feb 2008 15:50:12 +0100
Message-ID: <200802111550.12501.baeckham@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:56450 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752603AbYBKOuR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Feb 2008 09:50:17 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I am running kernel 2.6.24.1 on my Core2Duo Laptop. I trying to measure and 
lower the power consumption.

I noticed that after I logged in and started KDE (3.5.8) the system needs only 
little power (about 9 W, measured with an external power meter, no battery 
plugged in). But then usually after 10-15 minutes the power consumption 
raises to 22-25 W. I did not start any extra programs, I do not touch the 
system at all just watching the powermeter ... The system is idle all the 
time and I do not see any significant output in syslog.

I trying to find out what might cause this behavior. But I am at a loss.
Can anyone help me to find out what is causing this behavior? 

Steffen
