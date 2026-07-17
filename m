Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732C23AF64F;
	Fri, 17 Jul 2026 23:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784329891; cv=pass; b=Y4QiScHf5U9u68OaMtGDcWb+H+HYagPhnpX7y3lBV/HazIXqwMNBEfgjChFn9oaFAs1lFr+tKuau/nxHZITFIbdV6fquXt9qMjjoTGgRlu3dTT/00xtsj9qxP8PBE4RpKQEkBzVgx2XcZjY9zrI/94hAbulU7PqekbyA7EXzXrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784329891; c=relaxed/simple;
	bh=flynSxm0F9vG14eV7QFBlYm5P6X39dVJxCUZVPEmb7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PDd0LccDfCGkYJQo9ACu577+aK/lSqlJ3GUXA5cGiyQ6KfT4MGJ9xwn3cFEbB/u0oLozJR8oaXuPGgpAStixnvASDgHVd9vSxOzzKzou399q+gSJkNgmzGr5jLRWaVA4c3HTEye+FAlTnsDYUSWD3KvLM0fBKfYwOFzRm8lwta8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=MXW8BHkY; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="MXW8BHkY"
ARC-Seal: i=1; a=rsa-sha256; t=1784329855; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=irbs9ZJBzyDNsSPfqhv+W50+7kqaEs0FB8OWsQNWFWSK3AW3wUFJCP1SoREIGxcd1qverHxZS53NW5JwmXm3iaHd5En3YsY2cNkTQ7yoFX/ZFslHwQOWZM/qoN8uIcZ69dKFeWjiGPQunbbiwx4wo3yZBVc/UfjDeum6NHFHTv8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784329855; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xpF/qpi/SnA6F3Ft/nufv4BuYqGks84R6qq9ciJTc48=; 
	b=Z4uPxdjfpczLQyVdjbXSxVoJ1bPmcZ1K7LbhQfmUNvzMxkPY62fxcdoJhKksJ1znlkqFALVfFYfA1v7HTjbgqQb1ol0PmFdbUe+h71EzGAilxuBjzouoOYK4io2VtDNaU3qOb6aki1HaPeucKuXzWkMwfBIuqsnc6MqZfvlJTks=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784329855;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=xpF/qpi/SnA6F3Ft/nufv4BuYqGks84R6qq9ciJTc48=;
	b=MXW8BHkYvrJPiFuL2QIXm/GXZpcuQh5Acvgf834wgt4vc1U4/NIsF2Z11W8Cu9ff
	is5t4deBMnLOgVcZZOWZZsHlQlfzUdUWWZlzqp9OKdX74c4/JA5zplQE7UtiafVx4jk
	FhsFEgXkfgqI3C9TdQqz+94d6v7edEAII/IVKBejOXQug1eo9PmbTa54GSVuE8wIzFp
	fdu2KhAK2hwBZooVt/5atOzX9owwNT/p9IYns2A8RLBV28CHFxaBccCZ6I1e50mr7dD
	+6FD2wa50z/rUxxMmFHL9iBkJ/n6bxJJ4E2yfxzz5p2vv4dDIde+2Jfon05jBm2d7wG
	stw2ypkSaQ==
Received: by mx.zohomail.com with SMTPS id 1784329851681899.8125394572486;
	Fri, 17 Jul 2026 16:10:51 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
Date: Sat, 18 Jul 2026 07:10:20 +0800
Subject: [PATCH v4 2/3] ACPI: battery: Use kstrtoul() over sscanf("%lu\n")
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260718-b4-acpi-battery-notification-v4-2-599c8ed1072f@rong.moe>
References: <20260718-b4-acpi-battery-notification-v4-0-599c8ed1072f@rong.moe>
In-Reply-To: <20260718-b4-acpi-battery-notification-v4-0-599c8ed1072f@rong.moe>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 Avraham Hollander <anhollander516@gmail.com>, 
 =?utf-8?q?Jeffrey_W=C3=A4lti?= <jeffrey@waelti.dev>, 
 Rick <rickk1166@gmail.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rong Zhang <i@rong.moe>
X-Mailer: b4 0.16-dev-4217c
X-ZohoMailClient: External

It is more preferred to use kstrto*() to parse a single number. The
function family properly returns an errno on error and is the correct
mechanism to parse data from sysfs.

The number base is set to 10 in order not to break the ABI.

Tested-by: Avraham Hollander <anhollander516@gmail.com>
Signed-off-by: Rong Zhang <i@rong.moe>
---
Changes in v3:
- Address Sashiko's concerns on my last-minute changes:
  - Set the number base to 10 in order not to break the ABI
  - https://sashiko.dev/#/patchset/20260611-b4-acpi-battery-notification-v2-0-4e8ed651a151%40rong.moe

Changes in v2:
- New patch in series
  - Since the series touches acpi_battery_alarm_store(), also convert
    the use of sscanf("%lu\n") into the more preferred kstrtoul()
    beforehand
---
 drivers/acpi/battery.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 8b26962745bd..bd7fa93ff16f 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -675,9 +675,13 @@ static ssize_t acpi_battery_alarm_store(struct device *dev,
 {
 	unsigned long x;
 	struct acpi_battery *battery = to_acpi_battery(dev_get_drvdata(dev));
+	int err;
 
-	if (sscanf(buf, "%lu\n", &x) == 1)
-		battery->alarm = x/1000;
+	err = kstrtoul(buf, 10, &x);
+	if (err)
+		return err;
+
+	battery->alarm = x / 1000;
 	if (acpi_battery_present(battery))
 		acpi_battery_set_alarm(battery);
 	return count;

-- 
2.53.0

