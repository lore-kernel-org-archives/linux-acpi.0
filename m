From: marco <marco@metm.org>
Subject: suspend kills serial wacom tablet
Date: Tue, 20 Feb 2007 08:52:07 -0500
Message-ID: <pan.2007.02.20.13.52.07.111117@metm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:58702 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964893AbXBTOAS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Feb 2007 09:00:18 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HJVXG-0003cL-GJ
	for linux-acpi@vger.kernel.org; Tue, 20 Feb 2007 15:00:02 +0100
Received: from dsl081-200-033.nyc2.dsl.speakeasy.net ([64.81.200.33])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Tue, 20 Feb 2007 15:00:02 +0100
Received: from marco by dsl081-200-033.nyc2.dsl.speakeasy.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Tue, 20 Feb 2007 15:00:02 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello all,

I have a thinkpad X41-tablet which uses the linuxwacom serial drivers. 
The tablet works perfectly when the laptop first boots, but does not work
at all after resuming from sleep.  I posted to the linuxwacom list but
think that the problem might be more general in how acpi resumes the
serial ports.

As suggested here:
http://www.thinkwiki.org/wiki/Installing_Ubuntu_6.10_on_a_ThinkPad_X41_Tablet
I have added a script to resume.d which calls the setserial command:
  /bin/setserial /dev/ttyS0 port 0x0200 irq 5 autoconfig

>From looking at how Ubuntu at least stores the serial configurations, I
think that the above is redundant. If I try to run the above command from
the command line after resuming from sleep I get:
  Cannot autoconfigure port: Device or resource busy
If I try to cat /dev/ttyS0 after the resume, all my trackpoint and
keyboard die, no Ctrl-Alt-Delete etc. I have to cold reboot the system.

I have tried 
  > /dev/ttyS0
As was suggested on a tread in this list to about a serial console, but
that does not revive my tablet.  Also added the above line to the resume.d
script I wrote, but this does not work.

Any ideas of what I could do to revive this serial port?  Or if you think
I am completely on the wrong path, or am posting to the wrong list, please
let me know.

Thanks for the excellent work on the acpi infrastructure. I can tell you
that daily use of a laptop has become much more pleasurable thanks to you.

-- 
Marco

