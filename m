From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Ignore ACPI video devices that aren't present in hardware
Date: Sun, 3 Feb 2008 00:03:55 +0000
Message-ID: <20080203000354.GA26623@srcf.ucam.org>
References: <1197032113.28990.155.camel@queen.suse.de> <200801241721.17436.lenb@kernel.org> <20080127020920.GB10173@srcf.ucam.org> <200802020212.17812.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:60092 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765998AbYBCAEM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 2 Feb 2008 19:04:12 -0500
Content-Disposition: inline
In-Reply-To: <200802020212.17812.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Thomas Renninger <trenn@suse.de>, linux-acpi <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, "Li, Shaohua" <shaohua.li@intel.com>

On Sat, Feb 02, 2008 at 02:12:17AM -0500, Len Brown wrote:

> But I have to agree with Thomas' feedback:
> "I also wonder why you added this to acpi_video_bus_add_fs and not
>  acpi_video_bus_add, but it's functionally the same."
> 
> or perhaps acpi_video_bus_check()?

Yeah, that's fair enough. I'll respin it once I'm on the ground for more 
than 3 hours.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
