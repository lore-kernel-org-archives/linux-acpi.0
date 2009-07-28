From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [Patch] CPUFREQ: Add the suspend/resume flag to avoid smp_call
	in cpufreq_suspend/resume
Date: Tue, 28 Jul 2009 09:40:12 +0800
Message-ID: <1248745212.3556.74.camel@localhost.localdomain>
References: <1248399463.3556.30.camel@localhost.localdomain>
	 <20090724014918.GA8854@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:9196 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750930AbZG1Bjy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Jul 2009 21:39:54 -0400
In-Reply-To: <20090724014918.GA8854@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, 2009-07-24 at 09:49 +0800, Dave Jones wrote:
> On Fri, Jul 24, 2009 at 09:37:43AM +0800, ykzhao wrote:
>  > Subject: [CPUFREQ]: Add the suspend/resume flag to avoid smp_call in cpufreq_suspend/resume 
>  > From: Zhao Yakui <yakui.zhao@intel.com>
>  > 
>  > Only CPU0 is available in course of cpufreq_suspend/resume.
>  > So it is unnecessary to do the smp_call for getting the current
>  > cpufreq.
>  > 
>  > Add a flag of suspend/resume to avoid the smp_call in course of
>  > cpufreq_suspend/resume.
>  > 
>  > http://bugzilla.kernel.org/show_bug.cgi?id=13781
>  > http://bugzilla.kernel.org/show_bug.cgi?id=13269
>  > 
>  > Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
>  > Tested-by: Christian Casteyde<casteyde.christian@free.fr>
> 
> All this goes away if we just made that suspend/resume code
> conditional on powerpc as previously discussed.
Hi, Dave
    Will you please point out what we should do to fix the issue son x86
similar to that on powerpc?
    
    Is the patch mentioned already shipped in upstream kernel?

thanks.
> 
> We don't need any of it on x86 afaict
> 
> 	Dave

