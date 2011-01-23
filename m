From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: Common boot/shutdown issues with the latest 2.6.37 (Mostly Asus laptops)
Date: Sun, 23 Jan 2011 16:28:46 +0200
Message-ID: <4D3C3B1E.1080500@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lider.pardus.org.tr ([193.140.100.216]:37926 "EHLO
	lider.pardus.org.tr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996Ab1AWO2n (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 23 Jan 2011 09:28:43 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, rjw@sisk.pl

Hi,

I'm getting a lot of bug reports about hanging boot/shutdowns on these days.

Most of the affected hardware are ASUS laptops. The problem is that I 
don't have access to any of those problematic laptops and the users are 
not able at all to debug/bisect what is going on. However, I have 
collected dmesgs of good/bad boots, acpidump, etc.

Here are the current status:

"Asus F50SV does not boot unless lapic is passed"
   https://bugzilla.kernel.org/show_bug.cgi?id=26502

"Regression between 2.6.35-020635-rc1 and 2.6.35-020635 breaks acpi 
support on Asus X71 laptop"
   https://bugs.launchpad.net/ubuntu/+source/linux-meta/+bug/689796

"Asus N61JQ hangs at shutdown unless lapic is passed"
(Not reported upstream yet, I've only downstream bug report which is 
Turkish)
   http://bugs.pardus.org.tr/show_bug.cgi?id=15969

"Asus X61S does not boot unless acpi=off is given"
(Not reported upstream yet, I've only downstream bug report which is 
Turkish)
   http://bugs.pardus.org.tr/show_bug.cgi?id=16322
(I've told the reporter to try with nolapic, it will probably fix the 
issue but until confirmed acpi=off is the only solution. 2.6.36 was fine)

I'll post more bugs in here as I've found them.

Thanks,

-- 
Pardus Linux
http://www.pardus.org.tr/eng
