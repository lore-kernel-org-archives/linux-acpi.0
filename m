From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 0/4] eeepc-laptop updates
Date: Mon,  8 Jun 2009 10:16:46 +0200
Message-ID: <1244449010-7995-1-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:52392 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753197AbZFHIYV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 8 Jun 2009 04:24:21 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Corentin Chary <corentincj@iksaif.net>

Hi Len,
Some updates for eeepc-laptop.
Patch 1/4 is needed for linux-next

Thanks,

Corentin Chary (1):
  eeepc-laptop: Fix cpufv

Joe Perches (1):
  eeepc-laptop.c: use pr_fmt and pr_<level>

Pekka Enberg (1):
  eeepc-laptop: enable camera by default

Randy Dunlap (1):
  eeepc: fix kconfig selects

 drivers/platform/x86/Kconfig        |    3 +-
 drivers/platform/x86/eeepc-laptop.c |  129 +++++++++++++++++++++++++----------
 2 files changed, 95 insertions(+), 37 deletions(-)

