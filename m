From: Len Brown <lenb@kernel.org>
Subject: Re: [Resend] X86 cpuidle cleanups V2
Date: Tue, 17 Jan 2012 14:30:29 -0500
Message-ID: <4F15CC55.70004@kernel.org>
References: <1326817895-81436-1-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:50335 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118Ab2AQTac (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jan 2012 14:30:32 -0500
Received: by vcbfo1 with SMTP id fo1so2092810vcb.19
        for <linux-acpi@vger.kernel.org>; Tue, 17 Jan 2012 11:30:31 -0800 (PST)
In-Reply-To: <1326817895-81436-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi@vger.kernel.org, deepthi@linux.vnet.ibm.com, shaohua.li@intel.com

On 01/17/2012 11:31 AM, Thomas Renninger wrote:

> V2: Fix typo: &pr-id
> 
> This is a rebase of some recently posted intel_idle processor_idle
> related patches which needed refreshing, due to recent commits.
> 
> The purpose is to work towards hotplug support for intel_idle.
> It's still missing some logic to boot and online a CPU first
> before intel_idle can initialize the core. But this is the
> essential ground work that is needed first.
> 
> [PATCH 1/3] Revert "intel_idle: disable auto_demotion for hotplugged
> -> because I think it's wrong/unneeded. I commented on the initial
> posting.


#1 done - thanks!

> I tested these patches before I had to rebase them.
> Compile tested only after adjusting, but adjusting the code wasn't that hard.


please fix the checkpatch.pl issues in #2 and #3,
and explain in the check-in comments _why_ the patches
are a good idea.  (less of a need to describe _what_ the patches do,
since the patches themselves are the authority on that:-)

thanks,
-Len Brown, Intel Open Source Technology Center
