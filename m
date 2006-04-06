From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: Help with Averatec C3500
Date: Thu, 6 Apr 2006 08:59:42 -0600
Message-ID: <200604060859.42629.bjorn.helgaas@hp.com>
References: <442EB141.5040205@linuxkidd.com> <200604041326.45510.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel7.hp.com ([156.153.255.213]:64488 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S932177AbWDFO7r (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Apr 2006 10:59:47 -0400
In-Reply-To: <200604041326.45510.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Michael J. Kidd" <mjkidd@linuxkidd.com>
Cc: linux-acpi@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>

Alan, could you give me a hint about what you mean?  ACPI doesn't
ioremap device registers, so I'm not sure what the problem is.

> > After posting the above request to the linux-usb list, Alan Stern 
> > responded with:
> > ----------------------------------------------------------------------
> > According to the log, the I/O memory mappings for the USB and PCMCIA
> > controllers aren't getting set up. It's not a USB or PCMCIA issue at all;
> > you should ask for help on the PCI and ACPI mailing lists.
