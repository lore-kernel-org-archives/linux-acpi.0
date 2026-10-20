Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792493922;
	b=m87iem2EdoCwdAfbxLhiWDDNohC/Vvph5Q7nnqMtvLIbmpxg6XupkoO2aHvmvmLiWEWZ
	 7rs1aH2t3gWoi2BsGhPoSLQtQYu76DnaOf+sDQylQ/5qm3GhM47Dp6dhXxGzHgfXMVOGD
	 DN0+dgSPV42GE1BLsYzjKctlCJV2NXq/yDE4WX6fa9dafXpbPV2H/arsxnMNNP5gishjr
	 he5hFuKaangIduOgJ1NaeBNxi1PqW4cM0BKM4owc17oogAuJ7mzznIPsM63jnJRSXJ2Ql
	 WCYz84Lg9ndf9f9UibKY0Vbe6SoXvBL2ToFLzURDoMwXNipIj28OWZFYA4Bv6GKn+9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493922;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=dZpPN04hTrWA+idrAOPEGckZoQ14o/TbAbkfYcETJa4=;
	b=MbidNqzXVfZ5lZg+Fybh//Our5As2S6PFg7lCge/CuL3O4p9pYFbkEcsax+q/m22QGDv
	 qxjeySy8m/RxqEBfHO+FmHmk1Z/W5OOiQPBNT9Lg9eG60xL+7kFKS0LoNKzrKVEA85bEq
	 XRa3t4hWNyqimykrjpSh8YfP7kWkpAw6/sxMDxzh2wmXDWFkwVRuja2ehfwEW10xyrd+P
	 WxZIJBHVT4D2nwMsuWPiI/guo1av+5O3OURm3Rdt1p6OCs0S7TS6nxoHmuFHTgPdRoJ9d
	 FlgWbcmJuM+g0LKKZ7N6kczqOip2PUtSowID/vCLeZjqp8vR/JpMtm7eo+LhzYxAbXQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OEZcfIL5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5089E606A31C;
	Tue, 20 Oct 2026 10:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OEZcfIL5
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792493921;
	b=X/U4/Pk7jmMkLI1BWec2cM3Y2EDietC76zVwBp9RW97bOZYCYX2bKwpf8vId5i3dLA+U
	 BJzF5XohD6XnQ+ylEz1CWIr1JDLeu1ACiOfYNgqKwoW1gFe3vLP8kM6OxzKkMnnmtcSE9
	 ZxJZ1//A3bNkrrQ6F1N9Hv6nu4rIG41P+9P4QopK45Mus9pzVaTsHDUdxl4ReXzDYNb+F
	 P/vvD6sHzww5eahbS10z86KCpqXCzWPl2KWAe2hQgfteLOuy0vGsR2JZ+vHC9tO3hoyBa
	 OGXyM9QOhlfgXkdfm7ZGESv/68sYryxNohOMlpEYYLNj3yX4MwR9RZHr0NlJlWDo1gA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792493921;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=dZpPN04hTrWA+idrAOPEGckZoQ14o/TbAbkfYcETJa4=;
	b=b7i8ZAQin9kVUi/e6AMDiT/Ss3yco1GXIiB0RN3ozAQU+hkrZOah1/rFpZ6zoz4zYlPo
	 KIKV/k2RRqtDEVAbPLM6JMB+TU6MNhLBtZqHILPC3+vMfq74+H/Jase5jDBBtW9q7Ew5f
	 ZBZCeaE1jj/jbgAVB2WE4Q1TBKQ/29T+hTIELNwXhw2ZyYzoMP3XYgvStNu6+SnDNJ3HX
	 XqvwVX7V+UDrDzADjBc64QLhwnPKdblyjVlRxe5sNyGcDF31yJ2ee1AZHtzEaYEmn8n1v
	 FChYNIO3VtBACzpHizISc1pxNgQvqpH6AWyaEAcBBRK5hYRHIciwHGK6wdN+KPMm9aw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7635E1F000C6;
	Tue, 20 Oct 2026 10:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792493921;
	bh=dZpPN04hTrWA+idrAOPEGckZoQ14o/TbAbkfYcETJa4=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=OEZcfIL5yncC0RuNTnrZZkYdr+cP+xCBwRBHLof/r/dXxGYxvUoS/j6yNap2e7StN
	 iw2DV3kLU2Qb2N0k4F7VH0OWhsNARZJuVBFgrI3uSnjXuAisWbrmYEu7jIkEkspEOM
	 LRjnePpb1KKtoFfV0ZdlngVBXaSElx9qRzXlO5v4BjW4rHTd8nv8GmT2QGGGJak4tU
	 +/P40fWW7ON6RzkXTOW7XI2ZKMPjmZ+68Ac3cxBsDf1dbfXc68HZyLBC686p8vO4ts
	 W7fL8R4eHVkPksSCC8cN8drUkMrSNxmarO9a85vlwC/avekOhIj/mj4GdSFtNVvjNB
	 QXgK/l/toNIbA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D0B24406D4;
	Tue, 20 Oct 2026 10:58:40 +0000 (UTC)
From: Penkacelsus via B4 Relay <devnull+balthasar978.gmail.com@kernel.org>
Date: Tue, 20 Oct 2026 10:58:41 +0000
Subject: [PATCH] ACPI: SBS: Serialize battery state refreshes
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261020-acpi-sbs-serialize-v1-1-913abf8ed30c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ5EQBBA4atIraeS1n7CXGUyi1YKJWKky4gQd
 9dYfov3dlD2wgrvaAfPi6j8xoD4FQF1bmwZpQ4Ga2weG2vQ0SSoleIVukE2xpTLIk3KgpqMIIS
 T50bWe/r5PtZ/1TPN1wmO4wRO0QhLdgAAAA==
X-Change-ID: 20261020-acpi-sbs-serialize-4e984398cf5c
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Penkacelsus <balthasar978@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792493920; l=2969;
 i=balthasar978@gmail.com; s=20261020; h=from:subject:message-id;
 bh=juNEQpDZvarDTwpQSkqLQd/gYi+Y1pUsMl0a5qSjuSg=;
 b=7FyHcDkQ4jT9S3ICW1XCnA8onIWmGobgn3hBy6HhLI+qs/RqS5hZI3w+C2V4qD9nRRD5bQFhN
 MT/wqqgDl1+Am5D5DX6yJHVblPkXJFAIFEqe2uNJgEyeDL3ulhaE3nN
X-Developer-Key: i=balthasar978@gmail.com; a=ed25519;
 pk=2qjYMGCkah5ZygiRd5e1xAy6ayf0rjvvVxbCxzzG/8M=
X-Endpoint-Received: by B4 Relay for balthasar978@gmail.com/20261020 with
 auth_id=1249
X-Original-From: Penkacelsus <balthasar978@gmail.com>
Reply-To: balthasar978@gmail.com
Content-Transfer-Encoding: 7bit

From: Penkacelsus <balthasar978@gmail.com>

acpi_battery_get_state() refreshes the battery state at most once per
cache_time (1 s), but the check and the update are not serialized:
callers that arrive together all see a stale cache and each read all
seven state registers over SMBus.

On T2 MacBooks (MacBookPro16,1: SBS battery behind the EC's SMBus host
controller) every SMBus word read takes about two dozen EC GPEs. A
desktop shell that reloads ten BAT0 attributes in parallel every 2 s
drove the EC GPE to ~680/s, which kept irq/9-acpi near 16% of a CPU.
Readers of a single attribute file each get their own thread in such
shells, so the race is the common case, not a corner case.

Serialize the refresh with a per-battery mutex taken in
acpi_battery_get_state(), so that the power supply readers and the
SMBus alarm callback share it. The first caller does the SMBus reads;
the others wait and then find a fresh cache. Use a new lock rather than
sbs->lock: acpi_sbs_remove() holds sbs->lock while it unregisters the
power supplies, which waits for sysfs readers to drain.

With ten parallel readers of state attributes every 200 ms, SMBus reads
drop from 26-29/s to 6/s (the cache floor) and EC GPEs from 600-670/s
to ~140/s.

Signed-off-by: Penkacelsus <balthasar978@gmail.com>
---
 drivers/acpi/sbs.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index f10bbf13c..861739b18 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -55,6 +55,7 @@ struct acpi_battery {
 	struct power_supply_desc bat_desc;
 	struct acpi_sbs *sbs;
 	unsigned long update_time;
+	struct mutex state_lock;	/* serializes state refreshes */
 	char name[8];
 	char manufacturer_name[ACPI_SBS_BLOCK_MAX];
 	char device_name[ACPI_SBS_BLOCK_MAX];
@@ -355,6 +356,13 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 {
 	int i, result = 0;
 
+	/*
+	 * Callers that find the cache stale at the same time would each
+	 * re-read the whole state over SMBus. Serialize them so that only
+	 * the first one does; the others then find a fresh cache.
+	 */
+	guard(mutex)(&battery->state_lock);
+
 	if (battery->update_time &&
 	    time_before(jiffies, battery->update_time +
 				msecs_to_jiffies(cache_time)))
@@ -367,9 +375,8 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 					 (u8 *)battery +
 						state_readers[i].offset);
 		if (result)
-			goto end;
+			break;
 	}
-      end:
 	battery->update_time = jiffies;
 	return result;
 }
@@ -530,6 +537,7 @@ static int acpi_battery_add(struct acpi_sbs *sbs, int id)
 
 	battery->id = id;
 	battery->sbs = sbs;
+	mutex_init(&battery->state_lock);
 	result = acpi_battery_read(battery);
 	if (result)
 		return result;

---
base-commit: a7b81d2593fc90a93e108441a04e3b258d19f074
change-id: 20261020-acpi-sbs-serialize-4e984398cf5c

Best regards,
--  
Penkacelsus <balthasar978@gmail.com>


