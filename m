From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 0/2] eeepc-laptop updates for 2.6.32-rcX
Date: Fri, 16 Oct 2009 22:22:45 +0200
Message-ID: <1255724567-25597-1-git-send-email-corentincj@iksaif.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:43222 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751437AbZJPUVr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 Oct 2009 16:21:47 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Corentin Chary <corentincj@iksaif.net>

Hi Len,
Two more patch for eeepc-laptop, the first revert a previous commit:
> a much better patch for this
> (which fixes the problem directly in rt2860sta) arrived in Greg KH's
> staging.current queue late yesterday.

The second really speed up the boot process for Eeepc.
Thanks,

Corentin Chary (1):
  Revert "eeepc-laptop: Prevent a panic when disabling RT2860 wireless
    when associated"

Luca Niccoli (1):
  eeepc-laptop: don't enable camera at startup if it's already on.

 drivers/platform/x86/eeepc-laptop.c |   30 ++++++++++--------------------
 1 files changed, 10 insertions(+), 20 deletions(-)

