From: eaglex <eaglex@gmail.com>
Subject: sony-laptop on AR series
Date: Wed, 23 Jan 2008 12:33:34 +0200
Message-ID: <17b35fe50801230233jda8e183qf380ec153c26020c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:44725 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724AbYAWKdg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Jan 2008 05:33:36 -0500
Received: by fg-out-1718.google.com with SMTP id e21so2198270fga.17
        for <linux-acpi@vger.kernel.org>; Wed, 23 Jan 2008 02:33:34 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,

I own a Sony Vaio VGN-AR41E and have gotten the Fn keys
to report ACPI events by adding:

---------- paste ---------
            .ident = "Sony Vaio AR Series",
            .callback = sony_nc_C_enable,
            .driver_data = sony_C_events,
            .matches = {
                DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
                DMI_MATCH(DMI_PRODUCT_NAME, "VGN-AR"),
------- end paste -----

to the appropriate section in drivers/misc/sony-laptop.c, but that's
about all that works.

I get no controls in /sys/devices/platform/sony-laptop. I do get a few
controls in
/sys/class/backlight/sony, but they don't seem to do anything.
(I get these: actual_brightness bl_power brightness max_brightness).

Any suggestions?
