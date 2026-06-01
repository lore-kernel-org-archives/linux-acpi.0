Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A40F3DC4D9;
	Mon,  1 Jun 2026 17:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780334011; cv=none; b=rfyBBQqFG6RCL9CaVwzzZWs2akRItvUi1jiRTecngpPcVhIstQTb9LeYEGabjOYpboG7XVFTjCjUrMVl5FvwEQwd3wXXRFR0G+fgz46b9T4bsThOLsJe7hNRFcuf//VIIMORN0Gw17tjaVXjG6+C8Uzm80m1FSiKlVrXdfli5Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780334011; c=relaxed/simple;
	bh=rRx3Ke8RmZARHzmOYFdNzPU89q4tzEbE7QtNKY5lNmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ESoSUE7ZWudKEIIzPRNQ/D7h0qTiJMaggZXCj8RbqMlAmhXeuSOPKZFQYytlV2P+dq01fujQSUpYC5WuI5V7xbLiJerVO0j9qGhdB90A1bKkx1E4Ll6Uw70Tel9g1xv3pzxh5985t0Xo46PhbRUTikkJniQBt+M/ZzKquK5Fg8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epDpjTNi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epDpjTNi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BCE01F00893;
	Mon,  1 Jun 2026 17:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780334010;
	bh=Z5kqv+SyVMLmDm6gopCUpp/tbBvkp+WyEsx3oa+vAj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=epDpjTNialsjVzF8I6MM1n0N4uWJkx7cTaVcDeNqajdi/Blp/6tR6PuT73ZTSsmJZ
	 PJd+9MC/vahUve7zF2oOwfyKHfXjp/8tPRYweUGe15Ws13BT1tCtSQ+h+DmILdAGvy
	 nPMn1NKdWfT8YW0UI+OKP0Qi61U6e3cvbNX/Ak85LIQnwZpH7JX1lqQZkHhHlrzUJD
	 /kGwhAS2aau0pVGJPvvMdVqsswFUtUS4gFFlMbfg8Zhzi/28cjkUHcpFPRUFbBupSc
	 RMNzH2Ut99hpmjVOfswweHWzhH3RueedEXWJ116y3MdF5S1yFcz7LwY7mb09T2yLiW
	 9pDCP8+fA99Vg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject:
 [PATCH v1 11/15] ACPI: button: Merge two switch () statements in
 acpi_button_probe()
Date: Mon, 01 Jun 2026 19:05:31 +0200
Message-ID: <3352815.5fSG56mABF@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12913564.O9o76ZdvQC@rafael.j.wysocki>
References: <12913564.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Two switch () statements in acpi_button_probe() operate on the same
value and the statements between them can be reordered with respect
to the second one, so merge them.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/button.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index f0d29870b926..c035741e5abf 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -582,14 +582,19 @@ static int acpi_button_probe(struct platform_device *pdev)
 	switch (button_type) {
 	case ACPI_BUTTON_TYPE_LID:
 		input->name = ACPI_BUTTON_DEVICE_NAME_LID;
+		input_set_capability(input, EV_SW, SW_LID);
+		input->open = acpi_lid_input_open;
+
 		handler = acpi_lid_notify;
 		sprintf(class, "%s/%s",
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_LID);
-		input->open = acpi_lid_input_open;
 		break;
 
 	case ACPI_BUTTON_TYPE_POWER:
 		input->name = ACPI_BUTTON_DEVICE_NAME_POWER;
+		input_set_capability(input, EV_KEY, KEY_POWER);
+		input_set_capability(input, EV_KEY, KEY_WAKEUP);
+
 		handler = acpi_button_notify;
 		sprintf(class, "%s/%s",
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_POWER);
@@ -597,6 +602,8 @@ static int acpi_button_probe(struct platform_device *pdev)
 
 	case ACPI_BUTTON_TYPE_SLEEP:
 		input->name = ACPI_BUTTON_DEVICE_NAME_SLEEP;
+		input_set_capability(input, EV_KEY, KEY_SLEEP);
+
 		handler = acpi_button_notify;
 		sprintf(class, "%s/%s",
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_SLEEP);
@@ -613,28 +620,14 @@ static int acpi_button_probe(struct platform_device *pdev)
 		goto err_free_button;
 	}
 
-	snprintf(button->phys, sizeof(button->phys), "%s/button/input0", id->id);
+	snprintf(button->phys, sizeof(button->phys), "%s/button/input0",
+		 acpi_device_hid(device));
 
 	input->phys = button->phys;
 	input->id.bustype = BUS_HOST;
 	input->id.product = button_type;
 	input->dev.parent = dev;
 
-	switch (button_type) {
-	case ACPI_BUTTON_TYPE_POWER:
-		input_set_capability(input, EV_KEY, KEY_POWER);
-		input_set_capability(input, EV_KEY, KEY_WAKEUP);
-		break;
-
-	case ACPI_BUTTON_TYPE_SLEEP:
-		input_set_capability(input, EV_KEY, KEY_SLEEP);
-		break;
-
-	case ACPI_BUTTON_TYPE_LID:
-		input_set_capability(input, EV_SW, SW_LID);
-		break;
-	}
-
 	input_set_drvdata(input, button);
 	error = input_register_device(input);
 	if (error) {
-- 
2.51.0




