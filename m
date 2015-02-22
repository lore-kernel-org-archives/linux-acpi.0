From: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Subject: [v3.20] ACPI backlight problem
Date: Sun, 22 Feb 2015 17:53:11 +0100
Message-ID: <CADDKRnDuC8y_shfPEBcBnxg3BXzwMyv0AUhEsYcSUx8a9-mXsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:43803 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbbBVQxM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 22 Feb 2015 11:53:12 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

When I press backlight keys then normally OSD is shown and
backlight follows immediately the keystrokes step by step.

Now in v3.20 it behaves different:
When I press backlight keys at first nothing happens. If I watch a
video it is being stopped.
After some seconds OSD is shown, backlight changes - in one step - to
the new level and video continues.

Thanks, J=C3=B6rg
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
