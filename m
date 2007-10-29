From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 0/5] Detect hwmon and i2c bus drivers interfering with ACPI Operation Region resources
Date: Mon, 29 Oct 2007 13:11:59 +0000
Message-ID: <20071029131159.GA27283@srcf.ucam.org>
References: <1193236319.4590.225.camel@queen.suse.de> <200710250906.23003.bjorn.helgaas@hp.com> <20071027150947.GA1568@srcf.ucam.org> <200710282050.34166.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:44516 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313AbXJ2NVG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Oct 2007 09:21:06 -0400
Content-Disposition: inline
In-Reply-To: <200710282050.34166.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: trenn@suse.de, linux-acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@osdl.org>, Jean Delvare <khali@linux-fr.org>

On Sun, Oct 28, 2007 at 08:50:33PM -0600, Bjorn Helgaas wrote:
> On Saturday 27 October 2007 9:09:47 am Matthew Garrett wrote:
> > On Thu, Oct 25, 2007 at 09:06:22AM -0600, Bjorn Helgaas wrote:
> > > But we really *should* reserve things used by opregions, shouldn't
> > > we?  After all, the whole point of resource reservation is to prevent
> > > conflicts.
> >
> > Only if you're happy to lose functionality like IDE, sadly.
> 
> That's a simplistic answer to a complex problem.  I don't think
> we should just ignore the whole problem, cross our fingers, and
> hope that firmware stays out of our way.

Right now, there's not really any other way of handling it. The firmware 
may screw with pretty much everything, and it might even be safe for it 
to do so in many cases. In any case, you don't necessarily win that much 
by registering all the opregions, since SMI can go behind your back and 
write to stuff that's not declared in the DSDT anyway.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
