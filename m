From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [PATCH v3 2/3] hmat: add heterogeneous memory sysfs support
Date: Fri, 15 Dec 2017 13:53:36 -0700
Message-ID: <20171215205336.GB5454@linux.intel.com>
References: <20171214021019.13579-1-ross.zwisler@linux.intel.com>
 <20171214021019.13579-3-ross.zwisler@linux.intel.com>
 <CAJZ5v0h8=mh9BKa2eZzqbc12T6saB+q19yqSfRLYKOiUjS2Cjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:34677 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755650AbdLOUxj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Dec 2017 15:53:39 -0500
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h8=mh9BKa2eZzqbc12T6saB+q19yqSfRLYKOiUjS2Cjg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Anaczkowski, Lukasz" <lukasz.anaczkowski@intel.com>, "Box, David E" <david.e.box@intel.com>, "Kogut, Jaroslaw" <Jaroslaw.Kogut@intel.com>, "Koss, Marcin" <marcin.koss@intel.com>, "Koziej, Artur" <artur.koziej@intel.com>, "Lahtinen, Joonas" <joonas.lahtinen@intel.com>, "Moore, Robert" <robert.moore@intel.com>, "Nachimuthu, Murugasamy" <murugasamy.nachimuthu@intel.com>, "Odzioba, Lukasz" <lukasz.odzioba@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Schmauss, Erik" <erik.schmauss@intel.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>, "Zheng, Lv" <lv.zheng@intel.com>, Andrew Morton <akpm@linux-founda>

On Fri, Dec 15, 2017 at 01:52:03AM +0100, Rafael J. Wysocki wrote:
<>
> > diff --git a/drivers/acpi/hmat/core.c b/drivers/acpi/hmat/core.c
> > new file mode 100644
> > index 000000000000..61b90dadf84b
> > --- /dev/null
> > +++ b/drivers/acpi/hmat/core.c
> > @@ -0,0 +1,536 @@
> > +/*
> > + * Heterogeneous Memory Attributes Table (HMAT) representation in sysfs
> > + *
> > + * Copyright (c) 2017, Intel Corporation.
> > + *
> > + * This program is free software; you can redistribute it and/or modify it
> > + * under the terms and conditions of the GNU General Public License,
> > + * version 2, as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope it will be useful, but WITHOUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> > + * more details.
> > + */
> 
> Minor nit for starters: you should use SPDX license indentifiers in
> new files and if you do so, the license boilerplace is not necessary
> any more.

Okay, I'll fix that up.
