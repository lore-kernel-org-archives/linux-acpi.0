From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: ACPI: thinkpad-acpi: rename pci HID constant
Date: Sun, 15 Jul 2007 18:18:21 -0300
Message-ID: <20070715211820.GH19066@khazad-dum.debian.net>
References: <11844223322928-git-send-email-hmh@hmh.eng.br> <11844223351798-git-send-email-hmh@hmh.eng.br> <20070714223713.GC25782@srcf.ucam.org> <20070715180246.GE14134@khazad-dum.debian.net> <20070715183412.GB3235@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:39129 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751505AbXGOVS0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 15 Jul 2007 17:18:26 -0400
Content-Disposition: inline
In-Reply-To: <20070715183412.GB3235@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: lenb@kernel.org, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Sun, 15 Jul 2007, Matthew Garrett wrote:
> On Sun, Jul 15, 2007 at 03:02:46PM -0300, Henrique de Moraes Holschuh wrote:
> > On Sat, 14 Jul 2007, Matthew Garrett wrote:
> > > On Sat, Jul 14, 2007 at 11:12:04AM -0300, Henrique de Moraes Holschuh wrote:
> > > > -	 .hid = IBM_PCI_HID,
> > > > +	/* THIS ONE MUST NEVER BE USED FOR DRIVER AUTOLOADING.
> > > 
> > > Some rationale here would be good. There are no known devices where 
> > > loading ibm-acpi is harmful.
> > 
> > It is completely and utterly useless to autoload based on this.  You would
> > try to autoload it on every machine with a PCI root bridge, which is NOT a
> > bright idea at all.
> 
> I meant the IBM0068 device. That doesn't appear to be used anywhere 
> other than Thinkpads.

Oh, you CAN use the IBM0068 device to autoload.  I am not really sure
nothing but ThinkPads use it, and I already have other autoload hooks (based
on DMI) anyway, but it can be used as an autoload hint, yes.

But the comment about not using a HID for driver autoloading is for the
PCI_ROOT_HID_STRING only.  Is it in a confusing place on the source code, or
somesuch?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
