From: Mark Lord <lkml@rtr.ca>
Subject: Re: + restore-missing-sysfs-max_cstate-attr.patch added to -mm tree
Date: Mon, 07 Jan 2008 10:06:53 -0500
Message-ID: <4782400D.2040802@rtr.ca>
References: <20071130142058.816d1693.akpm@linux-foundation.org>	<924EFEDD5F540B4284297C4DC59F3DEE2FAEAF@orsmsx423.amr.corp.intel.com>	<4750CC78.9070105@rtr.ca>	<20071130190227.1976e682@laptopd505.fenrus.org>	<4750D180.6080001@rtr.ca>	<20071130191816.3e744205@laptopd505.fenrus.org>	<4750D585.1030200@rtr.ca>	<477C2143.8090406@rtr.ca>	<924EFEDD5F540B4284297C4DC59F3DEE4FC485@orsmsx423.amr.corp.intel.com>	<477C622F.6010304@rtr.ca>	<20080104021619.GA15409@linux-os.sc.intel.com>	<47814958.3070208@rtr.ca> <20080106231848.762e93c1.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757565AbYAGPHY@vger.kernel.org>
In-Reply-To: <20080106231848.762e93c1.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Venki Pallipadi <venkatesh.pallipadi@intel.com>, Arjan van de Ven <arjan@infradead.org>, abelay@novell.com, lenb@kernel.org, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, rjw@sisk.pl
List-Id: linux-acpi@vger.kernel.org

Andrew Morton wrote:
>..
> umm, OK, I queued it for 2.6.24.  I'll give people a day or so to comment
> on this.
> 
> I had to invent some silly changlelog for it.  Please review it for
> accuracy and completeness?
..
> From: Venki Pallipadi <venkatesh.pallipadi@intel.com>
> 
> This was writeable in 2.6.23 but the cpuidle merge made it read-only.  But
> some people's scripts (ie: Mark's) were writing to it.
..

Actually, the cpuidle changes made it not appear at all in sysfs.

Thanks, Andrew & Venki.
