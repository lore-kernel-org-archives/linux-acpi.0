From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: CPU_IDLE prevents resuming from STR [was: Re: 2.6.21-rc6-mm1]
Date: Mon, 16 Apr 2007 10:40:27 +0800
Message-ID: <1176691227.6993.1.camel@sli10-conroe.sh.intel.com>
References: <20070408143559.f5014629.akpm@linux-foundation.org>
	 <20070413234513.GA2940@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:20810 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754198AbXDPCns (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 15 Apr 2007 22:43:48 -0400
In-Reply-To: <20070413234513.GA2940@inferi.kami.home>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

On Sat, 2007-04-14 at 01:45 +0200, Mattia Dongili wrote:
> On Sun, Apr 08, 2007 at 02:35:59PM -0700, Andrew Morton wrote:
> ...
> >  git-acpi.patch
> 
> after bisecting I can finally say what breaks resume from STR here:
> 
> tadaaaaa: CPU_IDLE.
> I first spotted the git-acpi.patch then reapplied it and disabled
> CPU_IDLE, now my laptop resumes.
> 
> Any useful information I should add?
> 
> $ cat /sys/devices/system/cpu/cpuidle/*
> acpi_idle 
> no governors
> acpi_idle
> no governor
please check if the patch at
http://marc.info/?l=linux-acpi&m=117523651630038&w=2 fixed the issue

Thanks,
Shaohua
