From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [Linux-nvdimm] [PATCH v2 02/20] libnd, nd_acpi: initial libnd
 infrastructure and NFIT support
Date: Fri, 15 May 2015 13:41:43 -0700
Message-ID: <CAPcyv4ggH8j3wPiq513POy_CSRz0ekya0e2NSdNK88aY=FvH-A@mail.gmail.com>
References: <20150428181203.35812.60474.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20150428182423.35812.20930.stgit@dwillia2-desk3.amr.corp.intel.com>
	<x49twvdwrq5.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:34674 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934085AbbEOUlp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 May 2015 16:41:45 -0400
Received: by wicmc15 with SMTP id mc15so47086741wic.1
        for <linux-acpi@vger.kernel.org>; Fri, 15 May 2015 13:41:44 -0700 (PDT)
In-Reply-To: <x49twvdwrq5.fsf@segfault.boston.devel.redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: linux-nvdimm <linux-nvdimm@ml01.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, May 15, 2015 at 12:44 PM, Jeff Moyer <jmoyer@redhat.com> wrote:
> Dan Williams <dan.j.williams@intel.com> writes:
>
> Looks like the Kconfig stuff has been worked out between you and Rafael,
> so I won't comment on that.
>
>> diff --git a/drivers/block/nd/acpi.c b/drivers/block/nd/acpi.c
>> new file mode 100644
>> index 000000000000..9f0b24390d1b
>> --- /dev/null
>> +++ b/drivers/block/nd/acpi.c
>> @@ -0,0 +1,475 @@
>> +/*
>> + * Copyright(c) 2013-2015 Intel Corporation. All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of version 2 of the GNU General Public License as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * General Public License for more details.
>> + */
>> +#include <linux/list_sort.h>
>> +#include <linux/module.h>
>> +#include <linux/list.h>
>> +#include <linux/acpi.h>
>> +#include "acpi_nfit.h"
>> +#include "libnd.h"
>> +
>> +static bool warn_checksum;
>> +module_param(warn_checksum, bool, S_IRUGO|S_IWUSR);
>> +MODULE_PARM_DESC(warn_checksum, "Turn checksum errors into warnings");
>
> Is this just a debugging option?

Yes, but I've deleted it in the next rev of the code since the ACPI
core will have already done the checksum.  The driver need not
implement it's own checksum.

>> +
>> +enum {
>> +     NFIT_ACPI_NOTIFY_TABLE = 0x80,
>> +};
>
> This is unused by this patch.

Yes.  I went ahead and deleted all the ACPI notification
infrastructure until we're ready to implement hot-add.

> The rest looks ok to me.

Thanks Jeff.
