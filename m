From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch] ACPI: call init functions explicitly instead of using initcalls
Date: Fri, 31 Oct 2008 13:04:39 -0600
Message-ID: <200810311304.40459.bjorn.helgaas@hp.com>
References: <200810291525.58218.bjorn.helgaas@hp.com> <200810302251.46443.bjorn.helgaas@hp.com> <1225436139.3993.59.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:13844 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbYJaTFN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Oct 2008 15:05:13 -0400
In-Reply-To: <1225436139.3993.59.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Li, Shaohua" <shaohua.li@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Friday 31 October 2008 12:55:39 am Zhao Yakui wrote:
> On Fri, 2008-10-31 at 12:51 +0800, Bjorn Helgaas wrote:

> > As far as I can tell, CONFIG_ACPI_POWER is useless, since it
> > is always set the same as CONFIG_ACPI.  And interfaces from
> > acpi/power.c, such as acpi_power_transition(), are used
> > unconditionally from acpi/bus.c.  Given that, I think we
> > should remove the CONFIG_ACPI_POWER Kconfig option and change
> > the makefile to look like this:
> The CONFIG_ACPI_POWER is useless.If the CONFIG_ACPI is enabled, it is
> always set.

OK, I'll work up a patch to remove it.

> The power resource(ACPI device) should be bound with its ACPI device
> driver after EC initialization.

Let's be specific here.  There's way too much magic here, and that
makes things fragile.  Are you saying that the EC driver must be
initialized before acpi_power_add() is called?

6.5.4 of the spec says:

  OSPM must make Embedded Controller operation regions, accessed
  via the Embedded Controllers described in ECDT, available before
  executing any control method.

which is similar to what you're saying.  However, I think what
the spec requires is the sort of stuff in acpi_ec_ecdt_probe(),
which is already called early in acpi_bus_init().

It sounds like you're saying that ECDT probe is not sufficient,
and that we also need to run acpi_ec_init() (where we claim
PNP0C09 devices from the namespace) before we register the
acpi_power_driver.

> So it is not appropriate as done in the 
> following:
>     >obj-y                           += bus.o scan.o power.o

It also seems impossible to turn off CONFIG_ACPI_EC.  There is
Kconfig help text for it, but it has no menu item label, so it
is not selectable via menuconfig.

Given the requirement from 6.5.4 of the spec above, it doesn't
seem like CONFIG_ACPI_EC even makes sense -- shouldn't we just
consider acpi_ec_ecdt_probe() to be part of the ACPI core?
Then the makefile would be:

  obj-y                           += bus.o ec.c scan.o power.o

Bjorn


