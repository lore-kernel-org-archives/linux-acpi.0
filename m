From: Len Brown <lenb@kernel.org>
Subject: Re: [intel/acpi] backlight
Date: Sun, 30 Nov 2008 22:28:30 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811302220060.3314@localhost.localdomain>
References: <1227854824.3477.9.camel@hidalgo>
 <1228093715.4035.87.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:64753 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbYLAD2d (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 30 Nov 2008 22:28:33 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KB6009GGHNJHQ07@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 30 Nov 2008 21:28:32 -0600 (CST)
In-reply-to: <1228093715.4035.87.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Yves-Alexis Perez <corsac@debian.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>



On Mon, 1 Dec 2008, Zhao Yakui wrote:

> On Fri, 2008-11-28 at 14:47 +0800, Yves-Alexis Perez wrote:
> > Hi,
> > 
> > I'm running linux 2.6.28-rc6-00007-ged31348 on my Thinkpad T61, with
> > Intel GM965. Under X, brightness keys work fine most of the time, but in
> > some case it fails (for example after a dpms force off, but not always).
> > Switching to console and back to X fix the problem for a time.

> Will you please confirm whether the issue still exists if DPMS is not
> used?

I don't have DPMS enabled, and if editing xorg.conf is required
to enable it, I never will.
	
> > Another weird stuff is that, in single user, I have no way to control
> > the backlight. Using brightness key doesn't work,
> > and /sys/class/backlight/acpi_video0 doesn't do anything.

> Can you confirm whether the i915 driver is loaded in single user mode?
> If not, please load it and see whether the interface
> of /sys/class/backlight/* can work.

In 2.6.28...

in single user mode, i915 is not loaded,
/sys/class/backlight/acpi_video0 does NOT work

modprobe of i915 does not change this.

In 2.6.27

in single user mode, i915 is not loaded,
/sys/class/backlight/acpi_video0 does NOT work
/sys/class/backlight/acpi_video1 DOES work

modprobe of i915 does not change this.

-Len

