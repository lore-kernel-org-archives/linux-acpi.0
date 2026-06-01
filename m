Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6203E0082;
	Mon,  1 Jun 2026 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780334039; cv=none; b=ixcryEXQmYNBS/3uzlNOe93QsFKFpwTwVYbp8J2P1VTUOAO4KAaMNZBapo2LnKKLrNmu2z2N1yxYNA1SeRnFsr7/xZWQ603sX3pJjdCP6LQIupHl4QBWLmv0Jz2FAGkvN3AP9kVmeOh2W3+/l1/cUAY7iWjxDhTD3DTkk1khanM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780334039; c=relaxed/simple;
	bh=qiOo8t9G2/IOVbcB1jmmNH5HFv5B/K5M+mT8HC3Pk7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X/NA3j0McH/Wf7GV2/nQ+wHYjYlmmCDlmVHBcuWgC4eK24ZmpwuP1Be5P4vy4umvPDztcM1ZpBFFhxEluL8PyfjWntRKfY3uZfVJMPju6G9zLMQ3ADVmiqmCCqosC2ryfvbI58SCEDO32VVXjo6CNF7q0YGoh6KuA02P0YVd7hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUoW570z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUoW570z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF941F00893;
	Mon,  1 Jun 2026 17:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780334037;
	bh=UVKy8WPYm3SF8XlWZsBsvqpCif2H3Dk6bJc/jgZR5QI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VUoW570z6HfBHnEA5GuU31YMAcg+nVSgbBmMrw86myroMutL+wzoebXty0GgMRG4z
	 psyhuD65wemUZD7k8ZFnNHcN6/zjdnvrntMPsWuc5YFbZS9WrPXhp3jOEcB9uqvFAM
	 k+VhkzWaGUc1uPcoLH3s3tKB5WjpSFPPsK8TWEhVk7q25u+9+MUpw9g3BQk+2sSyE6
	 aq5d/n6qJZWXw7wn4Ubbt2m+Eex7zHJSrSpSGMGK0MjmnNh+zVrby55JtBvy4KMN7u
	 vkXsz8cbAVhzg9dtJD5LMNgpAcN642AK8oqUqrnkrevT+Bm1VM/RoSvk31CozIyiCX
	 6lg2cVjhvzRtg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject:
 [PATCH v1 01/15] ACPI: button: Fix lid_device value leak past driver removal
Date: Mon, 01 Jun 2026 18:55:15 +0200
Message-ID: <6281379.lOV4Wx5bFT@rafael.j.wysocki>
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

Static variable lid_device is set when the ACPI button driver probes
the last lid device (under the assumptions that there will be only
one lid device in the system) and never cleared, but in principle it
should be reset when the driver unbinds from the lid device pointed
to by it.

Address that and add locking that is needed to clear and set that
variable safely.

Fixes: 7e12715ecc47 ("ACPI button: provide lid status functions")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/button.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index d80276368b81..5df470eea754 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -182,7 +182,6 @@ struct acpi_button {
 	bool gpe_enabled;
 };
 
-static struct acpi_device *lid_device;
 static long lid_init_state = -1;
 
 static unsigned long lid_report_interval __read_mostly = 500;
@@ -378,9 +377,29 @@ static int acpi_button_remove_fs(struct acpi_button *button)
 	return 0;
 }
 
+static struct acpi_device *lid_device;
+static DEFINE_MUTEX(acpi_lid_lock);
+
+static void acpi_lid_save(struct acpi_device *adev)
+{
+	guard(mutex)(&acpi_lid_lock);
+
+	lid_device = adev;
+}
+
+static void acpi_lid_forget(struct acpi_device *adev)
+{
+	guard(mutex)(&acpi_lid_lock);
+
+	if (lid_device == adev)
+		lid_device = NULL;
+}
+
 /* Driver Interface */
 int acpi_lid_open(void)
 {
+	guard(mutex)(&acpi_lid_lock);
+
 	if (!lid_device)
 		return -ENODEV;
 
@@ -674,7 +693,7 @@ static int acpi_button_probe(struct platform_device *pdev)
 		 * This assumes there's only one lid device, or if there are
 		 * more we only care about the last one...
 		 */
-		lid_device = device;
+		acpi_lid_save(device);
 	}
 
 	pr_info("%s [%s]\n", name, acpi_device_bid(device));
@@ -696,6 +715,9 @@ static void acpi_button_remove(struct platform_device *pdev)
 	struct acpi_button *button = platform_get_drvdata(pdev);
 	struct acpi_device *adev = button->adev;
 
+	if (button->type == ACPI_BUTTON_TYPE_LID)
+		acpi_lid_forget(adev);
+
 	switch (adev->device_type) {
 	case ACPI_BUS_TYPE_POWER_BUTTON:
 		acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
-- 
2.51.0




