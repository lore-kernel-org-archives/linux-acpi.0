From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 0/2] eeepc-laptop: fix for 2.6.32-rc5
Date: Tue, 13 Oct 2009 00:13:31 +0200
Message-ID: <1255385613-25400-1-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:54312 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933362AbZJLWNV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 Oct 2009 18:13:21 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Corentin Chary <corentincj@iksaif.net>

Hi Len,
Here is 2 patchs for 2.6.32-rc5.
Sorry for the first batch, there was a typo and it was send to the wrong address.

Darren Salt (1):
  eeepc-laptop: Prevent a panic when disabling RT2860 wireless when
    associated

Rakib Mullick (1):
  eeepc-laptop: Properly annote eeepc_enable_camera().

 drivers/platform/x86/eeepc-laptop.c |   31 +++++++++++++++++++++----------
 1 files changed, 21 insertions(+), 10 deletions(-)

