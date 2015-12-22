From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/5] acpi-video and platform/x86 driver fixes
Date: Tue, 22 Dec 2015 19:09:47 +0100
Message-ID: <1450807792-4980-1-git-send-email-hdegoede@redhat.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Darren Hart <dvhart@infradead.org>
Cc: Corentin Chary <corentin.chary@gmail.com>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, ibm-acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Hi All,

This patch-set is the result of the discussion surrounding the
backlight issues on the Dell Vostro V131. The first 3 patches
cleanup how some platform/x86 drivers detect if acpi-video
is handling brightness key presses and that they should
not report duplicate events. This is a cleanup which I wanted
to do for a while already and the Vostro V131 fix actually
benefits from this.

The last 2 patches together actually fix the issues on the
Vostro V131. Since the 2 platform patches in this set depend
on an acpi patch, I believe that it would be best if this
entire set gets merged via the acpi tree with acks
from the platform driver maintainer.

Regards,

Hans
