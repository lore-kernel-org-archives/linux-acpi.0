From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: Backlight device class redesign
Date: Sat, 28 Nov 2009 01:30:08 +0100
Message-ID: <b170af450911271630k63fb857auf8314cecd6219eba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:12070 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbZK1AaD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Nov 2009 19:30:03 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

As discussed in http://marc.info/?t=3D124947671300008&r=3D1&w=3D2 we ne=
ed to
redesign our backlight device class. If you wish you can read whole
thread and even http://bugs.freedesktop.org/show_bug.cgi?id=3D20963 but
I'll try to summarize everything anyway.

1) One display can be controlled (I mean backlight) in more than one
way. For example: ACPI, something platform-specific and GPU encoder.
2) Exporting many ways of controlling one display at the same time
drives us to inconsistencies.
3) We have to decide some priority like: ACPI > platform > GPU
4) We have to keep list of all registered controllers for one display.
We can not just unregister lower prioritised as we will hit problem
after (for example) unloading acpi module.
5) We should not export more than one way and let userspace decide.

Currently we keep all registered controllers in /sys/class/backlgiht/
without any grouping per display or per anything. We can not use
grouping per GPU (as somewhere proposed) because one GPU can control
(for example) two PANELS and TV - 3 displays needing backlight
management. The most obvious and stable solution seems to be grouping
per display.

So staying with idea of grouping per display I tried to imagine the
most crazy notebook with external displays configuration we should
handle. Let's consider following displays in notebook (yes, two
panel-notebook!):
1) PANEL#A controlled by ACPI + platform-specific + GPU
2) PANEL#B controlled by ACPI + platform-specific
3) TV connected by S-VIDEO controlled by GPU
4) LCD#A connected by USB controlled by LCD-specific driver
5) LCD#B connected by USB controlled by LCD-specific driver (same
model as LCD#A, driven by the same driver)

Let's do reverse order:
a) For two USB-LCDs driver should generate two other names. Depends on
properties received from LCD that could be serial number or usb port
number. So we would get /sys/class/lcd-vendor-0000:00:1d.2 and
/sys/class/lcd-vendor-0000:00:a3.5
b) For TV gpu kernel module would use name with GPU card number and
output name. Let's say /sys/class/card0-svideo
c) The most complicated case is for PANELs. We have to pick up same
names in: ACPI, platform-specific and GPU driver. For most cases,
which means notebooks with one panel, we could just use "panel".
However I do not want to redesign this after year when we get more
notebooks with two PANELs. So do you have any idea about this? How we
could generate correct names in 3 almost unrelated modules (ACPI,
platform, GPU driver)? We should end with something like
/sys/class/internal-panel-1 and /sys/class/internal-panel-2 but that
won't be so easy. Any ideas?

Please use "Reply to all", as I do cross-ML-post and I am not
subscribed to LKML.

--=20
Rafa=C5=82
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
