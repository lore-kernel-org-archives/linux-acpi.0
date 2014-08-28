From: Hans de Goede <hdegoede@redhat.com>
Subject: Dealing with desktops with an acpi-video interface claiming backlight
 control
Date: Thu, 28 Aug 2014 16:47:13 +0200
Message-ID: <53FF40F1.2020501@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:15153 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502AbaH1OrQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 28 Aug 2014 10:47:16 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s7SElFYr025910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-acpi@vger.kernel.org>; Thu, 28 Aug 2014 10:47:15 -0400
Received: from shalem.localdomain (vpn1-5-244.ams2.redhat.com [10.36.5.244])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s7SElDQb012039
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
	for <linux-acpi@vger.kernel.org>; Thu, 28 Aug 2014 10:47:15 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>

Hi All,

I've been on the receiving and of several bug reports
complaining about Linux showing a backlight control
(and the desktop environment a brightness slider) on
non laptop machines:

https://bugzilla.redhat.com/show_bug.cgi?id=1097436
https://bugzilla.redhat.com/show_bug.cgi?id=1133327
https://bugzilla.redhat.com/show_bug.cgi?id=1133329
https://bugzilla.redhat.com/show_bug.cgi?id=1133646

Note the first one is already fixed in asus-wmi.c, as
that seemed best at the time. But the problem seems
to be wider then just Asus motherboards, and so far
all the machines with this issue seem to have this
issue due to acpi-video registering a backlight
interface.

For the asus-wmi.c driver the following solution was
chosen:

        /* Some Asus desktop boards export an acpi-video backlight interface,
           stop this from showing up */
        chassis_type = dmi_get_system_info(DMI_CHASSIS_TYPE);
        if (chassis_type && !strcmp(chassis_type, "3"))
                acpi_video_dmi_promote_vendor();

That will work for 2 of the 3 new models too, the 3th
model has a value of "6", aka "Mini Tower", so we could
move these check to acpi-video, but then we would need
to extend it to at least also check for "6", and in the
future possibly others values.

I'm not 100% certain simply moving the check is a good idea,
I'm afraid that the check may end up triggering on some
laptops, causing problems / regressions.

So although I dislike quirk lists as much as the next person,
as they need constant maintenance, I think that it probably
is best to solve this with dmi based quirks for the boards
in question, so as to avoid any chance of this causing
regressions for other machines.

Your input on this is greatly appreciated.

Thanks & Regards,

Hans
