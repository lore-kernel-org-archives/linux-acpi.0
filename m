From: Len Brown <lenb@kernel.org>
Subject: Re: [Resend][PATCH 0/3] ACPI / PM: Patches missing from
 linux-acpi-2.6/test
Date: Mon, 13 Dec 2010 15:31:19 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1012131523320.16730@x980>
References: <201012112339.53105.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:36079 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755625Ab0LMUbt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Dec 2010 15:31:49 -0500
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LDD00848VOKQP30@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 13 Dec 2010 14:31:38 -0600 (CST)
In-reply-to: <201012112339.53105.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg59@srcf.ucam.org>

> Hi Len,
> 
> The following three patches seem to have been dropped from your 'test' branch.
> 
> If that happened by accident, please reapply.  Otherwise, please let me know
> what's wrong with the patches so that I can fix them.
> 
> [1/3] - Make fujitsu_laptop use acpi_bus_update_power() instead of
>         acpi_bus_get_power() which is unsafe.
> 
> [2/3] - Drop acpi_bus_get_power() which is unsafe and has no users.
> 
> [3/3] - Do not call __acpi_bus_get_power() from acpi_bus_set_power()
>         and remove acpi_power_nocheck that is not necessary any more.
> 
> Without these patches the power resources handling rework is incomplete and
> the code will not work correctly in some situations. 

Looks like my screw-up.

I recall inserting the fujitsu patch to fix the 
build before what were originally 12/13 and 13/13 of this series,
but apparently I kept the baseline branch and deleted the fix on top of it.

Yes, in general, I do squawk when I drop patches from acpi-test,
even if it is a temporary drop due to a time-consuming manual merge.

So thanks for noticing, I'll look at these again now.

Len Brown
Intel Open Source Technology Center
