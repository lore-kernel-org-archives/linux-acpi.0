From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC PATCH 5/5] ACPI video: support _BQC/_BCL/_BCM methods that use index values
Date: Tue, 10 Mar 2009 17:10:00 +0000
Message-ID: <20090310171000.GC2527@srcf.ucam.org>
References: <1236672214.2820.123.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:49560 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545AbZCJRKE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Mar 2009 13:10:04 -0400
Content-Disposition: inline
In-Reply-To: <1236672214.2820.123.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Thomas Renninger <trenn@suse.de>

On Tue, Mar 10, 2009 at 04:03:34PM +0800, Zhang Rui wrote:
>  		if (level == device->brightness->levels[state]) {
> -			device->backlight->props.brightness = state - 2;
> +			if (device->backlight)
> +				device->backlight->props.brightness = state - 2;

This hunk doesn't seem obviously related?

> +			 * For now, we don't support the _BCL like this:
> +			 * 16, 15, 0, 1, 2, 3, ..., 14, 15, 16
> +			 * because we may mess up the index returned by _BQC.
> +			 * Plus: we have not got a box like this.

Do we have any bugs that suggest there are boxes like this?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
