Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164A23DCDB5;
	Mon,  1 Jun 2026 17:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780334025; cv=none; b=Tay6z883qOcTN8VWQ/rSmlG4WGLyrdDT26cL6bdwKh6GJ8Hbpa+pCCkBs5IsctVbkA2s5E+qMFOmP5KVyGQeH3YpTkvCYVuXISix4kaUyXwvLLLsJPxR7e4d0lXiiTSQjiEuFhNXztVOXDbmdQe/uWFczcf/XOwdHpS1VmPDzZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780334025; c=relaxed/simple;
	bh=6heZnCkJ6hoPjp+XOp+mtBsRC9g7nFitQ7n0UZxZTnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dXk3GdULOKl/9c4aG4Hji5MT6/PJ4APf4bmDQtKVPyekCpFUqfyQV15B6KNBIPTyxsrKnOqVvmYOetYcnEvppx3jMvj67/d2WwgUYWxeeSzqR42YpN2WrVpFxs7K0CzD7MHVa3tYC1OOrspkabLdCRhjEwKnk6UN6RELUYWdRcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nh5xLn0V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nh5xLn0V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C83B1F00893;
	Mon,  1 Jun 2026 17:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780334023;
	bh=t3shw3KIkgm0O2DC5v+MDgUpYpLboB1/xa8SDvj654M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nh5xLn0VXe3Mm9BJBBoZ3d4v/5p8Wu7N65kdZjSAQggBqxseZLwHt0TC7mPmRQvvK
	 acOJfHuj9ZIeOM4I07EY8qrQadShS3U9pRrySZhkCgaovLDzKP7M6ME5+++r6xI0vt
	 mR5ZiPVLiFQ9FBE+aospTa550t51kDWZp/8Fr69A1Fe1USbNstNV0/9n8Ys1ntxpGu
	 RJSm2lIdkIyhFsIgVeoZAMl50nGzRujXmEvDWk4SSJculLdo3wEyopf3v8dacumoG1
	 3/ycaPwxCsGZtwpztr7EhBeReA4uEmGgHtUL2e4ed+8c8M9S3VAf+JpP7VfAIComJx
	 r+rG0161dVT0w==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject:
 [PATCH v1 06/15] ACPI: button: Change return type of two functions to void
Date: Mon, 01 Jun 2026 19:00:00 +0200
Message-ID: <3429748.44csPzL39Z@rafael.j.wysocki>
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

The return value of acpi_lid_notify_state() is always 0, so change
its return type to void.

Moreover, the return value of the only caller of that function,
acpi_lid_update_state(), is never used, so change its return type
to void either.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/button.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index ae97c83bae2c..fcb2eed823c1 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -204,7 +204,7 @@ static int acpi_lid_evaluate_state(acpi_handle lid_handle)
 	return !!lid_state;
 }
 
-static int acpi_lid_notify_state(struct acpi_button *button, bool state)
+static void acpi_lid_notify_state(struct acpi_button *button, bool state)
 {
 	struct acpi_device *device = button->adev;
 	ktime_t next_report;
@@ -282,8 +282,6 @@ static int acpi_lid_notify_state(struct acpi_button *button, bool state)
 		button->last_state = state;
 		button->last_time = ktime_get();
 	}
-
-	return 0;
 }
 
 static int __maybe_unused acpi_button_state_seq_show(struct seq_file *seq,
@@ -407,19 +405,18 @@ int acpi_lid_open(void)
 }
 EXPORT_SYMBOL(acpi_lid_open);
 
-static int acpi_lid_update_state(struct acpi_button *button,
-				 bool signal_wakeup)
+static void acpi_lid_update_state(struct acpi_button *button, bool signal_wakeup)
 {
 	int state;
 
 	state = acpi_lid_evaluate_state(button->adev->handle);
 	if (state < 0)
-		return state;
+		return;
 
 	if (state && signal_wakeup)
 		acpi_pm_wakeup_event(button->dev);
 
-	return acpi_lid_notify_state(button, state);
+	acpi_lid_notify_state(button, state);
 }
 
 static void acpi_lid_initialize_state(struct acpi_button *button)
-- 
2.51.0




