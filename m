From: Hans de Goede <hdegoede@redhat.com>
Subject: [RFC 0/3] Add acpi_video_unregister_backlight and use it in acer-wmi
Date: Mon, 12 May 2014 20:03:41 +0200
Message-ID: <1399917824-10341-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:20484 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751326AbaELSD7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 May 2014 14:03:59 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lee Chun-Yi <jlee@suse.com>, Aaron Lu <aaron.lu@intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org

Hi Aaron and Lee,

While working on figuring out howto fix this Acer backlight bug properly:
https://bugzilla.redhat.com/show_bug.cgi?id=1012674

TL;DR: needs acpi-video to not register the backlight device, but keep it
processing hotkeys, like video.use_native_backlight=1 does, but this machine
does not have a win8 ready BIOS.

This eventually lead me to https://bugzilla.kernel.org/show_bug.cgi?id=35622
and the whole discussion between you there, as well as to the patches
attached there. I believe that Lee's patches there to add a function to
acpi-video to only unregister the backlight device are the correct way
forward. I've explained why in the commit messages.

Note that for the fix for bko35622 I've actually opted for a bigger hammer,
by simply always calling acpi_video_unregister_backlight instead of
acpi_video_unregister. Again rationale is in the commit message, it boils
down to acpi_video_unregister_backlight() leading to consistent behavior,
where as acpi_video_unregister() leads to different behavior depending on
module load ordering. So even if this causes issues somewhere (which would be
2 keypresses reported for each press, which is not too bad), it still is
better, because it at least will give us consistent wrong or wright behavior
and we can then fix the double key presses from a stable base.

One could go as far as to say that acpi_video_unregister() should simply go
away completely.

The 3th patch fixes the bug I started with by simply adding a dmi table
entry for the model in the rhbz1012674

This series is RFC for now because some of these changes may be somewhat
controversial, but if you agree with the proposed changes, then I would like
your acks and then get this merged.

Regards,

Hans
