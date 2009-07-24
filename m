From: Dave Jones <davej@redhat.com>
Subject: Re: [Patch] CPUFREQ: Add the suspend/resume flag to avoid smp_call
	in cpufreq_suspend/resume
Date: Thu, 23 Jul 2009 21:49:18 -0400
Message-ID: <20090724014918.GA8854@redhat.com>
References: <1248399463.3556.30.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:53261 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751342AbZGXBtV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Jul 2009 21:49:21 -0400
Content-Disposition: inline
In-Reply-To: <1248399463.3556.30.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ykzhao <yakui.zhao@intel.com>
Cc: cpufreq@vger.kernel.org, linux-acpi@vger.kernel.org

On Fri, Jul 24, 2009 at 09:37:43AM +0800, ykzhao wrote:
 > Subject: [CPUFREQ]: Add the suspend/resume flag to avoid smp_call in cpufreq_suspend/resume 
 > From: Zhao Yakui <yakui.zhao@intel.com>
 > 
 > Only CPU0 is available in course of cpufreq_suspend/resume.
 > So it is unnecessary to do the smp_call for getting the current
 > cpufreq.
 > 
 > Add a flag of suspend/resume to avoid the smp_call in course of
 > cpufreq_suspend/resume.
 > 
 > http://bugzilla.kernel.org/show_bug.cgi?id=13781
 > http://bugzilla.kernel.org/show_bug.cgi?id=13269
 > 
 > Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
 > Tested-by: Christian Casteyde<casteyde.christian@free.fr>

All this goes away if we just made that suspend/resume code
conditional on powerpc as previously discussed.

We don't need any of it on x86 afaict

	Dave
