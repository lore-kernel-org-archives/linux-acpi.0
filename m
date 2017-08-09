From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v3 0/8] Remove fwnode type field, constify property
 fwnode arguments
Date: Wed, 9 Aug 2017 11:47:55 +0300
Message-ID: <20170809084755.pec6w2y2thmbmjyi@valkosipuli.retiisi.org.uk>
References: <1500637177-16095-1-git-send-email-sakari.ailus@linux.intel.com>
 <26807574.YAK92jB8KX@aspire.rjw.lan>
 <20170808093215.uw2lricbbvwb7t3k@valkosipuli.retiisi.org.uk>
 <3442396.FuC0BxuCi0@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:42456 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752033AbdHIIsC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Aug 2017 04:48:02 -0400
Content-Disposition: inline
In-Reply-To: <3442396.FuC0BxuCi0@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>, Frank Rowand <frowand.list@gmail.com>, erik.veijola@intel.com

On Wed, Aug 09, 2017 at 02:53:25AM +0200, Rafael J. Wysocki wrote:
> On Tuesday, August 8, 2017 11:32:16 AM CEST Sakari Ailus wrote:
> > On Mon, Jul 24, 2017 at 10:28:12PM +0200, Rafael J. Wysocki wrote:
> > > On Friday, July 21, 2017 02:29:06 PM Rafael J. Wysocki wrote:
> > > > On Friday, July 21, 2017 03:33:09 PM Andy Shevchenko wrote:
> > > > > On Fri, 2017-07-21 at 13:52 +0200, Rafael J. Wysocki wrote:
> > > > > > On Fri, Jul 21, 2017 at 1:39 PM, Sakari Ailus
> > > > > > <sakari.ailus@linux.intel.com> wrote:
> > > > > > > Hello everyone,
> > > > > > > 
> > > > > > > This set removes the struct fwnode_handle type field and constifies
> > > > > > > the
> > > > > > > fwnode arguments in the fwnode property API more or less the way
> > > > > > > they are
> > > > > > > const in OF property API.
> > > > > > > 
> > > > > > > Comments are welcome.
> > > > > > > 
> > > > > > > All the dependent patches are now in linux-pm master branch.
> > > > > > > 
> > > > > > > <URL:http://www.spinics.net/lists/linux-acpi/msg75957.html>;
> > > > > > > 
> > > > > > > v1 can be found here:
> > > > > > > 
> > > > > > > <URL:http://www.spinics.net/lists/linux-acpi/msg74564.html>;
> > > > > > > 
> > > > > > > changes since v2:
> > > > > > > 
> > > > > > > - Add 8th patch "device property: Introduce
> > > > > > >   fwnode_property_get_reference_args". This allows obtaining
> > > > > > > references
> > > > > > >   with integer arguments using the fwnode interface.
> > > > > > > 
> > > > > > >   The functionality will be soon needed in adding support for nvmem
> > > > > > >   framework on ACPI as well as in referring to e.g. lens and flash
> > > > > > > devices
> > > > > > >   on V4L2.
> > > > > > 
> > > > > > OK, so if people have no objections, I'll queue this up for 4.14.
> > > > > 
> > > > > I have no objections.
> > > > > 
> > > > > One comment Sakari already has addressed, another one
> > > > > (list_first_enatry_or_null() use) might be addressed later.
> > > > 
> > > > Cool, thanks!
> > > 
> > > So the series have been applied.
> > 
> > Thanks a lot!
> > 
> > I see this is in the linux-next branch now; the device-properties branch
> > seems to be in its former state still. Is there a chance that you have
> > merged it locally but not pushed the new device-properties branch?
> 
> The branch is only local for the time being, but I can push it out if
> that helps.

I have V4L2 patches that depend on these --- I'd like to attempt to get
them in through the mediatree during this merge window.

-- 
Sakari Ailus
e-mail: sakari.ailus@iki.fi	XMPP: sailus@retiisi.org.uk
