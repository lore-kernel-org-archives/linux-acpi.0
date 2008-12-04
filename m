From: Matthias Heinz <mheinz@cs.uni-frankfurt.de>
Subject: samsung x360, acpi support
Date: Thu, 4 Dec 2008 19:15:39 +0100
Message-ID: <200812041915.39971.mheinz@cs.uni-frankfurt.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.rbi.informatik.uni-frankfurt.de ([141.2.1.1]:49988 "EHLO
	hera.rbi.informatik.uni-frankfurt.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752562AbYLDSmu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Dec 2008 13:42:50 -0500
Received: from bounty.local (p54B17DE0.dip.t-dialin.net [84.177.125.224])
	(authenticated bits=0)
	by hera.rbi.informatik.uni-frankfurt.de (8.13.8/8.13.8) with ESMTP id mB4IFhJP013386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Thu, 4 Dec 2008 19:15:46 +0100
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

as you can see from the topic i got a Samsung X360 right here. It works pretty 
fine, thanks to the fact that its more Intel than Samsung.

But i got some problems.

1) Backlight support: I cant control the brightness of the backlight with a 
2.6.28-rc7. It worked under mysterious circumstances with a 2.6.26. 
Mysterious, because i had to use /proc/acpi/video/NVID/LCD/brightness to set 
it, which obviously belongs to a nvidia driver (but theres nothing from 
nvidia in there...)
I just found out that its possible to disable the backlight, without disabling 
the display. Doesn't work, too.

2) Wifi LED: I dont know if this is a wifi driver issue or has to be 
controlled by acpi. 

3) The keyboard is not sending acpi events for several switches. It sends 
(unknown) keycodes that have to be interpreted by the OS.
But there seems to be an option to change between acpi events and key events, 
because i can control the backlight when grub is running and in the early 
boot phase of the kernel. I dont know if this should be classified as 
problem, but because X is catching all key events handling the wlan power 
function is a problem of the actual user.

I'll be grateful for any advice.

I've got a copy of acpidump output here:
http://www.cs.uni-frankfurt.de/~mheinz/acpidump-samsungx360.txt

Please tell me, if you need more informations.

Best regards,
Matthias
