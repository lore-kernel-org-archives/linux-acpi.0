From: Len Brown <lenb@kernel.org>
Subject: Re: Occasional (too common) suspend problem
Date: Fri, 21 Jan 2011 16:00:44 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1101211550190.3924@x980>
References: <AANLkTikBRf00H_6YcS9nsnJG68WguDzL_AvNTRyDWRY=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:64049 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039Ab1AUVBH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Jan 2011 16:01:07 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LFE00I2Q51FZ1E4@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 21 Jan 2011 15:00:56 -0600 (CST)
In-reply-to: <AANLkTikBRf00H_6YcS9nsnJG68WguDzL_AvNTRyDWRY=@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Jeff Chua <jeff.chua.linux@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>

> and here's the one that failed and then ended up coming back on a keypress:
> 
>   ...
>   [   54.628375] PM: Saving platform NVS memory
>   [   54.628387] Disabling non-boot CPUs ...
>   [   63.554966] ACPI Exception: AE_BAD_PARAMETER, Returned by Handler
> for [EmbeddedControl] (20110112/evregion-474)
>   [   63.554992] ACPI Error: Method parse/execution failed
> [\_SB_.PCI0.SBRG.EC0_.RCTP] (Node f5c2dea0), AE_BAD_PARAMETER
> (20110112/psparse-536)
>   [   63.555022] ACPI Error: Method parse/execution failed
> [\_TZ_.RTMP] (Node f5c32fa8), AE_BAD_PARAMETER (20110112/psparse-536)
>   [   63.555047] ACPI Error: Method parse/execution failed
> [\_TZ_.TZ00._TMP] (Node f5c34018), AE_BAD_PARAMETER
> (20110112/psparse-536)
>   [   63.555079] Thermal: failed to read out thermal zone 0
>   [   63.556361] CPU 1 is now offline
>   [   63.556944] PM: Restoring platform NVS memory
>   [   63.556944] Enabling non-boot CPUs ...
>   [   63.556944] Booting Node 0 Processor 1 APIC 0x1
>   [   63.556279] Initializing CPU#1
>   ...
> 
> which really doesn't tell me much, except that clearly something in
> ACPI-land is unhappy, and it looks thermal-related (that last error
> message comes from thermal_zone_device_update()).

The thermal code failed to get the current
temperature (via AML "_TMP" method) because
the embedded controller (or our interface to it) malfunctioned.
Likely the suspend issue has nothing to do with thermal per se,
and thermal is effectively pointing out to us that the EC is unhappy.

Failures associated with the embedded controller are now
by far the largest portion of unsolved mysteries
in the Linux ACPI implementation and we need to focus
on the EC in 2011.

-Len Brown, Intel Open Source Technology Center


