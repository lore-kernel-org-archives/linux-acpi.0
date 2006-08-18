From: Dave Jones <davej@redhat.com>
Subject: Re: acpi-cpufreq oddness
Date: Fri, 18 Aug 2006 15:04:54 -0400
Message-ID: <20060818190454.GB18750@redhat.com>
References: <EB12A50964762B4D8111D55B764A84547771E4@scsmsx413.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from c-66-30-195-131.hsd1.ma.comcast.net ([66.30.195.131]:4818 "EHLO
	nwo.kernelslacker.org") by vger.kernel.org with ESMTP
	id S932099AbWHRTFO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Aug 2006 15:05:14 -0400
Content-Disposition: inline
In-Reply-To: <EB12A50964762B4D8111D55B764A84547771E4@scsmsx413.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, cpufreq@lists.linux.org.uk

On Fri, Aug 18, 2006 at 11:59:26AM -0700, Pallipadi, Venkatesh wrote:

 > >I don't have handy access to a git tree at the moment, and 
 > >I've forgotten
 > >the history of the recent changes here.
 > >
 > >Alexey/Len, any ideas whats going on here?
 > >
 > >		Dave
 > >
 > 
 > Does the error say "Invalid _PSD data" or something similar. Seems to be
 > a side-effect of earlier software co-ordination patchset. If this is the
 > error you are seeing, I will send in a quick patch to fix it.

No, there's nothing in dmesg.
This is from the perror() in modprobe printing out the human-readable form
of -EINVAL

An strace shows ..

init_module(0x8287a88, 16244, "")       = -1 EINVAL (Invalid argument)
write(2, "FATAL: Error inserting acpi_cpuf"..., 139FATAL: Error inserting acpi_cpufreq (/lib/modules/2.6.17-1.2571.fc6/kernel/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.ko): Invalid argument


		Dave


-- 
http://www.codemonkey.org.uk
