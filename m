From: Richard Hughes <hughsient@gmail.com>
Subject: ACPI battery driver emits POWER_SUPPLY_STATUS_FULL when power lead
 plugged in
Date: Fri, 23 Jan 2009 16:57:23 +0000
Message-ID: <1232729843.3504.6.camel@hughsie-work.lan>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:56018 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756171AbZAWQ6E (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Jan 2009 11:58:04 -0500
Received: by ey-out-2122.google.com with SMTP id 22so989652eye.37
        for <linux-acpi@vger.kernel.org>; Fri, 23 Jan 2009 08:58:02 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, mjg <mjg@redhat.com>, Matthias Clasen <mclasen@redhat.com>

When I insert the power lead or attach my T61 to the powered dock, the
battery power supply status goes like this:

0.00s Discharging
{dock}
0.10s Fully charged
1.00s Charging

This causes userspace (in my case gnome-power-manager) to pop up a
dialog telling me the battery is full, and the icon flickers to fully
green, then 10% green and charging.

This seems to have existed as long as the power supply class was being
used by the acpi battery, but we've always relied on a userspace fudge.

This is tested with 2.6.27.9-159.fc10.i686, although I seem to get the
same thing with git from kernel.org.

Is this a known issue? Does anybody have any insight into what causes
this? I'm fully willing to test patches or debug this further myself.

Thanks,

Richard.


