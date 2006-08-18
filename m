From: Dave Jones <davej@redhat.com>
Subject: Re: acpi-cpufreq oddness
Date: Fri, 18 Aug 2006 16:54:44 -0400
Message-ID: <20060818205444.GA28979@redhat.com>
References: <EB12A50964762B4D8111D55B764A84547771E4@scsmsx413.amr.corp.intel.com> <20060818190454.GB18750@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from c-66-30-195-131.hsd1.ma.comcast.net ([66.30.195.131]:37589 "EHLO
	nwo.kernelslacker.org") by vger.kernel.org with ESMTP
	id S964918AbWHRUz3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Aug 2006 16:55:29 -0400
Content-Disposition: inline
In-Reply-To: <20060818190454.GB18750@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, cpufreq@lists.linux.org.uk, linux-acpi@vger.kernel.org

On Fri, Aug 18, 2006 at 03:04:54PM -0400, Dave Jones wrote:

 > No, there's nothing in dmesg.
 > This is from the perror() in modprobe printing out the human-readable form
 > of -EINVAL
 > 
 > An strace shows ..
 > 
 > init_module(0x8287a88, 16244, "")       = -1 EINVAL (Invalid argument)
 > write(2, "FATAL: Error inserting acpi_cpuf"..., 139FATAL: Error inserting acpi_cpufreq (/lib/modules/2.6.17-1.2571.fc6/kernel/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.ko): Invalid argument

Ok, after a bit more investigation, the -EINVAL seems to be coming
from acpi_processor_preregister_performance()
Should ..
                if (!performance || !performance[i]) {
                        retval = -EINVAL;
                        continue;
                }

be -ENODEV perhaps ?

		Dave

-- 
http://www.codemonkey.org.uk
