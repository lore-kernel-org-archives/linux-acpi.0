From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH v2 4/6] ACPI / osi: Fix default _OSI(Darwin) support
Date: Tue, 3 May 2016 01:56:09 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BB929B1@SHSMSX101.ccr.corp.intel.com>
References: <cover.1461656216.git.lv.zheng@intel.com>
 <e8ea6e8841adce9e10e5bd0b278b47a7c799c276.1461736123.git.lv.zheng@intel.com>
 <36DF59CE26D8EE47B0655C516E9CE64028748233@shsmsx102.ccr.corp.intel.com>
 <2223787.tzTyTqLAjo@vostro.rjw.lan>
 <1AE640813FDE7649BE1B193DEA596E883BB82C18@SHSMSX101.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E883BB82EF4@SHSMSX101.ccr.corp.intel.com>
 <20160429130123.GA18473@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160429130123.GA18473@wunner.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>, "Brown, Len" <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Chen, Yu C" <yu.c.chen@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi, Lukas

First, thanks for the test. :)

> From: Lukas Wunner [mailto:lukas@wunner.de]
> Subject: Re: [PATCH v2 4/6] ACPI / osi: Fix default _OSI(Darwin) support
> 
> Hi Lv Zheng,
> 
> On Fri, Apr 29, 2016 at 02:07:53AM +0000, Zheng, Lv wrote:
> > I just sent UPDATE of PATCH 4/6 and PATCH 6/6 to the mailing list with this
> > corrected.
> > I was hoping they could update patchwork content so that the Bugzilla
> > reporters might use the updated patches for confirmation.
> > The Message-Id(s) of the 2 patches were kept as same as the old ones.
> 
> As promised on Bugzilla I've tested v2 of this series (with the "INC"
> manually fixed up) on a MacBookPro9,1.
> 
> I only reviewed the patches in a superficial fashion, but one issue I've
> noticed is that
> 
> #define pr_fmt(fmt) "ACPI: " fmt
> 
> is missing in osi.c (patch [6/6]).
[Lv Zheng] 

This is a bug of internal.h.
I've been suffering from this in several my patches.
And people working for ACPI subsystem have been suffering from this for decades...
Sometimes we have to use printk(KERN_xxx PREFIX) here while checkpatch.pl complains coding style issues.
You comment makes it a good chance to escalate this issue to the maintainers.

This is a bug of internal.h because:
1. checkpatch.pl enforces pr_xxx() instead of printk(KERN_xxx...)
2. pr_xxx() macro is meant to eliminate KERN_xxx prefixes.
3. kernel provides pr_fmt(fmt) to allow drivers to add their own prefixes when pr_xxx() macros are used.
4. internal.h defines PREFIX for all ACPI drivers but doesn't provide the mean for the drivers to hide this prefix in pr_xxx() macros.
So this becomes a trap where developers can easily make mistakes.

Concluded from the point 1, 2, 3, the following code is wrong:
In drivers/acpi/osl.c:
		printk(KERN_ERR PREFIX "Cannot map memory that high\n");
printk(KERN_ERR PREFIX should be replaced by pr_fmt(

Concluded from the point 2, 3, the following code is wrong:
In drivers/acpi/osl.c:
	pr_info("ACPI: static SSDT installation disabled\n");
		pr_debug(PREFIX "%s: map reset_reg status %d\n", __func__, rv);
The PREFIX should be handled by pr_fmt().

Concluded from the point 3, 4, the following code is wrong:
In drivers/acpi/tables.c:
#define pr_fmt(fmt) "ACPI: " fmt
This should be handled by internal.h by default.

So in fact, my patch is written correctly on top of the assumption that the PREFIX have already been handled by internal.h not osi.c...

IMO, there are several ways to fix this long term issue:
1. Fix it with post-override:
This might be done in internal.h
We may
#ifndef PREFIX
#define PREFIX	"ACPI: "
#endif
#undef pr_fmt
#define pr_fmt(fmt)	PREFIX fmt
This enforces ec.c to be changed to define PREFIX instead of pr_fmt() which is not developers friendly as developers are trained to use pre-override for pr_fmt().

2. Fix it using pre-override:
The above fix looks a little bit confusing because the pr_fmt() is meant to be defined before including <linux/printk.h>
In internal.h:
#ifndef pr_fmt
#define pr_fmt(fmt) "ACPI: " fmt
#endif

#include <linux/xxxx.h>
...

In drivers/acpi/xxx.c, making internal.h the first one included by these files, so that they can override pr_fmt.
For example, in ec.c:

#define pr_fmt(fmt) "ACPI: EC: " fmt
#include "internal.h"
#include <linux/xxx.h>

It's hard for me to make a decision.
So I probably still have to work with this code quality issue and refresh this patchset.
Possibly I will still make same mistakes in the future.
Anyway, this is a chance for me to add your "Reported-and-tested-by:". :-)

> 
> Without command line arguments, Linux responds yay to _OSI("Darwin")
> and nothing else and the Thunderbolt controller is powered up.
> 
> With "acpi_osi=!Darwin", Linux responds nay to everything and the
> Thunderbolt controller is powered down.
> 
> So it seems to work as intended. If you want me to test anything else
> please let me know.
[Lv Zheng] 
Sounds good.
Thanks for the test.

Thanks and best regards
-Lv
