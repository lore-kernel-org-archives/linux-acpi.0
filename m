From: Christian Hofstaedtler <ch@zeha.at>
Subject: Re: [PATCH] Default to ACPI reboots on newish X86 hardware
Date: Tue, 5 Jan 2010 19:26:30 +0100
Message-ID: <201001051926.30580.ch@zeha.at>
References: <4B42B3FD.7000608@zytor.com> <1262694629-7068-1-git-send-email-ch@zeha.at> <4B437127.1000605@zytor.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from percival.namespace.at ([77.244.242.130]:46744 "EHLO
	percival.namespace.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754022Ab0AES11 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Jan 2010 13:27:27 -0500
In-Reply-To: <4B437127.1000605@zytor.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, lenb@kernel.org, tglx@linutronix.de, linux-acpi@vger.kernel.org, venkatesh.pallipadi@intel.com, arjan@infradead.org, bruce.w.allan@intel.com

On Tuesday 05 January 2010 18:04:39 H. Peter Anvin wrote:
> On 01/05/2010 04:30 AM, Christian Hofstaedtler wrote:
> > Newer hardware is assumed to no longer reboot succesfully using the
> > keyboard controller, but needs to use ACPI instead.
> > To not cause problems with older hardware, only hardware with a BIOS
> > date 2006 or newer is considered for this choice.
> >
> > Also unifiy reboot_type selection code.
> >
> > +	}
> > +	/* 0? Likely a buggy new BIOS */
> > +	if (year == 0) {
> > +		printk(KERN_ERR "reboot: DMI BIOS year==0, "
> > +			"assuming ACPI-reboot-capable machine\n");
> > +		return 1;
> > +	}
> > +        /* 2006 was decided as the cut-off year. */
> > +	if (year < 2006) {
> > +		return 0;
> > +	}
> > +	return 1;
> > +}
> > +
> 
> Why assume it is a buggy *new* BIOS rather than a buggy *old* BIOS?

Well, this is the same as with CONFIG_ACPI_BLACKLIST_YEAR. But yeah, I've also 
thought about it, but then *I* really don't know how many such broken BIOSes 
are there in the wild. And how many of them are new enough.

Also, I think we could push the year even more up, say, to 2009. On the 
assumption that such new hardware which can't do BOOT_KBD is only being 
produced now (late 2009). Better err on the safe side?

  Christian
