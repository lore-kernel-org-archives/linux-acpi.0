From: Yves-Alexis Perez <corsac@corsac.net>
Subject: Re: [intel/acpi] backlight
Date: Mon, 1 Dec 2008 12:11:58 +0100
Message-ID: <20081201111158.GA23348@corsac.net>
References: <1227854824.3477.9.camel@hidalgo> <1228093715.4035.87.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp8-g19.free.fr ([212.27.42.65]:60233 "EHLO smtp8-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751367AbYLALNe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 1 Dec 2008 06:13:34 -0500
Received: from smtp8-g19.free.fr (localhost [127.0.0.1])
	by smtp8-g19.free.fr (Postfix) with ESMTP id 02E4A32A7CD
	for <linux-acpi@vger.kernel.org>; Mon,  1 Dec 2008 12:13:32 +0100 (CET)
Received: from molly.corsac.net (molly.corsac.net [81.57.48.219])
	by smtp8-g19.free.fr (Postfix) with ESMTP id DA5F632A7FD
	for <linux-acpi@vger.kernel.org>; Mon,  1 Dec 2008 12:13:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1228093715.4035.87.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, Dec 01, 2008 at 09:08:35AM +0800, Zhao Yakui wrote:
> On Fri, 2008-11-28 at 14:47 +0800, Yves-Alexis Perez wrote:
> > Hi,
> > 
> > I'm running linux 2.6.28-rc6-00007-ged31348 on my Thinkpad T61, with
> > Intel GM965. Under X, brightness keys work fine most of the time, but in
> > some case it fails (for example after a dpms force off, but not always).
> > Switching to console and back to X fix the problem for a time.
> Will you please confirm whether the issue still exists if DPMS is not
> used?

I've disabled DPMS in xorg.conf (setting all times to 0) and will report
back. But basically I think it was broken only after a DPMS event.
> > 
> > Another weird stuff is that, in single user, I have no way to control
> > the backlight. Using brightness key doesn't work,
> > and /sys/class/backlight/acpi_video0 doesn't do anything.
> Can you confirm whether the i915 driver is loaded in single user mode?

It's not

> If not, please load it and see whether the interface
> of /sys/class/backlight/* can work.

When loading it, I still only have acpi_video0 (which is good, at least
I don't have two devices), but it doesnt work. Echoing stuff in
brightness changes the value inside, and in actual_brightness, but the
screen doesn't dim.

This is using 2.6.28-rc6-00184-gd9d060a

Cheers,
-- 
Yves-Alexis
