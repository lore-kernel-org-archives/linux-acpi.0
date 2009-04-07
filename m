From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 0/7 v2] ACPI: use device .notify methods
Date: Tue, 07 Apr 2009 09:37:01 -0600
Message-ID: <20090407153532.21399.92051.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:27521 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755401AbZDGPhD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Apr 2009 11:37:03 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Tony Vroon <tony@linx.net>, Mattia Dongili <malattia@linux.it>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Harald Welte <laforge@gnumonks.org>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>

This is just a refresh so these patches apply to the current
upstream tree (commit d508afb437daee7cf07da085b635c44a4ebf9b38).
No other code changes.

---

Bjorn Helgaas (7):
      ACPI: WMI: use .notify method instead of installing handler directly
      sony-laptop: use .notify method instead of installing handler directly
      panasonic-laptop: use .notify method instead of installing handler directly
      fujitsu-laptop: use .notify method instead of installing hotkey handler directly
      fujitsu-laptop: use .notify method instead of installing handler directly
      ACPI: video: use .notify method instead of installing handler directly
      ACPI: thermal: use .notify method instead of installing handler directly


 drivers/acpi/thermal.c                  |   27 ++------------
 drivers/acpi/video.c                    |   30 +++-------------
 drivers/platform/x86/fujitsu-laptop.c   |   60 +++++--------------------------
 drivers/platform/x86/panasonic-laptop.c |   26 +++----------
 drivers/platform/x86/sony-laptop.c      |   30 ++--------------
 drivers/platform/x86/wmi.c              |   15 ++------
 6 files changed, 30 insertions(+), 158 deletions(-)

-- 
Bjorn
