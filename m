From: Ken Corbin <kencx@peak.org>
Subject: Suspend locks up Toshiba Satelite L355-S7915
Date: Thu, 5 Nov 2009 19:28:38 -0800
Message-ID: <200911051928.38825.kencx@peak.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailscanner1.peak.org ([69.59.192.37]:32854 "EHLO
	mailscanner1.peak.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754340AbZKFDuH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Nov 2009 22:50:07 -0500
Received: from peak-mail-gateway.peak.org (mail01.peak.org [69.59.192.41])
	by mailscanner1.peak.org (8.13.8/8.13.8) with ESMTP id nA63T284001901
	for <linux-acpi@vger.kernel.org>; Thu, 5 Nov 2009 19:29:02 -0800
Received: from [192.168.2.4] (206-125-73-206.peak.org [206.125.73.206] (may be forged))
	(authenticated bits=0)
	by peak-mail-gateway.peak.org (8.12.10/8.12.8) with ESMTP id nA63SuEs077875
	for <linux-acpi@vger.kernel.org>; Thu, 5 Nov 2009 19:29:02 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi Folks,

I've installed Ubuntu 9.04 (kernel version 2.6.28-16) on a new laptop.  For 
the most part everything is working, but suspend to disk and suspend to RAM 
both lock the box up.  The shutdown looks normal, but then the screen comes 
back on with low level backlight, and the system won't respond to anything.  
Holding power button down for 5 seconds forces a poweroff and is the only way 
to recover.

I want to do whatever it takes to get this working.  I'm a pretty good C 
programmer.  I've never done any kernel hacking but am willing to learn.  
What I need now is some pointers where I should start looking.

Thanks a bunch,
-Ken


