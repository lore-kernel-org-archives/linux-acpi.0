From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/5] ACPI: procfs/sysfs/debugfs code cleanup
Date: Fri, 11 Jun 2010 12:48:32 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1006111211450.4096@localhost.localdomain>
References: <1276235269.19052.15870.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:40508 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756746Ab0FKQsv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Jun 2010 12:48:51 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L3V00HFI00XVNP2@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 11 Jun 2010 11:48:43 -0500 (CDT)
In-reply-to: <1276235269.19052.15870.camel@rzhang1-desktop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, 11 Jun 2010, Zhang Rui wrote:

> This patch set mainly cleans up the ACPI procfs/sysfs/debugfs code.
> 
> 1. removes the deprecated ACPI procfs I/F, including
>    /proc/acpi/debug_layer
>    /proc/acpi/debug_level
>    /proc/acpi/info
>    /proc/acpi/dsdt
>    /proc/acpi/fadt
>    because the sysfs I/F have been working for years without any problems.

Documentation/feature-removal-schedule.txt has warned
that we'd delete all of /proc/acpi/ for a long time now,
but we seem to have somewhat stalled out on that quest.

After this patch series, it seems like a good time to take inventory
of /proc/acpi/, list every file, and list if and when it will go away..
A section in feature-removal-schedule.txt is probably as good a place
as any for this.

Files that are deprecated should all be put under CONFIG_ACPI_PROCFS
where they should wait to be deleted for at least one release.

(Also, this patch series needs to update drivers/acpi/Kconfig comments
 because it removes some files that were aging under CONFIG_ACPI_PROCFS)

/proc/acpi/event was deemed too special to age under
CONFIG_ACPI_PROCFS, and so it has its own CONFIG_ACPI_PROC_EVENT
I think losing its default =y now would make sense,
and move it under CONFIG_ACPI_PROCFS in a year?
and hopefully delete it entirely in another year?

CONFIG_PROCFS_POWER should proably now also lose its default =y.
If current user-space no longer needs this, then
in a few releases it can get sucked under CONFIG_ACPI_PROCFS.

About 50% of button.c is suport for /proc/acpi/button/* --
it will be satisfying to simplify that one.
We tried to delete that code once, but somebody reads
the lid status, and so we restored it.
I don't know if we can get the LID status from anyplace else,
so that file may have to remain longer, but the other
/proc/acpi/button files are useuless and can go in 1 release.

thanks,
Len Brown, Intel Open Source Technology Center

