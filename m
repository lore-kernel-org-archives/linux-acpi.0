From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 0/4]Bind physical devices with ACPI devices - take 2
Date: Thu, 6 Jan 2005 10:57:31 +0100
Message-ID: <20050106095731.GE24380@elf.ucw.cz>
References: <1104893444.5550.127.camel@sli10-desk.sh.intel.com> <1104984055.18173.239.camel@d845pe> <1104997834.22886.17.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262800AbVAFJ5q@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1104997834.22886.17.camel@sli10-desk.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Li Shaohua <shaohua.li@intel.com>
Cc: Len Brown <len.brown@intel.com>, ACPI Developers <acpi-devel@lists.sourceforge.net>, lkml <linux-kernel@vger.kernel.org>, Greg <greg@kroah.com>, Patrick Mochel <mochel@digitalimplant.org>, Adam Belay <ambx1@neo.rr.com>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > It looks like some device drivers scribble on dev->platform_data;
> > and we need to fix those drivers before deploying this patch.
> > Alternatively, we could add a new field to struct device,
> > but then we'd probably never get rid of it...
> Yep, this is a big problem. According to the comments in the source
> file, it's designed for firmware such as ACPI, but some drivers misused
> it. A search shows there are many such drivers. Fixing the drivers is a
> pain for me.

It is easy: remove the field for release or two, then readd it with
your patch.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
