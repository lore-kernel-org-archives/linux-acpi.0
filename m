Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F833DCD8B;
	Mon,  1 Jun 2026 17:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780334022; cv=none; b=cfVV1HQz4m7YOSTDzyJHflnydQQLXdVzGIXMaqwkD66HZKKpzfWzSGetXPTOy/ynyQVj/+OinoxzlILNzPYocAxbKZ2dfrHL4sc8zS7DvxzBjDJcOiPQCB7hdpPHWrkHS3GnbgUzvkdqfyJOrdA7MjOYUVhpTr8x/gOiDsOZhbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780334022; c=relaxed/simple;
	bh=/N23oGigGm9vo+HgLqqvVysgD++wG00nIhDemSIGkO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DuJYjs2aBNeiMPAJhat4z2b8dAjs6xAAVmkhzpsExT3j3w8AB6asqTo6GN9C/y1uJ2aytkCNFvNbhzWSyrRXQKEcZHfwA8jUJRUfofmXBt9zGSQC3FfLOJiBZykqztttRzNADp0ZPZZ5dfzgfSoznCTAAUycp1oJfjGRTYyLB3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTuDcGVr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTuDcGVr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3A71F00893;
	Mon,  1 Jun 2026 17:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780334021;
	bh=YJihLsFA6R1rMMbc3HAx8HYPIWdDu6sJDuCiCrhybfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MTuDcGVrRhCWPPPFJ7hLrOQ17ZzIuvygt8TLLypodng28ULLnRAiKdLjiOWDM9p3b
	 pkssGcnquQ0BjlXhiBE/g2KXYYmb+x+VVCay7VsWZfcYLcECj1yVivi4g0YfMXtdK/
	 rFnD4gUWyQVdyfoemc7JbdS90pspzKgWW2e1UswpoGh0ExgnmP3sqVdawp69Qaao/c
	 GLuT0d3Yu7v8ea0K6RPPtE9QbAKg1dt4S4KKEFnVdVEHQJr6fOj8OPU8/G1spvdUvz
	 Tsoc17uKOUtJQO+hTA+rLLg0xtyaQEmKGAu+IWv/x45l/ZUsjTekg2tr6f6Fh5aw6r
	 IB+5yVGNuke0g==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject:
 [PATCH v1 07/15] ACPI: button: Eliminate redundant conditional statement
Date: Mon, 01 Jun 2026 19:00:47 +0200
Message-ID: <10868292.nUPlyArG6x@rafael.j.wysocki>
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

Simplify do_update initialization in acpi_lid_notify_state() by
assigning the value of the condition it depends on directly to it.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/button.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index fcb2eed823c1..236eb025bb0d 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -217,12 +217,8 @@ static void acpi_lid_notify_state(struct acpi_button *button, bool state)
 	 * So "last_time" is only updated after a timeout or an actual
 	 * switch.
 	 */
-	if (lid_init_state != ACPI_BUTTON_LID_INIT_IGNORE ||
-	    button->last_state != state)
-		do_update = true;
-	else
-		do_update = false;
-
+	do_update = lid_init_state != ACPI_BUTTON_LID_INIT_IGNORE ||
+			button->last_state != state;
 	next_report = ktime_add(button->last_time,
 				ms_to_ktime(lid_report_interval));
 	if (button->last_state == state &&
-- 
2.51.0




