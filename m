From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] platform/x86: wmi-bmof: New driver to expose embedded
 Binary WMI MOF metadata
Date: Tue, 6 Jun 2017 21:45:57 +0300
Message-ID: <CAHp75VeX0fTBcRA=GKyXVDqbi+WTSNOGBxfq0ZgB22c3+OXNTw@mail.gmail.com>
References: <cd020900567e5c26af29e0735a3945a855d26a30.1496718529.git.dvhart@infradead.org>
 <CAHp75VcEpnMzjomrnEQQEFp6zCJjcBugaRRHZO0GUc3FOyjF_Q@mail.gmail.com> <20170606165443.GB32509@fury>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170606165443.GB32509@fury>
Sender: linux-kernel-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Platform Driver <platform-driver-x86@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Lutomirski <luto@amacapital.net>, Mario Limonciello <mario_limonciello@dell.com>, Rafael Wysocki <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Jun 6, 2017 at 7:54 PM, Darren Hart <dvhart@infradead.org> wrote:
> On Tue, Jun 06, 2017 at 12:30:38PM +0300, Andy Shevchenko wrote:
>> On Tue, Jun 6, 2017 at 6:16 AM, Andy Lutomirski <luto@kernel.org> wrote:

>> > +#include <linux/kernel.h>
>> > +#include <linux/module.h>
>> > +#include <linux/init.h>
>> > +#include <linux/slab.h>
>> > +#include <linux/types.h>
>> > +#include <linux/input.h>
>> > +#include <linux/input/sparse-keymap.h>
>> > +#include <linux/acpi.h>
>> > +#include <linux/string.h>
>> > +#include <linux/dmi.h>
>> > +#include <linux/wmi.h>
>> > +#include <acpi/video.h>
>>
>> Alphabetical order? Up to you.
>
> OK, I failed to audit this... lots we don't need in here.
>
> The minimum to build is:
>
> #include <linux/wmi.h>
>
> So assuming this was copy/pasted from another file.

> Again, no guidance in coding-style.rst on includes. Seems to me we should
> include what we specifically require, regardless of whether or not another
> header also happens to include it.

Usually it's a sane choice.
Regarding to order the rationale I see there is easiest way to detect
(on the glance) what headers are already there and there is no
duplication. I saw in the past few patches to remove header
duplication since the original list wasn't in order in the first
place.

Of course there might be exceptions.

> We need acpi for example, even though wmi
> also includes it.
>
> We should include modules, even though acpi includes it.
>
> We use several other things we aren't including for, like
>
> memcpy
> dev_kzalloc
> sysfs_create_bin_file
>
> So I suggest:
>
> #include <linux/acpi.h>
> #include <linux/device.h>
> #include <linux/fs.h>
> #include <linux/kernel.h>
> #include <linux/module.h>
> #include <linux/string.h>
> #include <linux/sysfs.h>
> #include <linux/types.h>
> #include <linux/wmi.h>
>
> Which removes:
> #include <acpi/video.h>
> #include <linux/dmi.h>
> #include <linux/init.h>
> #include <linux/input.h>
> #include <linux/input/sparse-keymap.h>
> #include <linux/slab.h>
>
> And adds:
> #include <linux/device.h>
> #include <linux/fs.h>
> #include <linux/sysfs.h>

Works for me!

-- 
With Best Regards,
Andy Shevchenko
