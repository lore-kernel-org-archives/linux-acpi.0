From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Subject: Re: [patch] pci/hotplug acpiphp: fix Kconfig for Dock dependencies
Date: Wed, 26 Jul 2006 05:02:17 -0700
Message-ID: <20060726050217.A20441@unix-os.sc.intel.com>
References: <20060725161854.79f9cc1b.kristen.c.accardi@intel.com> <20060725164125.A15861@unix-os.sc.intel.com> <Pine.LNX.4.58.0607251711020.15622@shark.he.net>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:53258 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750719AbWGZML7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Jul 2006 08:11:59 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0607251711020.15622@shark.he.net>; from rdunlap@xenotime.net on Tue, Jul 25, 2006 at 05:13:31PM -0700
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>, akpm@osdl.org, zippel@linux-m68k.org, linux-kernel@vger.kernel.org, greg@kroah.com, pcihpd-discuss@lists.sourceforge.net

On Tue, Jul 25, 2006 at 05:13:31PM -0700, Randy.Dunlap wrote:
> On Tue, 25 Jul 2006, Keshavamurthy Anil S wrote:
> 
> > On Tue, Jul 25, 2006 at 04:18:54PM -0700, Kristen Carlson Accardi wrote:
> > >     drivers/pci/hotplug/Kconfig |   17 ++++++++++++++++-
> > >     1 file changed, 16 insertions(+), 1 deletion(-)
> > Can;t this be done with just one line change?
> 
> The first attempted patch was something like:
> 
> 	depends on HOTPLUG_PCI && ACPI_DOCK!=n
> 
> but that is not legal kconfig language.
> Did you have something else in mind?

Yup, already mentioned in my first email.
Please see below which is just one line change
and acheives the same as your 17 line change patch.

> > >    -       depends on ACPI_DOCK && HOTPLUG_PCI
> > 	depends on (!ACPI_DOCK && ACPI && HOTPLUG_PCI) || (ACPI_DOCK && HOTPLUG_PCI)

-Anil
