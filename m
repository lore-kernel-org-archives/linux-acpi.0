From: Alex Chiang <achiang@canonical.com>
Subject: Re: [BUG, REGRESSION] ACPI: Set _PDC
Date: Thu, 17 Jun 2010 08:54:46 -0600
Message-ID: <20100617145445.GE2138@canonical.com>
References: <201006170040.24736.pogadl.jan@googlemail.com>
 <20100617032413.GC2138@canonical.com>
 <201006170951.26455.pogadl.jan@googlemail.com>
 <4C19D51B.90100@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:39956 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756173Ab0FQOyy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jun 2010 10:54:54 -0400
Content-Disposition: inline
In-Reply-To: <4C19D51B.90100@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chen Gong <gong.chen@linux.intel.com>
Cc: Jan Pogadl <pogadl.jan@googlemail.com>, linux-acpi@vger.kernel.org

* Chen Gong <gong.chen@linux.intel.com>:
> >On Thursday 17 June 2010 05:24:14 Alex Chiang wrote:
> >>diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
> >>index 5128435..bcf0cf8 100644
> >>--- a/drivers/acpi/processor_core.c
> >>+++ b/drivers/acpi/processor_core.c
> >>@@ -223,7 +223,7 @@ static bool processor_physically_present(acpi_handle handle)
> >>  	type = (acpi_type == ACPI_TYPE_DEVICE) ? 1 : 0;
> >>  	cpuid = acpi_get_cpuid(handle, type, acpi_id);
> >>
> >>-	if (cpuid == -1)
> >>+	if ((cpuid == -1)&&  (num_online_cpus()>  1))
> >>  		return false;
> >>
> >>  	return true;
> >>
> I have a puzzle why num_online_cpus is used here, instead of
> num_possible_cpus. It will be possible under a hotplug scenario.

Hm, you're probably right.

I was following the example of the other usage of
acpi_get_cpuid() in acpi_processor_get_info(), but based on your
observation, it's probably better to use num_possible_cpus.

I'll change it when I submit a proper patch.

Thanks for the review.

/ac
