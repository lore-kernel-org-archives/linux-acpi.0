From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 2/2] ACPI / PMIC: xpower: Add support for the GPI1 regulator to the OpRegion handler
Date: Fri, 28 Apr 2017 00:28:12 +0200
Message-ID: <5402074.iyQs1h8kyq@aspire.rjw.lan>
References: <20170421114809.17468-1-hdegoede@redhat.com> <2873076.4YlPq2sVU6@aspire.rjw.lan> <1493285746.24567.224.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:57469 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756416AbdD0We1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 27 Apr 2017 18:34:27 -0400
In-Reply-To: <1493285746.24567.224.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, russianneuromancer@ya.ru

On Thursday, April 27, 2017 12:35:46 PM Andy Shevchenko wrote:
> On Thu, 2017-04-27 at 00:01 +0200, Rafael J. Wysocki wrote:
> > On Friday, April 21, 2017 01:48:09 PM Hans de Goede wrote:
> > > Some Bay Trail devices use a GPI1 regulator field (address 0x4c) in
> > > their 0x8d power OpRegion, add support for this.
> > > 
> > > This fixes AE_BAD_PARAMETER errors getting thrown on these devices
> > > and
> > > fixes these errors causing these devices to not suspend.
> > > 
> > > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > 
> > Srinivas, Andy, any concerns here?
> 
> Nothing major.
> 
> It might be useful to introduce
> 
> GPI1_LDO_MASK GENMASK(2,0)
> GPI1_LDO_ON  (3 << 0)
> GPI1_LDO_OFF (4 << 0)
> 
> But it's up to you. I'm fine with either.

This is a good point IMO.

Hans, care to use symbols as suggested by Andy?

Thanks,
Rafael

