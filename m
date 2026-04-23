Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD01B3491C2
	for <linux-acpi@vger.kernel.org>; Thu, 23 Apr 2026 07:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776931147; cv=none; b=i4QLGM4/K3rLuTAhQxQMCZku45Uc+D4Pm0Zq52+2nTktJoYqLoFBPvtrGMnZK66mPR788pQKSEhxuGZSD6B/gXFQYS1dzfahvbZsWOPvdB4YlxymTdbJDqiDeIeUy1A9UFuYBaH4um6x4VLu30+R4LDPjddsKIIu/Uva0goQnl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776931147; c=relaxed/simple;
	bh=YY9l/JQUT2wrLvX5VjikzOmN4bhDqWw5VYHx5QoY2VE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A5fhG/kDEUCaydyshPQfMyWsvTmX3CC718YZpwIp7tndHguNrvDbHXFPeJl+q6of2gxREWZpf5eX9tIbYvgXXSqQHJxfPDnUJNuqBcfk0Qrz1VYg/BSilqHJ4umQvdoMa8fl7yRsnwwJKc6EwTx6H5DBNPm+6VPTIk3IrrDqzIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-82fcd0aa2dbso1397231b3a.0
        for <linux-acpi@vger.kernel.org>; Thu, 23 Apr 2026 00:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776931145; x=1777535945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ggpS1cz1nsjmaPoLufsLB6faUlw5IEIPcq0RGxl0GU=;
        b=Y/5qPgt4pLte1hkbBzWC5a/tFIL7+HQqfuzivd/EWlZSgt71ui2+qyKahqR6F6mpNq
         64SHBBOPzAldk4dt9ZB4HpmytHcSAmhJcT7XcgpmNOTFP/v/NXnp57NFBlTcUqLVLgB+
         7SjcF7IKDmo9ueNLYgo+2+d/J+4B51gNQoheudvgln1K7oFhiDL+qB8xi6Xj0YSqmiH8
         6HdSn81sUIYd83ufqQmb9zvKbxlwl8V0niL+NC0DrGel/DcP6f/MPuU4VYSiEdeyV0IQ
         dQIKiNiJr95O6In+T83bFCwW0x2mrhW5HEAT7txJCxnTLzrKjqR2Y52E32WcCl7457eW
         t0cg==
X-Forwarded-Encrypted: i=1; AFNElJ+VXv4NAuH3Q0rBZj4j0o6Yvi93ZyxKrxpoHLO6xU3Tq1vx5a3kuAwJp1WeZ3I4mDmVQ5EFX9uB9fzH@vger.kernel.org
X-Gm-Message-State: AOJu0YxA4RVvQ5iBNK2hLmtT7MXbcn/BVtX+rdvG1uJHsn5zSGtmoAD5
	d5xhq1jHY5NFTHGsj9y+esJK3z1fw9A19DBTAYtECcscRS6JWxQ1SLwk
X-Gm-Gg: AeBDiev51dRtgwyXe39jpc6WoeVHUD8lT5L+n/Bh8rc9jzq//T1XdQ+HOQLptUSxHIH
	23HLCtfMZJT266Y9zxhb8uC/l2oCQtRDkaAqnQHzAzAs164cwzsidFjGGJg5WLV7/GPaTfv16Vf
	rnhT/iBBubu4g65C1nSZEzCBoK6ccqSG1ZSvaWgGFElUTdJOaWBfY0tgEyxW7oVWCVlzttn7RCU
	fndUCJ7G/YDGlCGG3FgSh/clbENlaVG0tNmfs5atMESiPCmP8rmbA9dfNtzA8jqBvd7gZDOcswI
	HUQkUheGBYVcdH7/Jf4sSDy+juw30zbaJE2kahb3IwPAR6WsL/eOcZ1B53cB1mgGMDGXqzwiAqI
	7xRv+y6m1/zPPivYYCbfNzpiYXCfRMX+t+zYU5/nQXWyvav/i90UDmJ8deFzADdU2lcj6f3mkFJ
	9OPVM6P4TaLjIQTP59n5h0wxt7ndYJg6/WiExTnrpu/96WdUqDPzz6cQpu
X-Received: by 2002:a05:6a00:190c:b0:82f:500a:128 with SMTP id d2e1a72fcca58-82f8b329161mr23111271b3a.5.1776931144703;
        Thu, 23 Apr 2026 00:59:04 -0700 (PDT)
Received: from kylin-XiaoXinPro-16-AHP9.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981c07sm23707842b3a.1.2026.04.23.00.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 00:59:04 -0700 (PDT)
From: luoxueqin <luoxueqin@kylinos.cn>
To: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH] ACPI: battery: add state_of_health support to power_supply
Date: Thu, 23 Apr 2026 15:58:53 +0800
Message-ID: <20260423075853.151829-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xueqin Luo <luoxueqin@kylinos.cn>

Add support for POWER_SUPPLY_PROP_STATE_OF_HEALTH in ACPI battery
driver.

State of Health is calculated as the ratio between full charge capacity
and design capacity, expressed as a percentage.

The value is computed as:
    SOH = full_charge_capacity * 100 / design_capacity

Only valid ACPI battery capacity values are used for the calculation.
If either full charge capacity or design capacity is not available,
the property returns -ENODEV.

Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
 drivers/acpi/battery.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index b4c25474f42f..6e6396aad2c8 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -267,6 +267,15 @@ static int acpi_battery_get_property(struct power_supply *psy,
 		else
 			val->intval = battery->full_charge_capacity * 1000;
 		break;
+	case POWER_SUPPLY_PROP_STATE_OF_HEALTH:
+		if (!ACPI_BATTERY_CAPACITY_VALID(battery->full_charge_capacity) ||
+		    !ACPI_BATTERY_CAPACITY_VALID(battery->design_capacity))
+			return -ENODEV;
+
+		full_capacity = battery->full_charge_capacity;
+		val->intval = DIV_ROUND_CLOSEST_ULL(full_capacity * 100ULL,
+					battery->design_capacity);
+		break;
 	case POWER_SUPPLY_PROP_CHARGE_NOW:
 	case POWER_SUPPLY_PROP_ENERGY_NOW:
 		if (battery->capacity_now == ACPI_BATTERY_VALUE_UNKNOWN)
@@ -323,6 +332,7 @@ static const enum power_supply_property charge_battery_props[] = {
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
 	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_STATE_OF_HEALTH,
 	POWER_SUPPLY_PROP_CHARGE_NOW,
 	POWER_SUPPLY_PROP_CAPACITY,
 	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
@@ -355,6 +365,7 @@ static const enum power_supply_property energy_battery_props[] = {
 	POWER_SUPPLY_PROP_POWER_NOW,
 	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
 	POWER_SUPPLY_PROP_ENERGY_FULL,
+	POWER_SUPPLY_PROP_STATE_OF_HEALTH,
 	POWER_SUPPLY_PROP_ENERGY_NOW,
 	POWER_SUPPLY_PROP_CAPACITY,
 	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
-- 
2.43.0

