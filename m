From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 0/8] Remove fwnode type field, constify property
 fwnode arguments
Date: Fri, 21 Jul 2017 15:33:09 +0300
Message-ID: <1500640389.29303.177.camel@linux.intel.com>
References: <1500637177-16095-1-git-send-email-sakari.ailus@linux.intel.com>
         <CAJZ5v0gWvjd4m0etYAiUJxKyDL1GkzKdKWBynjKExvZ+3KF8jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:21224 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750835AbdGUMgP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 Jul 2017 08:36:15 -0400
In-Reply-To: <CAJZ5v0gWvjd4m0etYAiUJxKyDL1GkzKdKWBynjKExvZ+3KF8jw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>, Frank Rowand <frowand.list@gmail.com>, erik.veijola@intel.com

On Fri, 2017-07-21 at 13:52 +0200, Rafael J. Wysocki wrote:
> On Fri, Jul 21, 2017 at 1:39 PM, Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> > Hello everyone,
> > 
> > This set removes the struct fwnode_handle type field and constifies
> > the
> > fwnode arguments in the fwnode property API more or less the way
> > they are
> > const in OF property API.
> > 
> > Comments are welcome.
> > 
> > All the dependent patches are now in linux-pm master branch.
> > 
> > <URL:http://www.spinics.net/lists/linux-acpi/msg75957.html>;
> > 
> > v1 can be found here:
> > 
> > <URL:http://www.spinics.net/lists/linux-acpi/msg74564.html>;
> > 
> > changes since v2:
> > 
> > - Add 8th patch "device property: Introduce
> >   fwnode_property_get_reference_args". This allows obtaining
> > references
> >   with integer arguments using the fwnode interface.
> > 
> >   The functionality will be soon needed in adding support for nvmem
> >   framework on ACPI as well as in referring to e.g. lens and flash
> > devices
> >   on V4L2.
> 
> OK, so if people have no objections, I'll queue this up for 4.14.

I have no objections.

One comment Sakari already has addressed, another one
(list_first_enatry_or_null() use) might be addressed later.


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
