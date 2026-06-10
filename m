Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A78384CEA;
	Wed, 10 Jun 2026 20:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781122279; cv=pass; b=Ygrql4MoPkd2K5N/Fr/OTX8G9HLTfkWeznstLu0uTtxoPj/hJKUYiqitlBkeVpIvIUPqMdM9/tzIyZGBJd56GmFs8kGd1OVuPxxVlEjNaoiZIFSvVDHEnyuaw6ijMqxJ893yRHZlJcIHmQ+ppUVUlJbRJMRNUhCi6JaJgB2TNRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781122279; c=relaxed/simple;
	bh=d/8aHu3sOJeRz6iy8fO/Ubrl6UiRR25wB9WPg43gakw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pNkhlBtF4BF3rS4U70Rsi42rk7+oev6paSX8muF6DI65O/mhHQilhZgY8vxl1ETv073Zvh84jjoYd6bcOrPejgN2HxuUgpQYl/eKkg7Z+lNRI8flPH/XKDiCBdM01VKjJzhLA7cvOB0/0iItaTevtsy2zNKLfNH9VYP1iFzOkM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=i3T1KDU6; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="i3T1KDU6"
ARC-Seal: i=1; a=rsa-sha256; t=1781122263; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jPolyxcizboKJoo+Z6IHDEHoYnA17uC/ILRfWDP+MN0iGd0TB0cYbYm7KMYitxj+ku+lMOO4noRextJtXrAa7NijiaAlO4GRsAdw/hnv6pFCR49DZ3AMpywkYNuNIvo7NNEdm59JV7R4b0EVOGdrlh6dEtgYWeYyshx0gBUT11Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1781122263; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=04pSwxHf+BNdMK+E7EF7iXIOB+o8V8MxaPFUMQsDMXU=; 
	b=jipfKYhax/sHBkPsbSB6xtanZhAUj2CizPsp3Iup4DsR92JRFUKiNkj8q68zx+mKVdvVnf3CHjWrjqCkGfD2QF4kdEnoXrR3phS5H/5gZ0zc9QzwCctTavHt3xrTrCafHR4sSjjYAqTBkBNONe3+grlZIuGTE92ZaVXAcE3VMvc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781122263;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=04pSwxHf+BNdMK+E7EF7iXIOB+o8V8MxaPFUMQsDMXU=;
	b=i3T1KDU6UwnUErqyWA4TmXV0CkuZV1KDtFh6fSzpFxqmdPpE+P+gd3p7zbo8OHAK
	qoWGqKAb1f+n5HHGHNSxQ+zpZd31qz7u0qGPRH+jkSB+rEDIUpWyhXKbbxBeEdexA4W
	JM7+MrT2cH/EkQvLDkf6e5a7HYcXhV91+F6MD9mMCcwZRVutSMxS3fRT3LWi8PC7vi5
	Dj1vxcNKGWIfugnDXOPXWAh+PkXaBk2jzBCZkLRwvkbndQwiF5LtdwxmV49iXDivUM5
	okXV//664Xew3DK+DA2IBoFX+8vCAcwf0EwDoOUvrEOeLBL9DzwahCT3zQ4XCD31zel
	aMFBJA5g/w==
Received: by mx.zohomail.com with SMTPS id 1781122261034198.5783134596877;
	Wed, 10 Jun 2026 13:11:01 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
Date: Thu, 11 Jun 2026 04:10:45 +0800
Subject: [PATCH v3 2/3] ACPI: battery: Use kstrtoul() over sscanf("%lu\n")
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-b4-acpi-battery-notification-v3-2-f9390382c5a4@rong.moe>
References: <20260611-b4-acpi-battery-notification-v3-0-f9390382c5a4@rong.moe>
In-Reply-To: <20260611-b4-acpi-battery-notification-v3-0-f9390382c5a4@rong.moe>
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

The number base is set to 10 in order not to break the ABI.

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
index 5f476c074c68..68b7a48357b4 100644
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

