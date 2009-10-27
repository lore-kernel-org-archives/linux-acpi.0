From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 1/3] Add a generic API for _OSC
Date: Tue, 27 Oct 2009 09:07:18 -0600
Message-ID: <200910270907.19103.bjorn.helgaas@hp.com>
References: <20091027063637.GA22237@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:29942 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754346AbZJ0PHl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Oct 2009 11:07:41 -0400
In-Reply-To: <20091027063637.GA22237@sli10-desk.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

On Tuesday 27 October 2009 12:36:37 am Shaohua Li wrote:
> Add an API to execute _OSC. A lot of devices can have this method, so add a
> generic API.

> +	out_obj = context->ret.pointer;
> +	if (out_obj->type != ACPI_TYPE_BUFFER) {
> +		printk(KERN_DEBUG "_OSC evaluation returned wrong type\n");
> +		status = AE_TYPE;
> +		goto out_kfree;
> +	}
> +	/* Need to ignore the bit0 in result code */
> +	errors = *((u32 *)out_obj->buffer.pointer) & ~(1 << 0);
> +	if (errors) {
> +		if (errors & OSC_REQUEST_ERROR)
> +			printk(KERN_DEBUG "_OSC request failed\n");
> +		if (errors & OSC_INVALID_UUID_ERROR)
> +			printk(KERN_DEBUG "_OSC invalid UUID\n");
> +		if (errors & OSC_INVALID_REVISION_ERROR)
> +			printk(KERN_DEBUG "_OSC invalid revision\n");
> +		if (errors & OSC_CAPABILITIES_MASK_ERROR) {
> +			if (((u32 *)context->cap.pointer)[OSC_QUERY_TYPE]
> +			    & OSC_QUERY_ENABLE)
> +				goto out_success;
> +			printk(KERN_DEBUG
> +			       "Firmware did not grant requested _OSC control\n");

On all these printks, it would be very useful to have some indication
of what the OS requested and which specific _OSC method we executed,
e.g., an ACPI device name or a namespace path.

Bjorn
