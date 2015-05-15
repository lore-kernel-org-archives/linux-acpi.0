From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [Linux-nvdimm] [PATCH v2 02/20] libnd, nd_acpi: initial libnd infrastructure and NFIT support
Date: Fri, 15 May 2015 15:44:34 -0400
Message-ID: <x49twvdwrq5.fsf@segfault.boston.devel.redhat.com>
References: <20150428181203.35812.60474.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20150428182423.35812.20930.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53388 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933604AbbEOTom (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 May 2015 15:44:42 -0400
In-Reply-To: <20150428182423.35812.20930.stgit@dwillia2-desk3.amr.corp.intel.com>
	(Dan Williams's message of "Tue, 28 Apr 2015 14:24:23 -0400")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@ml01.01.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, linux-kernel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

Looks like the Kconfig stuff has been worked out between you and Rafael,
so I won't comment on that.

> diff --git a/drivers/block/nd/acpi.c b/drivers/block/nd/acpi.c
> new file mode 100644
> index 000000000000..9f0b24390d1b
> --- /dev/null
> +++ b/drivers/block/nd/acpi.c
> @@ -0,0 +1,475 @@
> +/*
> + * Copyright(c) 2013-2015 Intel Corporation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + */
> +#include <linux/list_sort.h>
> +#include <linux/module.h>
> +#include <linux/list.h>
> +#include <linux/acpi.h>
> +#include "acpi_nfit.h"
> +#include "libnd.h"
> +
> +static bool warn_checksum;
> +module_param(warn_checksum, bool, S_IRUGO|S_IWUSR);
> +MODULE_PARM_DESC(warn_checksum, "Turn checksum errors into warnings");

Is this just a debugging option?

> +
> +enum {
> +	NFIT_ACPI_NOTIFY_TABLE = 0x80,
> +};

This is unused by this patch.

The rest looks ok to me.

-Jeff
