Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDD843635A
	for <linux-acpi@vger.kernel.org>; Tue,  5 May 2026 12:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777983921; cv=none; b=q2KR+yE/lG2dmodnw+iYuE+mbljshCP3nsGlqmJ4hB1szyWIeSVTKM7ozQURxCb32YhpAF8/6cAc769S5OCRLT3GkDebo9BUrGOsgBQ+cXSScjOFCTV3pQPN55rB9Q9+Y/AL+k94zCZYwc2WbjE8bg1UYA9lEq7oV63RvccUjyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777983921; c=relaxed/simple;
	bh=85/U6iXBPakM0Mmmb5NPMjAPvvGqfJ6KU2VNXgLZ+Sc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TiBBdpAfvaUpgd0zl1JAG4NMsk7K756HlrwjwjdQnnuxWwpmEJJ7+RjNn28cIe3GkTGuccYW5LvPqt6gi7ZVHuBwPlmc79CHqSF8tJidc/170BoMk9WKJ0Q3QKQboWkOdBMVB7FRBCV01vvD+hx0Old05++/U3x2rwC9WiRHE5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RAaL/5Nt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bcB4USsL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RAaL/5Nt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bcB4USsL"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6456lpG13187655
	for <linux-acpi@vger.kernel.org>; Tue, 5 May 2026 12:25:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vNQeM4CWq6GEUrlO+R6vYzykbXC2BbBSiNTrZjov5SU=; b=RAaL/5NtaOtf/UeJ
	61uZt5QhzCTyJJJm7qnLWJcbdhiiZeVsNfEjlUC6woArxVpPwCTBsn4awDbGUihp
	27m2eWPYJKNON/xUpn+L9hzcGnm89BUF/dnxHZtnlwwB7mRg5QKxVDIu85W1vUn7
	QB0G5Gy3ZDJcxTkbr8k10lpd0xaDWK/i46+Wk54vw9AcceF3hjVkWUXrwgbYGcvn
	sYyHqRHQyheK6Q6aJ0nv9R0ijhpT0ota0WfayP1o1VrX2YDmmGIoU94djvlKHZ/w
	eojB50BIDZ26n5gv9+YFMedY9sIeJD53+3gtgYK5tppWQq1qaIT6v+7Hp/0RUdWW
	h/l2ng==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dybkk97wb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 05 May 2026 12:25:18 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b4606f6f44so8048255ad.1
        for <linux-acpi@vger.kernel.org>; Tue, 05 May 2026 05:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777983918; x=1778588718; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vNQeM4CWq6GEUrlO+R6vYzykbXC2BbBSiNTrZjov5SU=;
        b=bcB4USsLrSCZD23BYRp3R6TWmxFWls/GiOPg/+r4Q7HQ6ctIcQadcTgzjc6Iug6b65
         2vfdhhpN/5V7O5qUDMcsqdXeybMAZh7LHU+cA3EKozL+L9wVbcwu1lRfEeenxFB4vxKf
         5SnSzqSiSMfsiFIGqZgYX/TyL1tsgqaxbgfU+b0pBxdpUcblALsQyTv0zkqwFCIxHEAD
         YJxJ0+yqb3l4XF6TccAiYO7odPhBGO/EqfHj7gvpGOSbexgmWj5PDdwJBVPY9Jngr41u
         E2Sblvz1KVwAMCKzSmr1758GiQ7cXlcd1mBhW0ukiR4/ZMJA4SBCe47EMJUw9utMU40r
         z6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777983918; x=1778588718;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vNQeM4CWq6GEUrlO+R6vYzykbXC2BbBSiNTrZjov5SU=;
        b=YPUCsAURPXZKH2VGBvKdvLYNPQ46NoO9i0B6+gFX/vpffmquY6XmSzF6EFQxkqXB8v
         4Q19aTgQzC2R2Zw9cJ6VRepIhF5WDFkoXKA3dxO88iLse6ydn4qUB5GQ1DGJ23SOvSUl
         1A88NoQkEPiN62hH6aiYAydE8bwfXIaU2bXGW28bYs8rhSRC5S2jW6zlHsviTo7InDO6
         d9/VSkaNzBXz9wT5jUH5yD4Tab2rYniUihzGS4Mh+U+m4GK5tINaO5ovZZzmzd3PtvIO
         2bMOCNqVoBrJTKVTgCiWlWSdJcJjJicnQ1xd9dLzH7/9O6JpcLMgMyv/qdzzSDXyUHI5
         lHBA==
X-Forwarded-Encrypted: i=1; AFNElJ8Td1ay/naF35pjYuqKlAY+izdpkLmM+dUasNJbN5qTdAfkfQzqSXZ2z6K2npQCKc9uE6AfaI+K4rtP@vger.kernel.org
X-Gm-Message-State: AOJu0YydxSlyvEFWhTPfl6Dhy7LtkLeDYlbgSql5FYLk2nVnVU+0mc0T
	0uB1pLwXGbHYZJc01OImv79xD6+ovyWGlDPpsIj+N/PVTaLYhhngejIu6QEMbN2gzGmkIPl0bfW
	mijdkgvshrGNxHmCD9922aHXQl4crHSfldsNi07i1UaVNohyeJ5bLjGHzCd5DAUlv
X-Gm-Gg: AeBDiese4RLB4Va2HTyiq9RsC3sdfAJBbD0Xh6L/P7nxzufGzajSdc4xOswnuOLKHAe
	U9Gr0Snz7fQWH1UY8fy25/r9bNjjbZF2EedZIi+0sbJPnASn+MHQDYgb+nL5ZXkT4LtjAQ30RvG
	KZVSWM1w6d9SxdO+rvE91Bt3rSIG6rYWmvNT4UDZuj6DnJLWNvs//KOZ9VEee1Da5HuAnIFj791
	Ap7mcnrm9rTkaSB5Z0vVo4JlxlZbH6Syb8GBT1J4DTN32Gq2L0OXPn8nzUvhoR0L68njq/vI5F/
	J50QK8qPTVXePD0FkUwlvJEta4Klz0++HaIEYEK0gLoodEE6phzA5691/2SWqvvQ1DQqKo7KFtH
	P02bqXs+V9/pZJgrrnvdCT9upMIsdMJgDSk10r0ubwNCH+RtbNCLqUxJn08l7mfI=
X-Received: by 2002:a17:90b:2f03:b0:35d:ab8b:abe6 with SMTP id 98e67ed59e1d1-3650ce1146dmr7079555a91.4.1777983917989;
        Tue, 05 May 2026 05:25:17 -0700 (PDT)
X-Received: by 2002:a17:90b:2f03:b0:35d:ab8b:abe6 with SMTP id 98e67ed59e1d1-3650ce1146dmr7079533a91.4.1777983917473;
        Tue, 05 May 2026 05:25:17 -0700 (PDT)
Received: from hu-uchheda-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7ffbbaac5bsm12597998a12.6.2026.05.05.05.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 05:25:16 -0700 (PDT)
From: Umang Chheda <umang.chheda@oss.qualcomm.com>
Date: Tue, 05 May 2026 17:53:48 +0530
Subject: [PATCH 4/8] ras: aest: Add panic_on_ue module parameter
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-aest-devicetree-support-v1-4-d5d6ffacf0a5@oss.qualcomm.com>
References: <20260505-aest-devicetree-support-v1-0-d5d6ffacf0a5@oss.qualcomm.com>
In-Reply-To: <20260505-aest-devicetree-support-v1-0-d5d6ffacf0a5@oss.qualcomm.com>
To: Ruidong Tian <tianruidond@linux.alibaba.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, catalin.marinas@arm.com,
        will@kernel.org, lpieralisi@kernel.org, rafael@kernel.org,
        mark.rutland@arm.com, Sudeep Holla <sudeep.holla@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-edac@vger.kernel.org,
        Umang Chheda <umang.chheda@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777983885; l=1723;
 i=umang.chheda@oss.qualcomm.com; s=20260328; h=from:subject:message-id;
 bh=85/U6iXBPakM0Mmmb5NPMjAPvvGqfJ6KU2VNXgLZ+Sc=;
 b=uAueX0E+J7mO3vSlmsfq2s5T3DTennvda5xbsWtVnYuvom+4lJANe1HZ9CTFuHCFI9bv0MzJh
 UVBLIZVfoxaCfAJSibykZ21OmsQSeQN479uLTCjjakaC2Y6xWj7Te3x
X-Developer-Key: i=umang.chheda@oss.qualcomm.com; a=ed25519;
 pk=3+tjZ+PFFYphz0Vvu4B14pBQSzqcG0jZAQspTaDRQYA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDExNyBTYWx0ZWRfX1nVSBYUoFoXg
 4GfzH1quNnHIne0QLlaQ0PcBzXU8octQX4H597DT4A2ysuRrFdfe9+dcFMpxPOTvNZ1KM0+nx5b
 W6gz8Cx7OW+V74veOwXOyRmyIHIQerLqrJ+f0LmtpEcLBdax94N4kpOm9Ona2T8WRUaEoLUCobp
 2/Vn7Ig2BTEm7Re/z0aKrJkKaznmXY4vfP4rpAksiWYMDvIvIN2tieQaxYGG/V22NefIgxGdIsJ
 biSK+PtCkLmXZLFpvU4ye6lR7kOAkZfc1QpTCD22PS84wSqD7LYlL1BXm5aP5k3hFGqT8vT+dFz
 +Xo98ipBaPd1/7YHRCzPYIAa+q0yljPgvjh4i6qbJI9+Skl6TGpwll4ifBmK9a82RQOY/wD035z
 4HFT87fFSOFxvi2HEDLxmSZjgPsh3xz/FFkIKI9RQZqEfdHlvmJWDtiUU/UqmUfGGJoU7hR8vj0
 m3PcCh7LIE8AD+TiVVg==
X-Authority-Analysis: v=2.4 cv=SPBykuvH c=1 sm=1 tr=0 ts=69f9e1ae cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=y-mMqNAVNQw5A1T741kA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: iyByEqSXL2_kRoRm4Js29f--fK_gg7x9
X-Proofpoint-ORIG-GUID: iyByEqSXL2_kRoRm4Js29f--fK_gg7x9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1011 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050117

The driver unconditionally calls panic() whenever an unrecoverable,
uncontainable UE (UET_UC or UET_UEU) is detected. There is no way
for the user to suppress this behaviour, which makes it difficult to
test UE injection or to run in environments where a kernel panic on
every UE is undesirable.

Add a module parameter `aest_panic_on_ue` When set to 0 the driver
logs the UE and continues instead of panicking.

Usage:
  # Boot time (kernel cmdline)
  aest.aest_panic_on_ue=0

  # Runtime
  echo 0 > /sys/module/aest/parameters/aest_panic_on_ue

Signed-off-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
---
 drivers/ras/aest/aest-core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/ras/aest/aest-core.c b/drivers/ras/aest/aest-core.c
index b4f4c975da1d..9ce782a66edf 100644
--- a/drivers/ras/aest/aest-core.c
+++ b/drivers/ras/aest/aest-core.c
@@ -22,6 +22,11 @@ DEFINE_PER_CPU(struct aest_device, percpu_adev);
 #undef pr_fmt
 #define pr_fmt(fmt) "AEST: " fmt
 
+static bool aest_panic_on_ue;
+module_param(aest_panic_on_ue, bool, 0644);
+MODULE_PARM_DESC(aest_panic_on_ue,
+		 "Panic on unrecoverable error: 0=off 1=on (default: 1)");
+
 #ifdef CONFIG_DEBUG_FS
 struct dentry *aest_debugfs;
 #endif
@@ -342,9 +347,11 @@ void aest_proc_record(struct aest_record *record, void *data, bool fake)
 			aest_record_info(
 				record,
 				"Simulated error! Skip panic due to fault injection\n");
-		else
+		else if (aest_panic_on_ue)
 			aest_panic(record, &regs,
 				   "AEST: unrecoverable error encountered");
+		else
+			aest_record_err(record, "UE detected, panic suppressed\n");
 	}
 
 	aest_log(record, &regs);

-- 
2.34.1

