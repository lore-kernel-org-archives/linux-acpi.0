From: Pavel Machek <pavel@ucw.cz>
Subject: 3.9-rc3+: reports battery as 0 mWh capacity on thinkpad x60
Date: Sat, 23 Mar 2013 12:40:12 +0100
Message-ID: <20130323114011.GA11092@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39651 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708Ab3CWLkU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 23 Mar 2013 07:40:20 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, lenb@kernel.org, linux-acpi@vger.kernel.org

Hi!

pavel@amd:~$ cat /proc/acpi/battery/BAT0/info 
present:                 yes
design capacity:         0 mWh
last full capacity:      0 mWh
battery technology:      rechargeable
design voltage:          14400 mV

This worked before... at least it works in 2.6 kernel used by debian.

          	    	      	       	  	       	      	      Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
