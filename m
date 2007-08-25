From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: 2.6.23-rc3-mm1
Date: Sat, 25 Aug 2007 16:57:01 -0700
Message-ID: <20070825165701.8423f5e6.randy.dunlap@oracle.com>
References: <20070822020648.5ea3a612.akpm@linux-foundation.org>
	<46CF695D.1020008@imap.cc>
	<20070824170702.a2c51084.akpm@linux-foundation.org>
	<653FFBB4508B9042B5D43DC9E18836F5014D954E@scsmsx415.amr.corp.intel.com>
	<653FFBB4508B9042B5D43DC9E18836F5014D956A@scsmsx415.amr.corp.intel.com>
	<46D0BA9D.1080708@imap.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from agminet01.oracle.com ([141.146.126.228]:38666 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752454AbXHZACL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 25 Aug 2007 20:02:11 -0400
In-Reply-To: <46D0BA9D.1080708@imap.cc>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tilman Schmidt <tilman@imap.cc>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>, Andi Kleen <ak@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Dave Jones <davej@codemonkey.org.uk>, Thomas Renninger <trenn@suse.de>, Adam Belay <abelay@novell.com>

On Sun, 26 Aug 2007 01:26:21 +0200 Tilman Schmidt wrote:

> Am 25.08.2007 02:38 schrieb Pallipadi, Venkatesh:
> >>
> >>>> FATAL: Error inserting processor (/lib/modules/2.6.23-rc3-mm1-testing/kernel/drivers/acpi/processor.ko): Input/output error
> >>>> WARNING: Error inserting processor (/lib/modules/2.6.23-rc3-mm1-testing/kernel/drivers/acpi/processor.ko): Input/output error
> > 
> > This is indeed related to CPUIDLE.
> > 
> > Tilman: Can you configure CONFIG_CPU_IDLE in your config (under Power
> > Management option) and double check that the frequency part works after
> > that.
> 
> Strangely enough, I do not see that option in "make xconfig".
> The "Power Management" subtree ends with "CPU Frequency scaling".
> In "make menuconfig" the option is there, though.

That sounds strange.  Please share your .config file.

> After activating it, these two errors are indeed gone, and the
> "thermal: Unknown symbol acpi_processor_set_thermal_limit" one
> as well.



---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
