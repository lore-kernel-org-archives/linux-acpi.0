Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783C1390C94
	for <linux-acpi@vger.kernel.org>; Sat, 19 Sep 2026 19:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789846610; cv=none; b=eVUExGWPGnPQe9r4mgkBJ1BO/hF/GpBGUJKQdRuGAlMPJFB+MO9l0UcibogwGcfTNBHPqvYtJ+c9kc4aB8aW+9OdB9lGz+wiok8Xyk9Okk19tkk2lq860UrdvOiW8aoZA++Yd9Cg57yjxxHAeShp+VkNr75S50VoHyorsGu3Lpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789846610; c=relaxed/simple;
	bh=CntfZH5YpGD4rg4E0AvfvaxQfBqRMlH85OJ01FCAET4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IyVs/lbYCFONjyX3EKqCDZudByapjd5/hszWEeu4YBAul8py4jiFzSyZWLBCA3LwzdafhRS43FLihTJKarjwryBuzSPvf/5EBmpyIiQtfBWylB2vLXBMmE+JvhLGsRENUEquJErgyVXaHIU1bJ30avPO1nLwTlBfeVEpzXFMEOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K66Huoqn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ET6nLGkA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K66Huoqn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ET6nLGkA"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68JGK10o4141839
	for <linux-acpi@vger.kernel.org>; Sat, 19 Sep 2026 19:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=lXyCZAnmc1IzA3rJMUzPME9X4zRA0aPBaKl
	ADkS4SxM=; b=K66HuoqnCo99DpCiHIaju6wOywdonVbZwdkUhVfkw3yertrAaGy
	ZBKrjm14oJxmn4qZNs0fOrAliqINjQ+mCMP0BIcpVuFRnm4+MYl5M+SLNzL5+0H/
	GHgq4VshG7nLA30P0p3SKUc74KU8VNIMqF0MHKOdg64uDm2wfgb5kmSfp8JedJUt
	dn9Gh5aPdhZffQDsAZO1m10pfWFlMEoI8wGFC6Ofp4SokZhq4CWezWlTEEeJuxZa
	opg8yLw7MjP5TdZo/oM+mPyZZMjzXkDYxMxO2bzgXShj2R6KWjO6gBvpAZmIDYSF
	48BpqMkR7CD5vIXAJm0Z07Hwl89fkC2yi6Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gsfrnsw3a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Sat, 19 Sep 2026 19:36:46 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93a1bffc2eeso566075585a.2
        for <linux-acpi@vger.kernel.org>; Sat, 19 Sep 2026 12:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789846605; x=1790451405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lXyCZAnmc1IzA3rJMUzPME9X4zRA0aPBaKlADkS4SxM=;
        b=ET6nLGkA4ufqEcvtjFm21PmKK+YoHW2goJShm9feiGPP0wZtYVqBmqCie/vkuRXgHC
         XwSxth4QJ/ZZjGdYcBdxgdUuPiJWVdjjC97+bwjsof6nek/ZUouVEqcv1qehBLhP/pm0
         EXLVlNaCZEWnchtH6xZZBdiLeh9lNbfM39uQbSCtfQUV1isK4icexOhqf3nC3f0bL3Fe
         LZ5uZQAp6++dbF7kwZBRaO7wboph8It8F5XgowsKA0cVw5dO1nIa2rrHd+CqeCEPpNgd
         nwuPO6I9OK2ljFEDqrnoQ1snIunZL+Vt+qowJoq9K9QqRHe2sBXc9HpvOrQiCWCHX6vN
         hR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789846605; x=1790451405;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lXyCZAnmc1IzA3rJMUzPME9X4zRA0aPBaKlADkS4SxM=;
        b=CtoynRmDkncZnefnM1Ba761NhfTuTM5KWmerN+RvrvRzbH6j/+Ev5XSLPpnpX5sYjP
         yHdy1OU2bIlFBjSTNKtJvHy+nwcURtGuq5qUZPnee9PWduvaYudZkiKafJa5l7CvphVG
         IPmyYbiqDobIWCpIOZt0db+UN4LY7e+dWRiX5CIWAhvAA4Tgx5VHvLzLCe0gPi8P5ZIR
         anl9z7AXSapZfpk0STZMPHmYChgBgr1ry8eYV4t7VAXOX6dngCmDRUGtINrNw//E5mPO
         8Wz9rkh1cKTF4zqRfKUuOtM6wJei9rCYsLXXs71pdP2UnL1NWH0E2a8IPROIE1rMuFnh
         vJ3Q==
X-Forwarded-Encrypted: i=1; AKwUvBwyJGeq+tpQ3w1zQ+ndYeXaE16JzJeZ462HzXr3hpHKxCZMDxKj60Q/cjvGywKQp2aF7LDeZz9+KRPA@vger.kernel.org
X-Gm-Message-State: AFuF++mEdQPEaOEcH/6RVWKaasY/fsQgeBfmaRdfDVpESa4b8Uep+WRZ
	1RqEVEsPtU+60EkCfkFIP/uVuFueWxpdp7lXZE4Ni9OvBkF5SkRDUL5Yb9sibSqFysRlqOD0kDY
	fCAFEWuzWIPPGknpJut2OEhKmt31QAZksUxIs7C9RcN+svoG3KTQ8UgxUBwuszpPC
X-Gm-Gg: AYBFou3wkCDk2ujEd5TDR24kvaw1712NybM07Nj500FEJDJ8W/saV+zvoCMwkCWYJs6
	ejokB3bA+sWP91fF3CP916X6IiCtZwCl/2QNFipH9TdDIKNgZndy4RNeg+Une73oGyb6h0NdJpZ
	efz5f4QqOtIakCzvjVDMLNWSkVmYlgGjYLwjGfZ/ptUtrKRJcQfM7EQCQdoQC6cdCyWLvlY4No5
	dYkrFeHh7v6hxkrmfO1+M+l6MFYbpxLp80Ef9QxNJGnN4kM5YRie77QXa2sEX65f6QJ2iwQxdu/
	ivGTcwiw6wNxVEjnGmYVigOoXYVqLWBxAkufQJdTZB31FwBOFTxlUhrRzcFwdgcJAtX3ZsrzMOW
	TQNhNk68gnKf7h6atNykUNsXaGI6af+Gno8bap9QA8M8rHXi1Ao1qg6ipZSzu52UiqCa4wBQzRp
	h2I8dfxhrpV5aqfw==
X-Received: by 2002:a05:620a:2682:b0:939:fc74:b6b5 with SMTP id af79cd13be357-93bf571dd8fmr312325885a.43.1789846605607;
        Sat, 19 Sep 2026 12:36:45 -0700 (PDT)
X-Received: by 2002:a05:620a:2682:b0:939:fc74:b6b5 with SMTP id af79cd13be357-93bf571dd8fmr312322885a.43.1789846605173;
        Sat, 19 Sep 2026 12:36:45 -0700 (PDT)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa67dafe8csm1623947a12.13.2026.09.19.12.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 12:36:44 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Andi Shyti <andi.shyti@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>, linux-i2c@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH 1/2] i2c: acpi: Use I2C_M_DMA_SAFE in acpi_gsb_i2c_[read|write]_bytes()
Date: Sat, 19 Sep 2026 21:36:41 +0200
Message-ID: <20260919193642.43058-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=W9mtxhWk c=1 sm=1 tr=0 ts=6aaee44e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=xtLyfKWn26C9IafwWvYA:9
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE5MDI4NyBTYWx0ZWRfX4T5PwXj+rhrK
 hQhjsY34ADsi9TcLTRNiRvKybHeCEVSl770D/Di8uSbQhf45DOjjF4pV2ihcdcZdVTlmpdp5iaP
 sDwmhtllYbTjawouCo9hXux+0eXcM4k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE5MDI4NyBTYWx0ZWRfX/vZvfIFnH7Hf
 /dbTJw74OYQazO3110p+EsVeRlMf3i66Z33fZaUKnHXPEn6NUhr1MTkwglws0svQrEz9k+l3BrB
 74rp22WrD0kV0L8kYfnWxohbynOEHkzvBkt8/upsp2VQSotHLCjGlbYkAFgnkp1zeXMqpBKz3gQ
 AXBqWpEhI127FDxFkf98i5kv/HPNgsdTPvXIcter7rAT70N1icOTYrZgWmNrSxoSkwohGzEOX61
 Yrl87CCM1yyFt7zidL01qouYrJynoRRNMnd5nMr2fkjwA2JW/0x9h6igsoqdEVFpDnbR356LS93
 swomfwVhgH7Yzub694eFR/7AiPmJyxoetfmetuvxcgUMGITLeGFrpz+pGd369PpJNhFw1AtVx3G
 xMrE3xghklImazGBtbPOCdhjUKtvjFkHRNpx8Ev8nZ1k8V2V4ebrfOIBUX1F5XvdDCTvFV0IXCE
 h7i6yzUUXlZOQXNOhjQ==
X-Proofpoint-ORIG-GUID: bROdm7aZZxXJg-cRhWzghP5eVndJqTGS
X-Proofpoint-GUID: bROdm7aZZxXJg-cRhWzghP5eVndJqTGS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-19_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609190287

The main read / write "buffer" is kzalloc()ed and as such is safe to
directly use for DMA (unlike stack mem). Add the I2C_M_DMA_SAFE flag
to the transfers using these buffers.

Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/i2c/i2c-core-acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 8f3bdd50186e..583d89c626e3 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -607,7 +607,7 @@ static int acpi_gsb_i2c_read_bytes(struct i2c_client *client,
 	msgs[0].buf = &cmd;
 
 	msgs[1].addr = client->addr;
-	msgs[1].flags = client->flags | I2C_M_RD;
+	msgs[1].flags = client->flags | I2C_M_RD | I2C_M_DMA_SAFE;
 	msgs[1].len = data_len;
 	msgs[1].buf = buffer;
 
@@ -648,7 +648,7 @@ static int acpi_gsb_i2c_write_bytes(struct i2c_client *client,
 	memcpy(buffer + 1, data, data_len);
 
 	msgs[0].addr = client->addr;
-	msgs[0].flags = client->flags;
+	msgs[0].flags = client->flags | I2C_M_DMA_SAFE;
 	msgs[0].len = data_len + 1;
 	msgs[0].buf = buffer;
 
-- 
2.55.0

