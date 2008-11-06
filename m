From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 01/11] ACPI: update debug parameter documentation
Date: Thu, 6 Nov 2008 15:22:39 -0600
Message-ID: <200811061422.39997.bjorn.helgaas@hp.com>
References: <20081105231710.26131.3110.stgit@bob.kio> <20081105231737.26131.62046.stgit@bob.kio> <alpine.LFD.2.00.0811061502100.3106@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:18443 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146AbYKFVWp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Nov 2008 16:22:45 -0500
In-Reply-To: <alpine.LFD.2.00.0811061502100.3106@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Zhao Yakui <yakui.zhao@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Thomas Renninger <trenn@suse.de>

On Thursday 06 November 2008 01:29:16 pm Len Brown wrote:
> On Wed, 5 Nov 2008, Bjorn Helgaas wrote:
> > +			The following are some of the global components
> > +			defined by the ACPI CA and the Linux OSPM:
> > +				0x01 utilities
> > +				0x02 hardware
> > +				0x04 events
> > +				0x08 tables
> > +				0x10 namespace
> > +				0x20 parser
> > +				0x40 dispatcher
> > +				0x80 executer
> > +			       0x100 resources
> > +			       0x200 ACPI CA debugger
> > +			       0x400 OS services
> > +			       0x800 ACPI CA disassembler
> > +			     0x40000 battery
> > +			     0x80000 button
> > +			    0x200000 fan
> > +			    0x400000 PCI
> > +			  0x10000000 bay
> 
> The (always current) bit definitions can always be had this way:
> 
> $ cat /sys/module/acpi/parameters/debug_layer
> Description              	Hex        SET
> ACPI_UTILITIES           	0x00000001 [*]
> ACPI_HARDWARE            	0x00000002 [*]
> ACPI_EVENTS              	0x00000004 [*]
> ACPI_TABLES              	0x00000008 [*]
> ACPI_NAMESPACE           	0x00000010 [*]
> ACPI_PARSER              	0x00000020 [*]
> ACPI_DISPATCHER          	0x00000040 [*]
> ACPI_EXECUTER            	0x00000080 [*]
> ACPI_RESOURCES           	0x00000100 [*]
> ACPI_CA_DEBUGGER         	0x00000200 [*]
> ACPI_OS_SERVICES         	0x00000400 [*]
> ACPI_CA_DISASSEMBLER     	0x00000800 [*]
> ACPI_COMPILER            	0x00001000 [*]
> ACPI_TOOLS               	0x00002000 [*]
> ACPI_ALL_DRIVERS         	0xFFFF0000 [*]
> 
> So I think just mentioning that is enough, rather than
> reproducing it here.  However, I do think that highlighting
> the driver bits would be good, since they're not included above.
> bay isn't a good example, as it doesn't exist any more.

I don't really like having the whole list in the doc either.
One problem with using only a pointer to the sysfs file is
that you have to have a booted machine with ACPI_DEBUG=y.

We could use a pointer to acoutput.h, especially if we moved
the driver definitions there.  It's still a minor irritation
that the source code says "ACPI_DEBUG_PRINT((ACPI_DB_INFO ..."
and you have to work back to the ACPI_LV_INFO definition before
you have a mask value.  But the benefit of having only a single
copy of the list is probably worth that irritation.

If you're willing to see the component definitions in acoutput.h,
would you also want to change acpi/debug.c so it prints the
driver bits individually?

> > +	  When no parameters are supplied, the default settings cause AML
> > +	  stores to the "Debug" object to produce console output.
> 
> I think Thomas may have changed this at SuSE b/c they ship
> with CONFIG_ACPI_DEBUG=y, if so, maybe upstream should also?

Yeah, I don't really like the default mask being non-zero.
I seem to have a bunch of machines that spew lots of debug
output.  Possibly these are protos with old firmware, but I
suspect we shipped firmware that uses Debug.

I didn't change it because the default is currently set in
the CA somewhere.  I guess we could override it early in
acpi_init() or something.

Bjorn
