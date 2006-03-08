From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH] Avoid slab errors on suspend
Date: Wed, 08 Mar 2006 17:05:00 +0800
Message-ID: <440E9E3C.5070802@intel.com>
References: <200603080951.29870.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr20.intel.com ([134.134.136.19]:26532 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S932521AbWCHJFP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Mar 2006 04:05:15 -0500
In-Reply-To: <200603080951.29870.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi@vger.kernel.org, Pavel Machek <pavel@suse.cz>, "Brown, Len" <len.brown@intel.com>, davi.arnaut@gmail.com

Thomas Renninger wrote:
> On Wednesday 08 March 2006 09:04, Thomas Renninger wrote:
>  > When going into suspend irqs must be disabled for a long time.
>  >
> Mine is very similar to recently posted:
> [patch 16/22] acpi_os_acquire_object (GFP_KERNEL) called with IRQs 
> disabled through suspend-resume
> 
> Hmm, but on my machine "acpi_os_derive_pci_id_2" is also invoked, 
> calling "acpi_evaluate_integer" in utils.c
> that also has a GFP_KERNEL call.
> 
> Davi, maybe it's best if you post the second part of your patch (which 
> is part of the
> ACPICA?) directly to Len/Robert.
> 
> Mine includes the first part of yours and adds some additional 
> acpi_in_resume checks that seem
> to be necessary on some machines.
If you want to workaround such issue, maybe we should change system_state
to !SYSTEM_RUNNING at the begining of irqrouter_resume' and restore it at
the end of this routine. This should solve all such issues.

Thanks,
Shaohua
