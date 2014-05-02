From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: RFC: changing acpi-video brightness_switch_enabled default to 0
Date: Fri, 02 May 2014 13:56:50 +0200
Message-ID: <4392622.hgzIWDcxEe@vostro.rjw.lan>
References: <5363661F.1050301@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52162 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751834AbaEBLkS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 2 May 2014 07:40:18 -0400
In-Reply-To: <5363661F.1050301@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Aaron Lu <aaron.lu@intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Josh Boyer <jwboyer@fedoraproject.org>

On Friday, May 02, 2014 11:32:15 AM Hans de Goede wrote:
> Hi All,
> 
> I was already considering asking for $subject for a while, but I did not see
> any bug reports caused by it so I didn't ask. Until today I discovered that
> I'm not seeing any bugs because Fedora is carrying a kernel patch
> changing the default.
> 
> A quick google search for brightness_switch_enabled OTOH reveals that for
> other distros it is a serious problem, see ie:
> https://bugs.launchpad.net/gnome-settings-daemon/+bug/527157
> http://askubuntu.com/questions/173921/why-does-my-thinkpad-brightness-control-skip-steps
> 
> The problem is that acpi-video is unique in that it not only generates
> brightness up/down keypresses, but also (sometimes) actively changes the
> brightness itself.
> 
> This presents an inconsistent kernel interface to userspace, basically there
> are 2 different scenarios, depending on the laptop model:
> 
> 1) On some laptops a brightness up/down keypress means: show a brightness osd
> with the current brightness, iow it is a brightness has changed notification.
> 
> 2) Where as on (a lot of) other laptops it means a brightness up/down key was
> pressed, deal with it.
> 
> Most of the desktop environments interpret any press as in scenario 2, and
> change the brightness up / down as a response to the key events, causing it
> to be changed twice, once by acpi-video and once by the DE.
> 
> With the new default for video.use_native_backlight we will be moving even
> more laptops over to behaving as in scenario 2. Making the remaining laptops
> even more of a weird exception. Also note that it is hard to detect scenario
> 1 properly in userspace, and AFAIK none of the DE-s deasls with it.
> 
> Therefor I would like to propose to change the brightness_switch_enabled
> default to 0.

Aaron, what do you think about that?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
