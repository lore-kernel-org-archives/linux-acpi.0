From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 86/98] ACPI: cap off P-state transition latency from buggy
 BIOSes
Date: Fri, 03 Apr 2009 12:35:20 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904031226350.4655@localhost.localdomain>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
 <a59d1637eb0e0a37ee0e5c92800c60abe3624e24.1238214620.git.len.brown@intel.com>
 <200904021450.26935.trenn@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:49283 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754194AbZDCQfk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Apr 2009 12:35:40 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KHJ003S3A2XETQZ@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 03 Apr 2009 11:35:27 -0500 (CDT)
In-reply-to: <200904021450.26935.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi@vger.kernel.org, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>

> Whatabout:
> 
> CC: stable@kernel.org

I've added this to my .stable list, thanks for pointing it out.
Note that I don't send patches to stable until after they are upstream.

thanks,
-Len

> This is a bug fix also existing in older kernels.
> 
> I remember even much newer HW (Intel and AMD) based have higher values
> 
> exported through ACPI _PSS tables as latency.
> 
> I remember values around (50-70us Core 2 Duo?) and 37us on K10.
> 
> I doubt this patch will cause much pain, but being close to values exported
> 
> via ACPI tables on similar HW sounds like a good idea.
> 
> In 2.6.30 (as soon as cpufreq branch is merged) you get that easily from here:
> 
> cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_transition_latency
> 
> 109000
> 
> I expect my machine's (K8 Dual core) ACPI exported value will be cut down to:
> 
> 20000
> 
> now?

Does your AMD box run acpi-cpufreq and use native MSR access to change 
P-states?

> I don't want to veto this one, but IMO the 20us second value
> 
> should get 100us...

Where does 100us come from?

thanks,
-Len Brown, Intel Open Source Technology Center

