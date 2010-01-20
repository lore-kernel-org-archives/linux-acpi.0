From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] Default to ACPI reboots on newish X86 hardware
Date: Wed, 20 Jan 2010 00:21:12 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001200007560.4265@localhost.localdomain>
References: <alpine.LFD.2.00.1001061433260.4086@localhost.localdomain>
 <1262894593-25563-1-git-send-email-ch@zeha.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:56433 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162Ab0ATFVb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Jan 2010 00:21:31 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KWJ001OC5JE30C1@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 19 Jan 2010 23:21:20 -0600 (CST)
In-reply-to: <1262894593-25563-1-git-send-email-ch@zeha.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Christian Hofstaedtler <ch@zeha.at>
Cc: x86@kernel.org, hpa@zytor.com, tglx@linutronix.de, linux-acpi@vger.kernel.org, venkatesh.pallipadi@intel.com, arjan@infradead.org, bruce.w.allan@intel.com

On Thu, 7 Jan 2010, Christian Hofstaedtler wrote:

Thanks for writing this patch Christian,
it is something that has been unsettled for
a long time and it will be great to close the issue.

> Newer hardware is assumed to no longer reboot succesfully using the
> keyboard controller, but needs to use ACPI instead.
> To not cause problems with older hardware, only hardware with a BIOS
> date 2006 or newer is considered for this choice. Broken BIOSes
> reporting a BIOS date of 0 are not specially considered, and therefore
> get the KBD reboot behaviour.
> 
> Also unifiy reboot_type selection code.

Please split the patch in two patches:

1. cleanup w/o policy change
2. policy change w/o cleanup

better if the policy change is #2, so if we need to revert it
we don't have to revert the cleanup too.

> Signed-off-by: Christian Hofstaedtler <ch@zeha.at>
> ---
>  arch/x86/include/asm/emergency-restart.h |    1 +
>  arch/x86/kernel/reboot.c                 |   65 ++++++++++++++++++++++++------
>  2 files changed, 53 insertions(+), 13 deletions(-)


> +/* See if the Hardware is new enough to support ACPI reboots. */
> +static int __init reboot_acpi_likey_supported(void)
> +{
> +        int year;
> +
> +	/* Doesn't exist? Likely an old system */
> +	if (!dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL)) {
> +		return 0;
> +	}

I think it may be better to simply return 1 in this case.

While we have seen dmi_get_date() fail in practice on "modern" machines,
if CONFIG_ACPI_BLACKLIST_YEAR is set, we will already punish users by
disabling ACPI and making them invoke acpi=force.

So the effect of this check is to disable ACPI-reset
on systems where the user has likely already invoked acpi=force --
which seems somewhat counter-intuitive.

> +        /* 2006 was decided as the cut-off year. */
> +	if (year < 2006) {
> +		return 0;
> +	}

I'd rather see 2003.
If we run into trouble, it is a 1-liner to move it forward.
But I think we'll probably do fine with anything newer than 2001.

thanks,
Len Brown, Intel Open Source Technolgy Center

