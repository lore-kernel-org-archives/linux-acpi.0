From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 1/3] of: Move OF property and graph API from base.c to property.c
Date: Mon, 22 May 2017 09:22:29 -0500
Message-ID: <CAL_JsqLwdi-oFxxF9rh4KzKim_ouQ8eDwZ5uicwtjb5-9eWHBw@mail.gmail.com>
References: <1495440698-22260-1-git-send-email-sakari.ailus@linux.intel.com> <1495440698-22260-2-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934401AbdEVOWw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 May 2017 10:22:52 -0400
In-Reply-To: <1495440698-22260-2-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Frank Rowand <frowand.list@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Al Stone <ahs3@redhat.com>

On Mon, May 22, 2017 at 3:11 AM, Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
> base.c contains both core OF functions and increasingly other
> functionality such as accessing properties and graphs, including
> convenience functions. In the near future this would also include OF
> specific implementation of the fwnode property and graph APIs.
>
> Create driver/of/property.c to contain procedures for accessing and
> interpreting device tree properties. The procedures are moved from
> drivers/of/base.c, with no changes other than copying only the includes
> required by the moved procedures.
>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/of/Makefile   |   2 +-
>  drivers/of/base.c     | 733 ------------------------------------------------
>  drivers/of/property.c | 763 ++++++++++++++++++++++++++++++++++++++++++++++++++

Please put graph functions in graph.c unless there is some reason not to.

[...]

> diff --git a/drivers/of/property.c b/drivers/of/property.c
> new file mode 100644
> index 0000000..e5d3e1f
> --- /dev/null
> +++ b/drivers/of/property.c
> @@ -0,0 +1,763 @@
> +/*
> + * drivers/of/property.c - Procedures for accessing and interpreting
> + *                        Devicetree properties and graphs.
> + *
> + * Initially created by copying procedures from drivers/of/base.c. This
> + * file contains the OF property as well as the OF graph interface
> + * functions.
> + *
> + * Paul Mackerras      August 1996.
> + * Copyright (C) 1996-2005 Paul Mackerras.
> + *
> + *  Adapted for 64bit PowerPC by Dave Engebretsen and Peter Bergner.
> + *    {engebret|bergner}@us.ibm.com
> + *
> + *  Adapted for sparc and sparc64 by David S. Miller davem@davemloft.net
> + *
> + *  Reconsolidated from arch/x/kernel/prom.c by Stephen Rothwell and
> + *  Grant Likely.
> + *
> + *      This program is free software; you can redistribute it and/or
> + *      modify it under the terms of the GNU General Public License
> + *      as published by the Free Software Foundation; either version
> + *      2 of the License, or (at your option) any later version.
> + */
> +

Need a pr_fmt here.

> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_graph.h>
> +#include <linux/string.h>
> +
> +#include "of_private.h"

A blank line needed here.

> +/**
> + * of_property_count_elems_of_size - Count the number of elements in a property
> + *
> + * @np:                device node from which the property value is to be read.
> + * @propname:  name of the property to be searched.
> + * @elem_size: size of the individual element
> + *
> + * Search for a property in a device node and count the number of elements of
> + * size elem_size in it. Returns number of elements on sucess, -EINVAL if the
> + * property does not exist or its length does not match a multiple of elem_size
> + * and -ENODATA if the property does not have a value.
> + */
