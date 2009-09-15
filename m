From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 2/4] sony-laptop: SPIC unset IRQF_SHARED, set IRQF_DISABLED
Date: Wed, 16 Sep 2009 00:05:30 +0900
Message-ID: <1253027132-5903-3-git-send-email-malattia@linux.it>
References: <1253027132-5903-1-git-send-email-malattia@linux.it>
 <1253027132-5903-2-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:43821
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754641AbZIOPO0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Sep 2009 11:14:26 -0400
In-Reply-To: <1253027132-5903-2-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Mattia Dongili <malattia@linux.it>

The SPIC irq is not really shareable, the IO port cannot be cleared and
always returns some data so there is no real way to understand if the irq
is for us or not. Moreover the _PRS acpi method says the irq is not
shareable.
In addition to this, in some cases, an additional write to the IO port has
to be performed in order to properly decode the event received from the
device. This generates another interrupt which may overlap with the
previous one. In the future this is going to be important for properly
decoding events.

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/platform/x86/sony-laptop.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index e283fe9..f2482f2 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -2795,7 +2795,7 @@ static int sony_pic_add(struct acpi_device *device)
 	/* request IRQ */
 	list_for_each_entry_reverse(irq, &spic_dev.interrupts, list) {
 		if (!request_irq(irq->irq.interrupts[0], sony_pic_irq,
-					IRQF_SHARED, "sony-laptop", &spic_dev)) {
+					IRQF_DISABLED, "sony-laptop", &spic_dev)) {
 			dprintk("IRQ: %d - triggering: %d - "
 					"polarity: %d - shr: %d\n",
 					irq->irq.interrupts[0],
-- 
1.6.3.3

