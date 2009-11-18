From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH v1 0/5] IPMI devices from ACPI namespace
Date: Wed, 18 Nov 2009 09:29:18 -0700
Message-ID: <200911180929.19924.bjorn.helgaas@hp.com>
References: <20091118000427.14214.14043.stgit@bob.kio> <1258511389.3813.54.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:48069 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757668AbZKRQ3w (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Nov 2009 11:29:52 -0500
In-Reply-To: <1258511389.3813.54.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ykzhao <yakui.zhao@intel.com>
Cc: Corey Minyard <minyard@acm.org>, Bela Lubkin <blubkin@vmware.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Myron Stowe <myron.stowe@hp.com>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, Len Brown <lenb@kernel.org>

On Tuesday 17 November 2009 07:29:49 pm ykzhao wrote:
>     In this patch set the IPMI system interface will be detected by
> using pnp device driver. In theory it is ok to detect the IPMI system
> interface by using pnp device driver.
>    But we will have to consider the following two problems:
>    a. how to detect the IPMI system interface defined in ACPI table if
> the pnp subsystem is disabled? For example: by adding the boot option of
> "pnpacpi=off". Why does this need to depend on two subsystems(ACPI and
> pnp)?

This is not a problem.  On an ACPI system, *all* PNP drivers depend
on PNPACPI.  There's no reason IPMI needs to be handled differently.
Treating the IPMI system interface the same as every other device
makes the kernel easier to understand and easier to maintain.

>    b. There exist several exceptions about the _CRS for the IPMI system
> interface defined in ACPI table.

What exceptions are these?  If you're talking about BIOS defects we
need to work around, we should make the workarounds explicit in the
code.  If they're not explicit, we're likely to accidentally break
the workaround later.

> Maybe there exist two IO/memory address 
> definition for the IPMI system interface and the memory type is declared
> before IO type. In such case we can't know which should be selected.

Your patch uses the first address (either I/O or memory) from _CRS.
My patch as posted uses an I/O port address if it exists (even if it
wasn't the first in _CRS) and falls back to using a memory address if
there was no I/O port address.

If this is an important difference, we can walk the struct pnp_dev
resources list, since PNP is careful to maintain that in the same
order as _CRS.  For example, we could do this:

        struct pnp_resource *pnp_res;
        struct resource *res;

        list_for_each_entry(pnp_res, &dev->resources, list) {
                res = &pnp_res->res;
                if (pnp_resource_type(res) == IORESOURCE_IO) {
			info->io_setup = port_setup;
			info->io.addr_type = IPMI_IO_ADDR_SPACE;
			info->io.addr_data = res->start;
			break;
		} else if (pnp_resource_type(res) == IORESOURCE_MEM) {
			info->io_setup = mem_setup;
			info->io.addr_type = IPMI_MEM_ADDR_SPACE;
			info->io.addr_data = res->start;
			break;
		}
	}

But you haven't given an example that proves this is necessary,
so I don't think the extra complication is worthwhile.

> At the same time in order to enable the communication between the ACPI
> AML code and IPMI subsystem, too strict dependency is added.
>    In such case if the ACPI IPMI driver is not selected, the IPMI
> subsystem can't be compiled correctly.

You are right that in my sample patch, ipmi_si_intf.c won't build
unless CONFIG_ACPI_IPMI=y.  But that's easily fixed by an ifdef in
ipmi_si_intf.c.  Or ipmi_si_intf.c could export an interface that
drivers/acpi/ipmi.c could use to register itself.

I don't care as much about those details because they're internal to
the IPMI driver piece, and they don't affect the ACPI core.

The important thing is that drivers/acpi/ipmi.c is not a driver for
the IPMI system interface, since it doesn't deal with interrupts or
IPMI registers, so it shouldn't use acpi_bus_register_driver() or
pnp_register_driver().

Bjorn
