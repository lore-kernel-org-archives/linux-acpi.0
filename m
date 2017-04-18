From: Dmitry Frank <mail@dmitryfrank.com>
Subject: What is the proper way to address the problem of backlight with two
 video cards?
Date: Tue, 18 Apr 2017 15:26:16 +0300
Message-ID: <20170418122616.GA11467@dimon-t520>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from forward10h.cmail.yandex.net ([87.250.230.221]:51169 "EHLO
        forward10h.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752784AbdDRMbh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 18 Apr 2017 08:31:37 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On my laptop Thinkpad T520, I have the following problem: when I suspend it
and then resume back, the backlight brightness always gets reset to the
maximum value, independently of the value I had before suspending it.

I tracked this issue down to the following:

Thinkpad T520 has two video cards: Intel i915 and Nvidia GF119M.

Attributes (as in struct acpi_video_device_attrib) for Intel are: 0x80010400
(LCD, bios_can_detect: 1)

Attributes for Nvidia are: 0x110. So, there's no device_id_scheme bit, and
thus acpi_video_bus_get_one_device() falls back to the legacy ID detection,
and sets it as LCD.

The main problem is that executing _BCM on either of those two cards affects
the laptop's LCD panel in the same way. They appear to the kernel as two
separate cards (and they are indeed).

When I adjust the brightness, only that of Intel card is recorded. But during
the resume, acpi_video_resume() calls acpi_video_device_lcd_set_level() for
both cards, and Nvidia happens to be the second one, so its brightness "wins".

Fwiw, I do not use proprietary nvidia drivers.

At this point I'm unsure of what's the right way to solve that. Since Nvidia
Optimus allows two cards to work simultaneously (for different applications),
it does not make sense to check which card is "active", since both of them can
be active. But, is there some way to check that two video adapters control the
same physical LCD panel? So far I failed to find one: these acpi_video_device-s
don't share anything, e.g. each of them has its own struct
acpi_video_device_brightness and struct backlight_device.

If anyone has some idea, please share.

Thanks!
