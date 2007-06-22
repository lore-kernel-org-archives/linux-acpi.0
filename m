From: David Brownell <david-b@pacbell.net>
Subject: Re: [2.6.22-rc1-mm1] vaio laptop (SZ72B) immediately resumes after STR
Date: Fri, 22 Jun 2007 03:08:26 -0700
Message-ID: <200706220308.27447.david-b@pacbell.net>
References: <20070518071523.GA3195@inferi.kami.home> <1182304359.5411.122.camel@localhost.localdomain> <200706202339.20188.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:36368 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752069AbXFVKIZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 Jun 2007 06:08:25 -0400
In-Reply-To: <200706202339.20188.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Zhang Rui <rui.zhang@intel.com>, Mattia Dongili <malattia@linux.it>, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Len Brown <lenb@kernel.org>, Greg KH <greg@kroah.com>, Andrew Morton <akpm@linux-foundation.org>

On Wednesday 20 June 2007, Rafael J. Wysocki wrote:

> Well, there's nothing interesting in there, AFAICS:
> 
> Device	S-state	  Status   Sysfs node
> P0P4	  S4	 disabled  pci:0000:00:1e.0
> BNIC	  S4	 disabled  pci:0000:02:05.0
> USB1	  S4	 disabled  pci:0000:00:1d.0
> USB2	  S4	 disabled  pci:0000:00:1d.1
> USB3	  S4	 disabled  pci:0000:00:1d.2
> EUSB	  S4	 disabled  pci:0000:00:1d.7
> PS2K	  S4	 disabled  pnp:00:0b
> PS2M	  S4	 disabled  pnp:00:0c

The interesting thing there is that all those devices are
able to wake from S4 state ... including USB controllers.

That's not very common for USB.  EHCI ("EUSB" above) at
least has a spec for how that should work ... it relies on
the PCI Vaux power well to maintain power sessions, though
I don't know that the EHCI code has been tested against
that part of the spec.  UHCI likely relies on black magic
to achieve that effect.

- Dave
