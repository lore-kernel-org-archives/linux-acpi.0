From: Dave Jones <davej@redhat.com>
Subject: Re: acpi-cpufreq oddness
Date: Fri, 18 Aug 2006 17:09:27 -0400
Message-ID: <20060818210926.GB28979@redhat.com>
References: <EB12A50964762B4D8111D55B764A84547771E4@scsmsx413.amr.corp.intel.com> <20060818190454.GB18750@redhat.com> <20060818134517.A22660@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from c-66-30-195-131.hsd1.ma.comcast.net ([66.30.195.131]:39817 "EHLO
	nwo.kernelslacker.org") by vger.kernel.org with ESMTP
	id S964929AbWHRVKG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Aug 2006 17:10:06 -0400
Content-Disposition: inline
In-Reply-To: <20060818134517.A22660@unix-os.sc.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, cpufreq@lists.linux.org.uk

On Fri, Aug 18, 2006 at 01:45:17PM -0700, Venkatesh Pallipadi wrote:

 > EINVAL is actually coming from early_init call and the return value of that
 > call should be ignored. Attached patch resolves the issue.
 
Ok, that'll do the trick :)

The -EINVAL actually came from this bit..

                pr->performance = performance[i];
                cpu_set(i, pr->performance->shared_cpu_map);
                if (acpi_processor_get_psd(pr)) {
                        retval = -EINVAL;
                        continue;
                }

I'll push this on tonight..

		Dave
-- 
http://www.codemonkey.org.uk
