From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] ACPI: Fix the issue that auto SSDT loading is conflict with customized SSDT that is included by the customized DSDT.
Date: Tue, 22 Apr 2014 13:19:45 +0200
Message-ID: <5046344.V68ybXiztI@vostro.rjw.lan>
References: <cover.1396925060.git.lv.zheng@intel.com> <10605546.pEf4E3AVn4@vostro.rjw.lan> <1AE640813FDE7649BE1B193DEA596E8802556E6A@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54541 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932165AbaDVLDZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Apr 2014 07:03:25 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E8802556E6A@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tuesday, April 22, 2014 12:50:37 AM Zheng, Lv wrote:
> Hi, Rafael
> 
> > From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> > Sent: Tuesday, April 22, 2014 5:14 AM
> > 
> > On Tuesday, April 08, 2014 10:49:06 AM Lv Zheng wrote:
> > > This patch fixes the following issue:
> > > User can specify a DSDT with SSDT embedded, in which case, no_static_ssdt
> > > must be enforced.  If we don't do that, then:
> > > 1. The namespace object conflicts will result in an AE_ALREADY_EXISTS
> > >    exception;
> > > 2. The namespace objects that are deleted from the original SSDT will be
> > >    restored by the auto loading of the original SSDT.
> > >
> > > Note that the DSDT customization is a compile-time feature, thus the SSDT
> > > inclusion indication of the DSDT customization is also implemented as a
> > > compile-time configurable.
> > >
> > > Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=69711
> > > Original-by: Enrico Etxe Arte <goitizena.generoa@gmail.com>
> > > Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> > > ---
> > >  drivers/acpi/Kconfig    |    8 ++++++++
> > >  drivers/acpi/internal.h |    5 +++++
> > >  drivers/acpi/osl.c      |   14 +++++++++++++-
> > >  drivers/acpi/tables.c   |    2 ++
> > >  4 files changed, 28 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> > > index c205653..a0b8131 100644
> > > --- a/drivers/acpi/Kconfig
> > > +++ b/drivers/acpi/Kconfig
> > > @@ -212,6 +212,14 @@ config ACPI_CUSTOM_DSDT
> > >  	bool
> > >  	default ACPI_CUSTOM_DSDT_FILE != ""
> > >
> > > +config ACPI_CUSTOM_SSDT_INCLUDED
> > > +	bool "Custom SSDT Tables included"
> > > +	depends on ACPI_CUSTOM_DSDT
> > > +	help
> > > +	  This option turns on acpi.no_static_ssdt by default.
> > > +
> > > +	  If the SSDT code has been merged into the custom DSDT file, say Y.
> > 
> > I wonder what the benefit of having a separate .config option for that is?
> > 
> > Can't we just use CONFIG_ACPI_CUSTOM_DSDT instead of CONFIG_ACPI_CUSTOM_SSDT_INCLUDED
> > everywhere instead?
> > 
> 
> It is a different use case.
> Normally, ACPI_CUSTOM_DSDT only allows 1 table to be customized.
> The original bug reporter has to customize the SSDT to make his platform bootable.
> He achieves this by copying the entire SSDT into the DSDT and compile the DSDT
> into a customized binary to be used for ACPI_CUSTOM_DSDT.
> So user can:
> 
> 1. customize DSDT without SSDTs copied into it;
> 2. customize DSDT with SSDTs copied into it.
> 
> The new config option is used for the new use case - case 2.
> So it seems we can't just use CONFIG_ACPI_CUSTOM_DSDT.
> 
> I think the naming of the new option might be confusing.
> It  can be ACPI_CUSTOM_DSDT_WITH_SSDT to indicate the fact that
> it is a sub-option that depends on the ACPI_CUSTOM_DSDT.

Well, it looks like the solution would be to allow SSDTs and DSDTs to be
customized independently, wouldn't it?

So that the user in question actually can leave his DSDT as is and customize
the SSDT only, no?

Rafael

