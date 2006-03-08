From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] Avoid slab errors on suspend
Date: Wed, 8 Mar 2006 09:51:29 +0100
Message-ID: <200603080951.29870.trenn@suse.de>
References: <200603080904.53204.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:64466 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932509AbWCHIvc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Mar 2006 03:51:32 -0500
In-Reply-To: <200603080904.53204.trenn@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Pavel Machek <pavel@suse.cz>, Len Brown <len.brown@intel.com>, davi.arnaut@gmail.com

On Wednesday 08 March 2006 09:04, Thomas Renninger wrote:
> When going into suspend irqs must be disabled for a long time.
> 
Mine is very similar to recently posted:
[patch 16/22] acpi_os_acquire_object (GFP_KERNEL) called with IRQs disabled through suspend-resume

Hmm, but on my machine "acpi_os_derive_pci_id_2" is also invoked, calling "acpi_evaluate_integer" in utils.c
that also has a GFP_KERNEL call.

Davi, maybe it's best if you post the second part of your patch (which is part of the
ACPICA?) directly to Len/Robert.

Mine includes the first part of yours and adds some additional acpi_in_resume checks that seem
to be necessary on some machines.

       Thomas
