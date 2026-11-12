Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794484930;
	b=1EXHPVWpKKtB94VVeG782zwJ+X3ow/nrn3zuwrZjTU6NstoDWP1UQymX1iniPM4koVNc
	 Io8vQyQ7DTJWdbJVl1Q4p9tdW7SbfzC9eqp7Znp4h/Bv7DClsJkzLuKu7vAS7YTsaBhu0
	 IAbP2nb+V7WCh66WNpSI8zeUK0AkgfwKz7+p/y8Y0XBcRvEPs+Pj+i9eIFICd11tMkmuL
	 itanr+2pA7DD3crCWjLGI6k0isxp763DPsJzwEwS+DIv4s5c+lj8DSaxXloXXfbHCp6BI
	 pi8oqQELrbkml8xGMc8JJYwZ27rv1KbQ1fDmoPnxWFLaqgA8u6UERruFjDhBuQ6WdBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794484930;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=LN4npOI8ENNn8TMuNv0TyruYxv1giv4YRRzHn3sz4Xc=;
	b=fLojJTT5aytcsR4EKCdJvyW/xd2n+0mdkSOmV9oQ6JQJkRgMbXZnZZJhbBiQskDX6jgD
	 v3wNvOrjZHhFB3/+jkcRiTJNvWp13yEV/ssActnwMFQivfsFE8JbJHbFWbrh7ThkHR6Er
	 IqOeEgvMXXwXZ5NMNyzqF65H63Tdg2dxEKZM6cvIMeuKPbeQmCvijhekq0dMDLQ32s7jl
	 zEI0/nJRvngm5YdmiJoQn+fY5HkBTiHFtgOiSp2HEu36t8WocgUPgfEzK1TsS2JjLl36A
	 XvrQwBonAHQxrWU84/cZ2z4FfxFADkNDhUmumUOtxdz5wMqjfuBdJDaKk9GeFqTHexA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="JQbqy/4c";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ee7d0C2P;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5326606A330
	for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2026 12:02:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5326606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JQbqy/4c;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ee7d0C2P
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACAV63I1630589
	for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2026 12:02:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=LN4npOI8ENN
	n8TMuNv0TyruYxv1giv4YRRzHn3sz4Xc=; b=JQbqy/4caH8gV2NgWMRAHNwct7u
	VtFQGJEwMEMFEtU8xYPTOczAHsM0tBKdEkYXMzARYNKSzUfX/aLdeh2GeX3QclcY
	KfOMKKu4wi8b1CPPPLF7EayiWG41B7Zvrb99M+XYGnyZ1nGMQ+rxeDjqn0ib4ayD
	s/aKuaT9JgyP7KOqNst00q5eB9f+MQfeTDzo1YV2N+InkfDWq7AzMpBAFtq/Z+BQ
	3aeUKgcbyfBGKiv533iD8iOD+PZJXHEGwh6ABZ4MT9l0EhQuCyDbUn9i5n/hoi/a
	cNbIf7rLkg3Z9qe5KDqk0ZATrh2fr3KOwmDeCjfUxMD5Zb2LCq9vjsqh9ng==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwbs009hh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2026 12:02:08 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5edf86a8c00so1000513e0c.0
        for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2026 04:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794484928; x=1795089728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LN4npOI8ENNn8TMuNv0TyruYxv1giv4YRRzHn3sz4Xc=;
        b=Ee7d0C2PrmC/n+0d3shjCeo39IWLf3JhT1zoOmuekvgYZPdBRolrbzd+pjE0WYv1I5
         3AkiPRiravgSJp3dA6sTG5RngV23dJnc2MfdB7fMIR5W0K+0K0chCZjuVr8lxMVs25ej
         l76wCSiogXXNk47CkSO5q57XXSgr/SuU5OyAtEYyzqWm5FIjO3xvYZ3IuWHH4ZI11uUA
         dMq4CiPF5ZwMbnElhb8kqGvtuggDgrrfcaOtQLEfd4JmvK316rxuk79tL9zopiRPuEwV
         84MvZP8C/L7OkTZjrMxpmT2DKr7/V0vy9KjY+8PQQRvM4UeNYFXEWJMHN5mloA6zCFKR
         OaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794484928; x=1795089728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LN4npOI8ENNn8TMuNv0TyruYxv1giv4YRRzHn3sz4Xc=;
        b=dMUYaRxyxekaDXd4OgnImCo0xmuVpvLIbOAqYAyUnM9Ebns6sywilyc86SPKRnizUU
         QUiGB8jzPtJiL6JgpT7J7WuahBeORXyk2uOsBM5hexuvWePG/JJJSff5cTYKEmJR82k6
         uTmtt8ktZ6tQYtt0TOy09tTYQsefqqqBr0kqJlzlDtc01DD7JFZedgKGMNrlohpisZ6K
         TEzS/B2C0Y9ZNiMuBoysBAhJ3+DNc5gfjKy52GnGepvlhRyRszZyRIaLIhTAvEEvDNUN
         t8anZo8qhJsSxBsPr/kFAYJ1dwkpay+qYf2BgIFizcdUlWXdAHUYJ+fwEBhUrZFN2rDO
         2cUQ==
X-Forwarded-Encrypted: i=1; AL+hErEJNUaWGNhJYphQqaWW5/pFD40UkrAGsHIPnWPsbJgaf4yWXbZB8kW3Dh6thN+SnMi9B8ZGCafFjxTQ@vger.kernel.org
X-Gm-Message-State: APuU4Z+0++TAudDPxSEIAZ0L9cgO9GmRbj5EBD52e7kHAgYMNLkjXg9g
	ZjjwkuI1HctlfvymVxgxHna1EsdjqKEq5Dea2IIeYqeuWgSJdAkbQAfwyf8/+f1ZrqpYOXWipoN
	XQ+RZLbx8jUwf1hoK/5lmqjK/pb91UQ5cDpm/lizlCNwNN7A7bNzoNJgc4Ks/ATLT
X-Gm-Gg: AYBFou0BG1LB4+Moq+yfQR6KbU9dFTonNGS7v2xqZk33zhEPibSMtER83TCut8RpSaq
	Nir0mBTdtCVEoq5em4BotR5nd/eDZTbJGir6EqjbAYbxrKTVNN7NGejMR9D3radFOgEFVMcu3kY
	CVMup6HGwDKFJRKWat142suRVi2vol/YjUFRsQhxZvWG87FMIT08YmoPWc9GhoRTIl1urzH165t
	HUtroyLKukwGxCh7ZsM7ZmhMkU4jVeJdY1bd4wA/ypALZStIj8Rff+edk1YLj3P7C4kDAmWPivb
	BclpmwJBAJzJc4yMyX0JWScVy4I/GfE+WTETtMU8HZJvQKgdbIJ/wUX7EeB1on7kslIyEGoRB3+
	4D9b0xCbWgn5a7YozEn6fRtgbb53Ynzyruvqx/7LfQECzlm0C5thu5ySjPz4bjdx9Y1iG9QMRbK
	e/E+SXj/8y1hCX2SoZn0OOTAKJwNuL4IH58elzL14sAUnUicyULbZpbDCz0LKN0UBr
X-Received: by 2002:a05:6122:e248:b0:5ec:3e18:b06a with SMTP id 71dfb90a1353d-5ee1bf5d992mr2179496e0c.0.1794484928124;
        Thu, 12 Nov 2026 04:02:08 -0800 (PST)
X-Received: by 2002:a05:6122:e248:b0:5ec:3e18:b06a with SMTP id 71dfb90a1353d-5ee1bf5d992mr2179440e0c.0.1794484927546;
        Thu, 12 Nov 2026 04:02:07 -0800 (PST)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a602b70sm325553366b.49.2026.11.12.04.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 04:02:06 -0800 (PST)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Luka Gejak <luka.gejak@linux.dev>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>, linux-mmc@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v2 1/1] mmc: sdio: Set acpi_device.power.flags.ignore_parent flag on sdio_func companion
Date: Thu, 12 Nov 2026 13:02:04 +0100
Message-ID: <20261112120204.98633-2-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112120204.98633-1-johannes.goede@oss.qualcomm.com>
References: <20261112120204.98633-1-johannes.goede@oss.qualcomm.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0NyBTYWx0ZWRfX9UbSGJhZmWss
 juBe8aY8CCWXLRH0Rn4rI4gGb/WeC1kIEymnrfmk+yLnnPPtMT9Eg8gZDh9xh55T8vmjFu7l3N7
 +HrdJ3pa5lFzn+LMMAeIkF68nVJFXg8Aw3I86Mgy8jmkbIqVOmM+n0P3VDNnO8ywM9Ug9FYVN/H
 Jesmt2EIti/02D4J6VF0zKT+j8x90NvAvwpG26A3Xc3UZ8wsZdtxmTT9lcqmrF9fePRci7nz3vs
 9hNMy4ij4nCAJN1SOJp76iDPkLg9kOmIrJYNh833r0VLv2IGgkX/K3HiYkZ1R6WNCiOf57aBPU+
 HRO0UwDl8wIN+yFUcHhs9OcGcf+74okA0BaijATXJ+9DXCgpxsLWa4CoxMt0BklEeF0No83962H
 3+7jnvwUiCW3euCL/UUuWiEjSDKdaipqnyGk2T/B+mEXZZX1oBTwfUhAwDHip18vUz9MEepZxr1
 BpI3C2l9S3NPXJVDQWg==
X-Authority-Analysis: v=2.4 cv=AsF7T+9P c=1 sm=1 tr=0 ts=6af5aac0 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=BMQ1IfJYKatq3Wfn4ssA:9 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0NyBTYWx0ZWRfX5CuAQcTy5zTE
 dRceJTfdnlVLo2izOfggIfZDwYf1kbAJdOt0a7u6x8A12DQ2ZKGqhKMp9fZrDzmYm/FtGIyTLp6
 Y5Mu2UqxsnKAWRIetkg76RBzmv14IoQ=
X-Proofpoint-GUID: 3FLLqciOGbwG1hdDm0ksPK1JDklUq60c
X-Proofpoint-ORIG-GUID: 3FLLqciOGbwG1hdDm0ksPK1JDklUq60c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120047

Many MMC host drivers call pm_suspend_ignore_children() which allows
to keep MMC cards and SDIO-functions on while the host is suspended.

For SDIO functions which are in the ACPI power-domain this causes a race
where the host may end up runtime-suspended before the driver for a SDIO
function loads and probes it. When the probe() looses this race this causes
the pm_runtime_get_sync() in sdio_bus_probe() to fail in the ACPI pm-domain
code with e.g. the following error:

 ACPI: \_SB_.SDHB.WLAN: Cannot transition to D0 for parent in D3hot

Busses using pm_suspend_ignore_children() for their children should set
acpi_device.power.flags.ignore_parent on the ACPI companion device of
their children to avoid this.

This is safe todo because drivers for sdio_func devices should always
call sdio_claim_host() before doing any IO and that runtime-resumes
the host.

Add the missing setting of the acpi_device.power.flags.ignore_parent flag
to fix probing of SDIO functions sometimes failing on ACPI systems with
the error mentioned above.

This brings the SDIO func handling inline with the SPI and I2C handling
of ACPI fwnodes which both also call pm_suspend_ignore_children().

Also add a sdio_acpi_clear_handle() function to undo this, since the ACPI
companion device wills stay around after removing the sdio_func device.
This re-does the ACPI handle lookup because acpi_device_notify_remove()
runs on some device_add() errors and from device_del() clearing func->dev's
fwnode pointer.

Fixes: eed222aca8d0 ("mmc: sdio: bind acpi with sdio function device")
Closes: https://github.com/MocLG/rtw/issues/2/
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
Changes in v2:
- Do not clear func->dev's (ACPI) fwnode pointer before calling
  device_del() so that acpi_device_notify_remove() properly removes
  the physical-device links from the ACPI fwnode.
---
 drivers/mmc/core/sdio_bus.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 4b07098c33c3..6814d0506445 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -373,11 +373,32 @@ static void sdio_acpi_set_handle(struct sdio_func *func)
 {
 	struct mmc_host *host = func->card->host;
 	u64 addr = ((u64)host->slotno << 16) | func->num;
+	struct acpi_device *adev;
 
-	acpi_preset_companion(&func->dev, ACPI_COMPANION(host->parent), addr);
+	adev = acpi_find_child_device(ACPI_COMPANION(host->parent), addr, false);
+	if (adev) {
+		adev->power.flags.ignore_parent = true;
+		ACPI_COMPANION_SET(&func->dev, adev);
+	}
+}
+
+static void sdio_acpi_clear_handle(struct sdio_func *func)
+{
+	struct mmc_host *host = func->card->host;
+	u64 addr = ((u64)host->slotno << 16) | func->num;
+	struct acpi_device *adev;
+
+	/*
+	 * Re-lookup adev because acpi_device_notify_remove() runs first and
+	 * clears the fwnode pointer of func->dev.
+	 */
+	adev = acpi_find_child_device(ACPI_COMPANION(host->parent), addr, false);
+	if (adev)
+		adev->power.flags.ignore_parent = false;
 }
 #else
 static inline void sdio_acpi_set_handle(struct sdio_func *func) {}
+static inline void sdio_acpi_clear_handle(struct sdio_func *func) {}
 #endif
 
 static void sdio_set_of_node(struct sdio_func *func)
@@ -402,6 +423,8 @@ int sdio_add_func(struct sdio_func *func)
 	ret = device_add(&func->dev);
 	if (ret == 0)
 		sdio_func_set_present(func);
+	else
+		sdio_acpi_clear_handle(func);
 
 	return ret;
 }
@@ -417,6 +440,7 @@ void sdio_remove_func(struct sdio_func *func)
 	if (sdio_func_present(func))
 		device_del(&func->dev);
 
+	sdio_acpi_clear_handle(func);
 	of_node_put(func->dev.of_node);
 	put_device(&func->dev);
 }
-- 
2.56.0

