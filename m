From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [ANNOUNCE] ACPI BIOS Guideline for Linux
Date: Thu, 28 Aug 2008 13:22:29 +0100
Message-ID: <20080828122227.GA26285@srcf.ucam.org>
References: <200807241732.23412.trenn@suse.de> <200808281141.30178.trenn@suse.de> <20080828105616.GA24515@srcf.ucam.org> <200808281416.57193.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:47076 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471AbYH1MWe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Aug 2008 08:22:34 -0400
Content-Disposition: inline
In-Reply-To: <200808281416.57193.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Andi Kleen <ak@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Aug 28, 2008 at 02:16:55PM +0200, Thomas Renninger wrote:
> On Thursday 28 August 2008 12:56:16 Matthew Garrett wrote:
> > A documented WMI interface is easier to use than an entirely custom 
> > documented interface, and reduces the amount of work the vendor has to
> > do in Windows. To be honest, I think it's the sort of thing we should be
> > encouraging.
> IMO WMI should not exist.
> A lot laptop BIOSes do not use it at all, unfortunately it seems to get
> more common again.
> What advantage do you get on Linux using WMI?

Little. But what advantage do we get in the same functionality being 
implemented in an entirely custom way? Even less.

> For example HP is using WMI to export a WLAN (or bluetooth?) button on
> some machines.
> They should not do that, right?

The HP wlan button is a hardware event. There's no need for it to be 
sent via the keyboard controller. Some of the other keys would be easier 
to deal with if they were sent via the keyboard controller, yes, but 
that's not the full set of what the WMI functionality gives us. How do 
you want kill switches to be controlled? I'd be happier with it being 
done through WMI (like HP) than via Dell's bizarro SMI interface.

> AFAIK most vendors tend to send an ordinary key event again for most
> extra buttons. Is this the way to go for the future? This probably
> should also be mentioned then.

Some vendors do, and I agree that it's preferable.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
