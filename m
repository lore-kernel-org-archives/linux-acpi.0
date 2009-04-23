From: Thomas Renninger <trenn@suse.de>
Subject: Separate average frequency from acpi-cpufreq and make it available via EXPORT_SYMBOL_GPL for others
Date: Thu, 23 Apr 2009 15:03:01 +0200
Message-ID: <1240491784-29933-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43704 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755984AbZDWNDH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Apr 2009 09:03:07 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: venkatesh.pallipadi@intel.com, linux-acpi@vger.kernel.org, cpufreq@vger.kernel.org

Hi Len,

if Venkatesh and others agree, can you push these into your test tree, please.
The patches are based on your latest test tree.

These slightly conflict with a work_on_cpu vs smp_call_function_single patch
which is AFAIK still under discussion. But it should be easy (just remove a
hunk?) to resolve this.

Thanks,

   Thomas


