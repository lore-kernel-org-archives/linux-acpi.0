From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: Do not try to set up acpi processor stuff on cores
 exceeding maxcpus=
Date: Fri, 28 May 2010 14:46:27 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1005281445170.4045@localhost.localdomain>
References: <1274886213-16337-1-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:62144 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532Ab0E1Sqr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 May 2010 14:46:47 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L3500IEV85HV1E2@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 28 May 2010 13:46:34 -0500 (CDT)
In-reply-to: <1274886213-16337-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: travis@sgi.com, linux-acpi@vger.kernel.org


On Wed, 26 May 2010, Thomas Renninger wrote:

> Patch is against latest Linus master branch and is expected to be
> safe bug fix.
> 
> You get:
> ACPI: HARDWARE addr space,NOT supported yet
> for each ACPI defined CPU which status is active, but exceeds
> maxcpus= count.
> 
> As these "not booted" CPUs do not run an idle routine
> and echo X >/proc/acpi/processor/*/throttling did not work
> I couldn't find a way to really access not onlined/booted
> machines. Still this should get fixed and
> /proc/acpi/processor/X dirs of cores exceeding maxcpus
> should not show up.

Can we delete the /proc/acpi/processor/ dirs instead of maintaining them?

thanks,
-Len Brown, Intel Open Source Technology Center

