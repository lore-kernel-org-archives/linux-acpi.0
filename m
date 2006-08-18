From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: RE: acpi-cpufreq oddness
Date: Fri, 18 Aug 2006 11:59:26 -0700
Message-ID: <EB12A50964762B4D8111D55B764A84547771E4@scsmsx413.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:22863 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1161081AbWHRS72 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Aug 2006 14:59:28 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dave Jones <davej@redhat.com>, Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, cpufreq@lists.linux.org.uk



>-----Original Message-----
>From: cpufreq-bounces@lists.linux.org.uk 
>[mailto:cpufreq-bounces@lists.linux.org.uk] On Behalf Of Dave Jones
>Sent: Friday, August 18, 2006 11:44 AM
>To: Alexey Starikovskiy
>Cc: Brown, Len; linux-acpi@vger.kernel.org; cpufreq@lists.linux.org.uk
>Subject: acpi-cpufreq oddness
>
>Someone reported to me that modprobe acpi-cpufreq now fails noisily
>complaining about invalid arguments.  I was able to reproduce it
>on one of my boxes that doesn't have any form of speed scaling at all.
>Previously, the modprobe would return with -ENODEV, but now its
>getting an -EINVAL from somewhere. (I'm still trying to chase down
>exactly where its coming from).
>
>So far in chasing this, all I found is a cosmetic bug,
>acpi_cpufreq_target has a..
>dprintk("acpi_cpufreq_setpolicy");
>in it, which is the only reference to setpolicy in the whole driver.
>
>I don't have handy access to a git tree at the moment, and 
>I've forgotten
>the history of the recent changes here.
>
>Alexey/Len, any ideas whats going on here?
>
>		Dave
>

Does the error say "Invalid _PSD data" or something similar. Seems to be
a side-effect of earlier software co-ordination patchset. If this is the
error you are seeing, I will send in a quick patch to fix it.

Thanks,
Venki 
