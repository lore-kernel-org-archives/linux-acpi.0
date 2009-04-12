From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 0/6] sony-laptop fixes for 2.6.30-rc2
Date: Sun, 12 Apr 2009 20:26:25 +0900
Message-ID: <1239535591-15514-1-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:41440
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760110AbZDLL0f (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 12 Apr 2009 07:26:35 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Mattia Dongili <malattia@linux.it>

Hi Len,

a few fixes for the new code handling the SNC devices, a fix for a small bug in
the resume path and a patch for ec.c that allows sony-laptop to restore the
brightness level on resume.

Almer S. Tigelaar (4):
  sony-laptop: Duplicate SNC 127 Event Fix
  sony-laptop: SNC 127 Initialization Fix
  sony-laptop: SNC input event 38 fix
  ec.c: Fix ACPI EC resume non-query interrupt message

Mattia Dongili (2):
  sony-laptop: fix bogus error message display on resume
  sony-laptop: always try to unblock rfkill on load

 drivers/acpi/ec.c                  |    1 +
 drivers/platform/x86/sony-laptop.c |   27 ++++++++++++++++++++-------
 2 files changed, 21 insertions(+), 7 deletions(-)

-- 
mattia
:wq
