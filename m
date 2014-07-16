From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] acpi-video: Fix backlight taking 2 steps on a brightness key press
Date: Wed, 16 Jul 2014 13:25:07 +0200
Message-ID: <1405509908-12620-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:7546 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751422AbaGPLZ0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jul 2014 07:25:26 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Torvalds <torvalds@linux-foundation.org>, =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Cc: linux-acpi@vger.kernel.org

Hi All,

Here is my cleaned-up version of Linus' patch to fix the 2 steps on a
brightness key press problem.

Changes compared to Linus' version:
-Move the global variables to inside struct acpi_video_device
-Rebase on top of Rafael's linux-pm linux-next branch (so on top of the
 revert of changing the brightness_switch_enabled default)

I've tested this on a laptop affected by the 2 steps problem and I can =
confirm
that it fixes the 2 steps issue under normal usage. I managed to trigge=
r the
race by generating a heavy io-load, as exptected hitting the race has n=
o
unwanted side-effects other then taking 2 steps instead of one.

Bj=C3=B8rn can you test this patch on your system and confirm that it d=
oes not
break things for you please ? Note that in order to apply it you first =
need
to do: "git revert 886129a8eebebec", as the revert has not yet reached
Linus' tree AFAIK.

Regards,

Hans
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
