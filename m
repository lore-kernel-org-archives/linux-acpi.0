From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 0/5] ACPI: procfs/sysfs/debugfs code cleanup
Date: Sat, 12 Jun 2010 11:18:18 +0800
Message-ID: <1276312698.19052.17280.camel@rzhang1-desktop>
References: <1276235269.19052.15870.camel@rzhang1-desktop>
	 <alpine.LFD.2.00.1006111211450.4096@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:50150 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752273Ab0FLDSI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Jun 2010 23:18:08 -0400
In-Reply-To: <alpine.LFD.2.00.1006111211450.4096@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>

On Sat, 2010-06-12 at 00:48 +0800, Len Brown wrote:
> On Fri, 11 Jun 2010, Zhang Rui wrote:
> 
> > This patch set mainly cleans up the ACPI procfs/sysfs/debugfs code.
> > 
> > 1. removes the deprecated ACPI procfs I/F, including
> >    /proc/acpi/debug_layer
> >    /proc/acpi/debug_level
> >    /proc/acpi/info
> >    /proc/acpi/dsdt
> >    /proc/acpi/fadt
> >    because the sysfs I/F have been working for years without any problems.
> 
> Documentation/feature-removal-schedule.txt has warned
> that we'd delete all of /proc/acpi/ for a long time now,
> but we seem to have somewhat stalled out on that quest.
> 
> After this patch series, it seems like a good time to take inventory
> of /proc/acpi/, list every file, and list if and when it will go away..
> A section in feature-removal-schedule.txt is probably as good a place
> as any for this.
> 
> Files that are deprecated should all be put under CONFIG_ACPI_PROCFS
> where they should wait to be deleted for at least one release.
> 
> (Also, this patch series needs to update drivers/acpi/Kconfig comments
>  because it removes some files that were aging under CONFIG_ACPI_PROCFS)
> 
Agree.

> /proc/acpi/event was deemed too special to age under
> CONFIG_ACPI_PROCFS, and so it has its own CONFIG_ACPI_PROC_EVENT

Do you know any progress about this?
is acpid going to switch to netlink events or anything else?

> I think losing its default =y now would make sense,

We may got a lot of bug reports if acpid can not catch the ACPI events
any more...

> and move it under CONFIG_ACPI_PROCFS in a year?
> and hopefully delete it entirely in another year?
> 
> CONFIG_PROCFS_POWER should proably now also lose its default =y.
> If current user-space no longer needs this, then
> in a few releases it can get sucked under CONFIG_ACPI_PROCFS.
> 
question is that does user-space still need this?
how does the current Ubuntu/Fedora get the AC/Battery status?

> About 50% of button.c is suport for /proc/acpi/button/* --
> it will be satisfying to simplify that one.
> We tried to delete that code once, but somebody reads
> the lid status, and so we restored it.
> I don't know if we can get the LID status from anyplace else,

we can add sysfs I/F for button drivers as the last choice, if we can
not get the lid status via input layer or any other place generic.

> so that file may have to remain longer, but the other
> /proc/acpi/button files are useuless and can go in 1 release.
> 
Agree.

thanks,
rui

