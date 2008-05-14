From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/2] Add a passive cooling trip point if the firmware doesn't define one
Date: Wed, 14 May 2008 11:37:22 -0400
Message-ID: <200805141137.22341.lenb@kernel.org>
References: <20080514010000.GB21608@srcf.ucam.org> <200805132330.20159.lenb@kernel.org> <20080514093304.GB28678@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35841 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753150AbYENWmU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 May 2008 18:42:20 -0400
In-Reply-To: <20080514093304.GB28678@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org

On Wednesday 14 May 2008, Matthew Garrett wrote:
> On Tue, May 13, 2008 at 11:30:20PM -0400, Len Brown wrote:
> 
> > An entire new handheld product line will ship this year
> > where the assumption that the processor is the primary
> > contributor to heat may simply be _false_, thermal
> > zones may be totally unrelated to the processor,
> > and throttling the processor may be exactly the
> > wrong way to handle a thermal issue.
> 
> That's fine. In the ACPI code, we currently have no support for managing 
> thermal conditions through anything other than the processor. Once that 
> changes, it's easy to fix this up so it doesn't interfere with thermal 
> zones that are handled by throttling other devices.

No.
ACPI thermal zones with no passive trip points can be used
to simply report interesting temperature events to user-space
(via the spiffy new generic thermal class).
User-space then invokes corrective action -- which may be
something _other_ than throttling the CPU.

> Menlow has a more complex thermal model than machines we've seen up to 
> now, but I was under the impression that this was to be handled by the 
> new generic thermal class rather than the existing ACPI code. I don't 
> see this patch as being in conflict with supporting that.

No.
It is a direct conflict.

Say the thermal zone is related to the communications chip.
If we create a phantom passive trip point for that zone
and throttle the CPU when it fires, we're shooting ourselves
in the head (when we should be poking ourselves in the ear, or some such:-)

-Len
