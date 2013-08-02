From: Borislav Petkov <bp@alien8.de>
Subject: Re: i915 backlight
Date: Fri, 2 Aug 2013 10:16:29 +0200
Message-ID: <20130802081628.GA11566@pd.tnic>
References: <20130731162252.GC4724@pd.tnic>
 <20130731163623.GD4724@pd.tnic>
 <1419236.138PcnXVBh@vostro.rjw.lan>
 <20130801080724.GA3448@nazgul.tnic>
 <51FB4B0A.7060706@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:57513 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754469Ab3HBIQb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 2 Aug 2013 04:16:31 -0400
Content-Disposition: inline
In-Reply-To: <51FB4B0A.7060706@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, lkml <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Fri, Aug 02, 2013 at 02:00:42PM +0800, Aaron Lu wrote:
> Assume you have specified to use intel_backlight in xorg.conf

Right, I have:

Section "Device"
        Option "Backlight"      "intel_backlight"
        Identifier  "Card0"
        Driver      "intel"
        BusID       "PCI:0:2:0"
EndSection

in there currently.

> does booting with video.brightness_switch_enabled=0 help?

Nope.

Kernel command line is like this:

[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-3.11.0-rc3+ root=/dev/sdb2 ro root=/dev/sdb2 ignore_loglevel log_buf_len=10M resume=/dev/sdb1 acpi_backlight=vendor video.brightness_switch_enabled=0 i915.i915_enable_rc6=4 i915.i915_enable_fbc=1 i915.lvds_downclock=1 i915.powersave=1

and acpi_backlight=vendor doesn't make any difference. It still works
over sysfs though.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
