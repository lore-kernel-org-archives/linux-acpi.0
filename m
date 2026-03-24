Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5673EF0BA
	for <linux-acpi@vger.kernel.org>; Tue, 24 Mar 2026 16:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774371353; cv=none; b=M6tdeJkVGuUd+KMvMTGS19DZw5y8pPw3ulZE6eZnISIaRgrdxbVzoftjzUJka7+/+fjtH2MP7W6OAxVL6oUYWw85nuWAaxnbyQ+5CHWGZofL060JDy0lPKaBe5HCWVFSi2MnFfEUhdMmm7SaHE8n8TAnMNwmU5GHulA1LUlQQro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774371353; c=relaxed/simple;
	bh=zOFlkScxBJYUYGol8WCMQ18qarIl7rXUAtr++5t+NbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D7aIFI96MrKyZjnzvRMQU1rJFSSH2ndKRrf/5T66N/yHm0EbubwyNpA5WsMQSzT6YiTIlnDtnX6wIrTTLVmVObqwg3VSR1ilvY2/zM6hJEwCyv7aG8I9cQt2jpO3wzCSCbhFAU1bLm6RE0P7P+GWoEMeLrs2/HKiIgz/xIyqZjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxUippWk; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxUippWk"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b0afa0210bso1511985ad.2
        for <linux-acpi@vger.kernel.org>; Tue, 24 Mar 2026 09:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774371351; x=1774976151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o68rfoZDW0Au8c+jth6d1+VgZxQdSG7BkN7Csca8lyE=;
        b=jxUippWkAlHLIXNh1VTvr7jKDObij7DmPkfIPWjUk5VCdW61CGn6IN3wjJ7/82D4Zu
         hto2n+3a2jjBvrp11TuAsIveFwcZk/0h19eZyH24XqeWoRAn2q0kv2jkq2mPGdxkz0k8
         nXoFKDhpPyXa2eNzAyyjmZtlWfJCoXCnEbECc7YSvfLce1xF0KKJcycIEXBHSCXu0ObO
         VAnytXpWFtDSMGrCzI/NdmgQij68Vy6A+XuyL9y//i5SipEClgMrY1cu9113ILx5hFAB
         blq9dBnaYC0rxEGbNjIzZRAG27LfnBSF2LXg6JZvE9Xj1nmruIzce6D66YpXkOxYzKeX
         BODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774371351; x=1774976151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o68rfoZDW0Au8c+jth6d1+VgZxQdSG7BkN7Csca8lyE=;
        b=dSs0udTz9y2fKdJeZdo698hU9NCkObnt0pxxW93ksSKfIMbva8rp1eYuNYwq5GIcvc
         qBh607Mn25G5SMFY8pvZHnr/XF8Taw01u2LDOzInMVRuiU0ICEdPkhhCZ8x3feebPgX1
         xPrsvJui5saqrFoAXt/PfMctyYEEBWnvuPR+DUIHUlKO7n3Vf88zTR6lVyRMo7N0OCpX
         6XUSKoxNehkxsVONxWYZ5KvIu6wZf2eis06EL2LfV7GyJaPqfCrORtLiFm2QyifsLIIe
         /CqR8zatqRks4F3mbUfNNUGLV+0R8SYs0Wry6iPqIPN/1r12ok3H7gMdbuaO0Vy1tR9A
         tqjg==
X-Forwarded-Encrypted: i=1; AJvYcCVkfMv1YAENgT2uY62JwcovDXq8TWuWsI1MNoYLmelULnOxFKze+XOgfGFp+wGlAsDYgBE2zripjUej@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxzl48sxLJVDACchrE+Vee1Hv+mVjK3tDIBmY9p6pAOWPelCII
	eDvu2hw9mamFMfjEXEshEIjAuo64zqDFhWLLSiqSY1oK3aQ81fm3o4/c
X-Gm-Gg: ATEYQzwEhB4Pl2HcoO9QKtLfjKuGw4GQld5I0RJZChxRYa+8XSWHlbVdaEs8iDwDL1N
	dtBPgYrLf70+HLvpozmeAwLgcF1numEVq1SbpdHHvVpvGcZVbPCcPcZF6dvJJyG+yt1mytojAfj
	3f/nzCw37vw8uDC8U7L/vrElkv9DGMx/JDn5oL9A/VBIY5M4bUL0Mk/ldgxxomRUoTcpkUasLwA
	N9uqKK3woZxtMgY1htlcQmQW3eL+gWwPdH99QSFitf3RDoyLWnreXKHo7FUIAELvKZQv9ljYD/Y
	8cLm+72QUS8HLeGnc/orjmHhjal6+EDFSM5retMRp7XpeLfmqHM7FoBzPJSfHewlu62KYLBH2dR
	ZdYmdIaO6rvG/NcD6oOJ5kTFXH0cU/IfHUOu0HS/6VkhTfKhgeglpAcKuxtf9QFcnJz9QO49578
	fGv/WDZ979ucG1ePj0uDKsR7QXI9+9TMlp2HBUX5AMeso29sR9FlGcsII3gs0K1YW/d7sOftAvw
	jGrmO7vnXJZOsORckioXA==
X-Received: by 2002:a17:902:ebc2:b0:2aa:d5e5:b136 with SMTP id d9443c01a7336-2b0b0af3befmr3511405ad.38.1774371351389;
        Tue, 24 Mar 2026 09:55:51 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0aefd07c2sm8639895ad.31.2026.03.24.09.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 09:55:50 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH] ACPI: EC: clean up handlers on probe failure in acpi_ec_setup()
Date: Wed, 25 Mar 2026 00:54:59 +0800
Message-ID: <20260324165458.1337233-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When ec_install_handlers() returns -EPROBE_DEFER on reduced-hardware
platforms, it has already started the EC and installed the address
space handler with the struct acpi_ec pointer as handler context.
However, acpi_ec_setup() propagates the error without any cleanup.
The caller acpi_ec_add() then frees the struct acpi_ec for non-boot
instances, leaving a dangling handler context in ACPICA.

Any subsequent AML evaluation that accesses an EC OpRegion field
dispatches into acpi_ec_space_handler() with the freed pointer,
causing a use-after-free:

 BUG: KASAN: slab-use-after-free in mutex_lock (kernel/locking/mutex.c:289)
 Write of size 8 at addr ffff88800721de38 by task init/1
 Call Trace:
  <TASK>
  mutex_lock (kernel/locking/mutex.c:289)
  acpi_ec_space_handler (drivers/acpi/ec.c:1362)
  acpi_ev_address_space_dispatch (drivers/acpi/acpica/evregion.c:293)
  acpi_ex_access_region (drivers/acpi/acpica/exfldio.c:246)
  acpi_ex_field_datum_io (drivers/acpi/acpica/exfldio.c:509)
  acpi_ex_extract_from_field (drivers/acpi/acpica/exfldio.c:700)
  acpi_ex_read_data_from_field (drivers/acpi/acpica/exfield.c:327)
  acpi_ex_resolve_node_to_value (drivers/acpi/acpica/exresolv.c:392)
  </TASK>

 Allocated by task 1:
  acpi_ec_alloc (drivers/acpi/ec.c:1424)
  acpi_ec_add (drivers/acpi/ec.c:1692)

 Freed by task 1:
  kfree (mm/slub.c:6876)
  acpi_ec_add (drivers/acpi/ec.c:1751)

The bug triggers on reduced-hardware EC platforms (ec->gpe < 0)
when the GPIO IRQ provider defers probing. Once the stale handler
exists, any unprivileged sysfs read that causes AML to touch an
EC OpRegion (battery, thermal, backlight) exercises the dangling
pointer.

Fix this by calling ec_remove_handlers() in the error path of
acpi_ec_setup() before clearing first_ec. ec_remove_handlers()
checks each EC_FLAGS_* bit before acting, so it is safe to call
regardless of how far ec_install_handlers() progressed:

  -ENODEV  (handler not installed): only calls acpi_ec_stop()
  -EPROBE_DEFER (handler installed): removes handler, stops EC

Fixes: 03e9a0e05739 ("ACPI: EC: Consolidate event handler installation code")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/acpi/ec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 59b3d50ff01e..c981a53434ed 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1655,6 +1655,8 @@ static int acpi_ec_setup(struct acpi_ec *ec, struct acpi_device *device, bool ca
 
 	ret = ec_install_handlers(ec, device, call_reg);
 	if (ret) {
+		ec_remove_handlers(ec);
+
 		if (ec == first_ec)
 			first_ec = NULL;
 
-- 
2.43.0

