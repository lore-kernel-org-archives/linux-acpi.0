From: Richard Hughes <hughsient@gmail.com>
Subject: Exporting struct power_supply.use_for_apm
Date: Wed, 22 Jun 2011 15:25:03 +0100
Message-ID: <BANLkTimy_b1qva63DumxU=SBLHXMaPS2cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43672 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757743Ab1FVOZE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Jun 2011 10:25:04 -0400
Received: by iwn6 with SMTP id 6so721978iwn.19
        for <linux-acpi@vger.kernel.org>; Wed, 22 Jun 2011 07:25:04 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>
Cc: cbou@mail.ru, spyro@f2s.com, Bastien Nocera <hadess@hadess.net>

Hi, if this isn't the correct mailing list please yell. I'm the author
of upower which is a userspace service that presents the power devices
in the system as a DBus interface for the session to use.

In struct power_supply there is a boolean use_for_apm which seems to
be 1 for devices actually powering the system, and 0 for devices
attached to the machine. Would this be sane to export into sysfs as
something sane?

The reason I ask, is that upower has to decide if the system as a
whole has several high level states, e.g. "low-power" or
"critically-low-power" and for that it needs to decide if the battery
backing the power supply device is critical to the system power state.
This would mean that a ACPI battery or UPS running low would mean the
system is low, but a USB mouse or a wacom tablet would not prompt the
low power warning.

This email has been triggered by a bug report :
https://bugs.freedesktop.org/show_bug.cgi?id=38569 in which the kernel
patch http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=59d2334ac9f4255f5f8f3e4e1bf41653e0bba99e;hp=4da361b69102cdffe73006771eae7504d2cb8736
added the power_supply device which confuses upower.

The alternative is to change the wacom power_supply code from
type=POWER_SUPPLY_TYPE_BATTERY to something else, e.g.
POWER_SUPPLY_TYPE_ACCESSORY which upower can easily key from. I really
don't want to blacklist "battery_wacom" as that seems like such a
hack.

Thanks for any comments,

Richard.
