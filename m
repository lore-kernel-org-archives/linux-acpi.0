From: zicada@stoneinnovation.no
Subject: Re: [Bug 6217] New: 'no event handler' error loops when connecting
     an external monitor
Date: Wed, 15 Mar 2006 17:55:38 +0100 (CET)
Message-ID: <27338.213.88.150.18.1142441738.squirrel@213.88.150.18>
References: <200603121744.k2CHiDuk019008@fire-2.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from [193.69.188.101] ([193.69.188.101]:41675 "EHLO
	stoneinnovation.no") by vger.kernel.org with ESMTP id S1750702AbWCORHa
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Mar 2006 12:07:30 -0500
In-Reply-To: <200603121744.k2CHiDuk019008@fire-2.osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Sorry for bugging you guys again with this.
Just wondering if there is anything else I can do to help out. Im unsure
wether the problem is due to a buggy dsdt or a bug in linux-acpi,
therefore im not too sure what info to supply you with. I realize you are
all probably very busy, but some feedback on what i can do to help would
be greatly appreciated. Im reading through the acpi specification and
trying to make sense of it all, but im fairly new to both aml and lower
level kernel code. Is there another channel i should go through ? Maybe an
irc channel somewhere on freenode, or another mailinglist ? I want to
help! :-)

-- Thomas W. Larsen

> http://bugzilla.kernel.org/show_bug.cgi?id=6217
>
>            Summary: "no event handler" error loops when connecting an
>                     external monitor
>     Kernel Version: 2.6.15
>             Status: NEW
>           Severity: normal
>              Owner: acpi_aml-interpreter@kernel-bugs.osdl.org
>          Submitter: zicada@stoneinnovation.no
>
>
> Most recent kernel where this bug did not occur: NA
> Distribution: Gentoo
> Hardware Environment: Quanta KN1 based notebook (915GM/PM, nvidia gf 6600)
> Software Environment: Gentoo / 2.6.15
> Problem Description:
> Most ACPI functionality seem to run fine except when an external monitor
> is
> connected. All procs freeze, and syslog is spammed with:
> "ACPI Error (evgpe-0688): No handler or method for GPE[17], disabling
> event
> [20060127]"
> Whenever the monitor is disconnected, the kernel resumes normal operation.
> I tried rewriting the DSDT to the best of my (very limited) knowledge. Got
> rid
> of the 4 errors, but this did not affect the issue.
>
> DSDT original (in hex format) can be found at this url:
> http://www.stoneinnovation.no/zicada/dsdt.hex
>
> ------- You are receiving this mail because: -------
> You reported the bug, or are watching the reporter.
>

