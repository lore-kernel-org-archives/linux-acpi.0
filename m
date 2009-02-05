From: Alex Chiang <achiang@hp.com>
Subject: Re: [PATCH 1/2] PCI/ACPI: move _OSC code to pci_root.c
Date: Thu, 5 Feb 2009 08:49:36 -0700
Message-ID: <20090205154936.GC24033@ldl.fc.hp.com>
References: <498AF51F.7070200@jp.fujitsu.com> <498AF557.4040601@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <498AF557.4040601@jp.fujitsu.com>
Sender: linux-pci-owner@vger.kernel.org
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, Andrew Patterson <andrew.patterson@hp.com>
List-Id: linux-acpi@vger.kernel.org

Hi Kenji-san,

Sorry, I didn't read your patch in detail last time, and only saw
the one wording change that Andrew suggested.

Reading through now, I have a few more suggestions.

> +	status = acpi_evaluate_object(handle, "_OSC", &input, &output);
> +	if (ACPI_FAILURE(status))
> +		return status;
> +
> +	if (!output.length)
> +		return AE_NULL_OBJECT;
> +
> +	out_obj = output.pointer;
> +	if (out_obj->type != ACPI_TYPE_BUFFER) {
> +		printk(KERN_DEBUG "Evaluate _OSC returns wrong type\n");

"_OSC evaluation returned wrong type\n"

> +	if (errors) {
> +		if (errors & OSC_REQUEST_ERROR)
> +			printk(KERN_DEBUG "_OSC request fails\n");

"_OSC request failed\n"

> +		if (errors & OSC_INVALID_UUID_ERROR)
> +			printk(KERN_DEBUG "_OSC invalid UUID\n");
> +		if (errors & OSC_INVALID_REVISION_ERROR)
> +			printk(KERN_DEBUG "_OSC invalid revision\n");
> +		if (errors & OSC_CAPABILITIES_MASK_ERROR) {
> +			if (capbuf[OSC_QUERY_TYPE] & OSC_QUERY_ENABLE)
> +				goto out_success;
> +			printk(KERN_DEBUG"Firmware did not grant requested "
> +			       "_OSC control\n");

I prefer to see this message on one line (and break the 80 column
rule) to make grepping easier. But this is a judgement call, and
I'll let you decide.

Thanks.

/ac
