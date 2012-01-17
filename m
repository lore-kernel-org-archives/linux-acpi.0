From: Thomas Renninger <trenn@suse.de>
Subject: Re: [patch 2/3] intel_idle: disable auto_demotion for hotplugged CPUs
Date: Tue, 17 Jan 2012 11:56:38 +0100
Message-ID: <201201171156.38490.trenn@suse.de>
References: <20120110234820.B14B8100270@wpzn3.hot.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46697 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752960Ab2AQK4l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jan 2012 05:56:41 -0500
In-Reply-To: <20120110234820.B14B8100270@wpzn3.hot.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: lenb@kernel.org, len.brown@intel.com, linux-acpi@vger.kernel.org, shaohua.li@intel.com

On Wednesday, January 11, 2012 12:48:20 AM akpm@linux-foundation.org wrote:
> From: Shaohua Li <shaohua.li@intel.com>
> Subject: intel_idle: disable auto_demotion for hotplugged CPUs

This one should not be necessary anymore with my intel_idle
patch series I have to rebase and resend (will do that after lunch).

It provides a per cpu intel_idle init function which is called
from processor.ko in physical cpu hotplug case.

>From what I can see this patch does not change anything/much, because:
  - CPUs onlined at bootup are initialized correctly already
  - Soft offlining/onlining shouldn't matter in auto_demotion_disable
    case as it's a HW MSR write and the CPU should still be in the
    same state after off- and onlined again.
  - Physically hotplugged/added CPUs are not registered with cpuidle
    at all (this is what my patch series fixes), because intel_idle
    does not offer any per cpu init() entry function.
    With this patch they might be set into auto_demotion_disable now,
    but no idle driver gets active for them.

I'll pick up patch 1/3 and 3/3, base my patches on top and resend
everything, that should be easiest for everybody?

   Thomas

