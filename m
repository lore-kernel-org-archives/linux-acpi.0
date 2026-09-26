Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210BE2AEE1
	for <linux-acpi@vger.kernel.org>; Sat, 26 Sep 2026 13:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790429136; cv=none; b=nGovsFfLF71VqrOEai+2gYwh+Bupi8A6O9cIlpn4t45lkow1NqGmPYUMmuB4FuM/yz/As51To1oBwiE7YWK/PG6vgesn7YkKdZR+WSmfq6Lp763xMVWkDehAjzJ3gM5Oe/6ldAIsi0PgTSS5w3Nt7fclEApQHTGsZ8eBNO8Rgro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790429136; c=relaxed/simple;
	bh=h++JxUoiT79qLtfzaUJKt0vl4kQpI0eEtljsYu158ig=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=GFC3O6lhZPpDG0awSk1yr8gh0GHlgEWboFXFYe0jqCmJP0LIRsKMgFXWXjXpCQCJchVNiqfhS6pJzEddDwlLZIWQhy1qxfaCcfNc7mzJpyHtgbo5C9oXYrT+A2mWuqmM/4ysxw/L6BrOI0OFbHAHmqAMsDl6426X63pCSahv0v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jH4uDbcp; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jH4uDbcp"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f63546c5so1448912f8f.2
        for <linux-acpi@vger.kernel.org>; Sat, 26 Sep 2026 06:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790429133; x=1791033933; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:subject:from:to
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LOZ9gIso2IWRspMbFidmgoNekkhNnEACrO3NY9FMDeI=;
        b=jH4uDbcpIyTY6rwC8xhA1eAtrO1TeVR4WMkl55jNWhGCh3fYBwVwdR0JznWcxG3wiY
         5RMj8Tq/PXKABpLzfzYu+y/urjTu+9SPluVIYA0KhuwXrSYd37ZVh6pyUavya0ekzPO1
         l2jsHh745EkXekgUZLJS+orHfH+kMg+hJbB6c8JJjmMr1BelDtrtGPkA66x3Br7/EXxF
         30/qY3HqWi70qsujYQnZaM7vv3OE6lJ/trbrQ1ugCDZDChaK7R44eo1nAIQ23Bd6Vsjp
         UVXfCDEpjxp88NOfHAMDOY8RaS6AYfNY8hGheMv+krtryVyyMFXdz2kids94qUNtThLx
         2U5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790429133; x=1791033933;
        h=mime-version:content-transfer-encoding:content-type:subject:from:to
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LOZ9gIso2IWRspMbFidmgoNekkhNnEACrO3NY9FMDeI=;
        b=2niz3eNdEWJg7pPAmdJvD8bZZbcGnbF+oLcYRt5jaQ/2DhXJnuOOb/ue+7JddISlYv
         gHnpTLZukHZ4ePdiEdkJDzL+jASNnZ+rf84aMlIyO2/++7wdqlqh+KMZEb/l9HibH+yB
         2Lp7tN2STYptwZocktJH2sm9/zhvE+YaBMritcMq/s3UlxToO6JFF7RvZCBf2PpSaAF4
         ga4xAHdktmSz/7SdAHWbuTJJSVro05yQuj0TB40JYXnBZH8oOewXI08k4mSUscOWiwYu
         WYsLIECGHzUi9zO6csnhpnCXGkyK/O9YnKZrY9hoPu1Wqelskthr1YOaQriVIfWaCLDs
         OE9w==
X-Gm-Message-State: AFq9FYLufkStafFxzQ+lxNkwATX0OFmuJgPxBzy6TTKHX/PFJFiKHbMS
	zSQ24U0cT/eJKsmJjHo5SI2Re8+CJsykJa5GBMF+eTuAl9UhPVjjEEIhE/OcCw==
X-Gm-Gg: AYBFou2Bh093E0tooXgzkfKcZOZRQuHAh8tTaAO7KPGs+ipWAMojOHof+VEdFm7d/ui
	V6GS21+6cVBqB9YcG+lh53VjqMiHRoowynFRRWbIGUbK26+Cg+hHhtfjpQdPpCHDdCsaAdW3P1+
	INANwCSv5w3gCTlajDq+Pl3FEc4rLBY+rgBTrQBcmGFfAvRyCsz6PMUB+are6ZHZwPkqPKrhJfJ
	yEHdMgQ4akFwOa0SE3lg19t05HIdyM94DveLmbnlu03e3L4+A5ZE8LnyxS2LgyfRnnjAYjZPOQe
	2CEAkYS3yxvFNmyQfvvaO3cHCC6q2qiewKOtU5SjeFvOYjzYBZwtNUyC223ndf6+Vlze2lUBMbI
	ksiwjm9uEDuRqHgLYEAyc+bcxwhtUi6IjwF9CckqynO8rEG6UpTf1EQAWYhxXyuEDYe2h4bYT2U
	6FPHXWCR6e4ndODnkTcVtb0jZVOyvkmlNi32lngbMRN2vE0FiIcYvtm3ZabXzCqKXy8Rm2TxCUr
	+w0SeTsHMeHzDO4uKWo6FMK4fRdJJEImOB8I8tFpg==
X-Received: by 2002:a05:6000:98f:b0:488:8823:f9ec with SMTP id ffacd0b85a97d-488882404c7mr3238244f8f.34.1790429133297;
        Sat, 26 Sep 2026 06:25:33 -0700 (PDT)
Received: from [172.23.0.2] (211.red-79-146-43.dynamicip.rima-tde.net. [79.146.43.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a6470b7sm13988743f8f.27.2026.09.26.06.25.32
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 06:25:33 -0700 (PDT)
Message-ID: <6ab7c7cd.aec4f0e4.3a9f4c.54b2@mx.google.com>
Date: Sat, 26 Sep 2026 06:25:33 -0700 (PDT)
To: linux-acpi@vger.kernel.org
From: calvitohq@gmail.com
Subject: [PATCH] ACPI: battery: Force "Discharging" status on battery for ASUS
 TUF Gaming A16
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

From: Marco <soytucalvitofavorito@icloud.com>

On the ASUS TUF Gaming A16 (FA608UMI), after AC is unplugged the ACPI
_BST status word reports neither the charging nor the discharging bit
set, so the battery driver reports "Not charging" (and UPower
"fully-charged") even though the battery is actively discharging
(current_now stays positive).

This is the same class of firmware bug as the ASUS Vivobook 18
M1807HA (Launchpad bug 2152185), where the status flips between
"Full"/"Not charging"/"Discharging". Add a DMI quirk that, when the
system is running on battery, forces a computed "Full" or
"Not charging" status to "Discharging".

Based on the M1807HA quirk patch by Norman Becker.

Signed-off-by: Marco <soytucalvitofavorito@icloud.com>
---
 drivers/acpi/battery.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -58,6 +58,7 @@
 static int battery_bix_broken_package;
 static int battery_notification_delay_ms;
 static int battery_ac_is_broken;
+static bool battery_force_discharging;
 static unsigned int cache_time =3D 1000;
 module_param(cache_time, uint, 0644);
 MODULE_PARM_DESC(cache_time, "cache time in milliseconds");
@@ -192,6 +193,19 @@
 		battery->full_charge_capacity < battery->design_capacity;
 }
=20
+static void acpi_battery_force_discharging_fix_status(union power_supply_pro=
pval *val)
+{
+	if (!battery_force_discharging)
+		return;
+
+	if (power_supply_is_system_supplied())
+		return;
+
+	if (val->intval =3D=3D POWER_SUPPLY_STATUS_FULL ||
+	    val->intval =3D=3D POWER_SUPPLY_STATUS_NOT_CHARGING)
+		val->intval =3D POWER_SUPPLY_STATUS_DISCHARGING;
+}
+
 static int acpi_battery_get_property(struct power_supply *psy,
 				     enum power_supply_property psp,
 				     union power_supply_propval *val)
@@ -250,6 +264,7 @@
 			val->intval =3D POWER_SUPPLY_STATUS_FULL;
 		else
 			val->intval =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
+		acpi_battery_force_discharging_fix_status(val);
 		break;
 	case POWER_SUPPLY_PROP_PRESENT:
 		val->intval =3D acpi_battery_present(battery);
@@ -1258,6 +1273,13 @@
 	return 0;
 }
=20
+static int __init
+battery_force_discharging_quirk(const struct dmi_system_id *d)
+{
+	battery_force_discharging =3D true;
+	return 0;
+}
+
 static const struct dmi_system_id bat_dmi_table[] __initconst =3D {
 	{
 		/* NEC LZ750/LS */
@@ -1294,6 +1316,15 @@
 			DMI_MATCH(DMI_PRODUCT_NAME, "Surface Go 3"),
 		},
 	},
+	{
+		/* ASUS TUF Gaming A16 FA608UMI */
+		.callback =3D battery_force_discharging_quirk,
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUS"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TUF Gaming A16 FA608UMI"),
+			DMI_MATCH(DMI_BOARD_NAME, "FA608UMI"),
+		},
+	},
 	{},
 };
=20
