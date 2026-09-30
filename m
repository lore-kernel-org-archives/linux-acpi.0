Received: from mail-dl2-f36.google.com (mail-dl2-f36.google.com [74.125.229.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589414AD7F6
	for <linux-acpi@vger.kernel.org>; Wed, 30 Sep 2026 11:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790766984; cv=none; b=Wzre9PHYrum5kCGPtCPsU8d2r5cjrDSXidx0xmxlYjIBgzM5IwK3mRVKf9i0dWwEEwmc5hpaiirVsRJH7h43Gv4BBpKf1qWkRzMzQmYq54lbko5HsVZ/E+d6EI5jm2LUGqd8+zLtXgMse/X3AG98paO1rWeoGYe34yiaR5kNUhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790766984; c=relaxed/simple;
	bh=//2HNXquIk9ck0FFhAaqhWFA7k65CQmAWL5qNBLX90E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lAUGEfQwCIjwagkSlCSJWCODF7EbNQ3lwyzjv9fTkcjH1tLyadUHkpakONGiXWdX9QU0WLigqOvOlapYAB9DLr/LKU98a5ISk380YP5tR1IzMeEcQK1o4MfCpxNhjSjRIcKkAt0YjufG6/K1bijKD5tZROZmL3acm9VYsNmhgX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Szt+ujd/; arc=none smtp.client-ip=74.125.229.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Szt+ujd/"
Received: by mail-dl2-f36.google.com with SMTP id a92af1059eb24-14373bcc010so4654601c88.1
        for <linux-acpi@vger.kernel.org>; Wed, 30 Sep 2026 04:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790766982; x=1791371782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AChnIhzvWEr/iAcPIjM9g8N+/d4nHDoh5cD1dZYc2VY=;
        b=Szt+ujd/+EoUWO6fa2YbIqh+F0z7Uuospa2wb/wa7EGpfEJqwFVtA9q+wP1fokDfS3
         ZSVChFyyQ5QGbSPDJYx9HHF9IX/+wPJF6zCnBvOXXLETG+TX4uj1edftR4noqzMzcsZu
         tBZyesKwAS7g87haMCYZkz+N/SBH8eJaNM/YPadLGTPH5caMvg9rsbyuouK08p7HBOBk
         dqr5ZgRbhc38mY6VB+SsQZaa9CqpXPXp8zPBiJqW77TVvVYZr4ujf6AtyD+O+FeIK3H+
         afB29gZthDTdiDSN31q0H2EKaab2D9Ajszb659YPugx5B2H7EVsfIf0XSPNX5Y1QE4Zd
         itQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790766982; x=1791371782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AChnIhzvWEr/iAcPIjM9g8N+/d4nHDoh5cD1dZYc2VY=;
        b=eZXbAVHs9UlbmUc5aZEcYpL4yIlPgxgE2xdTHiU7/q1SBj8SalR/TYBA2Dbr1YbNXB
         cVBIBFp+d93fxAEshbOoHRceY8iVGamDfzPFzBWOwsA/9fCyIs3wMg2im0vnj4VCU6Sd
         qWum/2rzcow1yYP1OHNsHlc2fNNq06izpLJmq/jZ7yK7CRlkPuSmFQxp1F71QHE6Rkfa
         NxvOscmtkzozYZARSVJAZSjuPif5hMSMgidE5gRbKiyVeKWvvkXtDZbGANixu1SAoPzZ
         wTw7zuCUffI1ZC+fOke9trCDpTo6ROv9gMh+FtofKPcetXGuvcog0l1dzxdywbUgHTP1
         WjCg==
X-Forwarded-Encrypted: i=1; AKwUvBzn7T9JQ9SN92zZV0Fibq1kp3dg6PhFrWpSO5mmuQcfpIyAxz6x/gWobknaz3nTd7H1LgM5VKkoOtHT@vger.kernel.org
X-Gm-Message-State: AFuF++mKIOw6qghLvp/O2JS4Qs5abLU9LLjrYdiMUXg/3EBoRwj1aS78
	D/5VWeRcr9dF1WlWXMxjfT+yIvS24hvvQr1HUIS9bhY4jRbZey2G5JVL
X-Gm-Gg: AYBFou3ZtjeClbrV8Ysm7msB5v1qHsLmjyLIaNb4yQc1RvtWiVp72zc/T/GSXl+cgqN
	MuG87NuIoxy9GFXf1/gQ3Tf1J1TA9z/4GKUhEJkBl9JVXL4xDp0Xs7KNg3U5Dhh9hZqZQI2mAnn
	SIavKIZ3fqBTxtdBQJWWkqCVMDULbaw7nBq4r/Ml4elkqUwUBTNTJeOyNEFLSQ+uKPOvbPA2T6V
	Hg0MwHu7RMKPTGfkjDi9LoPKx4CX8I6oQiiYTxGIL/V6NfACwPGdl1apb5kByKFtC7Scs+WBo8f
	XoiHCvAjuOIf/haJl4QTntkF4Y3DhwUBZZmoypCAdFWHWGYQhxYNdhicywusbnngkYNumSq28u4
	sa8IuTKfsNWZ86zULYaZK1w4+jsbb6lpQ+JTSNhRsEuHSG4toIvZXS0c5n4QAC7CyW1356rRJ6T
	J/BTD++IsoVhBaqAZhvm8lZEY70/SH5KQx7JOrPL1Zpi5fZD4lA8uGV/CwLaQ8nU/nUZIxziLtj
	4abl894+symbbNPO6rHwTlcqLnZ9885A8OtPgUXeVF84N2DjAPlYY/5ymesXOvyGIZ4jvZKvvhe
	WjLto33ft1Tk8Zq7rUfCO1ssNMAAHVuQVYI=
X-Received: by 2002:a05:7022:e11:b0:141:4951:f150 with SMTP id a92af1059eb24-14d327112dcmr1792750c88.18.1790766982048;
        Wed, 30 Sep 2026 04:16:22 -0700 (PDT)
Received: from rahuls-x2elite ([110.226.112.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14d090a9b07sm3525955c88.14.2026.09.30.04.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 04:16:21 -0700 (PDT)
From: Rahul Pon <theflyingrahul@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: GED: Support GpioInt event resources
Date: Wed, 30 Sep 2026 16:45:05 +0530
Message-ID: <20260930111505.1108-1-theflyingrahul@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Generic Event Device accepts only Interrupt and ExtendedInterrupt
resources in _CRS. Some ACPI firmware signals GED events through GPIO
controllers instead: the HP OmniBook 5 16-bf1xxx (Snapdragon X2) describes
its lid (LIGE) and embedded-controller event device (ECGE) as ACPI0013 with
GpioInt resources, and both currently fail to probe with "unable to parse
IRQ resource".

Handle GpioInt resources: get the Linux IRQ with acpi_dev_gpio_irq_get(),
which applies the trigger and polarity and returns -EPROBE_DEFER until the
GPIO controller is registered, and evaluate _EVT with the GPIO pin number,
as done for GSIs above 255. GpioIo resources are skipped. On a failed walk,
free the events already requested and propagate the GPIO error (including
-EPROBE_DEFER) instead of -EINVAL.

Tested on the HP OmniBook 5 16-bf1xxx: lid close/open run _EVT and reach
the ACPI button driver and logind.

Assisted-by: LLM
Signed-off-by: Rahul Pon <theflyingrahul@gmail.com>
---
 drivers/acpi/evged.c | 46 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/evged.c b/drivers/acpi/evged.c
index 5c35cbc7f6..478172ede7 100644
--- a/drivers/acpi/evged.c
+++ b/drivers/acpi/evged.c
@@ -43,6 +43,8 @@
 struct acpi_ged_device {
 	struct device *dev;
 	struct list_head event_list;
+	unsigned int gpio_index;
+	int error;
 };
 
 struct acpi_ged_event {
@@ -76,7 +78,7 @@ static acpi_status acpi_ged_request_interrupt(struct acpi_resource *ares,
 	struct device *dev = geddev->dev;
 	acpi_handle handle = ACPI_HANDLE(dev);
 	acpi_handle evt_handle;
-	struct resource r;
+	struct resource r = {};
 	struct acpi_resource_irq *p = &ares->data.irq;
 	struct acpi_resource_extended_irq *pext = &ares->data.extended_irq;
 	char ev_name[5];
@@ -85,6 +87,33 @@ static acpi_status acpi_ged_request_interrupt(struct acpi_resource *ares,
 	if (ares->type == ACPI_RESOURCE_TYPE_END_TAG)
 		return AE_OK;
 
+	if (ares->type == ACPI_RESOURCE_TYPE_GPIO) {
+		struct acpi_resource_gpio *agpio;
+		int ret;
+
+		/* GpioIo resources are not event sources. */
+		if (!acpi_gpio_get_irq_resource(ares, &agpio))
+			return AE_OK;
+
+		/* The GPIO core applies the GpioInt trigger and polarity. */
+		ret = acpi_dev_gpio_irq_get(ACPI_COMPANION(dev), geddev->gpio_index++);
+		if (ret < 0) {
+			geddev->error = ret;
+			return AE_ERROR;
+		}
+		irq = ret;
+		gsi = agpio->pin_table[0];
+		if (agpio->shareable == ACPI_SHARED)
+			r.flags |= IORESOURCE_IRQ_SHAREABLE;
+
+		/* As for GSIs above 255, GPIO-signaled events use _EVT. */
+		if (ACPI_FAILURE(acpi_get_handle(handle, "_EVT", &evt_handle))) {
+			dev_err(dev, "cannot locate _EVT method\n");
+			return AE_ERROR;
+		}
+		goto request;
+	}
+
 	if (!acpi_dev_resource_interrupt(ares, 0, &r)) {
 		dev_err(dev, "unable to parse IRQ resource\n");
 		return AE_ERROR;
@@ -115,6 +144,7 @@ static acpi_status acpi_ged_request_interrupt(struct acpi_resource *ares,
 		return AE_ERROR;
 	}
 
+request:
 	event = devm_kzalloc(dev, sizeof(*event), GFP_KERNEL);
 	if (!event)
 		return AE_ERROR;
@@ -138,6 +168,8 @@ static acpi_status acpi_ged_request_interrupt(struct acpi_resource *ares,
 	return AE_OK;
 }
 
+static void acpi_ged_free_events(struct acpi_ged_device *geddev);
+
 static int ged_probe(struct platform_device *pdev)
 {
 	struct acpi_ged_device *geddev;
@@ -152,6 +184,10 @@ static int ged_probe(struct platform_device *pdev)
 	acpi_ret = acpi_walk_resources(ACPI_HANDLE(&pdev->dev), "_CRS",
 				       acpi_ged_request_interrupt, geddev);
 	if (ACPI_FAILURE(acpi_ret)) {
+		acpi_ged_free_events(geddev);
+		if (geddev->error)
+			return dev_err_probe(&pdev->dev, geddev->error,
+					     "unable to get GPIO event IRQ\n");
 		dev_err(&pdev->dev, "unable to parse the _CRS record\n");
 		return -EINVAL;
 	}
@@ -160,9 +196,8 @@ static int ged_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static void ged_shutdown(struct platform_device *pdev)
+static void acpi_ged_free_events(struct acpi_ged_device *geddev)
 {
-	struct acpi_ged_device *geddev = platform_get_drvdata(pdev);
 	struct acpi_ged_event *event, *next;
 
 	list_for_each_entry_safe(event, next, &geddev->event_list, node) {
@@ -173,6 +208,11 @@ static void ged_shutdown(struct platform_device *pdev)
 	}
 }
 
+static void ged_shutdown(struct platform_device *pdev)
+{
+	acpi_ged_free_events(platform_get_drvdata(pdev));
+}
+
 static void ged_remove(struct platform_device *pdev)
 {
 	ged_shutdown(pdev);

base-commit: 551c722f40809618230001baccf219193e22fc5a
-- 
2.53.0

