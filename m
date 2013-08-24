From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] ACPI fix for v3.11-rc7
Date: Sat, 24 Aug 2013 17:17:56 +0200
Message-ID: <11694750.y7arDE0Ss8@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:59364 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754839Ab3HXPHR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 24 Aug 2013 11:07:17 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from the git repository at

  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-3.11-rc7

to receive one ACPI fix for v3.11-rc7 as
commit 168cf0eca45b86014b8c2a17fcb0673ab1af809b

  Revert "ACPI / video: Always call acpi_video_init_brightness() on init"

on top of commit b36f4be3de1b123d8601de062e7dbfc904f305fb

  Linux 3.11-rc6

I really hoped that it wouldn't be necessary to change anything in ACPI at
this point, but it turns out that we need to revert one more ACPI video
commit causing trouble.

This reverts a change in the ACPI video driver that caused the ACPI
backlight initialization to be carried out even if acpi_backlight=vendor
is passed in the kernel command line which turns out to break things
at least on one system.

Thanks!


---------------

Rafael J. Wysocki (1):
      Revert "ACPI / video: Always call acpi_video_init_brightness() on init"

---------------

 drivers/acpi/video.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

