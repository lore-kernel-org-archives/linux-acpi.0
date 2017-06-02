From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v6 0/1] platform/x86: Add driver for ACPI INT0002 Virtual GPIO
Date: Fri,  2 Jun 2017 17:15:06 +0200
Message-ID: <20170602151507.22391-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50372 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750971AbdFBPPM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 2 Jun 2017 11:15:12 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Darren Hart <dvhart@infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-gpio@vger.kernel.org

Hi All,

Here is v6 of my patch adding a driver for the ACPI INT0002 Virtual GPIO
device. When I started working on this driver using 4.11 as kernel this
fixed an irq-storm on irq 9, with some of the recent suspend-to-idle wakeup
changes which have landed in 4.12-rc1 this "driver" is necessary to fix
affected systems getting stuck in suspend when the user tries to wake
them through a peripheral which signals PME to the PMC to wakeup the system,
such as the xHCI controller.

As such ideally this driver should get added to a later 4.12-rc# as a
bugfix. Also see this linux-acpi mailinglist-thread:
https://www.spinics.net/lists/linux-acpi/msg74614.html

Regards,

Hans
	
