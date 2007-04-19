From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: CPU_IDLE prevents resuming from STR [was: Re: 2.6.21-rc6-mm1]
Date: Thu, 19 Apr 2007 09:05:40 +0800
Message-ID: <1176944740.7371.26.camel@sli10-conroe.sh.intel.com>
References: <20070408143559.f5014629.akpm@linux-foundation.org>
	 <20070413234513.GA2940@inferi.kami.home>
	 <1176691227.6993.1.camel@sli10-conroe.sh.intel.com>
	 <Pine.LNX.4.63.0704162243070.3859@dashnine.joshuawise.com>
	 <1176792455.7371.7.camel@sli10-conroe.sh.intel.com>
	 <Pine.LNX.4.63.0704181854150.3859@dashnine.joshuawise.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:48268 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030988AbXDSBJI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Apr 2007 21:09:08 -0400
In-Reply-To: <Pine.LNX.4.63.0704181854150.3859@dashnine.joshuawise.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joshua Wise <joshua@joshuawise.com>
Cc: Mattia Dongili <malattia@linux.it>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

On Wed, 2007-04-18 at 19:00 -0400, Joshua Wise wrote:
> On Tue, 17 Apr 2007, Shaohua Li wrote:
> > Looks there is init order issue of sysfs files. The new refreshed patch
> > should fix your bug.
> 
> Yes, that did fix the hang on resume from STR -- that now works fine.
> 
> However:
> joshua@rebirth:/sys/devices/system/cpu/cpuidle$ cat available_drivers current_driver
> 
> <NULL>
> joshua@rebirth:/sys/devices/system/cpu/cpuidle$ cat available_governors current_governor
> ladder
> ladder
it's correct and looks you didn't compile the acpi processor module.

Thanks,
Shaohua
