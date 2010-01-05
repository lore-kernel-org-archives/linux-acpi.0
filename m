From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Default to ACPI reboots on newish X86 hardware
Date: Tue, 05 Jan 2010 09:04:39 -0800
Message-ID: <4B437127.1000605@zytor.com>
References: <4B42B3FD.7000608@zytor.com> <1262694629-7068-1-git-send-email-ch@zeha.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:54847 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754561Ab0AERIt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Jan 2010 12:08:49 -0500
In-Reply-To: <1262694629-7068-1-git-send-email-ch@zeha.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Christian Hofstaedtler <ch@zeha.at>
Cc: x86@kernel.org, lenb@kernel.org, tglx@linutronix.de, linux-acpi@vger.kernel.org, venkatesh.pallipadi@intel.com, arjan@infradead.org, bruce.w.allan@intel.com

On 01/05/2010 04:30 AM, Christian Hofstaedtler wrote:
> Newer hardware is assumed to no longer reboot succesfully using the
> keyboard controller, but needs to use ACPI instead.
> To not cause problems with older hardware, only hardware with a BIOS
> date 2006 or newer is considered for this choice.
> 
> Also unifiy reboot_type selection code.
> 
> +	}
> +	/* 0? Likely a buggy new BIOS */
> +	if (year == 0) {
> +		printk(KERN_ERR "reboot: DMI BIOS year==0, "
> +			"assuming ACPI-reboot-capable machine\n");
> +		return 1;
> +	}
> +        /* 2006 was decided as the cut-off year. */
> +	if (year < 2006) {
> +		return 0;
> +	}
> +	return 1;
> +}
> +

Why assume it is a buggy *new* BIOS rather than a buggy *old* BIOS?

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.

