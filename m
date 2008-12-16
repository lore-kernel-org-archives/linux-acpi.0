From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 12235] New:
 /sys/devices/virtual/backlight/acpi_video0/brightness has it backwards
Date: Tue, 16 Dec 2008 10:00:23 -0800
Message-ID: <20081216100023.2e437c8c.akpm@linux-foundation.org>
References: <bug-12235-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48779 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751317AbYLPSAq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Dec 2008 13:00:46 -0500
In-Reply-To: <bug-12235-10286@http.bugzilla.kernel.org/>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: bugme-daemon@bugzilla.kernel.org, khashayar.lists@gmail.com, "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Tue, 16 Dec 2008 03:36:11 -0800 (PST) bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=12235
> 
>            Summary: /sys/devices/virtual/backlight/acpi_video0/brightness
>                     has it backwards
>            Product: ACPI
>            Version: 2.5
>      KernelVersion: 2.6.28-rc8
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Power-Video
>         AssignedTo: acpi_power-video@kernel-bugs.osdl.org
>         ReportedBy: khashayar.lists@gmail.com
> 
> 
> Latest working kernel version:
> 2.6.27
> 
> Earliest failing kernel version:
> probably 2.6.28-rc1, but could be later in the release candidates.
> 
> Distribution:
> Ubuntu 8.10
> 
> Hardware Environment:
> Asus, N20A, all intel.
> 
> Problem Description:
> If the laptop loads the video module at boot time,
> /sys/devices/virtual/backlight/acpi_video0/brightness is created. However, it's
> all backwards, confusing applications like gnome-power-manager and the likes
> (well, that basically means hal). Echoing 0 to 'brightness' raises the
> backlight of this laptop to maximum. Echoing 13 to it, takes the backlight to a
> minimum. 
> actual_brightness' seems to stay at 0 at all times.
> 
> If I disalllow the video module to be loaded at boot time, there's no backlight
> interface in /sys/class/backlight/*. But, nevertheless, the xbacklight utility
> and hal seem to be able to control the backlight just fine. In this latter
> case, withouth the video module loaded, xbacklight & hal handle the backlight
> correctly, i.e. less means lower backlight, and more means brighter backlight.
> 
> I just confirmed this problem exists with the latest git from Linus' tree, as
> well as the rc8 patch.
> 
> If I remember correctly, the 2.6.27-series created an interface under
> /sys/devices/platform/asus-laptop/ for controlling backlight which worked just
> fine.
> 
> Please let me know what additional information to post. I'd love to have this
> fixed before the 2.6.28 release.

OK, that's weird.  I have a suspicion that we're about to find out that
this is intentional, but I don't know what the fix is..
