From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Recent Lenovo ThinkPads define a dummy grahpics device, find it and ignore it
Date: Thu, 17 Jan 2008 03:11:56 +0000
Message-ID: <20080117031154.GA26703@srcf.ucam.org>
References: <1197032113.28990.155.camel@queen.suse.de> <20071207225025.GA2055@srcf.ucam.org> <1197290906.28990.329.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:57210 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045AbYAQDMM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Jan 2008 22:12:12 -0500
Content-Disposition: inline
In-Reply-To: <1197290906.28990.329.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@osdl.org>, "Li, Shaohua" <shaohua.li@intel.com>

I've had more time to look at this now. Let's take one of the most 
pathological cases, the Dell d610. It's available with either Intel or 
ATI graphics. The DSDT declares three video devices. Two are called VID, 
the third is called VID2. I'll call the first two VID(a) and VID(b) to 
reduce confusion.

The layout is as follows:

              host bridge (_ADR 0x00)
                       |
                       |
                      / \
                     /   \
AGP (_ADR 0x00010000)    |
           |            / \
           |           /   \
VID(a) (_ADR 0x00)    /     \
VID(b) (_ADR 0x00020000)    VID2 (_ADR 0x00020001)

If we call acpi_get_physical_device on VID(a), we'll get nothing - there 
isn't a corresponding physical device. Therefore we have to call it on 
the parent, and so will get the AGP bridge if the machine is configured 
that way. If not, we can be sure that VID(a) doesn't exist.

If we call acpi_get_physical_device on VID(b), then either the device 
exists and we get something, or the device doesn't exist and we don't. 
In the second case, how do we distinguish between that being because the 
device doesn't exist and that being because the physical device is the 
parent? If we call acpi_get_physical_device on the parent of VID(b), 
then we'll hit the host bridge and we'll get a PCI device back. This 
then looks almost identical to the AGP bridge case.

There are two things we can do here. The first is to examine the _ADR 
field and use that to determine whether we should look at the parent or 
not (if it's parsable as a PCI address, look at the current device. If 
not, look at the parent device). The second is to always look at the 
parent device and ignore it if the host bridge is returned.

I think the first approach is probably better, since it doesn't result 
in us depending on the vagueries of bus topology. However, I'm concerned 
about the inherent assumption it makes about video devices being 
PCI-like. That's true now, but I'm aware of at least one forthcoming 
platform where that may not be the case. The spec certainly doesn't 
require it. I'll try to come up with a patch in any case.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
