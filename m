From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI video: fix a poor error message
Date: Tue, 17 Aug 2010 14:34:58 +0100
Message-ID: <20100817133458.GA22699@srcf.ucam.org>
References: <1282012975.5181.16.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:56390 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738Ab0HQNfN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Aug 2010 09:35:13 -0400
Content-Disposition: inline
In-Reply-To: <1282012975.5181.16.camel@rui>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Brown, Len" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, Thomas Renninger <trenn@suse.de>

On Tue, Aug 17, 2010 at 10:42:55AM +0800, Zhang Rui wrote:
>  		*cap |= ACPI_VIDEO_BACKLIGHT;
>  		if (ACPI_FAILURE(acpi_get_handle(handle, "_BQC", &h_dummy)))
> -			printk(KERN_WARNING FW_BUG PREFIX "ACPI brightness "
> -					"control misses _BQC function\n");
> +			printk(KERN_WARNING FW_BUG PREFIX "could not find "
> +					"required _BQC function\n");

I don't really like the "required". It's a spec requirement but the 
driver will work fine (if suboptimally) without it.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
