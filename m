From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 0/4] asus-laptop and eeepc-laptop regressions
Date: Sun, 15 Feb 2009 19:30:17 +0100
Message-ID: <1234722621-14498-1-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp21.services.sfr.fr ([93.17.128.3]:49354 "EHLO
	smtp21.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754230AbZBOSlH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Feb 2009 13:41:07 -0500
Received: from smtp21.services.sfr.fr (msfrf2119 [10.18.25.33])
	by msfrf2110.sfr.fr (SMTP Server) with ESMTP id 1F39E7000A57
	for <linux-acpi@vger.kernel.org>; Sun, 15 Feb 2009 19:33:23 +0100 (CET)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org, Corentin Chary <corentincj@iksaif.net>

Hi Len,
Patch 1:    fixes http://bugzilla.kernel.org/show_bug.cgi?id=12501
Patch 2, 3: restore proc events for backward compatibility
Patch 4:    may be merged later, but no big changes here
Thanks

Corentin Chary (4):
  eeepc-laptop: Fix Kconfig
  asus-laptop: restore acpi_generate_proc_event()
  eeepc-laptop: restore acpi_generate_proc_event()
  asus-laptop: use select instead of depends on

 drivers/platform/x86/Kconfig        |    9 +++++----
 drivers/platform/x86/asus-laptop.c  |    5 ++++-
 drivers/platform/x86/eeepc-laptop.c |    6 +++++-
 3 files changed, 14 insertions(+), 6 deletions(-)


