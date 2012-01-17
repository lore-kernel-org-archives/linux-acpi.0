From: Thomas Renninger <trenn@suse.de>
Subject: [Resend] X86 cpuidle cleanups V2
Date: Tue, 17 Jan 2012 17:31:32 +0100
Message-ID: <1326817895-81436-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40498 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754970Ab2AQQbi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Jan 2012 11:31:38 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, lenb@kernel.org
Cc: deepthi@linux.vnet.ibm.com, shaohua.li@intel.com

V2: Fix typo: &pr-id

This is a rebase of some recently posted intel_idle processor_idle
related patches which needed refreshing, due to recent commits.

The purpose is to work towards hotplug support for intel_idle.
It's still missing some logic to boot and online a CPU first
before intel_idle can initialize the core. But this is the
essential ground work that is needed first.

[PATCH 1/3] Revert "intel_idle: disable auto_demotion for hotplugged
-> because I think it's wrong/unneeded. I commented on the initial
posting.

I tested these patches before I had to rebase them.
Compile tested only after adjusting, but adjusting the code wasn't that hard.

Would be great if these could get picked up for 3.3 inclusion.

Thanks,

   Thomas

