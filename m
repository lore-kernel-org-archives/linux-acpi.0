From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] cpuidle: Make cpuidle_enable_device() call poll_idle_init()
Date: Mon, 10 Jan 2011 17:49:07 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1101101747530.7945@x980>
References: <201101080029.20744.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:57843 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755091Ab1AJWtb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Jan 2011 17:49:31 -0500
In-reply-to: <201101080029.20744.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Renninger <trenn@suse.de>

works for me!

/sys/devices/system/cpu/cpu0/cpuidle/state0/desc:<null>
/sys/devices/system/cpu/cpu0/cpuidle/state0/latency:0
/sys/devices/system/cpu/cpu0/cpuidle/state0/name:<null>
/sys/devices/system/cpu/cpu0/cpuidle/state0/power:4294967295
/sys/devices/system/cpu/cpu0/cpuidle/state0/time:1715
/sys/devices/system/cpu/cpu0/cpuidle/state0/usage:8

becomes

/sys/devices/system/cpu/cpu0/cpuidle/state0/desc:CPUIDLE CORE POLL IDLE
/sys/devices/system/cpu/cpu0/cpuidle/state0/latency:0
/sys/devices/system/cpu/cpu0/cpuidle/state0/name:C0
/sys/devices/system/cpu/cpu0/cpuidle/state0/power:4294967295
/sys/devices/system/cpu/cpu0/cpuidle/state0/time:28716
/sys/devices/system/cpu/cpu0/cpuidle/state0/usage:11

thanks,
Len Brown, Intel Open Source Technology Center

