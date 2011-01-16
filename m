From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI: don't attempt to use hest_tab unless !acpi_pci_disabled
Date: Sun, 16 Jan 2011 20:28:33 +0100
Message-ID: <201101162028.33572.rjw@sisk.pl>
References: <20110114181620.188e7a62@queued.net> <201101152148.43791.rjw@sisk.pl> <20110115192422.706af049@queued.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:39809 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753772Ab1APT3a (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 16 Jan 2011 14:29:30 -0500
In-Reply-To: <20110115192422.706af049@queued.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andres Salomon <dilinger@queued.net>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Huang Ying <ying.huang@intel.com>, Jesse Barnes <jbarnes@virtuousgeek.org>

On Sunday, January 16, 2011, Andres Salomon wrote:
> On Sat, 15 Jan 2011 21:48:43 +0100
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > On Saturday, January 15, 2011, Andres Salomon wrote:
> > > On Sat, 15 Jan 2011 21:38:10 +0100
> > > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > 
> > > > On Saturday, January 15, 2011, Andres Salomon wrote:
> > > > > On Sat, 15 Jan 2011 14:01:18 +0100
> > > > > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > > > 
> > > > > > On Saturday, January 15, 2011, Andres Salomon wrote:
> > > > > > > On Fri, 14 Jan 2011 23:24:27 -0500 (EST)
> > > > > > > Len Brown <lenb@kernel.org> wrote:
> > > > > > > 
> > > > > > > [...]
> > > > > > > > > This patch causes apei_hest_parse to check both
> > > > > > > > > hest_disabled and acpi_pci_disabled before continuing.
> > > > > > > > > With it, the XO-1 boots properly.
> > > > > > > > 
> > > > > > > > The X0-1 has no ACPI support, and thus you are running
> > > > > > > > with acpi_disabled=1, yes?
> > > > > > > 
> > > > > > > The XO-1 has no ACPI support, but ACPI support is enabled
> > > > > > > in the kernel (as the XO-1.5 does have ACPI support, and
> > > > > > > the same kernel is used between both) and I'm not passing
> > > > > > > any arguments to the kernel regarding it. The kernel's ACPI
> > > > > > > code detects that it's not there and disables it (the
> > > > > > > kernel message that's seen is "ACPI: Interpreter disabled.")
> > > > > > > 
> > > > > > > This is what sets apci_pci_disabled to 1; I'm not doing it
> > > > > > > manually.
> > > > > > 
> > > > > > Hmm.  Does the appended patch help instead?
> > > > > 
> > > > > Nope.  acpi_hest_init returns immediately if acpi_disabled, and
> > > > > thus never sets hest_disable.  You either need to set
> > > > > hest_disable, or ensure apei_hest_parse checks more than just
> > > > > hest_disable.
> > > > 
> > > > OK, so the new one below should help, right?
> > > 
> > > Yes, that looks better
> > 
> > OK
> > 
> > > (though you probably just want to use 'goto err;' instead).
> > 
> > Indeed.
> > 
> > > I can test it later today.
> > 
> > Cool, thanks.  Please try the version below with the 'goto'.
> > 
> > Rafael
> 
> 
> Yep, just tested it out; it works fine.

Great, thanks!

Rafael
