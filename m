From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 0/8] Remove fwnode type field, constify property fwnode arguments
Date: Mon, 24 Jul 2017 22:28:12 +0200
Message-ID: <26807574.YAK92jB8KX@aspire.rjw.lan>
References: <1500637177-16095-1-git-send-email-sakari.ailus@linux.intel.com> <1500640389.29303.177.camel@linux.intel.com> <1578902.vGrhFWnP8d@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:62953 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754706AbdGXUgL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 24 Jul 2017 16:36:11 -0400
In-Reply-To: <1578902.vGrhFWnP8d@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>, Frank Rowand <frowand.list@gmail.com>, erik.veijola@intel.com

On Friday, July 21, 2017 02:29:06 PM Rafael J. Wysocki wrote:
> On Friday, July 21, 2017 03:33:09 PM Andy Shevchenko wrote:
> > On Fri, 2017-07-21 at 13:52 +0200, Rafael J. Wysocki wrote:
> > > On Fri, Jul 21, 2017 at 1:39 PM, Sakari Ailus
> > > <sakari.ailus@linux.intel.com> wrote:
> > > > Hello everyone,
> > > > 
> > > > This set removes the struct fwnode_handle type field and constifies
> > > > the
> > > > fwnode arguments in the fwnode property API more or less the way
> > > > they are
> > > > const in OF property API.
> > > > 
> > > > Comments are welcome.
> > > > 
> > > > All the dependent patches are now in linux-pm master branch.
> > > > 
> > > > <URL:http://www.spinics.net/lists/linux-acpi/msg75957.html>;
> > > > 
> > > > v1 can be found here:
> > > > 
> > > > <URL:http://www.spinics.net/lists/linux-acpi/msg74564.html>;
> > > > 
> > > > changes since v2:
> > > > 
> > > > - Add 8th patch "device property: Introduce
> > > >   fwnode_property_get_reference_args". This allows obtaining
> > > > references
> > > >   with integer arguments using the fwnode interface.
> > > > 
> > > >   The functionality will be soon needed in adding support for nvmem
> > > >   framework on ACPI as well as in referring to e.g. lens and flash
> > > > devices
> > > >   on V4L2.
> > > 
> > > OK, so if people have no objections, I'll queue this up for 4.14.
> > 
> > I have no objections.
> > 
> > One comment Sakari already has addressed, another one
> > (list_first_enatry_or_null() use) might be addressed later.
> 
> Cool, thanks!

So the series have been applied.

Thanks,
Rafael

