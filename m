From: Joseph Dunn <jdunn14@hotpop.com>
Subject: wake-on-lan
Date: Sun, 8 Jan 2006 10:45:13 -0700
Message-ID: <20060108104513.1468689f@taco>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.hotpop.com ([38.113.3.61]:28357 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP
	id S1161497AbWATEaW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Jan 2006 23:30:22 -0500
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.105])
	by smtp-out.hotpop.com (Postfix) with SMTP id 6AD8E22CA67C
	for <linux-acpi@vger.kernel.org>; Fri, 20 Jan 2006 04:30:18 +0000 (UTC)
Received: from taco (71-208-66-142.hlrn.qwest.net [71.208.66.142])
	by smtp-2.hotpop.com (Postfix) with ESMTP id 84D0821D46F3
	for <linux-acpi@vger.kernel.org>; Sun,  8 Jan 2006 17:45:13 +0000 (UTC)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I'm trying to get wake-on-lan working for my media box.  However, I'm
running into a problem.  When I halt the machine (shutdown -h) I cannot
wake it.  However, if the machine is unplugged, then plugged back in,
*then* I can wake it.  The lights on the ethernet card will only glow
when the machine is off (i.e. card can wake the machine) when I unplug
the power and plug it back in.  I did find that however software
suspend 2 shuts down the machine does leave it in a wakable state.

So, one option is to hibernate the machine instead of shutting down,
but thats not a great solution.  Also, I have a desktop machine that
has a similar problem.  The wake on alarm in the BIOS cannot wake the
machine if linux performed the last shutdown.  It looks to me like
linux leaves the machine in a deeper sleep state than even plugging it
in for the first time.

I tried to go into the code where the sleep state is hard coded and
mess with it. I edited poweroff.c and changed the two hardcoded lines
referring to S5 to S4.  No affect.  Just to make sure that I was really
calling that code during shutdown I changed it to S0, and the machine
remained on (in S0 state I believe).  By the way, I also tried S3 there
and found that I couldn't wake using the network card in any case.

The machines in question are running Fedora Core 4, but with my own
custom kernels.  The kernels are vanilla for the most part, but are
patched with software suspend and a couple drivers.  I'm sure this is
probably something simple, but it doesnt look like I'm going to trip
over the solution, so does anyone have any suggestions?

-Joe Dunn

