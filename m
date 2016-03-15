From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH] device property: don't bother the drivers with struct
 property_set
Date: Tue, 15 Mar 2016 11:04:19 +0200
Message-ID: <20160315090419.GA21114@kuha.fi.intel.com>
References: <1456485600-129229-1-git-send-email-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:64932 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964881AbcCOJEe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Mar 2016 05:04:34 -0400
Content-Disposition: inline
In-Reply-To: <1456485600-129229-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lee Jones <lee.jones@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thierry Reding <treding@nvidia.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Fri, Feb 26, 2016 at 01:20:00PM +0200, Heikki Krogerus wrote:
> Since device_add_property_set() now always takes a copy of
> the property_set, and also since the fwnode type is always
> hard coded to be FWNODE_PDATA, there is no need for the
> drivers to deliver the entire struct property_set. The
> function can just create the instance of it on its own and
> bind the properties from the drivers to it on the spot.
> 
> This renames device_add_property_set() to
> device_add_properties(). The function now takes struct
> property_entry as its parameter instead of struct
> property_set.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  arch/arm/mach-tegra/board-paz00.c |  6 +-----
>  drivers/base/platform.c           | 19 ++++++++++---------
>  drivers/base/property.c           | 35 ++++++++++++++++++++++-------------
>  drivers/mfd/intel-lpss-acpi.c     |  6 +-----
>  drivers/mfd/intel-lpss-pci.c      | 14 +++-----------
>  drivers/mfd/intel-lpss.c          |  2 +-
>  drivers/mfd/intel-lpss.h          |  2 +-
>  drivers/mfd/mfd-core.c            |  4 ++--
>  include/linux/mfd/core.h          |  2 +-
>  include/linux/platform_device.h   |  4 ++--
>  include/linux/property.h          | 15 +++------------
>  11 files changed, 47 insertions(+), 62 deletions(-)

There are now more users for the build-in properties so I'm going to
have to resend this.


Cheers,

-- 
heikki
