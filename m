From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [intel/acpi] backlight
Date: Mon, 01 Dec 2008 09:08:35 +0800
Message-ID: <1228093715.4035.87.camel@yakui_zhao.sh.intel.com>
References: <1227854824.3477.9.camel@hidalgo>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:46045 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755728AbYLABBG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Nov 2008 20:01:06 -0500
In-Reply-To: <1227854824.3477.9.camel@hidalgo>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yves-Alexis Perez <corsac@debian.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, 2008-11-28 at 14:47 +0800, Yves-Alexis Perez wrote:
> Hi,
> 
> I'm running linux 2.6.28-rc6-00007-ged31348 on my Thinkpad T61, with
> Intel GM965. Under X, brightness keys work fine most of the time, but in
> some case it fails (for example after a dpms force off, but not always).
> Switching to console and back to X fix the problem for a time.
Will you please confirm whether the issue still exists if DPMS is not
used?
> 
> Another weird stuff is that, in single user, I have no way to control
> the backlight. Using brightness key doesn't work,
> and /sys/class/backlight/acpi_video0 doesn't do anything.
Can you confirm whether the i915 driver is loaded in single user mode?
If not, please load it and see whether the interface
of /sys/class/backlight/* can work.
> 
> I know there was a lot of enhancements with OpRegion stuff for 2.6.27
> and 2.6.28, and it's maybe not finished, but are those problems known?
> 
> Cheers, and many thanks for the good work :)

