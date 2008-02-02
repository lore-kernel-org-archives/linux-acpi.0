From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] Ignore ACPI video devices that aren't present in hardware
Date: Sat, 2 Feb 2008 02:12:17 -0500
Message-ID: <200802020212.17812.lenb@kernel.org>
References: <1197032113.28990.155.camel@queen.suse.de> <200801241721.17436.lenb@kernel.org> <20080127020920.GB10173@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58731 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758020AbYBBHMj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 2 Feb 2008 02:12:39 -0500
In-Reply-To: <20080127020920.GB10173@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Thomas Renninger <trenn@suse.de>, linux-acpi <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, "Li, Shaohua" <shaohua.li@intel.com>

On Saturday 26 January 2008 21:09, Matthew Garrett wrote:
> On Thu, Jan 24, 2008 at 05:21:17PM -0500, Len Brown wrote:
> > _ADR returns a bus-specific format.
> > In the case of a video device, section B.6.1 says that
> > _ADR returns a 32-bit device ID, and that
> 
> No, that's only true for the output devices - not the parent device. The 
> parent device is what's interesting here, and the format of its _ADR 
> method is not defined.

oh, ic, you're right.

> In practice, it's either going to be a PCI device ID or something 
> custom. If it's custom, it's unlikely to be a PCI device ID. From that 
> point of view, 0x10000 isn't magic - it's the lowest PCI device ID that 
> stands a real chance of being the graphics hardware or bridge that the 
> graphics hardware is attached to.

I share your uneasyness about this heuristic,
but I don't have a better idea
and this seems to work, so I think we should proceed...

But I have to agree with Thomas' feedback:
"I also wonder why you added this to acpi_video_bus_add_fs and not
 acpi_video_bus_add, but it's functionally the same."

or perhaps acpi_video_bus_check()?

I'll lob this into the test tree in the mean-time...

thanks,
-Len
