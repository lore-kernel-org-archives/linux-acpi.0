From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 3.14-rc: /proc/acpi/battery gone?
Date: Fri, 14 Mar 2014 22:20:04 +0100
Message-ID: <20140314212004.GA23731@amd.pavel.ucw.cz>
References: <20140314211456.GA23213@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45529 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754747AbaCNVUG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Mar 2014 17:20:06 -0400
Content-Disposition: inline
In-Reply-To: <20140314211456.GA23213@amd.pavel.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, linux-acpi@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>

Hi!

> It seems /proc/acpi/battery interface is gone, and I don't see any
> option to reintroduce it... what is going on?
> 
> (I got into habit of archiving content of /proc/acpi/battery to
> monitor, how battery ages..)

And this is ungood:

pavel@duo:~/denx/active$ cat /sys/class/power_supply/BAT0/alarm 
2403000

What is it? Not exactly easy to guess, and not documented. 

pavel@duo:~$ grep alarm /data/l/linux-good/Documentation/ABI/*/*
/data/l/linux-good/Documentation/ABI/testing/sysfs-ptp:What:
/sys/class/ptp/ptpN/n_alarms
/data/l/linux-good/Documentation/ABI/testing/sysfs-ptp:		alarms
offer by the PTP hardware clock.
pavel@duo:~$ 

I wish files with physical values included units. alarm is probably in
uA, but it might be uW as well, and ... :-(.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
