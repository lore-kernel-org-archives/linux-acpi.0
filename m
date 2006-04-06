From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: Help with Averatec C3500
Date: Thu, 6 Apr 2006 09:03:25 -0600
Message-ID: <200604060903.25824.bjorn.helgaas@hp.com>
References: <442EB141.5040205@linuxkidd.com> <200604041326.45510.bjorn.helgaas@hp.com> <200604060859.42629.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:24751 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S932159AbWDFPDc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Apr 2006 11:03:32 -0400
In-Reply-To: <200604060859.42629.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Michael J. Kidd" <mjkidd@linuxkidd.com>
Cc: linux-acpi@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>

On Thursday 06 April 2006 08:59, Bjorn Helgaas wrote:
> Alan, could you give me a hint about what you mean?  ACPI doesn't
> ioremap device registers, so I'm not sure what the problem is.
> 
> > > After posting the above request to the linux-usb list, Alan Stern 
> > > responded with:
> > > ----------------------------------------------------------------------
> > > According to the log, the I/O memory mappings for the USB and PCMCIA
> > > controllers aren't getting set up. It's not a USB or PCMCIA issue at all;
> > > you should ask for help on the PCI and ACPI mailing lists.

Sorry, I see you already responded to the bugzilla:
    http://bugzilla.kernel.org/show_bug.cgi?id=6332

I'll take another look and respond there also.

Thanks,
  Bjorn
