From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 0/3] sony-laptop updates
Date: Sun, 20 Dec 2009 23:17:36 +0900
Message-ID: <1261318659-5980-1-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:54540
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550AbZLTORw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 20 Dec 2009 09:17:52 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Mattia Dongili <malattia@linux.it>

Hi Len,

a few more updates. Nothing exciting, some cleanups from Dmitry and a
documentation update.
Please apply together with my previous submission.

Thanks!


Dmitry Torokhov (2):
  sony-laptop: switch from workqueue to a timer
  sony-laptop: simplify keymap initialization

Mattia Dongili (1):
  sony-laptop: documentation updates

 Documentation/laptops/sony-laptop.txt |   37 +++++++++++++++++++++++-----
 drivers/platform/x86/sony-laptop.c    |   42 +++++++++++++++------------------
 2 files changed, 49 insertions(+), 30 deletions(-)

