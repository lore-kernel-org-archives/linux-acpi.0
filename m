Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8540377A81
	for <linux-acpi@vger.kernel.org>; Thu, 20 Aug 2026 03:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787197033; cv=none; b=lVr6QCW9ZpTliTlfS9Hw1NCbcyTdfgCzeKb8NiQV5SBEWOt2chW5/dL2ARrVtp89ngdaEao1/GXpXr73NagTmNPt/vlJ+tPaXC7DKPp302BikSqCvzR0kOK9tq3Cnhc/Md/2vDXOepcaNMLte6P1oQP4kt2VelU/LzRBuOKQ320=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787197033; c=relaxed/simple;
	bh=ofPrnzg+ZXWkEkhbKcspbON3ebrXzoTrIj07Zp2uxtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FdKjZjq9wEgl0Mr2+4ovj1mfVaERQoOTh6kQITBCurR/VNGZSY3e94BBzgaT1BlQDmUFksbpbYC5WF17I0SrO85vUhXiu2QHLQk7MQxvKnw3aol/omia/n4ofEXe/4pdu05vlecBRIlUbb0K1jpHdcdlfPiVq9Bpkm33djnZBo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXcaJpA0; arc=none smtp.client-ip=74.125.227.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXcaJpA0"
Received: by mail-pj2-f3.google.com with SMTP id d9443c01a7336-2ccbff2e6a7so8313495ad.1
        for <linux-acpi@vger.kernel.org>; Wed, 19 Aug 2026 20:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787197031; x=1787801831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SkTtVaUvkrndBFZ8UGOVBPX/3VqVO7aSr6OqB3qIqCU=;
        b=JXcaJpA0fIwEmHxPwhCbPSmpl3zmrdLmbeJ3Kp8A6A76D8gGRNCdTlUJ4+n6VJlUOb
         73cU/V8glpUFO57CHhQJ6ZnNCh2xhxmjwx0qFalqXs0dgKAFLNNVJtliWqwxrD/OrNYO
         kDI50jdOmyTQyfL31LiJ+qo64JhbcZzkhAoqwUJpWLHoQ1B5KEkOiREGM7Ej1B2jq81o
         VFQrFLXj2t6/Re8gM9a2j7QqxxKyXsoA1l3xqkF8gtLbhZNrOBuyDOUT68G36pGFCA31
         o2ilR2/9HrlKJ4USXeqZNGT4PZ5F0+UgxSoGSU8ad+0zLO4yxtEyIR/+1aexauGqG98z
         ZYbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787197031; x=1787801831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SkTtVaUvkrndBFZ8UGOVBPX/3VqVO7aSr6OqB3qIqCU=;
        b=pBryybyjg6xUIJp8WC95OGNDIRW6/3TzmWV15vfUIHGZX4+aVMziJNzlvAHxdKBoF5
         s7F9hTzbOkUjI+RDq+MPTy/0YiuZFnGprywN1buQQpoDXgevUDGlvFyPrvY1+fb5OLZN
         ky9a3ZW4RINdHAJfE3H9CkYvAqy+NIgSKvGW7x6NAm+lKHNy/S2bKvDxSCpSQ9oNTzLP
         VUW4+SrhY5hx0IfTeby2SIk3avolMiFCbuZOuoswU95gYcTeU9ah6GioEYf5ptxTPv9k
         pX9VVmeQid9K2LcQaUj6p0JOzt2ZmpO+G/fi0qJuYxE3hrAC9MGuEET3KM8DBViMrb50
         FUdA==
X-Forwarded-Encrypted: i=1; AHgh+RomjkUjv5odplFHhSddDr13Lds80harOKbxIF3COPKmMpQ39MNs2rm8TDRCyaBz1qVLlIflT4lF1DPz@vger.kernel.org
X-Gm-Message-State: AFuF++kzBz4S1lqN91ZpYAJdXFATsDRPstXLcoF9K/l69Dj2BO/G2sOq
	A5TmrpZOOGofln/IZn2hM4nJLDMh/kmLL9R2FB5FFxQw0uja+orqjaM=
X-Gm-Gg: AR+sD107i6ygwJrYBRdINPD5eCHSxTkNwfvBgzbxHrUt8+wchuCNIoIZ2yuU4f+5s9D
	greoZCN/qr5iG02CTlc+7+c3ORbDfrEauVTX8Nhtlbdy8Lw97fmz84jmVJDFj9W7w0aaAoMLYIs
	CRwD8mqkGRd7WxxvHJAGHeMTI3CzIND/WZyEHLyjhKGx5wgLYt6Y/vigVbS0QpAVuayyP0nRVvd
	wAv0O5yHDpEygAdSvOIRVnhDeHoslBK3G7UyMaKIjREs59vthtyQaAJZZiVM7/kp668Kn3h7Qxe
	J8hYa848LIQicjzyj0oSX1wxR2ERLUZIrykqS/hK/Iz8jR4qEzzpH2byQuIe6+8MhmVl6sml7HP
	Ljj65ss0b4kXvk+2W/ZcEtj8cNhVhj5qLVJW2yDP5AhuFZbrC7e+0kXPVkezQKPZ9L4dh8odZdd
	38jXbrORaRpLnD0LFIKfAKYdPqo77/jyU8dh1CGqqlvWoX8AhHUqT609SgVoyC7N8dmVucIYvvN
	Q==
X-Received: by 2002:a17:903:b4e:b0:2d5:ea01:429d with SMTP id d9443c01a7336-2d60197e7b6mr192855385ad.14.1787197031007;
        Wed, 19 Aug 2026 20:37:11 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62e36e1f9sm1438415ad.43.2026.08.19.20.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 20:37:10 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH] ACPI: button: use DEFINE_SIMPLE_DEV_PM_OPS
Date: Thu, 20 Aug 2026 10:36:53 +0700
Message-ID: <20260820033653.1682804-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the deprecated SIMPLE_DEV_PM_OPS
to DEFINE_SIMPLE_DEV_PM_OPS

Also use pm_sleep_ptr() when assigning the ops to the driver.
This allows the removal of the ifdef CONFIG_PM_SLEEP
and unnecessary forward declarations of 4 functions.

No intentional functional impact.

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
 drivers/acpi/button.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 3836ee75dd66..d4cb942b754f 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -147,28 +147,6 @@ static const struct dmi_system_id dmi_lid_quirks[] = {
 	{}
 };
 
-static int acpi_button_probe(struct platform_device *pdev);
-static void acpi_button_remove(struct platform_device *pdev);
-
-#ifdef CONFIG_PM_SLEEP
-static int acpi_button_suspend(struct device *dev);
-static int acpi_button_resume(struct device *dev);
-#else
-#define acpi_button_suspend NULL
-#define acpi_button_resume NULL
-#endif
-static SIMPLE_DEV_PM_OPS(acpi_button_pm, acpi_button_suspend, acpi_button_resume);
-
-static struct platform_driver acpi_button_driver = {
-	.probe = acpi_button_probe,
-	.remove = acpi_button_remove,
-	.driver = {
-		.name = "acpi-button",
-		.acpi_match_table = button_device_ids,
-		.pm = &acpi_button_pm,
-	},
-};
-
 struct acpi_button {
 	struct acpi_device *adev;
 	struct device *dev;		/* physical button device */
@@ -491,7 +469,6 @@ static u32 acpi_button_event(void *data)
 	return ACPI_INTERRUPT_HANDLED;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int acpi_button_suspend(struct device *dev)
 {
 	struct acpi_button *button = dev_get_drvdata(dev);
@@ -521,7 +498,6 @@ static int acpi_button_resume(struct device *dev)
 	}
 	return 0;
 }
-#endif
 
 static int acpi_lid_input_open(struct input_dev *input)
 {
@@ -753,6 +729,18 @@ static void acpi_button_remove(struct platform_device *pdev)
 		acpi_lid_forget(button->adev);
 }
 
+static DEFINE_SIMPLE_DEV_PM_OPS(acpi_button_pm, acpi_button_suspend, acpi_button_resume);
+
+static struct platform_driver acpi_button_driver = {
+	.probe = acpi_button_probe,
+	.remove = acpi_button_remove,
+	.driver = {
+		.name = "acpi-button",
+		.acpi_match_table = button_device_ids,
+		.pm = pm_sleep_ptr(&acpi_button_pm),
+	},
+};
+
 static int param_set_lid_init_state(const char *val,
 				    const struct kernel_param *kp)
 {
-- 
2.53.0

