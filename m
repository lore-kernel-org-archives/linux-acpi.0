From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] PNP update for v4.8-rc1
Date: Tue, 26 Jul 2016 23:00:27 +0200
Message-ID: <CAJZ5v0i8UPC_DkdY_taf26y2qV1DCPGXbsqj0Hc_Lh8cbHFsEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36461 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757179AbcGZVA3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Jul 2016 17:00:29 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pnp-4.8-rc1

to receive a PNP subsystem update for v4.8-rc1 as commit
917c7fc264abb9c470486b157bc7252e53f68fbb

 PNP: make pnpbios core explicitly non-modular

on top of commit a99cde438de0c4c0cecc1d1af1a55a75b10bfdef

 Linux 4.7-rc6

One simple change to make the PNP core use device_initcall() instead
of module_init() to run pnpbios_thread_init() (Paul Gortmaker).

Thanks!

---------------

Paul Gortmaker (1):
      PNP: make pnpbios core explicitly non-modular

---------------

 drivers/pnp/pnpbios/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)
