From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 0/4] device property: Add fwnode_name() helper
Date: Mon, 5 Nov 2018 16:38:18 +0200
Message-ID: <20181105143818.GL10650@smile.fi.intel.com>
References: <20181105091727.25544-1-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181105091727.25544-1-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Nov 05, 2018 at 12:17:23PM +0300, Heikki Krogerus wrote:
> Hi,
> 
> I prepared fwnode_name() for something I'm working on, but then I
> realized that it makes it possible to also implement a generic
> fwnode_get_named_child_node(). So in practice I'm proposing that we
> replace get_named_child_node fwnode op with that new "name" fwnode op
> in this series.
> 

All LGTM, though consider one minor comment in patch 1.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> thanks,
> 
> Heikki Krogerus (4):
>   device property: Introduce fwnode_name()
>   ACPI: property: Introduce acpi_fwnode_name()
>   of/property: Introduce of_fwnode_name()
>   device property: Drop get_named_child_node callback
> 
>  drivers/acpi/property.c  | 26 +++++++-------------------
>  drivers/base/property.c  | 28 +++++++++++++++++++++++++++-
>  drivers/of/property.c    | 21 ++++++---------------
>  include/linux/fwnode.h   |  4 +---
>  include/linux/property.h |  2 ++
>  5 files changed, 43 insertions(+), 38 deletions(-)
> 
> -- 
> 2.19.1
> 

-- 
With Best Regards,
Andy Shevchenko
