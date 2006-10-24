From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: ia64 acpi-cpufreq driver
Date: Tue, 24 Oct 2006 11:50:30 -0600
Message-ID: <200610241150.31012.bjorn.helgaas@hp.com>
References: <EB12A50964762B4D8111D55B764A8454C57982@scsmsx413.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:49843 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1161121AbWJXRun (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Oct 2006 13:50:43 -0400
In-Reply-To: <EB12A50964762B4D8111D55B764A8454C57982@scsmsx413.amr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-ia64@vger.kernel.org

On Monday 23 October 2006 22:46, Pallipadi, Venkatesh wrote:
> Actually it is slightly different from low_level_read and write. 
> Generic ACPI definition of ACPI PERF_CTRL and PERF_STATUS define 
> them as if they are registers. But, with FfixedHW, ACPI allows 
> architectures to implement this functionality in a native way.
> Just like x86 implements FfixedHW based P-state support in 16 bits 
> of some known MSR (Note the register field itself in _PCT is not used)
> or FFH C-states are supported by native instructions like "hlt",
> "monitor-mwait".
> 
> So, when firmware tells P-state are FFH, OS will look at the hardware 
> and processor information and use appropriate native interfaces. 
> In this case, appropriate native interface is PAL_GET_PSTATE 
> and PAL_SET_PSTATE.

Clearly ia64 ultimately has to use PAL_SET_PSTATE.  My question
is, does the PAL_SET_PSTATE call belong in acpi-cpufreq, or does
it belong in the FFH driver?

I think it belongs in the latter, because the OSPM can be more
generic if the architecture-specific stuff is in the FFH driver.

Another way to ask this is, if ia64 had an FFH driver, who would
use it?  I assume acpi-cpufreq would be one user.  If so, what
interface would acpi-cpufreq use to access FFH?

Bjorn
