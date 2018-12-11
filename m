From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v6 0/3] device property: Add fwnode_get_name() helper
Date: Tue, 11 Dec 2018 15:59:25 +0200
Message-ID: <20181211135925.GD10650@smile.fi.intel.com>
References: <20181211131451.52832-1-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181211131451.52832-1-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Rob Herring <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Dec 11, 2018 at 04:14:48PM +0300, Heikki Krogerus wrote:
> Hi,
> 
> Andy, I dropped you Reviewed-by tag because of the last change to this
> series, so if you could check these again I would much appreciate.

They all looks fine,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Changes since v5:
> - No longer reading "name" device property as fallback.
> 
> Changes since v4:
> - No changes. There was an extra patch in v3. This was just a resend
>   of v3 without that extra patch.
> 
> Changes since v3:
> - I'm now returning -EOVERFLOW if the buffer is not big enough as
>   proposed by Andy.
> 
> This is the cover letter from v3:
> 
> This is the third version of my proposal for this helper. The
> second version can be checked here:
> https://lkml.org/lkml/2018/11/8/1005
> 
> I'm now passing the length as proposed by both Rob and Andy. I'm also
> leaving the .get_named_child_node fwnode op untouched.
> 
> --
> heikki
> 
> 
> Heikki Krogerus (3):
>   device property: Introduce fwnode_get_name()
>   ACPI: property: Add acpi_fwnode_name()
>   of/property: Add of_fwnode_name()
> 
>  drivers/acpi/property.c  | 28 ++++++++++++++++++++++++++++
>  drivers/base/property.c  | 17 +++++++++++++++++
>  drivers/of/property.c    | 13 +++++++++++++
>  include/linux/fwnode.h   |  3 +++
>  include/linux/property.h |  2 ++
>  5 files changed, 63 insertions(+)
> 
> -- 
> 2.19.2
> 

-- 
With Best Regards,
Andy Shevchenko
