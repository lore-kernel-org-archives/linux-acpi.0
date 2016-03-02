From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] device property: don't bother the drivers with struct
 property_set
Date: Wed, 2 Mar 2016 13:03:16 +0000
Message-ID: <20160302130316.GA3444@x1>
References: <1456485600-129229-1-git-send-email-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:32935 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755053AbcCBNDV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Mar 2016 08:03:21 -0500
Received: by mail-wm0-f44.google.com with SMTP id l68so79165592wml.0
        for <linux-acpi@vger.kernel.org>; Wed, 02 Mar 2016 05:03:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1456485600-129229-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thierry Reding <treding@nvidia.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Fri, 26 Feb 2016, Heikki Krogerus wrote:

> Since device_add_property_set() now always takes a copy of
> the property_set, and also since the fwnode type is always
> hard coded to be FWNODE_PDATA, there is no need for the
> drivers to deliver the entire struct property_set. The
> function can just create the instance of it on its own and
> bind the properties from the drivers to it on the spot.
>=20
> This renames device_add_property_set() to
> device_add_properties(). The function now takes struct
> property_entry as its parameter instead of struct
> property_set.
>=20
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  arch/arm/mach-tegra/board-paz00.c |  6 +-----
>  drivers/base/platform.c           | 19 ++++++++++---------
>  drivers/base/property.c           | 35 ++++++++++++++++++++++-------=
------
>  drivers/mfd/intel-lpss-acpi.c     |  6 +-----
>  drivers/mfd/intel-lpss-pci.c      | 14 +++-----------
>  drivers/mfd/intel-lpss.c          |  2 +-
>  drivers/mfd/intel-lpss.h          |  2 +-
>  drivers/mfd/mfd-core.c            |  4 ++--

Acked-by: Lee Jones <lee.jones@linaro.org>

>  include/linux/mfd/core.h          |  2 +-
>  include/linux/platform_device.h   |  4 ++--
>  include/linux/property.h          | 15 +++------------
>  11 files changed, 47 insertions(+), 62 deletions(-)
>=20
> Hi Rafael,
>=20
> This depends on Johannes' wireless next tree:
> git://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
