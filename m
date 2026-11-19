Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.230.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795055031;
	b=aLkEEFzF+g4Z1dRAKRdRZ65NxYUE9+6JtKnZZzkXkYUwSXz8ngwTD4xrj1xIBtDxbVOl
	 S3OaZnwEbyAHRWtZaTbExfMCci2ZXU5K9Tw/lu9LeO5cjVraFRrvCjTFapd3+2rPOFVJw
	 hjoV6epjp2tvGCbBOGi0md5rfeoZlLXZtsT+vH2/EEdkVtLYzhFMmg/DO/ic04aZ7gcT0
	 eUEDQx2GQUk5l1gDalxp+B0qKGGk4mm7b/wZSvoSofVVV0kS9BBhn3q3o2BQ94iaBLiwg
	 KWrFuwpvmp/2TgJwYxOZY4OUCLshd5KlnFgG8QyGbEGLcFN6UwekOq7zJP4Q4eCZxvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795055031;
	h=DMARC-Filter:DKIM-Signature:To:From:Date:Content-Transfer-Encoding:
	 X-Original-From:Content-Type:Mime-Version:X-Mailer:X-Lms-Return-Path:
	 Cc:Subject:Message-Id;
	bh=gA8AWdM2sUsHs0KBRdbs/YN0huasJSV/DHLpUiZnmqw=;
	b=ceHPe7j6N6fBTvvQ7bJOR8KtlVmP4fJP6nPkK0orrjru7m9JG2l0oohj0jgCnO8FTwmR
	 Cc6BGbSy6/rAUOGnb/hkJ8PtNvlsoWOA2dSVONPRpcs++Y7bz1+ZeueWjPhDnG5naM+in
	 w60V2ObKL973qz8F5hrZBuXxkk0qISDZigyVeH3ci6Q8u6v+Jlxsh6CHTWGoC7RBXG45q
	 NhyL8jfU4kgOHQbn46XitumaR/NMnq72JAo8sRiHAlHvN7OgiTmVyfYZf7Xuz2s6CxTUZ
	 evW3oiDgDi3ZaBuEsvIZlU2KLBfPeE7nsUvdgsSWelUT6TGEBvkC0ir6b+avxBwqPkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=f2hs6BmR;
	arc=none smtp.remote-ip=209.127.230.112
Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE38606A320
	for <linux-acpi@vger.kernel.org>; Thu, 19 Nov 2026 02:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFE38606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=f2hs6BmR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1795055025; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=gA8AWdM2sUsHs0KBRdbs/YN0huasJSV/DHLpUiZnmqw=;
 b=f2hs6BmRgV7t7ITjWwqJLpJwWznINLe9YuADdIhtibK4ALaAhXmGxoi1h7i6SN2QB9BEnH
 hPIlG8dcF1OaI77XhX9yAC4rhvhvD7hcMby4lqU/VlGjrK59bNsMD/cnB9y0MZ/V2Rbb/b
 u6kwrdcxnZqtJ66VW9M9tLUue1exCvUswnVDXhUbobTWCuBf69JBzJxlFNM0CJ1Jl5kTz1
 s6hVEEaZ55Q4wrSGcN0elQrGxIAb6OTujONobPL2/sV/v7QT+FBkUWAKXr5f87RBsIQx5C
 vWVKVxFp8g2rHj3loXtPI8lwLroOvhp2jEvc4Br7/kBhvGz2xNB68Dy7/fF2Ew==
To: <rafael@kernel.org>
From: "Rui Qi" <qirui.001@bytedance.com>
Date: Thu, 19 Nov 2026 10:23:30 +0800
Content-Transfer-Encoding: 7bit
X-Original-From: Rui Qi <qirui.001@bytedance.com>
Content-Type: text/plain; charset=UTF-8
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1
X-Lms-Return-Path: <lba+26afe5daf+319c5d+vger.kernel.org+qirui.001@bytedance.com>
Cc: <lenb@kernel.org>, <okaya@codeaurora.org>, <linux-acpi@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, "Rui Qi" <qirui.001@bytedance.com>
Subject: [PATCH] ACPI: GED: Add wake support for wake-capable interrupts
Message-Id: <20261119022330.2875110-1-qirui.001@bytedance.com>

GED interrupt resources can be marked wake-capable by firmware, but the
GED driver does not enable IRQ wake for them. Consequently, the generic
IRQ suspend code disables those interrupts along with ordinary device
IRQs, preventing them from waking a system in suspend-to-idle.

Enable IRQ wake after registering each interrupt whose resource has
IORESOURCE_IRQ_WAKECAPABLE set. Remember successful enables per event
so that releasing the event disables IRQ wake before freeing the IRQ.
This supports multiple wake interrupts on one GED without relying on
the single wake IRQ slot in struct device.

Keep runtime event handling available if enabling IRQ wake fails, and
warn about the missing wake functionality. Release previously registered
events when walking _CRS fails, balancing both IRQ registrations and wake
references before device-managed event storage is released.

This does not implement device _PRW-to-GED mappings or infer wake
capability for interrupt resources not marked wake-capable by firmware.

Fixes: 3db80c230da1 ("ACPI: implement Generic Event Device")
Signed-off-by: Rui Qi <qirui.001@bytedance.com>
---
 drivers/acpi/evged.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/evged.c b/drivers/acpi/evged.c
index 189dc68b8875..8afae44ac2b3 100644
--- a/drivers/acpi/evged.c
+++ b/drivers/acpi/evged.c
@@ -51,6 +51,7 @@ struct acpi_ged_event {
 	unsigned int gsi;
 	unsigned int irq;
 	acpi_handle handle;
+	bool wake_enabled;
 };
 
 static irqreturn_t acpi_ged_irq_handler(int irq, void *data)
@@ -81,6 +82,7 @@ static acpi_status acpi_ged_request_interrupt(struct acpi_resource *ares,
 	struct acpi_resource_extended_irq *pext = &ares->data.extended_irq;
 	char ev_name[5];
 	u8 trigger;
+	int ret;
 
 	if (ares->type == ACPI_RESOURCE_TYPE_END_TAG)
 		return AE_OK;
@@ -133,11 +135,34 @@ static acpi_status acpi_ged_request_interrupt(struct acpi_resource *ares,
 		return AE_ERROR;
 	}
 
+	if (r.flags & IORESOURCE_IRQ_WAKECAPABLE) {
+		ret = enable_irq_wake(irq);
+		if (ret)
+			dev_warn(dev, "failed to enable wakeup for irq %u: %d\n",
+				 irq, ret);
+		else
+			event->wake_enabled = true;
+	}
+
 	dev_dbg(dev, "GED listening GSI %u @ IRQ %u\n", gsi, irq);
 	list_add_tail(&event->node, &geddev->event_list);
 	return AE_OK;
 }
 
+static void ged_release_events(struct acpi_ged_device *geddev)
+{
+	struct acpi_ged_event *event, *next;
+
+	list_for_each_entry_safe(event, next, &geddev->event_list, node) {
+		if (event->wake_enabled)
+			disable_irq_wake(event->irq);
+		free_irq(event->irq, event);
+		list_del(&event->node);
+		dev_dbg(geddev->dev, "GED releasing GSI %u @ IRQ %u\n",
+			event->gsi, event->irq);
+	}
+}
+
 static int ged_probe(struct platform_device *pdev)
 {
 	struct acpi_ged_device *geddev;
@@ -153,6 +178,7 @@ static int ged_probe(struct platform_device *pdev)
 				       acpi_ged_request_interrupt, geddev);
 	if (ACPI_FAILURE(acpi_ret)) {
 		dev_err(&pdev->dev, "unable to parse the _CRS record\n");
+		ged_release_events(geddev);
 		return -EINVAL;
 	}
 	platform_set_drvdata(pdev, geddev);
@@ -163,14 +189,8 @@ static int ged_probe(struct platform_device *pdev)
 static void ged_shutdown(struct platform_device *pdev)
 {
 	struct acpi_ged_device *geddev = platform_get_drvdata(pdev);
-	struct acpi_ged_event *event, *next;
 
-	list_for_each_entry_safe(event, next, &geddev->event_list, node) {
-		free_irq(event->irq, event);
-		list_del(&event->node);
-		dev_dbg(geddev->dev, "GED releasing GSI %u @ IRQ %u\n",
-			 event->gsi, event->irq);
-	}
+	ged_release_events(geddev);
 }
 
 static void ged_remove(struct platform_device *pdev)
-- 
2.20.1
