From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v2] platform/x86: wmi-bmof: New driver to expose embedded
 Binary WMI MOF metadata
Date: Tue, 6 Jun 2017 09:54:43 -0700
Message-ID: <20170606165443.GB32509@fury>
References: <cd020900567e5c26af29e0735a3945a855d26a30.1496718529.git.dvhart@infradead.org>
 <CAHp75VcEpnMzjomrnEQQEFp6zCJjcBugaRRHZO0GUc3FOyjF_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:51164 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbdFFQyr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Jun 2017 12:54:47 -0400
Content-Disposition: inline
In-Reply-To: <CAHp75VcEpnMzjomrnEQQEFp6zCJjcBugaRRHZO0GUc3FOyjF_Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Platform Driver <platform-driver-x86@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Lutomirski <luto@amacapital.net>, Mario Limonciello <mario_limonciello@dell.com>, Rafael Wysocki <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, Jun 06, 2017 at 12:30:38PM +0300, Andy Shevchenko wrote:
> On Tue, Jun 6, 2017 at 6:16 AM, Andy Lutomirski <luto@kernel.org> wrote:
> > Many laptops (and maybe servers?) have embedded WMI Binary MOF metadata.
> > We do not yet have open-source tools for processing the data, although
> > one is in the works thanks to Pali:
> >
> >         https://github.com/pali/bmfdec
> >
> > There is currently no interface to get the data in the first place. By
> > exposing it, we facilitate the development of new tools.
> 
> My comments below.
> Overall, FWIW,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> 
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/slab.h>
> > +#include <linux/types.h>
> > +#include <linux/input.h>
> > +#include <linux/input/sparse-keymap.h>
> > +#include <linux/acpi.h>
> > +#include <linux/string.h>
> > +#include <linux/dmi.h>
> > +#include <linux/wmi.h>
> > +#include <acpi/video.h>
> 
> Alphabetical order? Up to you.

OK, I failed to audit this... lots we don't need in here.

The minimum to build is:

#include <linux/wmi.h>

So assuming this was copy/pasted from another file.

Again, no guidance in coding-style.rst on includes. Seems to me we should
include what we specifically require, regardless of whether or not another
header also happens to include it. We need acpi for example, even though wmi
also includes it.

We should include modules, even though acpi includes it.

We use several other things we aren't including for, like

memcpy
dev_kzalloc
sysfs_create_bin_file

So I suggest:

#include <linux/acpi.h>
#include <linux/device.h>
#include <linux/fs.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/string.h>
#include <linux/sysfs.h>
#include <linux/types.h>
#include <linux/wmi.h>

Which removes:
#include <acpi/video.h>
#include <linux/dmi.h>
#include <linux/init.h>
#include <linux/input.h>
#include <linux/input/sparse-keymap.h>
#include <linux/slab.h>

And adds:
#include <linux/device.h>
#include <linux/fs.h>
#include <linux/sysfs.h>

-- 
Darren Hart
VMware Open Source Technology Center
