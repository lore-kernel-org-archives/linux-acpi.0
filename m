Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345963587DE
	for <linux-acpi@vger.kernel.org>; Sat, 17 Oct 2026 16:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792253094; cv=none; b=nCpL0JWajLfrpfW6jvtKa25mUznX6JTMJTWhsvdqbBGM1jlSIeC6wewfN4K3XzOSJRQ6/2fCvfBDpAYq0jQ0QnChlpI4bwMoxtX+Xa9hHIx+g23/Ndf9gR6r6qNu0paIACzrm3MJpEF3LIN93rVDNPjRiGDKd5QUyUqo8xX9yLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792253094; c=relaxed/simple;
	bh=byVAvNqvsjwPdeh+FO9RKveJ6t3iuSgMa1R3KK8A1ss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l65lH/S/8iLG1yrvr8QhE4NSgcdgyCwTlEih4peOuMjwxowlxOVIHlyTn6aBgOgOLD7J6da6ZC7JO4ujx9Lp2vxx6gt3kktaZPBRoIAB9grN/v4OyB9Pfofc2AKLbt384Db+VbyhzAUzj1xSBRNHLHCqJZ4JGbdnSM01y15j9ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GTd+c8tQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MfCIzXsh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GTd+c8tQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MfCIzXsh"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69HDF2Sv1677840
	for <linux-acpi@vger.kernel.org>; Sat, 17 Oct 2026 16:04:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=/ccr27OimvV2UAkq9Kmkh9z2UO6XI19mmad
	BeZlL4Xw=; b=GTd+c8tQgy0d1ilB6i4BdONLqEh1c7vl296/R4QYTdCwRj4SrzA
	koK6EUxfMcjz4wm1/RKTPd4h2Uk2FPWZGwqf57Ktd4KhstVEsbHC7w6eXUE98LGL
	ri7MtQjVQPvY8U9Zoe8z6+KEcbZ1Bcx3BsY5YmS4aXC75biYn+/XIP7Gzo+Z6jTF
	owAV0vRWExG4OyCFC3NfDwLIPcgpHGLD1hKv2fYBUzz6ju5K22gIi2HPHLB6UKgt
	Bp0R25bqub3MSBH79nanEHruabNdrkcmmGn5F3dhMwv+3D89GkLwm0LkT4VkU5xZ
	pel5wzwPhGebPbiN5R241xWwHcXtvEubzzA==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc0kxh9rw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Sat, 17 Oct 2026 16:04:51 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5e91f39ad57so282656e0c.0
        for <linux-acpi@vger.kernel.org>; Sat, 17 Oct 2026 09:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792253091; x=1792857891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/ccr27OimvV2UAkq9Kmkh9z2UO6XI19mmadBeZlL4Xw=;
        b=MfCIzXshHITDDSc02bT/OmL6GhFSP9kTHk9TkzruuM2qVF3i2ZnV9dAV8snzK+mqOw
         tX9eqvZre1Xf+zAMLECmC6wjIuxelxbcNDUFgZrhU0ytbnn4sxDC/qYIJ9mpO0CGG/BI
         /inpgnMeZLwjETs2dxRByRIJTP3pEaCgGvQIOZhOm4aQ5PLfcoHDku6iP3B2Y5vVgX16
         SdzDfQTn63JzbRyHMIj/aj9u8hJ4pMXtniesXxV1/BWuyz5H3vogDIH9ka0hZdFnKAKc
         nLdBYeI2O6vPeW7wEis5aKpuqDIJFITti7oOu+P1Z9vOUUZh2+cbldm6v2DJbVP+ccZp
         oBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792253091; x=1792857891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/ccr27OimvV2UAkq9Kmkh9z2UO6XI19mmadBeZlL4Xw=;
        b=ok3gojUEKwfHEMtesMX6Me+8GhVafIfavPb8QNKI1YJvpLmvAk7wMgjEs8Qmcn+aku
         gnVWEJkac0qlSLiRxpv3XIMAXm87brze6vG3t5uZzYDk/Q+TehiejT369qON67RsTOu4
         1GYfZptLJqXu3BfKkCa1qmfdCZLlxBHiywww4o4CGP8RyVVi0dnZ1bbOqbZO2AmrS0fo
         KDk1upWHBhlo+5mTSFOMhu8Edr23ldisOcB6vzQ7BRzhuvwBMlwe/M/2x02wmibCVvIr
         VjlPo+0afq0YvOSJaPDhxbKGzfbYPPxJMany/+nnwDdRkV+YPCQJ8Y/knn1jUA7Sr6uS
         16Mg==
X-Forwarded-Encrypted: i=1; AKwUvBy/H5/7tICO8zNF3aJR9EBpP9Md4WS9n7cn2UYgZy3WnV2L6JZ8IxWtEOPm27BOflveYxiIEUPUq2NM@vger.kernel.org
X-Gm-Message-State: AFq9FYLLLvUCdBLRzeJyg9lSKlIJ0x0tXUb+fnO0nmPMyMTwSnyMYQOi
	JOgPWCVU992zG8HIr9hOzDXl2g3fylS+k1+8lnSetOSi2anVfOIotkofll4+NuiWCrf1+qCJ0nW
	UG4Yvvc3QnApQn7pQUKR14jcM/cyllenVVS2F2HTGgq/9gk1uh0l0ioEmWCCykbsY
X-Gm-Gg: AYBFou29xtqmOqOumy060MSGBAUovVho1iCM/4V1eNxvHVNVCbPY+NtIDjeLJO0ryNv
	FXair0iTORhcXEl3JixirQ2gwJBxLj0kn+9pxuiunMM6ht2jKFrbX5OxEeHKXUq5pe49rADBWVd
	bvNI1B4dGLzJkIXFQDfnVoBDUWRTJZnOaE6QmuSyjAYbhwBBo89M6/OYsJJnXbk+z7awnaMKN9N
	apnutrkwpz+Jo60Ihf0vxG1rxXPnvMV5Z3h4cYBu8W8UPOXqgDWdslr67oQURc5bv+Gv0gw3o4o
	uOehnRZPe4l1nkaN/cMJziLWZdaRdRgkApAxs/i4Ymadd6AQNa+kPgNU8MEUqGHPPYuqWRXSaB5
	YOy1lO1Q6115tI5jZRitCieEHD6gbJPhPpTN9GyScnvzpJGyf3rF+BEeUFtUyuYYhkACigrhJqU
	vgwizif9P0aifI/zg=
X-Received: by 2002:a05:6102:3749:b0:7c9:624:86e1 with SMTP id ada2fe7eead31-7cc36b021c9mr733946137.35.1792253091218;
        Sat, 17 Oct 2026 09:04:51 -0700 (PDT)
X-Received: by 2002:a05:6102:3749:b0:7c9:624:86e1 with SMTP id ada2fe7eead31-7cc36b021c9mr733942137.35.1792253090745;
        Sat, 17 Oct 2026 09:04:50 -0700 (PDT)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4091eb1835sm187735166b.79.2026.10.17.09.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:04:49 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Aaron Lu <aaron.lu@intel.com>, linux-mmc@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH] mmc: sdio: Set acpi_device.power.flags.ignore_parent flag on sdio_func companion
Date: Sat, 17 Oct 2026 18:04:48 +0200
Message-ID: <20261017160448.77436-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDA2NCBTYWx0ZWRfX9V0Glmx+oxlT
 7bDqwfcKAEaXScg7Ln25gV+E3qOhrzvQBDIMITJcyYiHe+9uPt9TQtz1iFQ7WSALCnswJeI6tQ/
 6iR1jLWVJxFhNdVdwN21258uNBNk8qo=
X-Authority-Analysis: v=2.4 cv=JpZkP84C c=1 sm=1 tr=0 ts=6ad39ca3 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=aOoE8zyrkuWKOWMt7W0A:9 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDA2NCBTYWx0ZWRfX13o64AO/qWUq
 sWIx80gaeCWAtg147Ms+I3MfqEzsZ3zl/COdQNyqti0lL3MPCU2cIgg6BIfsdpauvrPYCSky/Mc
 aO/OLtvpucU3pfN6aGmBqgM4J4UCA3nDta200Fd5+eWDCwUz7cOgHZHvwlMPv5LKeRj+8y/ia5/
 MwgjRIytfgp4T695uTuZZG/800dy8uDUxECYLHpE4x3E39gBkazkKSSNXUWC4kVVPbjqnmHCi/V
 9ms/s1NnGUv5stb9ojB/VSaKUE+4qrjs8G/ws40OAdMH6dXXJEIZL3OzouV2oTGDhkgnZcr1J+v
 7x032CcsDyQtdH4a+l1v0qV9G0HdkvOBjfg9wBt4sqtUVFB07PpulLeSZN4w0KDrey9uMfqgTt/
 FHBpiA9TGNP2U4SnQshJ6fChaLVd9gD9j1qs8N060LGJaVd4vb+rgwIrH/qgW1EIgWcd0sYMit7
 RGJwxxUGmOYIzeGY0Yw==
X-Proofpoint-ORIG-GUID: uQusS7hx2P2z2WMMsUNcWqOwidDMjlZp
X-Proofpoint-GUID: uQusS7hx2P2z2WMMsUNcWqOwidDMjlZp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610170064

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

Also add a sdio_acpi_clear_handle() function to undo this, since the ACPI
companion device wills stay around after removing the sdio_func device. To
make sdio_acpi_clear_handle() the proper inverse of sdio_acpi_set_handle()
also make it actually clear the companion pointer on the sdio_func device.
Technically this clearing is not really necessary since the sdio_func
device will go away shortly afterwards anyways.

Closes: https://github.com/MocLG/rtw/issues/2/
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/mmc/core/sdio_bus.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 4b07098c33c3..fa1d300211d3 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -373,11 +373,27 @@ static void sdio_acpi_set_handle(struct sdio_func *func)
 {
 	struct mmc_host *host = func->card->host;
 	u64 addr = ((u64)host->slotno << 16) | func->num;
+	struct acpi_device *adev;
 
 	acpi_preset_companion(&func->dev, ACPI_COMPANION(host->parent), addr);
+	adev = ACPI_COMPANION(&func->dev);
+	if (adev)
+		adev->power.flags.ignore_parent = true;
+}
+
+static void sdio_acpi_clear_handle(struct sdio_func *func)
+{
+	struct acpi_device *adev;
+
+	adev = ACPI_COMPANION(&func->dev);
+	if (adev) {
+		adev->power.flags.ignore_parent = false;
+		ACPI_COMPANION_SET(&func->dev, NULL);
+	}
 }
 #else
 static inline void sdio_acpi_set_handle(struct sdio_func *func) {}
+static inline void sdio_acpi_clear_handle(struct sdio_func *func) {}
 #endif
 
 static void sdio_set_of_node(struct sdio_func *func)
@@ -402,6 +418,8 @@ int sdio_add_func(struct sdio_func *func)
 	ret = device_add(&func->dev);
 	if (ret == 0)
 		sdio_func_set_present(func);
+	else
+		sdio_acpi_clear_handle(func);
 
 	return ret;
 }
@@ -414,6 +432,8 @@ int sdio_add_func(struct sdio_func *func)
  */
 void sdio_remove_func(struct sdio_func *func)
 {
+	sdio_acpi_clear_handle(func);
+
 	if (sdio_func_present(func))
 		device_del(&func->dev);
 
-- 
2.55.0

