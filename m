From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] X86: Cleanup idle= internal variables by getting rid of
 idle_halt idle_nomwait
Date: Wed, 12 Jan 2011 01:22:01 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1101120120370.19140@x980>
References: <201011021441.09258.trenn@suse.de>
 <alpine.LFD.2.00.1011030150560.3378@localhost.localdomain>
 <201011031706.15248.trenn@suse.de> <201011051124.49973.trenn@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:39144 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444Ab1ALGWJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 01:22:09 -0500
In-reply-to: <201011051124.49973.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, stable@kernel.org, LKML <linux-kernel@vger.kernel.org>

> > > That function and all these idle workaround flags
> > > need to be re-whacked.

> > Whatabout this (compile tested (on x86_64/ia64)).
> > Adding lkml as this affects x86 core code.
> as this mostly affects intel_idle and acpi processor driver,
> can you apply this one to your acpi test branch if you are
> ok with it.

Looks good to me, Thomas, thanks for the follow-up.

I don't think it needed for -stable, but it is a good cleanup
for upstream.

applied to idle-test.

thanks,
Len Brown, Intel Open Source Technology Center

