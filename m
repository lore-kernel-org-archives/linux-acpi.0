From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [linux-pm] Occasional (too common) suspend problem
Date: Fri, 21 Jan 2011 13:26:58 +0800
Message-ID: <1295587618.11852.57.camel@minggr.sh.intel.com>
References: <AANLkTikBRf00H_6YcS9nsnJG68WguDzL_AvNTRyDWRY=@mail.gmail.com>
	 <AANLkTi=LyufFJ-zqMWdGnSnZ-iW+ONbQ8mLfTn1O5WVi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:24672 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750695Ab1AUF0c (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Jan 2011 00:26:32 -0500
In-Reply-To: <AANLkTi=LyufFJ-zqMWdGnSnZ-iW+ONbQ8mLfTn1O5WVi@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Jeff Chua <jeff.chua.linux@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, "Moore, Robert" <robert.moore@intel.com>

On Fri, 2011-01-21 at 13:23 +0800, Lin Ming wrote:
> ---------- Forwarded message ----------
> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Fri, Jan 21, 2011 at 12:50 PM
> Subject: [linux-pm] Occasional (too common) suspend problem
> To: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>,
> Jeff Chua <jeff.chua.linux@gmail.com>, ACPI Devel Maling List
> <linux-acpi@vger.kernel.org>, Linux-pm mailing list
> <linux-pm@lists.linux-foundation.org>
> 
> 
> So I have one remaining problem on my nasty EeePC problem child
> computer, and this one I cannot bisect simply because it's so flaky.
> 
> The exact same kernel may suspend and resume many many times in a row,
> and then I reboot it, and it hangs on the first suspend. Very
> occasionally the machine comes back when I press a key, and resumes
> ok. Most of the time it does not - it's just dead to the world, and
> there are no logs to go by. I even tried pm_trace, and that didn't get
> me anywhere, although I once got a hash match:
> 
>  hash matches drivers/base/power/main.c:555
> 
> which is the last part of a deivice_resume(), but none of the devices
> matched, so that didn't really give any information at all.
> 
> So I have very little to go on.
> 
> However, at least one time when it failed and came back (remember:
> very rare), I did get that suspend sequence printouts logged. Here's a
> _good_ suspend:
> 
>  ...
>  [   79.596367] PM: Saving platform NVS memory
>  [   79.596378] Disabling non-boot CPUs ...
>  [   79.700053] CPU 1 is now offline
>  [   79.700565] PM: Restoring platform NVS memory
>  [   79.700565] Enabling non-boot CPUs ...
>  [   79.700565] Booting Node 0 Processor 1 APIC 0x1
>  [   79.597894] Initializing CPU#1
>  ...
> 
> and here's the one that failed and then ended up coming back on a keypress:
> 
>  ...
>  [   54.628375] PM: Saving platform NVS memory
>  [   54.628387] Disabling non-boot CPUs ...
>  [   63.554966] ACPI Exception: AE_BAD_PARAMETER, Returned by Handler
> for [EmbeddedControl] (20110112/evregion-474)
>  [   63.554992] ACPI Error: Method parse/execution failed
> [\_SB_.PCI0.SBRG.EC0_.RCTP] (Node f5c2dea0), AE_BAD_PARAMETER
> (20110112/psparse-536)
>  [   63.555022] ACPI Error: Method parse/execution failed
> [\_TZ_.RTMP] (Node f5c32fa8), AE_BAD_PARAMETER (20110112/psparse-536)
>  [   63.555047] ACPI Error: Method parse/execution failed
> [\_TZ_.TZ00._TMP] (Node f5c34018), AE_BAD_PARAMETER
> (20110112/psparse-536)
>  [   63.555079] Thermal: failed to read out thermal zone 0
>  [   63.556361] CPU 1 is now offline
>  [   63.556944] PM: Restoring platform NVS memory
>  [   63.556944] Enabling non-boot CPUs ...
>  [   63.556944] Booting Node 0 Processor 1 APIC 0x1
>  [   63.556279] Initializing CPU#1
>  ...
> 
> which really doesn't tell me much, except that clearly something in
> ACPI-land is unhappy, and it looks thermal-related (that last error
> message comes from thermal_zone_device_update()).
> 
> Any ideas?

Does revert bba63a29(ACPICA: Implicit notify support) help?

Lin Ming

> 
>                    Linus
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm


