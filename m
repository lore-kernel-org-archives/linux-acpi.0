From: Brennan Taylor <b4taylor@csclub.uwaterloo.ca>
Subject: asus-laptop: Hangs during poweroff, but acpi appears to work.
Date: Tue, 5 Apr 2011 14:23:44 -0400
Message-ID: <20110405182344.GC1908@taurine.csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from caffeine.csclub.uwaterloo.ca ([129.97.134.17]:50034 "EHLO
	caffeine.csclub.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753657Ab1DESXq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Apr 2011 14:23:46 -0400
Received: from taurine (taurine.csclub.uwaterloo.ca [129.97.134.34])
	by caffeine.csclub.uwaterloo.ca (Postfix) with SMTP id C99D42034
	for <linux-acpi@vger.kernel.org>; Tue,  5 Apr 2011 14:23:44 -0400 (EDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I have an Asus N53JF-A1 laptop.

I am currently running archlinux with kernel version 2.6.37.5. The asus_laptop
module is also loaded.

When I turn the laptop off it prints "Power Off" then hangs.

Reboot works and all other acpi features appear to work (both the files in
/proc/acpi and whatever conky hooks into).

Archlinux users reported that installing 2.6.38.2 from the testing repos fixed
their problems, but they did not fix mine.

I also use the acpi_call module to write raw acpi calls so I can turn off the
nvidia gpu when in linux (which is a giant power savings) but I have made sure
that this module does not get loaded incase there was any interaction there.

If this isn't a known/fixed issue, is there a way for me to debug this more
directly? Either increasing the verbosity of the powerdown, increasing the
verbosity of what the kernel prints or even running gdb.
