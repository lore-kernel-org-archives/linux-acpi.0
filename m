From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] ACPI / OSL: Fix a regression by returning acpi_table_header.length instead of 0 from acpi_get_table_with_size()
Date: Tue, 13 Dec 2016 00:04:19 +0100
Message-ID: <1723852.pt9sn0DzLb@aspire.rjw.lan>
References: <cover.1480490191.git.lv.zheng@intel.com> <CAJZ5v0jwHekD0YYLivgCf9H0zjEYrLC_NfmNOSTo7j6U92myDA@mail.gmail.com> <1AE640813FDE7649BE1B193DEA596E886CDDEC6B@SHSMSX103.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:51864 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751613AbcLLXIH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 12 Dec 2016 18:08:07 -0500
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886CDDEC6B@SHSMSX103.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>

On Monday, December 12, 2016 02:44:01 AM Zheng, Lv wrote:
> Hi,
> 
> > From: rjwysocki@gmail.com [mailto:rjwysocki@gmail.com] On Behalf Of Rafael J. Wysocki
> > Subject: Re: [PATCH v2] ACPI / OSL: Fix a regression by returning acpi_table_header.length instead of
> > 0 from acpi_get_table_with_size()
> > 
> > On Fri, Dec 9, 2016 at 8:15 AM, Lv Zheng <lv.zheng@intel.com> wrote:
> > > The following wrong commit triggers issues in acpi_get_table_with_size()
> > > users:
> > >     Subject: ACPICA: Tables: Back port acpi_get_table_with_size() and
> > >              early_acpi_os_unmap_memory() from Linux kernel
> > >
> > > The function is invented to be a replacement of acpi_get_table() during
> > > early stage so that the early mapped pointer will not be stored in ACPICA
> > > core and thus the late stage acpi_get_table() won't return a wrong pointer.
> > > However the mapping size is returned just because it is required by
> > > early_acpi_os_unmap_memory() to unmap the pointer during early stage.
> > >
> > > As the mapping size equals to the acpi_table_header.length
> > > (see acpi_tb_init_table_descriptor() and acpi_tb_validate_table()), when
> > > such a convenient result is returned, driver code will start to use it
> > > instead of accessing acpi_table_header to obtain the length.
> > >
> > > So the commit can trigger problems in such drivers as it returns 0 now. And
> > > it did bring a trouble to drivers/acpi/nfit/core.c. So before cleaning up
> > > the drivers, we should keep the old semantics of the API.
> > >
> > > This patch fixes the wrong commit by returning the acpi_table_header.length
> > > from acpi_get_table_with_size().
> > 
> > Well, the way this works isn't particularly straightforward.
> 
> I don't know what's your preference here?
> Shall we drop the 2 wrong commits, and merge fixed ones to replace them in linux-pm/linux-next?

Yes.

> Or can we just merge this fix patch on top of the wrong commits?

I've already sent a pull request with the 2 problematic commits dropped.

> > 
> > Wouldn't it be better to simply drop the check (if it is redundant)
> > from the NFIT driver?
> 
> At this point, I'm not sure if NFIT is the only driver broken by the wrong commit.

You can look for acpi_get_table_with_size() users.

It looks like radeon_bios.c may have the same problem.

> My plan was:
> 1. Keep old behavior working by still providing acpi_get_table_with_size()/early_acpi_os_unmap_memory();

OK

> 2. Use a set of patches to cleanup acpi_get_table_with_size()/early_acpi_os_unmap_memory() users,
>    So that we can carefully examine every caller, split strange use cases into separate commits to avoid regressions;
> 3. Remove acpi_get_table_with_size() and early_acpi_os_unmap_memory() if there is no driver using them.

Looks reasonable in principle.

Thanks,
Rafael

