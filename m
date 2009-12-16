From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 0/4 v2] sony-laptop for 2.6.33
Date: Thu, 17 Dec 2009 00:08:32 +0900
Message-ID: <1260976116-6369-1-git-send-email-malattia@linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:38821
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756883AbZLPPIq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 10:08:46 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Mattia Dongili <malattia@linux.it>

Hi Len,

as promised here is a re-submission of the previous two patches plus two more
that are helpful to support rfkill on newer models like Type P and Type X.

Dmitry Torokhov (1):
  sony-laptop: remove private workqueue, use keventd instead

Mattia Dongili (3):
  sony-laptop: add AVMode key mapping
  sony-laptop: rfkill support for newer models
  sony-laptop: enumerate rfkill devices using SN06

 drivers/platform/x86/sony-laptop.c |  151 ++++++++++++++++++++++++------------
 include/linux/sonypi.h             |    1 +
 2 files changed, 103 insertions(+), 49 deletions(-)

