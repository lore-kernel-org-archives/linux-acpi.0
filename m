From: Borislav Petkov <bp@alien8.de>
Subject: Re: 174cc7187e6f ACPICA: Tables: Back port
 acpi_get_table_with_size() and early_acpi_os_unmap_memory() from Linux
 kernel
Date: Wed, 11 Jan 2017 11:03:23 +0100
Message-ID: <20170111100323.5srwcfmwfsui23db@pd.tnic>
References: <20170109231501.xrhwsv46mznw3kqt@pd.tnic>
 <20170109233204.GG3800@linux.vnet.ibm.com>
 <20170109234039.mfefmv5dv4shxnfn@pd.tnic>
 <20170109235211.yetponvbexvalkir@pd.tnic>
 <CAJZ5v0gRYcC5fJZF207iyehvPR9_2zqprSvWHA_Qt93W9njqAw@mail.gmail.com>
 <20170110022338.GJ3800@linux.vnet.ibm.com>
 <1AE640813FDE7649BE1B193DEA596E886CE286C3@SHSMSX101.ccr.corp.intel.com>
 <20170110055129.GK3800@linux.vnet.ibm.com>
 <20170111092105.3y57tyeskpyjtmxi@pd.tnic>
 <20170111095156.GR3800@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:45441 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965533AbdAKKD3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 11 Jan 2017 05:03:29 -0500
Content-Disposition: inline
In-Reply-To: <20170111095156.GR3800@linux.vnet.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Moore, Robert" <robert.moore@intel.com>, J?rg R?del <joro@8bytes.org>, lkml <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On Wed, Jan 11, 2017 at 01:51:56AM -0800, Paul E. McKenney wrote:
> Yes, you could make RCU expedited grace periods go back to using the
> requesting task, and that would allow expedited grace periods to run early
> in the boot process.  But that causes problems with signals and the like
> unless you revert a few other patches.  The bugzilla is interesting --
> it looks like ACPI was in some cases doing early-boot grace-period waits
> some time back?

I think this and https://bugzilla.suse.com/show_bug.cgi?id=1017783 is an
example of a bunch of toshiba schlaptops which cause the issue. So it
looks like ACPI is doing something very early on those which tickles the
issue to happen.

But this is ACPI - anything can happen!

> I have a limping prototype RCU patch that should avoid this problem.
>
> If all goes well, I will send it out late tomorrow evening, Pacific Time.

Attach it to the bugzilla too, pls, because the people there trigger the
issue.

I have the respective(?) SUSE bug and I can ask people there to run it
too.

Thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
