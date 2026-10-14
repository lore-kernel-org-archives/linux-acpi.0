Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86E21FC0;
	Wed, 14 Oct 2026 01:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791942659; cv=none; b=gVXl43bbo7tesnHeFyLbRTPqLOXmTNaFOeMoDCg/WaQt2+YLUYe/JL0h7JLqMlwDEfACJ+ArXf2do41ort9Pj2S5eMKXw3wGdJjkqnvuChPpW6FCzUGxhBV77X7Pt2ZcaVk0/cr1TBx+3MAfoRVAKZMzPhadIUqDoyMuowQOm14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791942659; c=relaxed/simple;
	bh=+B+uyvx9Iw9ATQqOyIU5cndaMT4KyQf+Zz6HrXr9nbw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o/2nEAuXzS4g/WWBAcXW89QzJl4isBieRp11IHzl9rRoGwrnh4Pl364HnHipS/kO1tyqvcfScmyz2wRtmSd42Te8LYHbRWQTW2krOYprNYRHZ6GoUvf3+80FWiNhDBShlvg60oY5HUm0fpJ+j4BafzcjImIfI8Ju1t/HTjWkZ0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=acNEavqO; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="acNEavqO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=kw
	rMt3W8ZV1DNCUMW2T5/dYRmEwoznw1MEYsa+uUAc0=; b=acNEavqOH5qKArs3Qc
	r/1oE5mrHTFAARCvOUAObQGDeYME6fDwQ0aAeD3HUnuCHzpLclqYgpZY8iYPpuiq
	74G8zrMIqlmcsyP7WWikpPlOAheZQLwOF81skGNCVSfa06RaxEs1VEdjnBONUz0m
	ytlREP1A2e/Qp3DKYEdYqIIAM=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDnIMPr385qTgZdEA--.54482S2;
	Wed, 14 Oct 2026 09:50:36 +0800 (CST)
From: liujinlong176@163.com
To: rafael@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liujinlong <liujinlong@kylinos.cn>
Subject: [PATCH v2] ACPI: button: Evaluate _PSB to determine power button state
Date: Wed, 14 Oct 2026 09:50:34 +0800
Message-Id: <20261014015034.2248352-1-liujinlong176@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261013063856.1755787-1-liujinlong176@163.com>
References: <20261013063856.1755787-1-liujinlong176@163.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgDnIMPr385qTgZdEA--.54482S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJFy7urWkAw4ftrWfWw18Grg_yoW5Wr4Upr
	Z8KayS93y5Kan7X3Wavr1UuryYk34xKr15GrsrAa4fZa15WryrArZrtryjva1UC3s2qa1q
	qa1DtFs0kF4UA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jozuXUUUUU=
X-CM-SenderInfo: xolxyxxqor0wqrxwqiywtou0bp/xtbC5wyBlGrO3+x89gAA3j

From: liujinlong <liujinlong@kylinos.cn>

The ACPI button driver always synthesizes a press followed by an
immediate release upon receiving a 0x80 notify.  This prevents
userspace from determining the actual duration of a power button
press.

When the 0x80 notification is received, evaluate the _PSB control
method if present.  If _PSB returns 1, report only a key press; if
it returns 0, report only a key release.  If _PSB is not available,
fall back to the existing press+release behavior for compatibility
with firmware that does not implement it.

Signed-off-by: liujinlong <liujinlong@kylinos.cn>

--- changes in v2:
 - Dropped the new ACPI notify values 0x81/0x82 per Rafael's
   feedback, as they would require an ACPI specification update.
 - Instead, evaluate the _PSB control method upon receiving the
   existing 0x80 notification to determine the real button state.
 - No longer touches include/acpi/button.h.
---
 drivers/acpi/button.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index cdbb1023a8ee..2d079703899b 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -456,12 +456,25 @@ static void acpi_lid_notify(acpi_handle handle, u32 event, void *data)
 	acpi_lid_update_state(button, true);
 }
 
+static int acpi_button_evaluate_state(acpi_handle handle)
+{
+	unsigned long long state;
+	acpi_status status;
+
+	status = acpi_evaluate_integer(handle, "_PSB", NULL, &state);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	return !!state;
+}
+
 static void acpi_button_notify(acpi_handle handle, u32 event, void *data)
 {
 	struct acpi_button *button = data;
 	struct acpi_device *device = button->adev;
 	struct input_dev *input;
 	int keycode;
+	int state;
 
 	switch (event) {
 	case ACPI_BUTTON_NOTIFY_STATUS:
@@ -482,10 +495,18 @@ static void acpi_button_notify(acpi_handle handle, u32 event, void *data)
 	input = button->input;
 	keycode = test_bit(KEY_SLEEP, input->keybit) ? KEY_SLEEP : KEY_POWER;
 
-	input_report_key(input, keycode, 1);
-	input_sync(input);
-	input_report_key(input, keycode, 0);
-	input_sync(input);
+	state = acpi_button_evaluate_state(device->handle);
+	if (state < 0) {
+		/* No _PSB method, synthesize a press+release */
+		input_report_key(input, keycode, 1);
+		input_sync(input);
+		input_report_key(input, keycode, 0);
+		input_sync(input);
+	} else {
+		/* _PSB returns 1 = pressed, 0 = released */
+		input_report_key(input, keycode, state ? 1 : 0);
+		input_sync(input);
+	}
 
 	acpi_bus_generate_netlink_event(button->class, dev_name(&device->dev),
 					event, ++button->pushed);
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

