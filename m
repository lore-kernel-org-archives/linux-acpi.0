From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Resume on Apple Mac Mini
Date: Sun, 18 Jun 2006 14:25:06 +0100
Message-ID: <20060618132506.GA13697@srcf.ucam.org>
References: <CFF307C98FEABE47A452B27C06B85BB670F3C4@hdsmsx411.amr.corp.intel.com> <44677056.1080004@gmail.com> <Pine.LNX.4.64.0606171408230.5498@g5.osdl.org> <Pine.LNX.4.64.0606171732370.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:50904 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932219AbWFRNZP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 18 Jun 2006 09:25:15 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606171732370.5498@g5.osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jiri Slaby <jirislaby@gmail.com>, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org

On Sat, Jun 17, 2006 at 05:35:51PM -0700, Linus Torvalds wrote:

> The thing that does work is to literally just set the SCI_ENABLE bit:
> 
> 	acpi_set_register(ACPI_BITREG_SCI_ENABLE, 1, ACPI_MTX_DO_NOT_LOCK);
> 
> after resume, _not_ the "acpi_enable()".

The ACPI spec says:

"If this is an S2 or S3 wake, then the BIOS restores minimum context of 
the system before jumping to the waking vector. This includes:

...

ACPI registers. SCI_EN bit must be set. All event status/enable bits 
(PM1x_STS, PM1x_EN, GPEx_STS and GPEx_EN) must not be changed by BIOS."

So it seems like either we're doing something slightly wrong on putting 
machines to sleep which is resulting in them waking up without SCI_EN 
being set, or Windows unconditionally enables it and some hardware is 
just broken. Either way, it doesn't seem likely that it'll cause any 
harm.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
