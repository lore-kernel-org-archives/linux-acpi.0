From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] acpi/video: Load the module even if ACPI is disabled
Date: Wed, 04 Mar 2015 15:39:27 +0100
Message-ID: <4640975.h9PWU3GnN9@vostro.rjw.lan>
References: <1425206498-1615-1-git-send-email-chris@chris-wilson.co.uk> <20150304015443.GA6943@aaronlu.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150304015443.GA6943@aaronlu.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>, intel-gfx@lists.freedesktop.org, Daniel Vetter <daniel.vetter@ffwll.ch>, Jani Nikula <jani.nikula@intel.com>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday, March 04, 2015 09:55:55 AM Aaron Lu wrote:
> On Sun, Mar 01, 2015 at 10:41:37AM +0000, Chris Wilson wrote:
> > i915.ko depends upon the acpi/video.ko module and so refuses to load if
> > ACPI is disabled at runtime if for example the BIOS is broken beyond
> > repair. acpi/video provides an optional service for i915.ko and so we
> > should just allow the modules to load, but do no nothing in order to let
> > the machines boot correctly.
> > 
> > Reported-by: Bill Augur <bill-auger@programmer.net>
> > Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: Jani Nikula <jani.nikula@intel.com>
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: linux-acpi@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: stable@vger.kernel.org
> 
> For both patches:
> Acked-by: Aaron Lu <aaron.lu@intel.com>

Both applied, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
