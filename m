From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v2] platform/x86: wmi-bmof: New driver to expose embedded
 Binary WMI MOF metadata
Date: Tue, 6 Jun 2017 09:34:42 -0700
Message-ID: <20170606163442.GA32509@fury>
References: <cd020900567e5c26af29e0735a3945a855d26a30.1496718529.git.dvhart@infradead.org>
 <CAHp75VcEpnMzjomrnEQQEFp6zCJjcBugaRRHZO0GUc3FOyjF_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:55437 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751536AbdFFQep (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Jun 2017 12:34:45 -0400
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
> > +config WMI_BMOF
> > +       tristate "WMI embedded Binary MOF driver"
> > +       depends on ACPI_WMI
> 
> > +       default y
> 
> Since it can be module it would be better to have more sane default
> (distros usually prefers modules over built-in).
> Thus, I would go, for example, with
> 
> default ACPI_WMI

Good point, done.

> 
> > +       ---help---
> > +         Say Y here if you want to be able to read a firmware-embedded
> > +         WMI Binary MOF data. Using this requires userspace tools and may be
> > +         rather tedious.
> > +
> > +         To compile this driver as a module, choose M here: the module will
> > +         be called wmi-bmof.
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

Hrm. There seems to be plenty of similar suggestions on the mailing lists, but
nothing documented in coding-style.rst. If this is a thing we are going to ask
of our contributors, it should be documented. I'm happy to reorder, would you
consider sending the coding-style patch?

> 
> > +#define WMI_BMOF_GUID "05901221-D566-11D1-B2F0-00A0C9062910"
> 
> > +MODULE_ALIAS("wmi:" WMI_BMOF_GUID);
> 
> I would gather all MODULE_* together, but it's also matter of taste.
> 

Sure, done.

> > +static ssize_t
> > +read_bmof(struct file *filp, struct kobject *kobj,
> > +        struct bin_attribute *attr,
> > +        char *buf, loff_t off, size_t count)
> > +{
> > +       struct bmof_priv *priv =
> > +               container_of(attr, struct bmof_priv, bmof_bin_attr);
> > +
> > +       if (off >= priv->bmofdata->buffer.length)
> > +               return 0;
> 
> Shouldn't we return an error code here? -ERANGE or alike?
> 

I took some time and compared this with:

read(2)
lseek(2)
fseek(3)
memory_read_from_buffer()

If offset is <0, we should return EINVAL
If offset is >end_of_buffer.... it's not so cut and dry. It is simpler to just
return 0, and as far as how it affects usage... returning 0 seems perfectly
acceptable for typical read loop usage.

As loff_t is a long long, it could conceivably be < 0, so I've added a check for
that and return -EINVAL in that case.

> > +static int wmi_bmof_probe(struct wmi_device *wdev)
> > +{
> 
> > +       int ret;
> > +
> > +       struct bmof_priv *priv =
> > +               devm_kzalloc(&wdev->dev, sizeof(struct bmof_priv), GFP_KERNEL);
> 
> I'm not a fan of memory allocation in definition block, so, I would rewrite this
> 
>       struct bmof_priv *priv;
>       int ret;
> 
>       priv = devm_kzalloc(&wdev->dev, sizeof(struct bmof_priv), GFP_KERNEL);
> 

Agreed, changed.

Thanks for the review Andy.

-- 
Darren Hart
VMware Open Source Technology Center
