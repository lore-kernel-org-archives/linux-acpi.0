From: Lex Neva <acpi@lexneva.name>
Subject: How I got my LCD brightness keys to work
Date: Thu, 5 Apr 2007 12:51:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0704051213540.28998@lexneva.name>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lexneva.name ([207.210.101.78]:2567 "EHLO lexneva.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767135AbXDERPD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 5 Apr 2007 13:15:03 -0400
Received: from localhost ([127.0.0.1])
	by lexneva.name with esmtp (Exim 4.62 #1 (Debian))
	id 1HZVAs-0007dU-Fy
	for <linux-acpi@vger.kernel.org>; Thu, 05 Apr 2007 12:51:02 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I recently bought a Sager NP2030c laptop[1], and most ACPI bits seem to be 
supported by the 2.6.19 kernel.  I did have to do a little minor kernel 
surgery to get the brightness adjustment buttons (Fn+F4 and Fn+F5) working, so 
I thought I'd share what I did in hopes that it'll help the developers.  I 
apologize in advance if this is already outdated information.

The keys were both resulting in "video device notify" lines in my kernel log, 
although only one was actually making it to userland through acpid.  I threw 
a few printks into video.c, and discovered that the following video notify 
codes are being sent:

Fn+F5 (brightness up) 0x86
Fn+F6 (brightness down) 0x87

0x86 corresponds to VIDEO_DEVICE_NOTIFY_DISPLAY_OFF, so I'm kind of glad 
that's not implemented.  0x87 has no #define.  I added a #define for it and 
added code to make sure that video.c sends an event to userland for 0x87.  It 
seems that the brightness-adjusting code in my video.c isn't implemented, but 
that's fine with me; I just wrote some very machine-specific scripting to 
handle the events from acpid and use the /proc interface to adjust my LCD's 
brightness one notch up or down.  Voila!  It worked perfectly.

[1] http://www.sagernotebook.com/pages/notebooks/product2.cfm?ProductType=2030&SubType=C
