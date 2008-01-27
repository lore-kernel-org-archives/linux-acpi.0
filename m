From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Ignore ACPI video devices that aren't present in hardware
Date: Sun, 27 Jan 2008 02:09:20 +0000
Message-ID: <20080127020920.GB10173@srcf.ucam.org>
References: <1197032113.28990.155.camel@queen.suse.de> <20080117031154.GA26703@srcf.ucam.org> <20080117033936.GB26703@srcf.ucam.org> <200801241721.17436.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:36174 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753019AbYA0CJg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 26 Jan 2008 21:09:36 -0500
Content-Disposition: inline
In-Reply-To: <200801241721.17436.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Thomas Renninger <trenn@suse.de>, linux-acpi <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, "Li, Shaohua" <shaohua.li@intel.com>

On Thu, Jan 24, 2008 at 05:21:17PM -0500, Len Brown wrote:
> _ADR returns a bus-specific format.
> In the case of a video device, section B.6.1 says that
> _ADR returns a 32-bit device ID, and that

No, that's only true for the output devices - not the parent device. The 
parent device is what's interesting here, and the format of its _ADR 
method is not defined.

> So I don't think you can use the numerical value returned
> to have any particular meaning at all.
> In particular, comparing it to magic number 0x10000 makes no sense.

In practice, it's either going to be a PCI device ID or something 
custom. If it's custom, it's unlikely to be a PCI device ID. From that 
point of view, 0x10000 isn't magic - it's the lowest PCI device ID that 
stands a real chance of being the graphics hardware or bridge that the 
graphics hardware is attached to.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
