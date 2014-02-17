From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] Revert "ACPI / video: Add HP EliteBook Revolve 810 to
 the blacklist"
Date: Mon, 17 Feb 2014 11:57:17 +0200
Message-ID: <20140217095717.GN5018@intel.com>
References: <1392381247-28109-1-git-send-email-mika.westerberg@linux.intel.com>
 <s5hy51dzr9f.wl%tiwai@suse.de>
 <20140214152601.GL5018@intel.com>
 <5716481.SxKZLEy9L1@vostro.rjw.lan>
 <5301A3AE.9030703@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:42862 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751330AbaBQJto (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Feb 2014 04:49:44 -0500
Content-Disposition: inline
In-Reply-To: <5301A3AE.9030703@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Takashi Iwai <tiwai@suse.de>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org

On Mon, Feb 17, 2014 at 01:52:46PM +0800, Aaron Lu wrote:
> On 02/15/2014 06:21 AM, Rafael J. Wysocki wrote:
> > On Friday, February 14, 2014 05:26:01 PM Mika Westerberg wrote:
> >> On Fri, Feb 14, 2014 at 03:46:20PM +0100, Takashi Iwai wrote:
> >>> The acpi_osi blacklist is just a workaround, and if we have better
> >>> solutions, it should be removed.  That's why I'm asking it.
> >>>
> >>> So, after removing acpi_osi blacklist, and keeping your video
> >>> blacklist patch, the backlight works?
> >>
> >> Yes, the backlight works (there is only intel_backlight listed under
> >> /sys/class/backlight).
> >>
> >>> If yes, as mentioned, we should think of rather extending this video
> >>> blacklist to more EliteBook G1 and ProBook G1 machines, and remove
> >>> acpi_osi blacklist instead.
> >>
> >> Makes sense to me. (Well, I'm fine as long as backlight on my machine works
> >> ;-))
> >>
> >> Aaron, Rafael, any comments on this?
> > 
> > I generally agree with Takashi, but I'm not sure what to do for 3.14.
> 
> I can re-base the previously sent patch titled:
> [PATCH] ACPI / video: Add systems that should favor native backlight interface
> And put Mika's system into the DMI table that will use native backlight
> interface in video module and remove it from video_detect's DMI table at
> the same time. Does this sound OK?

You also need to remove it from the acpi_osi blacklist.

Anyway, that sounds good to me. Not sure if that's suitable for 3.14,
though.
