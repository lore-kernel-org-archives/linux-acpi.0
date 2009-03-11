From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC PATCH 1/5] ACPI video: check the return value of acpi_video_device_lcd_get_level_current
Date: Wed, 11 Mar 2009 13:04:32 +0000
Message-ID: <20090311130432.GA21313@srcf.ucam.org>
References: <1236672205.2820.119.camel@rzhang-dt> <200903111356.01710.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:51307 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754573AbZCKNEh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Mar 2009 09:04:37 -0400
Content-Disposition: inline
In-Reply-To: <200903111356.01710.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Wed, Mar 11, 2009 at 01:56:00PM +0100, Thomas Renninger wrote:

> (BTW, I recently saw a BIOS with _BCQ function. They said they are going to 
> fix it, but it may be more widespread, e.g. this also is often the case 
> (missing _BQC) on Samsung). I found it by luck disassembling and 
> recompiling the DSDT, a runtime warning would be nice (if it does not 
> already exist).

It's not that uncommon - there's a few machines with _BCQ. I actually 
thought we handled it already, but it seems not. Just adding a cap._BCQ 
and using it if there's no _BQC sounds like a safe idea.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
