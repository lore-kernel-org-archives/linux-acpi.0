From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Help with Averatec C3500
Date: Thu, 6 Apr 2006 11:34:28 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0604061132020.5126-100000@iolanthe.rowland.org>
References: <200604060859.42629.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:28316 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751109AbWDFPec (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 6 Apr 2006 11:34:32 -0400
In-Reply-To: <200604060859.42629.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: "Michael J. Kidd" <mjkidd@linuxkidd.com>, linux-acpi@vger.kernel.org

On Thu, 6 Apr 2006, Bjorn Helgaas wrote:

> Alan, could you give me a hint about what you mean?  ACPI doesn't
> ioremap device registers, so I'm not sure what the problem is.
> 
> > > After posting the above request to the linux-usb list, Alan Stern 
> > > responded with:
> > > ----------------------------------------------------------------------
> > > According to the log, the I/O memory mappings for the USB and PCMCIA
> > > controllers aren't getting set up. It's not a USB or PCMCIA issue at all;
> > > you should ask for help on the PCI and ACPI mailing lists.

Since I don't know how this low-level stuff is handled, I was guessing.

ACPI is involved in setting up motherboard resources, including 
configuration of various bridges.  If a bridge wasn't configured properly, 
the CPU wouldn't be able to access the device's I/O hardware.

Alan Stern

