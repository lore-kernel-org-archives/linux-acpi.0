From: Ben Jencks <ben@bjencks.net>
Subject: "Windows 2012" OSI causes backlight problems on current ThinkPad
 firmware
Date: Mon, 24 Dec 2012 16:32:01 -0500
Message-ID: <50D8C9D1.2060801@bjencks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:42364 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753342Ab2LXVcE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Dec 2012 16:32:04 -0500
Received: by mail-ob0-f172.google.com with SMTP id za17so6964503obc.17
        for <linux-acpi@vger.kernel.org>; Mon, 24 Dec 2012 13:32:04 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

The addition of "Windows 2012" to the OSI strings in the 3.7 cycle has
caused backlight brightness adjustment to break on my ThinkPad T530.

Without "Windows 2012" _BCL returns the actual 16 brightness levels:

5, 10, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 80, 90, 100

When "Windows 2012" is present, it returns 101 levels 0-100, but _BCM
rounds any value up to one of the real values above.

This interacts badly with gnome-settings-daemon, which attempts to
change brightness in increments of 5 (1/20 of 100). If brightness is
currently 100, it attempts to decrement it to 95, but it gets rounded
back up to 100, so it's impossible to decrease the brightness.

Booting with acpi_osi="!Windows 2012" fixes the problem, though I'm not
sure if it introduces others; I see several other things depend on WIN8
in DSDT.

Perhaps this should be fixed in gnome-settings-daemon, but since it
appears on the surface to be a kernel regression (3.6 works, 3.7 broken)
I thought I'd report it here first.

ThinkPad T530, BIOS 2.07, booting with pure UEFI (BIOS compatibility
module disabled). I can provide all or part of acpidump output if needed.

-Ben

Not subscribed, please copy me on replies.
