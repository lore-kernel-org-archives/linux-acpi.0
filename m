From: Fabio Comolli <fabio.comolli@gmail.com>
Subject: Possible bug in eeepc-laptop.c - EeePC 900
Date: Tue, 9 Mar 2010 23:58:47 +0100
Message-ID: <b637ec0b1003091458j67efc62cg2c975e9e286f4b0b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f216.google.com ([209.85.219.216]:42647 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785Ab0CIW6u (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Mar 2010 17:58:50 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI mailing list <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, Corentin Chary <corentin.chary@gmail.com>

Hi.
I have an EeePC 900 running 2.6.34-rc1.

If I boot it on AC the cpu runs at full speed, 900MHz; if I boot it on
battery it runs only at 630Mhz. Plugging / unplugging the AC does not
change the cpu frequency. Only a reboot can change the situation.

I already tried to echo 0 or 1 to the
/sys/devices/platform/eeepc/cpufv file; no effects, even if the file
changes its value.

This is not a regression from 2.6.33: this behavior is also present in
that version.

Does this ring any bells? This is really annoying, especially when
trying to watch a movie on battery. Also 3D apps show a 30%
performance drop, as expected.

Regards,
Fabio
