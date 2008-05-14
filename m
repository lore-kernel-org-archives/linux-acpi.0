From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 2/2] Add a passive cooling trip point if the firmware doesn't define one
Date: Thu, 15 May 2008 00:01:15 +0100
Message-ID: <20080514230115.GA11960@srcf.ucam.org>
References: <20080514010000.GB21608@srcf.ucam.org> <200805132330.20159.lenb@kernel.org> <20080514093304.GB28678@srcf.ucam.org> <200805141137.22341.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mjg.x.mythic-beasts.com ([93.93.128.6]:46542 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752449AbYENXBk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 May 2008 19:01:40 -0400
Content-Disposition: inline
In-Reply-To: <200805141137.22341.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Wed, May 14, 2008 at 11:37:22AM -0400, Len Brown wrote:

> No.
> ACPI thermal zones with no passive trip points can be used
> to simply report interesting temperature events to user-space
> (via the spiffy new generic thermal class).
> User-space then invokes corrective action -- which may be
> something _other_ than throttling the CPU.

If user space wants to decouple ACPI from the generic thermal model, 
then it can do so by using the mode file in the sysfs node. That doesn't 
change.

> > Menlow has a more complex thermal model than machines we've seen up to 
> > now, but I was under the impression that this was to be handled by the 
> > new generic thermal class rather than the existing ACPI code. I don't 
> > see this patch as being in conflict with supporting that.
> 
> No.
> It is a direct conflict.
> 
> Say the thermal zone is related to the communications chip.
> If we create a phantom passive trip point for that zone
> and throttle the CPU when it fires, we're shooting ourselves
> in the head (when we should be poking ourselves in the ear, or some such:-)

As I said, if userspace is managing the thermal envelope then it has to 
indicate this by writing a value into sysfs (see the get_mode and 
set_mode calls in the thermal_zone_device_ops structure). If that's 
done then it indicates to the kernel that it should leave control up to 
the userspace application. acpi_thermal_check will then return without 
handling the trip points (including the critical one, which I'm not sure 
sounds like a good idea...)

As a result, this patch doesn't conflict with the userspace thermal 
management at all. The moment the userspace policy daemon starts up 
it'll disable the code that would fire on the passive trip point. If 
you're not using a userspace policy daemon, then the only hardware that 
can be used to drop the temperature is the processor. Which is what this 
patch does.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
