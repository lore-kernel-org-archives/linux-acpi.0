Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53C63C9896
	for <linux-acpi@vger.kernel.org>; Fri,  7 Aug 2026 03:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786074906; cv=none; b=ecIEEjXr/gdkIfl7sE3zbx3o4S7aUfU9tRuXqFdsGsTIRzbOSqzyr6gXQnwCq53ucDgXY/ABxbGeZVN0eVkOKvotsPJHRVJ08vt26kDgaYrTnqRQyGPhJGmrOV3lbvpDJzSWIk8YX3nf3BerS55P/98HUmrwDALxNWFBh660TaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786074906; c=relaxed/simple;
	bh=Elhaw7454IcxOxFvajFIj/zc+9hsb3/Q9YfUijVfmjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YaKvVl/0GF4bPpB6z84mmKaVYg4z26TLKVwGIxq0/nPq7txkIDDTyovuSHNWJXUPqDRciR2p7VPjoAjoenYcunb/0WvRDUkEyt9yBXvISJaoCpgdAEgHsM/4hIMEEBfb4CbIgfrYrkc1NrnRBfow0j3Q3TSJrrZ3ZWtMSHW57BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWKOsA69; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWKOsA69"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e85499ffbso197246285a.0
        for <linux-acpi@vger.kernel.org>; Thu, 06 Aug 2026 20:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786074898; x=1786679698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V73Au8wEhU0LrohqbWiG8So58r1u7vwRuaOrdVjuz8Y=;
        b=fWKOsA69tHrnoXuMtSRFOThpnW5seCHiWJmWA/Z/LhbX+vgFp1/ucYoyGPJedbc+Xt
         Zhbn2FYGQ7QxT1YhgdJYxVAGNmM9IO+rhjiH6BbnvyGWp/siAztCcP4YH0ITizskZeKV
         totXkdhmVnuiQjs5geE169sa6h14GA7IvoQ4pJpuvQqTzj/HsPDsID4x6PFUo+MqqOxF
         AfVSR18w2SozUtr+fNTZOD67QKFkdz4/rgQ7Dlq+/7y2FmPwop9xzwGuwGSc4VyHOfgc
         uaU3doqwbNTAZtiyBd+sowBjICRfn1A/3JOi8WjovWvE+ezfYapE2LZ54Sq3oB9/MfxR
         Ghlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786074898; x=1786679698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V73Au8wEhU0LrohqbWiG8So58r1u7vwRuaOrdVjuz8Y=;
        b=FGLtJnRgGlhL88tPRAif4NDnDJIKCYfbOj7UNTSyrWNVZIsbImDrXzKYOV8LnnnXCh
         q4yrsKV+mEiLd+Hjc1WrWcSeS7pzTvt+kkG4GwIWbDzOCgrZyw9TANP/iObfzraqDwy0
         qd89tphoCIYht5/nU/BVl9ePxQqyGic14mvMQ4s7EhXTH0TvDjp3nnt24KrbMKKmktRX
         0zeXaS7pHKVE9kXApXGDPzLZP6wXH1iMvJrxul57iVx3RlkcMbfP+14lcSI3PxKumte3
         eBBtJ0oDoCIxIoe7b6fFomujYKizx34LsO722ZjpQeIRRbUpLfcJnmMChw/71oNqdKby
         qVTg==
X-Forwarded-Encrypted: i=1; AHgh+RoFsyIlib+q7Lrh5WWzySdv6cStqfypB8tpFjOZ97g7m32ONGZ1pl7xodn6JsTT5okUKWtrygxT2xVC@vger.kernel.org
X-Gm-Message-State: AOJu0YwuV3e7mbFpp31q7210jD1uOzVCQj72TVq6sxvCP0myM4hp1Bdp
	w1jWStoBoNnJUY6yKdEoRchnuOezgKZLoV289Ho/2a6HJp4qdqMoBV0w
X-Gm-Gg: AR+sD12xnpbLB7KbZz/Er6ylvH0IbklclhHf2A28lnAdyttg2JDZ0Li9n7FFVe5WKC8
	/DE6VmhQZWx/XDxJn9Z9ibJg7kdpWNayWf5sGashF2Ui3a7WSe+m4cpuiFYn8PGs4SoqFqRJzur
	HmGyMkG+3tl6dkWikTbHTlUORw47waO5v8/Ldu2j4EREP5ZE/sh1XUmJQyfTHbi9jOC2aVzktCl
	8oSQBj9kF5TwqMDtgEjr1E/RJn40Lam6oU3UAf2wF5yamxsQtb+/XAPmo8U0wMgPktDbqP2AQ7S
	1/g2/vnbLkqTjCRxZwfFrMPhV+ac+hsDfjPmMbdUcl6LDjcuDWUJQziZbdiYTb0pOyT3CUrXGBU
	BNBflrJGBA1Jtyd2CW81Wqt32wwjcD/SJTP+GKEm+vZbUhg2RMzLDoluZdU3n6mjGjV/k1H0rHY
	P5MRHjcL/YmSk0NCVuM9QdwUx8JCl3aCHTFwgm727yRNBJighbip77IfPn9O6yBqF8WACjTjtMO
	fSpAUu2c36Q91i2Fry9UuMgwgZhGwyXLmUrO3IlUbRbqHMQ0g7+csusX+JNxnI=
X-Received: by 2002:a05:620a:f07:b0:936:583a:dd75 with SMTP id af79cd13be357-9366646501amr671111785a.17.1786074898332;
        Thu, 06 Aug 2026 20:54:58 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366e258608sm61386985a.33.2026.08.06.20.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 20:54:57 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH v1] PNP: Release protocol device on registration failure
Date: Thu,  6 Aug 2026 23:54:53 -0400
Message-ID: <20260807035453.948129-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pnp_register_protocol() adds a protocol to the PNP list before calling
device_register(). If device registration fails, pnp_remove_protocol() only
removes the list entry and leaves the device-core reference acquired by
device_initialize() held.

Give static protocol devices a release callback and drop the reference on
registration failure. Also stop PNP ACPI device enumeration when protocol
registration fails, instead of using an unregistered protocol device as a
parent.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
 drivers/pnp/core.c         | 9 ++++++++-
 drivers/pnp/pnpacpi/core.c | 7 ++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/pnp/core.c b/drivers/pnp/core.c
index 81603327079c..fc3bff43fdd8 100644
--- a/drivers/pnp/core.c
+++ b/drivers/pnp/core.c
@@ -23,6 +23,10 @@ static LIST_HEAD(pnp_protocols);
 LIST_HEAD(pnp_global);
 DEFINE_MUTEX(pnp_lock);
 
+static void pnp_protocol_release(struct device *dev)
+{
+}
+
 /*
  * ACPI or PNPBIOS should tell us about all platform devices, so we can
  * skip some blind probes.  ISAPNP typically enumerates only plug-in ISA
@@ -66,14 +70,17 @@ int pnp_register_protocol(struct pnp_protocol *protocol)
 
 	protocol->number = nodenum;
 	dev_set_name(&protocol->dev, "pnp%d", nodenum);
+	protocol->dev.release = pnp_protocol_release;
 
 	list_add_tail(&protocol->protocol_list, &pnp_protocols);
 
 	mutex_unlock(&pnp_lock);
 
 	ret = device_register(&protocol->dev);
-	if (ret)
+	if (ret) {
 		pnp_remove_protocol(protocol);
+		put_device(&protocol->dev);
+	}
 
 	return ret;
 }
diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index fbf03ff007eb..da0ebc378696 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -298,12 +298,17 @@ static acpi_status __init pnpacpi_add_device_handler(acpi_handle handle,
 int pnpacpi_disabled __initdata;
 static int __init pnpacpi_init(void)
 {
+	int ret;
+
 	if (acpi_disabled || pnpacpi_disabled) {
 		printk(KERN_INFO "pnp: PnP ACPI: disabled\n");
 		return 0;
 	}
 	printk(KERN_INFO "pnp: PnP ACPI init\n");
-	pnp_register_protocol(&pnpacpi_protocol);
+	ret = pnp_register_protocol(&pnpacpi_protocol);
+	if (ret)
+		return ret;
+
 	acpi_get_devices(NULL, pnpacpi_add_device_handler, NULL, NULL);
 	printk(KERN_INFO "pnp: PnP ACPI: found %d devices\n", num);
 	pnp_platform_devices = 1;
-- 
2.43.0

