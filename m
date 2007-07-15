From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: ACPI: thinkpad-acpi: rename pci HID constant
Date: Sun, 15 Jul 2007 19:34:12 +0100
Message-ID: <20070715183412.GB3235@srcf.ucam.org>
References: <11844223322928-git-send-email-hmh@hmh.eng.br> <11844223351798-git-send-email-hmh@hmh.eng.br> <20070714223713.GC25782@srcf.ucam.org> <20070715180246.GE14134@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:52211 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753516AbXGOSt7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Jul 2007 14:49:59 -0400
Content-Disposition: inline
In-Reply-To: <20070715180246.GE14134@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: lenb@kernel.org, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Sun, Jul 15, 2007 at 03:02:46PM -0300, Henrique de Moraes Holschuh wrote:
> On Sat, 14 Jul 2007, Matthew Garrett wrote:
> > On Sat, Jul 14, 2007 at 11:12:04AM -0300, Henrique de Moraes Holschuh wrote:
> > > -	 .hid = IBM_PCI_HID,
> > > +	/* THIS ONE MUST NEVER BE USED FOR DRIVER AUTOLOADING.
> > 
> > Some rationale here would be good. There are no known devices where 
> > loading ibm-acpi is harmful.
> 
> It is completely and utterly useless to autoload based on this.  You would
> try to autoload it on every machine with a PCI root bridge, which is NOT a
> bright idea at all.

I meant the IBM0068 device. That doesn't appear to be used anywhere 
other than Thinkpads.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
