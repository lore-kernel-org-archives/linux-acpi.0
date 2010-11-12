From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2/3] cpuidle: Rename X86 specific idle poll state[0] from C0 to CPUIDLE
Date: Fri, 12 Nov 2010 11:13:48 -0600
Message-ID: <201011121113.49178.trenn@suse.de>
References: <1289581334-26836-1-git-send-email-trenn@suse.de> <1289581334-26836-3-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:32996 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932475Ab0KLRNx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 12 Nov 2010 12:13:53 -0500
In-Reply-To: <1289581334-26836-3-git-send-email-trenn@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, arjan@linux.intel.com

On Friday 12 November 2010 11:02:13 am Thomas Renninger wrote:
> C0 means and is well know as "not idle".
> All documentation out there uses this term as "running"/"not idle"
> state. Also Linux userspace tools (e.g. cpufreq-aperf and turbostat)
> show C0 residency which there is correct, but means something totally
> else than cpuidle "CPUIDLE" state.
...
>  
> -	snprintf(state->name, CPUIDLE_NAME_LEN, "C0");
> -	snprintf(state->desc, CPUIDLE_DESC_LEN, "CPUIDLE CORE POLL IDLE");
> +	snprintf(state->name, CPUIDLE_NAME_LEN, "CPUIDLE");
An even better name might be POLL_IDLE, this corresponds to idle=poll
and other (function,..) names in the kernel and people immediately get a 
picture what this state is about.

Comments?
Shall I resend or could you rename it to whatever you think fits best.
I don't care much about the name, but it must not be called C0...

Thanks,

     Thomas
