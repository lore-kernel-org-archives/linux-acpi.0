From: acme <saur@acmelabs.de>
Subject: RE: 2.6.17-rc4-mm3 - kernel panic
Date: Thu, 25 May 2006 20:05:34 +0000
Message-ID: <44760E0E.90408@acmelabs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from natsluvver.rzone.de ([81.169.145.176]:1506 "EHLO
	natsluvver.rzone.de") by vger.kernel.org with ESMTP
	id S1030380AbWEYUFX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 May 2006 16:05:23 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, kristen.c.accardi@intel.com, len.brown@intel.com

Hello Kristen,

does it make sense for me to patch? I meen, if you want me to dmesg, I 
need a clean boot. But the panic occurs on boot. Since your patch makes 
nothing but logging, this makes less sense for me.
And what is that dock thing, could my WOL on S3 and NIC problem also 
have something to do with that?

Btw.: Len, I've compiled the 2.6.16.18 kernel last night, with and 
without your latest acpi-release. The result was, with patch the system 
woke up one time and the second time it died, without your patch the 
system died the very first time sending a magic packet. Funny, but 
keyboard and powerbutton are always working.

Regards,

Andreas
