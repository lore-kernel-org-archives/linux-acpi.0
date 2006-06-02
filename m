From: Andi Kleen <ak@muc.de>
Subject: Re: [patch 12/13] Fix HPET operation on 64-bit NVIDIA platforms
Date: 2 Jun 2006 05:47:51 +0200
Message-ID: <20060602034751.GC62654@muc.de>
References: <200606020314.k523EXuI028340@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from colin.muc.de ([193.149.48.1]:10257 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1751257AbWFBDrx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2006 23:47:53 -0400
Date: Fri, 2 Jun 2006 05:47:51 +0200
Content-Disposition: inline
In-Reply-To: <200606020314.k523EXuI028340@shell0.pdx.osdl.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org, ACurrid@nvidia.com, luming.yu@intel.com


>  #ifdef CONFIG_ACPI
> -					/* All timer overrides on Nvidia
> -				           seem to be wrong. Skip them. */
> -					acpi_skip_timer_override = 1;
> -					printk(KERN_INFO 
> -	     "Nvidia board detected. Ignoring ACPI timer override.\n");
> +					/*
> +					 * All timer overrides on Nvidia are
> +					 * wrong unless HPET is enabled.
> +					 */
> +					nvidia_hpet_detected = 0;
> +					acpi_table_parse(ACPI_HPET,
> +							nvidia_hpet_check);

I'm not sure it's safe to call acpi_table_parse() when the user passed acpi=off 

Better would be probably to set a flag in the HPET callback in arch/i386/kernel/acpi/boot.c

-Andi
