From: Thomas Renninger <trenn@suse.de>
Subject: [RESEND] X86 cpuidle cleanups
Date: Tue, 17 Jan 2012 17:20:27 +0100
Message-ID: <1326817230-79711-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:39983 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755106Ab2AQQUy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Jan 2012 11:20:54 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org
Cc: deepthi@linux.vnet.ibm.com

This is a rebase of some recently posted intel_idle processor_idle
related patches which needed refreshing, due to recent commits.

[PATCH 1/3] Revert "intel_idle: disable auto_demotion for hotplugged
-> because I think it's wrong/unneeded. I commented on the initial
posting.

I tested these patches before I had to rebase them.
Now they are compile tested, but adjusting the code wasn't that hard.

Would be great if these could get picked up for 3.3 inclusion.

Thanks,

   Thomas

