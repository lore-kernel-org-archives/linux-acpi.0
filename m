From: Pavel Machek <pavel@suse.cz>
Subject: Re: 2.6.27-rc1: critical thermal shutdown on thinkpad x60
Date: Thu, 7 Aug 2008 11:13:18 +0200
Message-ID: <20080807091318.GA1585@elf.ucw.cz>
References: <20080806090246.GA1572@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:47392 "EHLO
	gprs189-60.eurotel.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633AbYHGVW2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Aug 2008 17:22:28 -0400
Content-Disposition: inline
In-Reply-To: <20080806090246.GA1572@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, ACPI mailing list <linux-acpi@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

Hi!

> Aug  6 11:00:10 amd kernel: ACPI: Critical trip point
> Aug  6 11:00:10 amd kernel: Critical temperature reached (128 C),
> shutting down.
> Aug  6 11:00:10 amd shutdown[24414]: shutting down for system halt
> 
> ...and machine went down at that point :-(.

This one is quite repeatable:

Aug  7 10:46:24 amd dhclient: DHCPACK from 10.20.0.2
Aug  7 10:46:24 amd dhclient: bound to 10.20.5.28 -- renewal in 7200
seconds.
Aug  7 10:50:46 amd kernel: thinkpad_acpi: unhandled HKEY event 0x6022
Aug  7 10:51:03 amd last message repeated 48 times
Aug  7 10:51:05 amd kernel: ACPI: Critical trip point
Aug  7 10:51:05 amd kernel: Critical temperature reached (128 C),
shutting down.
Aug  7 10:51:05 amd shutdown[1928]: shutting down for system halt
Aug  7 10:51:06 amd init: Switching to runlevel: 0
Aug  7 10:51:06 amd kernel: thinkpad_acpi: unhandled HKEY event 0x6022
Aug  7 10:51:09 amd last message repeated 7 times
Aug  7 10:51:09 amd kernel: ACPI: Critical trip point
Aug  7 10:51:09 amd kernel: Critical temperature reached (128 C),
shutting down.
Aug  7 10:51:12 amd exiting on signal 15
Aug  7 10:54:01 amd syslogd 1.5.0#1: restart.
Aug  7 10:54:01 amd kernel: klogd 1.5.0#1, log source = /proc/kmsg
started.

...and it does not seem to be stray reading from the sensor: cat
/proc/acpi/therm*/*/* shows the bogus value in like 5 consecutive
readings.

Plus the temperature rises up to 95C before this triggers, and machine
is so hot it refuses to start again. Trip points seem to assume 128C,
too:

root@amd:~# cat /proc/acpi/thermal_zone/THM*/trip*
critical (S5):           127 C
critical (S5):           97 C
passive:                 93 C: tc1=5 tc2=4 tsp=600 devices=CPU0 CPU1
root@amd:~#

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
