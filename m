From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] Revert "ACPI / video: Add HP EliteBook Revolve 810 to the blacklist"
Date: Fri, 14 Feb 2014 23:21:53 +0100
Message-ID: <5716481.SxKZLEy9L1@vostro.rjw.lan>
References: <1392381247-28109-1-git-send-email-mika.westerberg@linux.intel.com> <s5hy51dzr9f.wl%tiwai@suse.de> <20140214152601.GL5018@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58598 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752871AbaBNWHL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Feb 2014 17:07:11 -0500
In-Reply-To: <20140214152601.GL5018@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Aaron Lu <aaron.lu@intel.com>, linux-kernel@vger.kernel.org

On Friday, February 14, 2014 05:26:01 PM Mika Westerberg wrote:
> On Fri, Feb 14, 2014 at 03:46:20PM +0100, Takashi Iwai wrote:
> > The acpi_osi blacklist is just a workaround, and if we have better
> > solutions, it should be removed.  That's why I'm asking it.
> > 
> > So, after removing acpi_osi blacklist, and keeping your video
> > blacklist patch, the backlight works?
> 
> Yes, the backlight works (there is only intel_backlight listed under
> /sys/class/backlight).
> 
> > If yes, as mentioned, we should think of rather extending this video
> > blacklist to more EliteBook G1 and ProBook G1 machines, and remove
> > acpi_osi blacklist instead.
> 
> Makes sense to me. (Well, I'm fine as long as backlight on my machine works
> ;-))
> 
> Aaron, Rafael, any comments on this?

I generally agree with Takashi, but I'm not sure what to do for 3.14.

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
