From: Bela Lubkin <blubkin@vmware.com>
Subject: RE: [Openipmi-developer] [PATCH ] IPMI: Locate the IPMI system
	interface in ACPI namespace
Date: Mon, 16 Nov 2009 12:37:07 -0800
Message-ID: <E0AA796A7E3F4C4E8F1065D15FE4786183AF69A5@EXCH-MBX-4.vmware.com>
References: <1258363089-26881-1-git-send-email-yakui.zhao@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-outbound-2.vmware.com ([65.115.85.73]:51577 "EHLO
	smtp-outbound-2.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753476AbZKPUhD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 16 Nov 2009 15:37:03 -0500
In-Reply-To: <1258363089-26881-1-git-send-email-yakui.zhao@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "'yakui.zhao@intel.com'" <yakui.zhao@intel.com>, "minyard@acm.org" <minyard@acm.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, "lenb@kernel.org" <lenb@kernel.org>

Hi Yakui,

>    1. enumerate the ACPI device tree to find the IPMI system interface
> 	The IPMI device type is IPI0001. When the device is found, it
> will continue to parse the corresponding resources.
>         For example:
> 		interface type (KCS, BT, SMIC) (SSIF is not supported)

> +	/* Figure out the interface type. */
> +	switch (spmi->interfacetype) {
> +	case 1:	/* KCS */
> +		info->si_type = SI_KCS;
> +		break;
> +	case 2:	/* SMIC */
> +		info->si_type = SI_SMIC;
> +		break;
> +	case 3:	/* BT */
> +		info->si_type = SI_BT;
> +		break;
> +	default:
> +		printk(KERN_INFO "ipmi_si: Unknown ACPI/SPMI SI type %d\n",
> +			spmi->interfacetype);
> +		kfree(info);
> +		return -EIO;
> +	}

If SSIF is a possible value defined by the standard which specifies ACPI
identification of IPMI, please display it in the error message.  Then if
it starts appearing in the future, it will be obvious what support needs
to be added.  e.g.:

   default:
      printk(KERN_INFO "ipmi_si: ACPI/SPMI SI type %d (%s) is not supported",
             spmi->interfacetype,
             (spmi->interfacetype == ??4?? /* SSIF */) ? "SSIF" : "Unknown");

> +	if (spmi->interrupttype & 1) {
> +		/* We've got a GPE interrupt. */
> +		info->irq = spmi->gpe;
> +		info->irq_setup = acpi_gpe_irq_setup;
> +	} else if (spmi->interrupttype & 2) {
> +		/* We've got an APIC/SAPIC interrupt. */
> +		info->irq = spmi->global_interrupt;
> +		info->irq_setup = std_irq_setup;
> +	} else {
> +		/* Use the default interrupt setting. */

if any other bits are set, should this warn about them?

> +		info->irq = 0;
> +		info->irq_setup = NULL;
> +	}
>
> +	if (spmi->addr.bit_width) {
> +		/* A (hopefully) properly formed register bit width. */

should this be checked (e.g. warn if bit_width % 8 != 0)?

> +		info->io.regspacing = spmi->addr.bit_width / 8;
> +	} else {
> +		info->io.regspacing = DEFAULT_REGSPACING;
> +	}
> +	info->io.regsize = info->io.regspacing;
> +	info->io.regshift = spmi->addr.bit_offset;
> +
> +	if (spmi->addr.space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
> +		info->io_setup = mem_setup;
> +		info->io.addr_type = IPMI_MEM_ADDR_SPACE;
> +	} else if (spmi->addr.space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
> +		info->io_setup = port_setup;
> +		info->io.addr_type = IPMI_IO_ADDR_SPACE;
> +	} else {
> +		kfree(info);
> +		printk(KERN_WARNING
> +		       "ipmi_si: Unknown ACPI I/O Address type\n");

"%d", io.addr_type
(or maybe %x? -- whatever's right in context)

I'm not going to go line-by-line over the rest, but in general,
if the code thinks something is wrong, have it show what it
objects to:

> +			if (irq->interrupt_count != 1) {
> +				printk(KERN_WARNING "incorrect IRQ is "
> +					"defined in _CRS\n");

"interrupt_count is %d, must be 1", irq->interrupt_count

etc.

>Bela<