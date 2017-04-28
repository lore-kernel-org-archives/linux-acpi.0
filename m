From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] acpi: fix acpi_get_table() leak / acpi-sysfs denial of service
Date: Fri, 28 Apr 2017 02:31:18 +0200
Message-ID: <1937873.b5pFZVzxiV@aspire.rjw.lan>
References: <149315024459.9151.4555045488194999231.stgit@dwillia2-desk3.amr.corp.intel.com> <1AE640813FDE7649BE1B193DEA596E886CE998CF@SHSMSX101.ccr.corp.intel.com> <CAPcyv4jk3iCOmvq06s++KM6zJdi=DXRq-KYosT+rWOBkF=Dpsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:44682 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754219AbdD1Ahf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 27 Apr 2017 20:37:35 -0400
In-Reply-To: <CAPcyv4jk3iCOmvq06s++KM6zJdi=DXRq-KYosT+rWOBkF=Dpsg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Seetharaman, Anush" <anush.seetharaman@intel.com>, "Kasanicky, Tiffany J" <tiffany.j.kasanicky@intel.com>, "Jensen, Ryon" <ryon.jensen@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Stable <stable@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Jacque, Kristin" <kristin.jacque@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>

On Thursday, April 27, 2017 07:48:32 AM Dan Williams wrote:
> On Wed, Apr 26, 2017 at 11:49 PM, Zheng, Lv <lv.zheng@intel.com> wrote:
> > Hi, Rafael
> >
> >> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Rafael J.
> >> Wysocki
> >> Subject: Re: [PATCH v2] acpi: fix acpi_get_table() leak / acpi-sysfs denial of service
> >>
> >> On Tue, Apr 25, 2017 at 9:58 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> >> > Reading an ACPI table through the /sys/firmware/acpi/tables interface
> >> > more than 65,536 times leads to the following log message:
> >> >
> >> >  ACPI Error: Table ffff88033595eaa8, Validation count is zero after increment
> >> >   (20170119/tbutils-423)
> >> >
> >> > ...and the table being unavailable until the next reboot. Add the
> >> > missing acpi_put_table() so the table ->validation_count is decremented
> >> > after each read.
> >> >
> >> > Cc: <stable@vger.kernel.org>
> >> > Cc: Zhang Rui <rui.zhang@intel.com>
> >> > Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>
> >> > Cc: Kristin Jacque <kristin.jacque@intel.com>
> >> > Cc: Tiffany Kasanicky <tiffany.j.kasanicky@intel.com>
> >> > Cc: Ryon Jensen <ryon.jensen@intel.com>
> >> > Reported-by: Anush Seetharaman <anush.seetharaman@intel.com>
> >> > Fixes: 1c8fce27e275 ("ACPI: introduce drivers/acpi/sysfs.c")
> >> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >>
> >> I'm going to apply this, but your Fixes tag is not correct.
> >
> > Even we want to skip the so-called "short period".
> > This fix is not 100% correct.
> > It's written in a very casual way.
> > I would think it was just a material to mention me to work on this issue.
> > See, there are several acpi_get_table clones invoked in sysfs.c, it just fixed one of them.
> > So it only fixes very limited cases.
> > I'll post one for fixing sysfs calls later.
> 
> That's the point, the other problem areas can be fixed up incrementally.

Right.

> >
> > There are also several cases needing urgent care, for example, FACS table used between suspend/resume process.
> > Which can also increase the count by 1 for each suspend/resume cycle.
> > I'll post an urgent fix for this along with the sysfs one.
> >
> >>
> >> validation_count was added to struct acpi_table_desc by commit
> >>
> >> commit 174cc7187e6f088942c8e74daa7baff7b44b33c9
> >> Author: Lv Zheng <lv.zheng@intel.com>
> >> Date:   Wed Dec 14 15:04:25 2016 +0800
> >>
> >>     ACPICA: Tables: Back port acpi_get_table_with_size() and
> >> early_acpi_os_unmap_memory()
> >> from Linux kernel
> >>
> >> from the 4.10 time frame, so IMO it should be
> >>
> >> Fixes: 174cc7187e6f (ACPICA: Tables: Back port
> >> acpi_get_table_with_size() and early_acpi_os_unmap_memory() from Linux
> >> kernel)
> >
> > And TBH, IMO, my posted patch is a regression fix fixing this tag.
> > https://patchwork.kernel.org/patch/9700175/
> > It fixes my damaged brain of trying to enable this mechanism.
> > It's actually a mistake, the planned way is not that.
> >
> > I don't think fixing ~50 users could be easily achieved in just 1 cycle without triggering any other issues.
> > Especially among them, there are design changes.
> > In order to upstream this mechanism to ACPICA, I've already changed the original design.
> > Originally it's done in a different way:
> > A acpi_get_validate_table() API is prepared for those wants to pin the ACPI table in memory.
> > And it is not reference counting based.
> > Now all solution need to be re-considered due to the design change.
> > So I don't think it will be a short period.
> >
> > On the contrary, if there is no one executing a script to read/write sysfs more than 60000 times,
> > the error won't flood logs.
> 
> That's not true. Here is the log flood is how we discovered the
> problem in the first place:
> 
> https://gist.github.com/djbw/ac03ac15bde6db0301a73a33bea70521
> 
> ...this was not a deliberate loop. Now, we did find that this
> application was reading the tables more often than it should, and
> hopefully there aren't too many more applications like this out in the
> wild.
> 
> > So I was actually trying to do the right things for Linux kernel.
> > While just laying down a simple hammer without caring about user experiences could be destructive.
> > It's a disaster if some servers need to be rebooted due to this issue.
> 
> It's not a disaster in that most systems should not be re-reading the
> tables at a high enough frequency for this to matter. The fact that
> this bug has shipped in Fedora and other places without issue helps
> point out that this is hard to hit in practice.

Again, right.

Thanks,
Rafael

