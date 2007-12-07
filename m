From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Recent Lenovo ThinkPads define a dummy grahpics device, find it and ignore it
Date: Fri, 7 Dec 2007 22:50:25 +0000
Message-ID: <20071207225025.GA2055@srcf.ucam.org>
References: <1197032113.28990.155.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:50245 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753913AbXLGWus (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Dec 2007 17:50:48 -0500
Content-Disposition: inline
In-Reply-To: <1197032113.28990.155.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@osdl.org>

On Fri, Dec 07, 2007 at 01:55:13PM +0100, Thomas Renninger wrote:
> Hi Matthew,
> 
> I posted this one already and you had some concerns about it:
> http://www.mail-archive.com/linux-acpi@vger.kernel.org/msg09510.html
> 
> IMO, this one should still be added to -mm, because:
>   - The patch itself is correct, it is the function that is called
>     that must make sure to return the corresponding pci device

No, I don't think that follows. The semantics of 
acpi_get_physical_device are currently to return a physical device only 
if the node directly corresponds to one. What's the correct physical 
device for the video extension? It may be a PCI device, but it's just as 
easy to argue that it corresponds to some piece of platform-specific 
hardware.

We could change the semantics and ensure that all leaf nodes of an ACPI 
node representing a PCI device share the same physical device. That 
would avoid the bug your patch currently introduces of ignoring 
functional devices, but would immediately cause the second video device 
to reappear on Thinkpads.

Incidentally, have you tried this on a Thinkpad with a discrete graphics 
controller? I /suspect/ (but can't verify) that you'll end up discarding 
the working video extension.

In summary, I don't think this approach can be made to work. You're 
throwing out legitimate and working devices. Instead, we should export 
information about the addresses of the video extensions and let 
whoever's handling the graphics (which is userspace right now) handle 
it.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
