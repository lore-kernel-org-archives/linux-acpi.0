From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] Untested proposal patch: Store video capabilities of
	BIOS globally at ACPI parse time and export it.
Date: Wed, 17 Oct 2007 16:35:29 +0200
Message-ID: <1192631729.9847.678.camel@queen.suse.de>
References: <1192466754.9847.594.camel@queen.suse.de>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:43499 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756518AbXJQOfi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 17 Oct 2007 10:35:38 -0400
In-Reply-To: <1192466754.9847.594.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>
Cc: ibm-acpi-devel <ibm-acpi-devel@lists.sourceforge.net>, Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>

On Mon, 2007-10-15 at 18:45 +0200, Thomas Renninger wrote:
> Store video capabilities of BIOS globally at ACPI parse time and export it.
> 
> This is for vendor specific vs video driver so that they can distinguish who
> should take care of video/brightness control.
> The bits are chosen in a way that video can handle the ability gracefully
> if all the checked functions are there...
> 
> Vendor specific modules must check on that bits and take their hands off
> brightness/video control when set, as they are then served by the video
> driver.
> 
> This hasn't been tested yet. It's more a proposal whether this is the way
> to go...
> Would be great if someone could give it a test if accepted, I will test
> this also as soon as some positive feedback is popping up.
> 
> + success:
> +	acpi_walk_namespace(ACPI_TYPE_METHOD, device->handle, ACPI_UINT32_MAX,
> +			    acpi_brighntess_cap_match, NULL, NULL);
This has been tested now and and it works fine if ACPI_TYPE_METHOD is
replaced with ACPI_TYPE_DEVICE.
Oh, Len was not in CC on the original post..:
Please tell me if you like to take it and if, whether you replace this
METHOD <-> DEVICE manually or if you like to have it reposted.

Thanks,

   Thomas

