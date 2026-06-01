Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C62396B79;
	Mon,  1 Jun 2026 17:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780334014; cv=none; b=nRcUGsAQd2cGQmFemMiv+fyRKrDCYrxX1ekCJtNS6e+i3YhhlyM+9GqxIGofme/P/LJ4ABB5ptTNw7arss/bfwCDnfJ/yVgEbg9dqrYem2L//td/MgJGut8YXjGhstHyGQ9A+xdQ0CjU6ySEjtPbFwzvxn8ImN9eDJ7e9UPKO9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780334014; c=relaxed/simple;
	bh=4a4KzAiDmo2R5Jpu2eX5evcJtptUf6M3JRS447Dh7rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hxjwcKvO8MhtsfXUaa/oYc63c3G9zf5wS2U1yN6f3ZC0iYCm+Ag8OTdjmpWcJquc81KGLEeWZJS6bhro+Xqoq+0Lpt1EigqGRvtAqaEDQw5S9C1vExzsYjZkpxPztQS9PFtQxYSGhuzEFTNuEtZwTbNgi4ZJVKItwr0bDQEGYK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXDI4q9B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXDI4q9B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF781F00893;
	Mon,  1 Jun 2026 17:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780334013;
	bh=BQ7Ub65iNB71AuffK0TYH+3OwIMSOKbsflFiIEw5qiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZXDI4q9BCa9gp62v9h8IYpLNFtUw4l+xM/uiD9XPkfjTWNBFW+pi3JRsD0ZPhBUYl
	 dPqSpKHGL1QE3kgzUQ6A5fVO/YwDl1HWY3TpMqfhvVdWmH838iQmJ+OO9d5X7fBidy
	 yS2mybgNXR8DrSDIm4EWocAC8Q1TAMhBmZo8e5cscTF2D4kFC/sgyXaN7XubRHtcOp
	 SiAcVmH2/HknZnNkt9CAXgducS7fu8XYOBR1j5KK4g/PIwtdP291eGESAdy1o+2WNu
	 +c724PXU9cXoQwPsiTCrfs1QZWbIk7zDNIoxYsvNiHP9nAtgD6gVRgIijthokYJ7Wp
	 vXLfRA2FZO8cQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject:
 [PATCH v1 10/15] ACPI: button: Drop redundant variable from
 acpi_button_probe()
Date: Mon, 01 Jun 2026 19:04:04 +0200
Message-ID: <3706239.iIbC2pHGDl@rafael.j.wysocki>
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

Local char pointer called "name" in acpi_button_probe() is redundant
because its value can be assigned directly to input->name and the
latter can be used in the only other place where "name" is read, so
get rid of it.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/button.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index dbaf87417428..f0d29870b926 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -548,7 +548,7 @@ static int acpi_button_probe(struct platform_device *pdev)
 	struct acpi_button *button;
 	struct input_dev *input;
 	acpi_status status;
-	char *name, *class;
+	char *class;
 	u8 button_type;
 	int error = 0;
 
@@ -581,23 +581,23 @@ static int acpi_button_probe(struct platform_device *pdev)
 
 	switch (button_type) {
 	case ACPI_BUTTON_TYPE_LID:
+		input->name = ACPI_BUTTON_DEVICE_NAME_LID;
 		handler = acpi_lid_notify;
-		name = ACPI_BUTTON_DEVICE_NAME_LID;
 		sprintf(class, "%s/%s",
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_LID);
 		input->open = acpi_lid_input_open;
 		break;
 
 	case ACPI_BUTTON_TYPE_POWER:
+		input->name = ACPI_BUTTON_DEVICE_NAME_POWER;
 		handler = acpi_button_notify;
-		name = ACPI_BUTTON_DEVICE_NAME_POWER;
 		sprintf(class, "%s/%s",
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_POWER);
 		break;
 
 	case ACPI_BUTTON_TYPE_SLEEP:
+		input->name = ACPI_BUTTON_DEVICE_NAME_SLEEP;
 		handler = acpi_button_notify;
-		name = ACPI_BUTTON_DEVICE_NAME_SLEEP;
 		sprintf(class, "%s/%s",
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_SLEEP);
 		break;
@@ -615,7 +615,6 @@ static int acpi_button_probe(struct platform_device *pdev)
 
 	snprintf(button->phys, sizeof(button->phys), "%s/button/input0", id->id);
 
-	input->name = name;
 	input->phys = button->phys;
 	input->id.bustype = BUS_HOST;
 	input->id.product = button_type;
@@ -690,7 +689,7 @@ static int acpi_button_probe(struct platform_device *pdev)
 		acpi_lid_save(device);
 	}
 
-	pr_info("%s [%s]\n", name, acpi_device_bid(device));
+	pr_info("%s [%s]\n", input->name, acpi_device_bid(device));
 	return 0;
 
 err_input_unregister:
-- 
2.51.0




