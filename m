Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3F7374E6F;
	Wed, 10 Jun 2026 19:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781119367; cv=pass; b=RgHJWJQwa/DmkNfe5CSI+TLBsaIEUkw3MoE3yksnmaMQplAzxau8xChTJia7Q7MOHO3OG9/E9uFR3UeR+HQZAnJuPvDfK5Fg5+NTflRAcDX3+Hbe/4Ev3s3crh2JgqFG6p+aGqa3AJAONeKTGX4FO/qgaURrmBN2ALB23Io578c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781119367; c=relaxed/simple;
	bh=qWYBSAeyNxNEb35SvrTk/wComq8xIjJFLQIYeWO7NcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rI0haJTeZtRV44BhetmC5is11NXmJe7JUK7m5hSGPVMdAAT0ITVLC/b4PQV5PeRrxwGkNTeuNHzBGfefA3bwMIShkXb0CAB5L9hQdUSlM3PZ4fNiIUVHFDhMIborGSEdEYbeubeYJ7bQNNfwx7CgTr4AusDw8B9JVq/anJfg7zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=gZT8jBri; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="gZT8jBri"
ARC-Seal: i=1; a=rsa-sha256; t=1781119355; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=h3sV+d/54znc3qj+bdVDK/Yf47VHqt/lqF/OKG4PLNa+0tWYrgumtQ/GeAWJNH8RoWj8EZcGoE9Pd1nN7/4A1KDR4ZBF5ZtLCEeuRD953Q1wh8y4fb1De1OPMaKWMNi2WcF9nWeHTPLuZJ8SSG/WXZmzdarl8xd9FZN+6E1e/0U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1781119355; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6G1CqWzgCdyZFnklQSec/iW/SpcG0NqOm3TReU8XFlM=; 
	b=VlNWCHnByS2UH0fwy2VQYGnOTPOYqVHo2fgchsiCbnRysatzdMs286uIddRqRlMQIw5SuMI107EoDkXtmiqHilOe7CSzXYBmUbfob5AUr09bBtPyKXibT0xrkYbaymOgsREvU0/NY5H6uWFMvULkxtljvtbhpwR1gPJJY/xzYUQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781119355;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=6G1CqWzgCdyZFnklQSec/iW/SpcG0NqOm3TReU8XFlM=;
	b=gZT8jBriOhAQVMhZjZjSRmeWqRllekVWOSDNb1lx5BqTio65TOw/ufBWs6MdviI+
	ElHdCiSpH03HbaT3tc62D6EQ2OFZypN+kdC1xG74/cYcJgM3GnW3otasZ+Y4TiFpE0h
	QuIzbE3qj1Bv9hh2LP1iaUjboEdDX77Sxhkqr5rHGaZBFgEuuGzof4o1Y+z/q5cV60Y
	hoGLRNKyOLWjD/vozKyX0YfwkGnKVIEvc20ycIzWf+SaAsytFNM20fmZoV+8rrG4D/b
	nVLUdj43NNYcn7ZvgdIZBOeku9CvYwrmABGag8nw12qg+vMmxUeQvPQ5v8NRlyxwbBm
	yM67I6waAw==
Received: by mx.zohomail.com with SMTPS id 1781119352872205.8190643934231;
	Wed, 10 Jun 2026 12:22:32 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
Date: Thu, 11 Jun 2026 03:22:18 +0800
Subject: [PATCH v2 2/3] ACPI: battery: Use kstrtoul() over sscanf("%lu\n")
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-b4-acpi-battery-notification-v2-2-4e8ed651a151@rong.moe>
References: <20260611-b4-acpi-battery-notification-v2-0-4e8ed651a151@rong.moe>
In-Reply-To: <20260611-b4-acpi-battery-notification-v2-0-4e8ed651a151@rong.moe>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 =?utf-8?q?Jeffrey_W=C3=A4lti?= <jeffrey@waelti.dev>, 
 Rick <rickk1166@gmail.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rong Zhang <i@rong.moe>
X-Mailer: b4 0.16-dev-d5d98
X-ZohoMailClient: External

It is more preferred to use kstrto*() to parse a single number. The
function family properly returns an errno on error and is the correct
mechanism to parse data from sysfs.

Signed-off-by: Rong Zhang <i@rong.moe>
---
 drivers/acpi/battery.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 5f476c074c68..40b67e12d115 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -675,9 +675,13 @@ static ssize_t acpi_battery_alarm_store(struct device *dev,
 {
 	unsigned long x;
 	struct acpi_battery *battery = to_acpi_battery(dev_get_drvdata(dev));
+	int err;
 
-	if (sscanf(buf, "%lu\n", &x) == 1)
-		battery->alarm = x/1000;
+	err = kstrtoul(buf, 0, &x);
+	if (err)
+		return err;
+
+	battery->alarm = x / 1000;
 	if (acpi_battery_present(battery))
 		acpi_battery_set_alarm(battery);
 	return count;

-- 
2.53.0

