From: Joerg Platte <jplatte@naasa.net>
Subject: Re: Linux 3.11-rc2 (acpi backlight, revert)
Date: Fri, 26 Jul 2013 06:23:14 +0200
Message-ID: <51F1F9B2.9000302@naasa.net>
References: <CA+55aFy330bSRjK5HT1n0wXioPykL3RquHXyBPjm5GpTz_Y=DQ@mail.gmail.com> <2218913.HKGjJcYT1G@vostro.rjw.lan> <CAAG0J98i-XaO_3sPWsnyEGDX77T=WiNf1K=YMhe5DvkwKotorw@mail.gmail.com> <9711528.yIoJy2i1iX@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from s15372268.onlinehome-server.info ([87.106.227.76]:41900 "EHLO
	ferdi.naasa.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793Ab3GZEdJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Jul 2013 00:33:09 -0400
In-Reply-To: <9711528.yIoJy2i1iX@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: James Hogan <james@albanarts.com>, Kamal Mostafa <kamal@canonical.com>, =?UTF-8?B?SsO2cmcgT3R0ZQ==?= <jrg.otte@gmail.com>, Aaron Lu <aaron.lu@intel.com>, Kalle Valo <kvalo@adurom.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Matthew Garrett <matthew.garrett@nebula.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Steven Newbury <steve@snewbury.org.uk>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Martin Steigerwald <Martin@lichtvoll.de>, Daniel Vetter <daniel.vetter@ffwll.ch>, intel-gfx <intel-gfx@lists.freedesktop.org>, Jani Nikula <jani.nikula@linux.intel.com>

On 25.07.2013 21:47, Rafael J. Wysocki wrote:

> Other people who experienced problems with backlight in 3.11-rc2, please let me
> know whether or not the revert works for you too if you can.

Before reverting the patch /sys/class/backlight was empty and backlight 
brightness was set to max, now it again contains a link to acpi_video0 
on my Thinkpad 420s with intel video and adjusting the backlight works 
again.

Joerg
