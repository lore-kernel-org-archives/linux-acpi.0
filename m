Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80FE3DC87B;
	Mon,  1 Jun 2026 17:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780334030; cv=none; b=hSPWeshAAND86Lj2OP5p6FCxXROivAWZ4ZcXGzBmgSPCHUNIMQmj+LCdl9wlv88TsGietHR/u7tJXwtbORvyf7cQQnvpmIrARzmCnqnMH3Kv/Yjgdgizr0wyel2GMsIhOXX9NB2O0KIHHqh/uJ8+AE0r3U22AyWywhOrCmvLqZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780334030; c=relaxed/simple;
	bh=Ngd/boM8RValMny0HN42/WDmC2I58FffamD2tbqvARs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=slqAw6i5qVfIRl6UWvoOV8sBGchZhqsWiCZAcnpS1GTPLqcpuhjsb9fatCg+PAhTCywdTSiGEWb3uEGP5LTim/tr7JBQ6vTGjbVLxN9Qoz1mwrDQYmCf6OdznncJSoMgW1FrHe0yjci9wDhgMSkkgCkDmp8uGMm9dgTXKTwBPGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ywecvq3I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ywecvq3I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9ADD1F00893;
	Mon,  1 Jun 2026 17:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780334029;
	bh=U5ZHFKQCYfrvb7rVpJ/PUG1+TFD1RaAnj7HtwGBwfT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ywecvq3IVE6gZ7X0YrGUPYrcRLyO6HZFl/LCknX0yICTV35JSPiNFU19dt0fN7UOL
	 k8yl/BrCj1ALK0m2cnriqjnVl/yiPWll6qLTcRmDjvUz1WdnrxnpHeuaP6pvnadMH7
	 olsZiu+ICNiZPTNK/1nX56HMBqBunylADJI8H30KCQI/7TvJRZgG9+qfKCKxarJn2H
	 3lW29CJpQVw5agb7xHFNlngn/jFv93ARmXmgHIBq0gvj/mrPBqgJIed8Dse4yoVmY2
	 LnOgZAc1g0l0jwSJEGFFZEMnKeML7gU6gGJTTrxbr7MSfYzNHxDiASOZH1grvcPxsc
	 UGIGOP21ZdGFA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject:
 [PATCH v1 04/15] ACPI: button: Use bool for representing boolean values
Date: Mon, 01 Jun 2026 18:58:13 +0200
Message-ID: <2274778.irdbgypaU6@rafael.j.wysocki>
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

Change the data type of the last_state field in struct acpi_button and
the data type of the acpi_lid_notify_state() second argument to bool
because they both are used for storing boolean values.

Update the callers of acpi_lid_notify_state() accordingly and
while at it, remove the unnecessary (void) cast from the
acpi_lid_update_state() call in acpi_lid_initialize_state() for
consistency.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/button.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index d2c2b8105639..21a10da8b60b 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -175,7 +175,7 @@ struct acpi_button {
 	struct input_dev *input;
 	char phys[32];			/* for input device */
 	unsigned long pushed;
-	int last_state;
+	bool last_state;
 	ktime_t last_time;
 	bool suspended;
 	bool lid_state_initialized;
@@ -204,7 +204,7 @@ static int acpi_lid_evaluate_state(acpi_handle lid_handle)
 	return lid_state ? 1 : 0;
 }
 
-static int acpi_lid_notify_state(struct acpi_button *button, int state)
+static int acpi_lid_notify_state(struct acpi_button *button, bool state)
 {
 	struct acpi_device *device = button->adev;
 	ktime_t next_report;
@@ -218,14 +218,14 @@ static int acpi_lid_notify_state(struct acpi_button *button, int state)
 	 * switch.
 	 */
 	if (lid_init_state != ACPI_BUTTON_LID_INIT_IGNORE ||
-	    button->last_state != !!state)
+	    button->last_state != state)
 		do_update = true;
 	else
 		do_update = false;
 
 	next_report = ktime_add(button->last_time,
 				ms_to_ktime(lid_report_interval));
-	if (button->last_state == !!state &&
+	if (button->last_state == state &&
 	    ktime_after(ktime_get(), next_report)) {
 		/* Complain about the buggy firmware. */
 		pr_warn_once(FW_BUG "Unexpected lid state reported by firmware\n");
@@ -279,7 +279,7 @@ static int acpi_lid_notify_state(struct acpi_button *button, int state)
 				  state ? "open" : "closed");
 		input_report_switch(button->input, SW_LID, !state);
 		input_sync(button->input);
-		button->last_state = !!state;
+		button->last_state = state;
 		button->last_time = ktime_get();
 	}
 
@@ -426,10 +426,10 @@ static void acpi_lid_initialize_state(struct acpi_button *button)
 {
 	switch (lid_init_state) {
 	case ACPI_BUTTON_LID_INIT_OPEN:
-		(void)acpi_lid_notify_state(button, 1);
+		acpi_lid_notify_state(button, true);
 		break;
 	case ACPI_BUTTON_LID_INIT_METHOD:
-		(void)acpi_lid_update_state(button, false);
+		acpi_lid_update_state(button, false);
 		break;
 	case ACPI_BUTTON_LID_INIT_IGNORE:
 	default:
-- 
2.51.0




