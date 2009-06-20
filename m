From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/3] ACPICA/ACPI: clean up power button event management
 during resume
Date: Sat, 20 Jun 2009 01:06:15 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0906200105440.13037@localhost.localdomain>
References: <20090619205713.30130.79530.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:49860 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585AbZFTGzn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 20 Jun 2009 02:55:43 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KLI00M3FU6GVBI1@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 20 Jun 2009 00:06:17 -0500 (CDT)
In-reply-to: <20090619205713.30130.79530.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Bob Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org

series applied to acpi-test

however, i will not push this series upstream as it is...
will wait for the patches to flow from acpica.

thanks,
Len Brown, Intel Open Source Technology Center

On Fri, 19 Jun 2009, Bjorn Helgaas wrote:

> This mini-series moves a little resume-path code from the host OS
> (Linux in this case) into the ACPI CA.
> 
> When resuming, OSPM must clear GPEs and power button events to prevent
> taking spurious events when interrupts are enabled.  Linux currently
> clears these events itself, but this series adds code to do it in the
> ACPICA (in acpi_leave_sleep_state_prep(), which is already supposed to
> be called before enabling interrupts).  This should be safe without
> any host OS changes.
> 
> The last patch takes out the event clearing from Linux and obviously
> depends on the previous ACPICA patches.  It's safe to drop this one
> (no harm in clearing the events twice).  I can easily post it again
> later.
> 
> ---
> 
> Bjorn Helgaas (3):
>       ACPICA: Use fixed event wrappers to enable/disable/clear
>       ACPICA: Clear GPEs and power button events during wakeup
>       ACPI: remove clearing of events on resume, now that ACPI CA does it
> 
> 
>  drivers/acpi/acpica/evevent.c |   13 +++----------
>  drivers/acpi/acpica/hwsleep.c |   24 +++++++-----------------
>  drivers/acpi/sleep.c          |   14 --------------
>  3 files changed, 10 insertions(+), 41 deletions(-)
> 
> -- 
> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
