Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6450A3D4125
	for <linux-acpi@vger.kernel.org>; Sat, 19 Sep 2026 12:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789821974; cv=none; b=QZh2SnV1OhTEfAS2cE0Uass3BMHF6Z/JcyDl6TgxWvXRxlCk+xZb5CmOdDylAC6qNdGxn37Q/k5vBww6dK8wy+qfweBYy+vnmcyU0XJQBsxa4qW/pqUXZSnBWidFiY45y7ZSfSpI13zGC6AJsi141YA9Nu0c8wQmnL0auuh1ip4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789821974; c=relaxed/simple;
	bh=nVXdbYl9Ed/zUReN4wz3xJC5uWFZ/3tLpHSj2Pm8bbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mKaS34GMDXSAFtHWnkj0YmpwFrw1ymj30z4hL30SmdkKH4AzS8P1GOihF0b8SLX4gh4FDCsju15mdq1hx81td2gXaocLfPhjvs+VqSY2Igp2wWQz+9wAGgFd+eN+wz9RAixV1Oe9PB9uryjVbiX+vMID+Ofm4M4A6iUPX1vOis8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gTGJVey7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OAyS7IG1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gTGJVey7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OAyS7IG1"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68J9tSMS146312
	for <linux-acpi@vger.kernel.org>; Sat, 19 Sep 2026 12:46:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=SGYijClpZ0O
	Xp58e29U4yPvq1wPsOjNpBmDO0C2z0JE=; b=gTGJVey7l6fBlhUm9+qzU3D39u0
	g09tWYyOoGbuuEsiAURRMLqSJuurw8ymfZdNoWdzMue/Ti6745/gh3oya36loIad
	nkOrpBPEhMltBC3PGnwiiq57gMWu+ZFIa/PlmRpfoEvmwXPdgC4QfWTGzrMIaOcX
	RxoNWvc7xnDfj9Jtr9Yzp/ODryVrU20+ePqvEs0xlRMdJNLQM6eovZ8a5xLfqe4B
	uSn0iH2vp/bEA0STyrdCzS/7zJ6coo4innpcEWSGB6Tp7bLTsS52IEUKQ1msNMev
	ArKTaukGpT0OvQI1tTDoKb8GQ/KQUE6dv5/FT1uEkraX0JQblMaPpc6fd9g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gshbs91rf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Sat, 19 Sep 2026 12:46:12 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93ae8e7e546so363332685a.1
        for <linux-acpi@vger.kernel.org>; Sat, 19 Sep 2026 05:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789821972; x=1790426772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SGYijClpZ0OXp58e29U4yPvq1wPsOjNpBmDO0C2z0JE=;
        b=OAyS7IG1/UftkGWpAPnCFwDBoie7VYFzU99FvNiFJwkKG3/xl0za/X/BM8/ZGCbM96
         tXO665uHUZZiajJi0WTjN3JkT6VXISSq0HjrBfJjPabLbD/b9YacC/CtfFDuceoNlgGy
         cQP3CZcaIw50J8TzbS3FJrsIP9s7o/GgXwEHH81bBafTXTg1ZP2ay/8RVTL17b9JApn5
         /wVL6nsdufUa1DYzzhPBXN8gOoUJqMEweKzWmkLbr4Jsn4d97LGYlK5C4Rojxc3hBGPo
         uXfG2OpiRJE2Bhbp2Xyn/AfsDR7039d09G2iTgC5jpHahtscEZNAKnc5APi2gxXuA/4X
         q/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789821972; x=1790426772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SGYijClpZ0OXp58e29U4yPvq1wPsOjNpBmDO0C2z0JE=;
        b=gBZyecAWpz+pOmj+gNI2qwgBjdNnYd57iM28EyX6khdHfZoCKXjvcSlOsX15fFkIlj
         5oqaH484XiO+7ZlcPp5CBsS1jeB5n59GYwO5pMbXg+TKsdTRvYz0xLLCoB/O17HI9VXw
         WIFRQrpIaG52oM7pQrB3jXrhOfbw0ljTOvzIsuG1uvQVWw8UyhSQmo/qGUvbsq3g6+qT
         8uHk/vyV8h1NZzWqwrgRwPYCzgg9AnzGg0a3Owsz4Lf78+8HDgDmCR+jU8drKEPWKAfT
         vFNlXo3wvvoYOBlrJIyDgkRXxWzeUdHmtnpeqLhPt2p5mSWMPWK0XER2Y89T9WdFjKwG
         n2HQ==
X-Forwarded-Encrypted: i=1; AKwUvBw+xIEr87f/aeFlPGaQ0FRcucvHq0hmNU2l/eEgFBcYWsXQnKeFB7GpWN4dlaXYQqtXBEL89o1zzLY7@vger.kernel.org
X-Gm-Message-State: AFuF++nJpb+0wsjbnsn4HejOfz+sSyRZ+4SWCh38mkeCCX+P9Z3ir7IK
	uDIGchAOb06UjGtfGGNkY0qaV3rfnoEjONsQRTyeytQZibhPnMxS2eGZf5p0n/u/50m4yoNsHS9
	+5YSyaIVJ8gFDxbaNpxJi6FekhMuEFk9KCEE44DunS8sFm1rx1xS+afzRyIoI725X
X-Gm-Gg: AYBFou2jWmss58yW1ou7m3VYQdlWWTNzSH/hRlpFUDzOmjcBGNUuJH0BU9qn5kgVbOJ
	1uLh6UbfOx6fHvFLWoPiYoZhI97bV3QYyOtdSfhGnQjdZ7yN25HOafOkl3BkRR6j47H61ekBZ36
	EsniCi8GLSFFdm5YuFrPJA7dxq4d/+K4Ey0CQ93KpXfDaIz1U+PHYD0lAk0tX/pMVxmC1Ijr5rb
	KhNcdz3hESOWXosW8bFzCJncMRCGT2rEQI4SsaXHczbM7yCdc+mTNxFDJQWQ/AXjC20It58Mq70
	N9Q0gMXew5vSsu3gqOsRCpsHIs5TmY84ETrH40I+zf/9xR+hIDmEml2YDLhyGoCW9jZa3DwRR/L
	F3KLxTdTsF5rI6ALaBFROm8FI5MChLtaVgGnOQ6kIp0V+DihcN7lUOo4lGrWXztOf2LslbyjjQV
	ueinbzItW02Et/6Q==
X-Received: by 2002:a05:620a:710f:b0:93b:d79b:9a58 with SMTP id af79cd13be357-93bf578d686mr106763385a.57.1789821971497;
        Sat, 19 Sep 2026 05:46:11 -0700 (PDT)
X-Received: by 2002:a05:620a:710f:b0:93b:d79b:9a58 with SMTP id af79cd13be357-93bf578d686mr106761785a.57.1789821970969;
        Sat, 19 Sep 2026 05:46:10 -0700 (PDT)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa67dbaf0esm1332269a12.15.2026.09.19.05.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 05:46:09 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH 1/2] ACPI: scan: Skip acpi_scan_dep_init() for processor devices
Date: Sat, 19 Sep 2026 14:46:04 +0200
Message-ID: <20260919124605.12429-2-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919124605.12429-1-johannes.goede@oss.qualcomm.com>
References: <20260919124605.12429-1-johannes.goede@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: yWJVBNnnRkcEHqWrtLqONEsN_QLKj-14
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE5MDE4NCBTYWx0ZWRfX8xxncN4zKPHM
 scP9si2IXKyu5yiQEiqgiJRsvEgUUMN8/85cC07ZnDm8GiBGNF2FUUKeWxqUtXbRz28c1if5nfu
 sBtgfaKpYotdubG6iCj0mxqQg0+ViYchPkWA8BZ6/I1CofwogZny+FdlNFVZcpaMcTvR6o7McGZ
 ecVcZ6rhvFMdLDc34uOirNwi7EYpGFTfE+vNgXdrEF3yb2a1AkAaVlptD6o5xSJhFFH7hGiWndc
 BI3KFuAeJb5NjLEZgxADAJLRdtbZ4UF3+AZPf+/bbcjyvOHXV1ztHyFxVIDfd1up7pHJjqSoa2f
 rnMRaVjx1vkBfICoXuCQqachySa1tNRL6mUsyX7Q4Hq9Bwzv4iiPyXBKXi0PqgT3SeRXbr4t6Pz
 hlm820VJYqyJvP73yYAFThFYo0aGkh1tfToJvDuKHyL1EsJxc4UcAmDOG0seNHJ1y2NMxq0GK/S
 MtC+r6SgcMrwwp1PMkQ==
X-Proofpoint-ORIG-GUID: yWJVBNnnRkcEHqWrtLqONEsN_QLKj-14
X-Authority-Analysis: v=2.4 cv=bPqDs/+Z c=1 sm=1 tr=0 ts=6aae8414 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=ta3r3zHELXrGytohR_IA:9
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE5MDE4NCBTYWx0ZWRfX/6hOqrL4ZPDv
 bUXxCb8aXPKZVOqDs+Krqkhk5nXMJvAzbZX9rfClKRb1KAQK0aReFjx/llFt5g/Q6gfsNllVGOJ
 biSNKgBz0NLiGn4s/Sict01u3COz4vE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-19_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609190184

acpi_bus_check_add() only calls acpi_scan_add_dep() for devices of
the ACPI_TYPE_DEVICE type. So the dep list of processor devices will
never contain any deps for that device, making the acpi_scan_dep_init()
call a no-op.

Make acpi_add_single_object() only call acpi_scan_dep_init() for devices
with the ACPI_TYPE_DEVICE type matching acpi_bus_check_add().

Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/acpi/scan.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 40bbf9e322c2..38ac6c470a9f 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1873,25 +1873,26 @@ static int acpi_add_single_object(struct acpi_device **child,
 		return -ENOMEM;
 
 	acpi_init_device_object(device, handle, type, acpi_device_release);
+
+	if (type == ACPI_BUS_TYPE_DEVICE && dep_init) {
+		mutex_lock(&acpi_dep_list_lock);
+		/*
+		 * Hold the lock until the acpi_tie_acpi_dev() call
+		 * below to prevent concurrent acpi_scan_clear_dep()
+		 * from deleting a dependency list entry without
+		 * updating dep_unmet for the device.
+		 */
+		release_dep_lock = true;
+		acpi_scan_dep_init(device);
+	}
+
 	/*
 	 * Getting the status is delayed till here so that we can call
 	 * acpi_bus_get_status() and use its quirk handling.  Note that
 	 * this must be done before the get power-/wakeup_dev-flags calls.
 	 */
-	if (type == ACPI_BUS_TYPE_DEVICE || type == ACPI_BUS_TYPE_PROCESSOR) {
-		if (dep_init) {
-			mutex_lock(&acpi_dep_list_lock);
-			/*
-			 * Hold the lock until the acpi_tie_acpi_dev() call
-			 * below to prevent concurrent acpi_scan_clear_dep()
-			 * from deleting a dependency list entry without
-			 * updating dep_unmet for the device.
-			 */
-			release_dep_lock = true;
-			acpi_scan_dep_init(device);
-		}
+	if (type == ACPI_BUS_TYPE_DEVICE || type == ACPI_BUS_TYPE_PROCESSOR)
 		acpi_scan_init_status(device);
-	}
 
 	acpi_bus_get_power_flags(device);
 	acpi_bus_get_wakeup_device_flags(device);
-- 
2.55.0

