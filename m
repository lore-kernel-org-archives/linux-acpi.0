From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 00/10] ACPI: remove several initcalls
Date: Fri, 27 Mar 2009 12:57:54 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903271254070.26419@localhost.localdomain>
References: <20090324224834.1262.65260.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:58153 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753522AbZC0Q6F (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Mar 2009 12:58:05 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH600HWBCGKYC5P@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 11:57:56 -0500 (CDT)
In-reply-to: <20090324224834.1262.65260.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org, Li Shaohua <shaohua.li@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>Li Shaohua <shaohua.li@intel.com>, Zhao Yakui <yakui.zhao@intel.com>

On Tue, 24 Mar 2009, Bjorn Helgaas wrote:

> These patches change several ACPI initcalls to explicit calls.
> This removes dependencies on link order and makes the code
> clearer.
> 
> Comments welcome.
> 
> ---
> 
> Bjorn Helgaas (10):
>       ACPI: tidy up makefile
>       ACPI: call acpi_wakeup_device_init() explicitly rather than as initcall
>       ACPI: call acpi_sleep_proc_init() explicitly rather than as initcall
>       ACPI: call init_acpi_device_notify() explicitly rather than as initcall
>       ACPI: call acpi_debug_init() explicitly rather than as initcall
>       ACPI: call acpi_system_init() explicitly rather than as initcall
>       ACPI: call acpi_power_init() explicitly rather than as initcall
>       ACPI: call acpi_ec_init() explicitly rather than as initcall
>       ACPI: call acpi_scan_init() explicitly rather than as initcall
>       ACPI: skip DMI power state check when ACPI disabled

nice cleanup, Bjorn -- applied.

I'm fine with the #ifdef in debug.c, BTW.

Indeed, I'd accept a patch to delete the /proc part of debug.c,
since it is obsolete by the modparam code above it, and we warned
over a year ago that it will go away.

thanks,
-Len Brown, Intel Open Source Technology Center

