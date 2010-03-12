From: Thomas Renninger <trenn@suse.de>
Subject: Re: [RFC PATCH]: ACPI: Automatically online hot-added memory
Date: Fri, 12 Mar 2010 14:18:14 +0100
Message-ID: <201003121418.14204.trenn@suse.de>
References: <20100309141203.10037.62453.sendpatchset@prarit.bos.redhat.com> <1268294876.3632.5.camel@localhost.localdomain> <4B98AA89.4060609@linux.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:41171 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932689Ab0CLNSQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 12 Mar 2010 08:18:16 -0500
In-Reply-To: <4B98AA89.4060609@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: chen gong <gong.chen@linux.intel.com>
Cc: ykzhao <yakui.zhao@intel.com>, Prarit Bhargava <prarit@redhat.com>, Matthew Garrett <mjg@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, trenn@novell.com

On Thursday 11 March 2010 09:32:09 chen gong wrote:
> On 2010-3-11 16:07, ykzhao wrote:
... 
> BTW, how about using UDEV rules to do this operation. It looks more smooth. I know some
> Novell guy is working on it.
I also know this guy :)

These would be the udev rules to automatically add memory/cpus:
SUBSYSTEM=="cpu", ACTION=="add", TEST=="online", ATTR{online}=="0", ATTR{online}="1", RUN+="/bin/logger onlining cpu: $env{DEVPATH}"
SUBSYSTEM=="memory", ACTION=="add", TEST=="state", ATTR{state}=="offline", ATTR{state}="online", RUN+="/bin/logger onlining memory: $env{DEVPATH}"

But this should be the same as you suggest (at least the memory rule)
to do in the kernel:
automatically online the memory, once hotadded.

I would not add any udev rules before this does not work
reliably and currently it is totally broken, mainly because:
  - not being able to alloc memory on foreign nodes (at least with slab)
  - C-state, throttling and cpufreq set up is done without valid
    cpu_data(new_cpu) resulting in wrong C-state (and other) info

   Thomas
