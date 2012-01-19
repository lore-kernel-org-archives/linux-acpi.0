From: Thomas Renninger <trenn@suse.de>
Subject: ACPI processor hotplug - Missing patches to make C-states work on hotplugged cores
Date: Thu, 19 Jan 2012 18:18:41 +0100
Message-ID: <1326993523-6492-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49461 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756900Ab2ASRSq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Jan 2012 12:18:46 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, shaohua.li@intel.com

I also have an udev rule to automatically online memory and CPUs,
I'll try to get it into the udev repo as soon as these are in.

Tested on real HW.
Before:
/sys/devices/system/cpu/cpu*/cpuidle
was missing. Now cpuidle is set up correctly with a sane C-state usage
count hotplugged cores.

Would be great if these could still make it into 3.3, together
with the other ACPI processor hotplug related patches.

Thanks,

   Thomas

