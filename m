From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 1/4] ACPI: fix ACPI_VIDEO dependencies
Date: Wed, 19 Mar 2014 14:35:30 +0100
Message-ID: <20140319143530.06af48e5@endymion.delvare>
References: <20140317154644.15065deb@endymion.delvare>
	<3419553.dABDqM4501@vostro.rjw.lan>
	<20140319075145.2954e06f@endymion.delvare>
	<24496062.xxuyBC0FZJ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <24496062.xxuyBC0FZJ@vostro.rjw.lan>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Jani Nikula <jani.nikula@linux.intel.com>, "Lee, Chun-Yi" <jlee@suse.com>, Len Brown <lenb@kernel.org>, Matthew Garrett <matthew.garrett@nebula.com>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, 19 Mar 2014 14:10:53 +0100, Rafael J. Wysocki wrote:
> On Wednesday, March 19, 2014 07:51:45 AM Jean Delvare wrote:
> > Hi Rafael,
> > 
> > On Wed, 19 Mar 2014 02:26:52 +0100, Rafael J. Wysocki wrote:
> > > On Monday, March 17, 2014 03:46:44 PM Jean Delvare wrote:
> > > > From: Jean Delvare <jdelvare@suse.de>
> > > > Subject: ACPI: fix ACPI_VIDEO dependencies
> > > > 
> > > > ACPI_VIDEO stopped depending on VIDEO_OUTPUT_CONTROL over 3 years ago
> > > > (see commit 677bd810, "ACPI video: remove output switching control".)
> > > > So it's about time to remove the Kconfig dependency between these two
> > > > options.
> > > > 
> > > > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > > > Cc: Zhang Rui <rui.zhang@intel.com>
> > > > Cc: Len Brown <lenb@kernel.org>
> > > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > 
> > > Do you want me to take this series?
> > 
> > If other maintainers are OK with it, yes, I think that would be the
> > easiest way. Thanks for proposing. All these patches depend on each
> > other and must be applied in the right order, so pushing them through
> > different trees would be slow at best, and risky.
> 
> OK, I'll queue them up for 3.15 then, as I haven't seen any objections.

Thank you :-)

> > Also, thinking about it, I wonder if the first 3 patches of the series
> > could go to longterm kernel series? While they do not fix any build
> > breakage nor run-time bug, without them everyone (on x86 at least) is
> > forced to build dead code. This is kind of frustrating. They are simple
> > and obvious enough that hopefully there won't be any objection.
> 
> I think it'll be best if you request the -stable people to pick
> up those commits once they have reached the Linus' tree.

Sure, I can do that.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
