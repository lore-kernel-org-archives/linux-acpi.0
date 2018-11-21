From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v2 0/4] device property: Add fwnode_get_name() helper
Date: Wed, 21 Nov 2018 14:36:37 +0200
Message-ID: <20181121123637.GB26377@kuha.fi.intel.com>
References: <20181108165156.60073-1-heikki.krogerus@linux.intel.com>
 <4687553.lNXoFSueqb@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4687553.lNXoFSueqb@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 20, 2018 at 11:03:45PM +0100, Rafael J. Wysocki wrote:
> On Thursday, November 8, 2018 5:51:52 PM CET Heikki Krogerus wrote:
> > Hi,
> > 
> > This is the second version of my proposal for this helper. The
> > first version can be checked here:
> > https://lkml.org/lkml/2018/11/5/326
> > 
> > In order to support also ACPI properly, I decided to change the API.
> > The function fwnode_name() is now fwnode_get_name(), and instead of
> > returning pointer to the name, the function copies it to a buffer. I
> > did that because acpica does not offer a way to get a pointer to the
> > node name, and the name is clearly expected to be accessed only with
> > the namespace lock held.
> > 
> > I think this is better approach in any case. It will also solve the
> > problem of getting rid of the unit-address part from DT node names.
> > 
> > Let me know what you guys think.
> > 
> > --
> > heikki
> > 
> > 
> > Heikki Krogerus (4):
> >   device property: Introduce fwnode_get_name()
> >   ACPI: property: Add acpi_fwnode_name()
> >   of/property: Add of_fwnode_name()
> >   device property: Drop get_named_child_node callback
> > 
> >  drivers/acpi/property.c  | 43 ++++++++++++++++++++++------------------
> >  drivers/base/property.c  | 34 ++++++++++++++++++++++++++++++-
> >  drivers/of/property.c    | 26 ++++++++++--------------
> >  include/linux/fwnode.h   |  6 +++---
> >  include/linux/property.h |  2 ++
> >  5 files changed, 73 insertions(+), 38 deletions(-)
> > 
> > 
> 
> I will be expecting at least one more iteration of this series to address the
> Rob's comments.

Yes, I'll send a new version soon.

thanks,

-- 
heikki
