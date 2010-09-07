From: Len Brown <lenb@kernel.org>
Subject: Re: Speedstep on Celeron SU2300 - 20% more battery lifetime on Windows
Date: Tue, 07 Sep 2010 12:20:44 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1009071214360.22515@localhost.localdomain>
References: <AANLkTiktJ5Xgnsmq2je7T3Yc5Sf53Bu8vWMM1XT1V_vm@mail.gmail.com>
 <201009020152.37466.trenn@suse.de>
 <AANLkTi=WDEA+prG26g5R9oG1uZ7cNgaMrYDtug_LM7bY@mail.gmail.com>
 <201009061035.03727.trenn@suse.de>
 <AANLkTi==7HGa9OKUDq4cpexPpdPMKVgcXqONFL+UqmRe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:59155 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752933Ab0IGQVI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Sep 2010 12:21:08 -0400
In-reply-to: <AANLkTi==7HGa9OKUDq4cpexPpdPMKVgcXqONFL+UqmRe@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tiago Marques <tiagomnm@gmail.com>
Cc: Thomas Renninger <trenn@suse.de>, cpufreq@vger.kernel.org, discuss@lesswatts.org, linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org

> I'm getting around 75% in C4, the rest almost exclusively in C0.

This 25% in C0 is likely all of your battery life problem.

use top and powertop to find out what is running and why,
and see if it is something you can prevent from running.

If your CPU is more than 1% buys when "profoundly idle",
then it has a significant software or configuration problem.

cheers,
Len Brown, Intel Open Source Technology Center

ps. note for comparisons...  your XP partition should have a
"perfmon" application that can draw a pretty graph of cpu usage,
including adding counters for the various C-states.
