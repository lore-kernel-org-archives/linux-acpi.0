From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: acpi_find_bmc() and acpi_get_table()
Date: Mon, 19 Feb 2007 21:31:52 -0700
Message-ID: <200702192131.52947.bjorn.helgaas@hp.com>
References: <200702102327.28312.lenb@kernel.org> <200702152103.54960.bjorn.helgaas@hp.com> <45D53DDE.5000300@acm.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:49015 "EHLO atlrel9.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932818AbXBTEb5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 19 Feb 2007 23:31:57 -0500
In-Reply-To: <45D53DDE.5000300@acm.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corey Minyard <minyard@acm.org>
Cc: Len Brown <lenb@kernel.org>, minyard@mvista.com, linux-acpi@vger.kernel.org

On Thursday 15 February 2007 22:15, Corey Minyard wrote:
> Bjorn Helgaas wrote:
> > On Saturday 10 February 2007 21:27, Len Brown wrote:
> >   
> >> acpi_find_bmc() appears to be searching for 
> >> multiple SPMI tables in the RSDT and running
> >> try_init_acpi() on each of them
> >> until it doesn't find any more.
> >>     
> >
> > I can't remember why we look at the SPMI table(s) rather than
> > registering a normal ACPI (or even PNP) driver.  Unless we
> > need to poke the BMC very early, wouldn't it be better to
> > rely on the device description in the namespace?
> >   
> For some strange reason the normal ACPI information does not
> have all the information needed by the driver.  It doesn't have
> register size or spacing information.

I guess that would be a defect in the way ACPI is being used,
wouldn't it?  A PNP ID should define the device programming
model, including things like register size and spacing.  It
sounds like somebody didn't define a new PNP ID when he should
have.  I wonder whether it's worth trying to fix this.

Bjorn
