From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: WMI vs Linux
Date: Wed, 28 Mar 2007 23:17:26 +0100
Message-ID: <20070328221726.GA14968@srcf.ucam.org>
References: <200703281544.41842.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:60967 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933862AbXC1WRn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Mar 2007 18:17:43 -0400
Content-Disposition: inline
In-Reply-To: <200703281544.41842.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: jamey.hicks@hp.com, linux-acpi@vger.kernel.org

On Wed, Mar 28, 2007 at 03:44:41PM -0400, Len Brown wrote:

> I was wondering if you could tell me about it.
> I was just about to write a little driver that binds to PNP0C14 and tells the
> user that they should not buy machines with WMI extensions and run Linux on them --
> but maybe an exception to that rule already exists?

It would be helpful to export as much WMI information as possible - we 
can supply information to utilise it via HAL, which would at least 
provide support for doing things like poking the wireless and bluetooth 
hardware on the old HP tablets.

I agree that WMI functionality is generally a bad sign, but where we can 
drive it I think we probably should be.

> ps. while you're at it, what is the WACF005 Wacom Digitizer device also in the patch --
> I don't see that upstream either.

It's handled by 8250_pnp.c now.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
