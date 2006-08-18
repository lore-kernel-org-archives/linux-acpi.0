From: Dave Jones <davej@redhat.com>
Subject: acpi-cpufreq oddness
Date: Fri, 18 Aug 2006 14:43:47 -0400
Message-ID: <20060818184347.GE4616@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from c-66-30-195-131.hsd1.ma.comcast.net ([66.30.195.131]:50363 "EHLO
	nwo.kernelslacker.org") by vger.kernel.org with ESMTP
	id S1751448AbWHRSn4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Aug 2006 14:43:56 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, cpufreq@lists.linux.org.uk, linux-acpi@vger.kernel.org

Someone reported to me that modprobe acpi-cpufreq now fails noisily
complaining about invalid arguments.  I was able to reproduce it
on one of my boxes that doesn't have any form of speed scaling at all.
Previously, the modprobe would return with -ENODEV, but now its
getting an -EINVAL from somewhere. (I'm still trying to chase down
exactly where its coming from).

So far in chasing this, all I found is a cosmetic bug,
acpi_cpufreq_target has a..
dprintk("acpi_cpufreq_setpolicy");
in it, which is the only reference to setpolicy in the whole driver.

I don't have handy access to a git tree at the moment, and I've forgotten
the history of the recent changes here.

Alexey/Len, any ideas whats going on here?

		Dave

-- 
http://www.codemonkey.org.uk
