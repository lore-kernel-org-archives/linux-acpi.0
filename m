Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794402979;
	b=GZBNaguH/j8UkXGlsGy0z07XltSs8iAyY3ddaPFhAHzSSMSsGKxIryDSLXRLwOsVoQVe
	 5MiDNSGI3q9orRqsxUZTONhgUeBQ7FkQOpRCaCLN2PTZ4ibpJxL0QJS8rVNcUpAT3dcMa
	 ZKvMQawGPC0G0W1iL/noyJ/iH5hKbNoZkwYyrMDj7AOkr/W4ZZLL0UDD8igxG/kZ4FzmG
	 dNluJMVozwuB9PuQddw1HjCroWOms4upxjQqir/FCknE+VG6LeyxQNkBlmC1AqRyXllIg
	 hP/AmoX2NencsN+PHbgIz8MVuUvMbWiSQsrC+S6FuVLgsqZYTQZXl6sA220lwQcnEcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794402979;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=EpL/UlhMli3NzA/FongzlGW8okom/Xkf+Hc9CuN7O6w=;
	b=gNLmg7h0axcfc6DAfBhC+rCXOXJZRlNO9pxgmepfnK2qufutVnXkQExpSyvVTEoRWI94
	 E0/h5PlrVjbTpfkoZjeof/SymQtw2Ouf6KfTCwAQg9wV9uOFG5uN0M4eAICA7/7Q2AT2S
	 v0HrFC13ZTNlMYOUNePux8VDFRzf7kgO+385VZrMT16hzlVGtCOjkpBqgRDT6HzMCIBgF
	 tzk54D0MC5nHZuMW8kh766rh6QblVATPrTRevhvqGw7IOWlOIawP3nNms5wFymmgnRsiJ
	 7OzpYLWuWqZYO7Rj79x6BEee1C1/vfhlIQf0cartbQ2Kq/nBtELJguryJKxQm6aSXbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=D1tET7ov;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hcS89MQn;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9859606A88D
	for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2026 13:16:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9859606A88D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=D1tET7ov;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hcS89MQn
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABCZ18G2338053
	for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2026 13:16:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=EpL/UlhMli3NzA/FongzlGW8okom/Xkf+Hc
	9CuN7O6w=; b=D1tET7ovDU3+9KHBZwF0yq3+CocjlJIhV0HFEqLLCorlTioinOL
	pocuw7ofJ2j6NeJhx9mSDgFIE+p5fTRDKVXTFd7KwGeQmQMgL7ZUXmvmby/IGLX3
	OlMxwbu5Ro2i33R42TVjSAGC7FIbL90r59gh+8WJPGiqXsKa2sJTWb+VfGKnDGoY
	km0LVTdqR1NlgbyukXuv2+GzLbB6L3g7myvk9eeQbf3spYPCz21iyo+lnGaI2tay
	WL+z9hUUeNiHFD9pz7529GBDprd6DLfHvx7umW4xW2ReGKFQ6+Wwjkvn3BLlpv+Q
	bBDVvKXxQJCKn+KG8NjTBSx+HxI/sk9abxQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvdnmar2m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2026 13:16:17 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91eacf20364so65002086d6.0
        for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2026 05:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794402977; x=1795007777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EpL/UlhMli3NzA/FongzlGW8okom/Xkf+Hc9CuN7O6w=;
        b=hcS89MQn2ym7k3pFtQgrPfQxXaxCcZbAtsB5Hunr/DSyuvOxbSkKtFNb7FxPIuBnYm
         t3TXzLdPR95sGvxV7NAitthApRvjoSQLI4yG96A9+k2UymxyXUFPr2R6SYDSvC4O87rI
         jQ4Dxm920XXxxzsZoCwERhnICW1SWMaQOHdSbr0BNWs6mybx2q+Ec7gQkO+FR/7z0mNT
         Z8MT46cIC3SuJ1+XoeVSWMmyUCtLpiVhcz9GVrmAEKgfxpqetGuciwefCoSloBDty9nI
         O0c8h/3zPDcT9ouLdU/Jv56J9EXL1X62Hw56WhlfUSElbnGqptGq346vLdJNDG8hL86n
         2dew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794402977; x=1795007777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EpL/UlhMli3NzA/FongzlGW8okom/Xkf+Hc9CuN7O6w=;
        b=ZDx5EPMhOOzu5e0G5R9EE8vOlIu3v2a5N6zl9UcHO9LQ6N9IvNlY64KCvSyW7bo1k8
         DEuj69Vjs4Udp+WIk4/lbrFbTzVCeiiMraX9uQtHTPX8WztcolyH0/6zt4HAnct7MNZa
         72rc4sQkO3gwWxiGjhoJLSk+STp4/0WjKC5dk7lCOZVBGsdtVGC+Wyp06NiJz+eYYB85
         p7QpPZYYXB3RyUWGWb0BZOHtIlZLFTr4Qss7oJsBLnmo8/Sip77/pKySSzOydM3BuU70
         SYrRm2sqWmr4kgNsNlNc9L8XThCfSeD+/tBCIYRIUG7bm8uYvPjLmRTJO51QlirmyeWP
         Dzyw==
X-Forwarded-Encrypted: i=1; AL+hErG9C4tPP18bYG1MT8RiVrajj7rO03Uox/T7drZEJiHL6Q4m4AkkkRga9Nw5TRX+yfhZ+Vu/ISxKNk0x@vger.kernel.org
X-Gm-Message-State: APuU4Z/ARAiH2S7N5GJnVV554slnqsn809BVVEXw2K3za89gpdtAvxoA
	BfxXoir/yGlvBDsk6Bokd836smEiL/fHB7XQ/MgLm0cbEdqpKU+S3/Zj+EA5z6bH3XOLwsd9VYW
	IHLE6smZILWfYJKg2/cSYM+bMfs3IFLNE0Zf6qKEeVknALI5NCDKTodBM2nrrftQu
X-Gm-Gg: AYBFou2nINEqOYXOFtLh+tiUTIyedE9smMQ9v7Ko2Ly/xJbnJfXXNBGt8/rhwz0ObUr
	ynzILTsUghGZNnjUbR3bWUkRdkjwdcn6K5pSPxOGMlgSxNE3YHPGEW+NZntBe8hh/Pdd5PkoLes
	fIt6mzrw9IkE8NkM6Qg9SXdfAMLiovK5ZGwRXyoBXInKQS/gAuC75faHIDDNJtRIpX4C9exmS6I
	Xt28epB3wPeaxbFhNKbxenKn2avWE3gsanFY1Q24M+lHCH5NtC8Fuvbn+7QMROmn2YMYsnxpYvi
	qZ8k1IG/JZC70aOdfbXO+xK7QyqJSQVXuf4pW+ZD/tb9kJdZKFs0wbIXjpO7u+axtBCqoTYzNLH
	ccZnQFxbt9qSZQtPv9k3uqtqYvSn2swBeLQrPnHPRWKQDChgU6cOPW4PrrPoa2/5N1ix21A6uKi
	76JRsYGU5p0M/oyMvCWxoN1PiTqRy5bImqufwqEOpDDx8pFZsMUj80BJ05VbAy
X-Received: by 2002:a05:620a:4107:b0:93e:c5eb:2230 with SMTP id af79cd13be357-947afd92bf7mr381829385a.33.1794402977289;
        Wed, 11 Nov 2026 05:16:17 -0800 (PST)
X-Received: by 2002:a05:620a:4107:b0:93e:c5eb:2230 with SMTP id af79cd13be357-947afd92bf7mr381824785a.33.1794402976801;
        Wed, 11 Nov 2026 05:16:16 -0800 (PST)
Received: from t14s (2001-1c00-0c32-7800-07d4-cca3-ec08-7ac7.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:7d4:cca3:ec08:7ac7])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7578eb0b1sm2399995a12.22.2026.11.11.05.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 05:16:15 -0800 (PST)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Armin Wolf <W_Armin@gmx.de>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Han Gao <gaohan@iscas.ac.cn>, Han Gao <rabenda.cn@gmail.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH] platform/wmi: Allow wmi module to load when acpi_disabled is set
Date: Wed, 11 Nov 2026 14:16:13 +0100
Message-ID: <20261111131613.6290-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
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
X-Proofpoint-ORIG-GUID: CWevp14FGyaS3IVzOHwT4MhJBNF0JZzJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1MiBTYWx0ZWRfX+fpFLN6W78XR
 eyQBojVf/2TQYOsPLyLx3uoRv69znCCF/BRIEDU+sU8LjWGSFLsNGh900QcTgZ1YdTcBbdzj4rl
 8z7Jz7c1FRZCnONeiZwO1jH3N9kb9vQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1MiBTYWx0ZWRfX7EYbUrF/VBmV
 xEk+eznl4XTBvNaLrGL7l7bMXnbgUtCD/pAluVZyh5zXUBg3UokJDcdEf7XDqSMaM9CD0bfqTuU
 Mzc6qdz8E3VXTgucyH5jM5ClRwu3nwuLptOSoXJGnIPfIJCWosX+rei88sH6gd5ks+AA5PqmXJo
 nhZI+zN9swe3b1OQdtsLiZ+gy150c4xGVMIAMiP1kdzn3Q/LEmDWutTm3U6y7EYn+ZotjIT2rDl
 Qp4cq5ayZnfKkTr99Yx2VHdjqA60u98LSeSyehCEk4rVGv3dOF//IdYuWvl5wtjFqWXlVh4b04/
 /00UjWuMArjH4iETKWwMFuJJbHn4kFn3Avm8cUSeQJZivUc5Y2gxfVLDs3ZaIsSvrCSCButEei/
 jPm8d/z+uh2c3bOpJDBQjVMD3E9ra0YtDPWLUlBqTLzvDWyqn5VPxNm5ziTqN0nRVj18ub8EaOW
 SajDasHpjLh4Xv/F0Cw==
X-Proofpoint-GUID: CWevp14FGyaS3IVzOHwT4MhJBNF0JZzJ
X-Authority-Analysis: v=2.4 cv=MpzHeGae c=1 sm=1 tr=0 ts=6af46aa1 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=zogTTYgQR-khBHg7lYcA:9
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110052

The core wmi module provides symbols which may be used by other modules.
These other modules may still function when acpi_disabled is set, but
the current behavior of acpi_wmi_init() returning -ENODEV when it is set
causes loading these modules to fail because the wmi module these depend
on fails to load with -ENODEV.

One example of this is booting a kernel with both DT and ACPI/WMI support
on an arm64 systems with devicetree which will lead to acpi_disabled being
set. Trying to load the amdgpu module will fail in this case because it
uses symbols from the drivers/acpi/video module which in turn uses symbols
from the wmi module. Note the video module itself already contains handling
to still load when acpi_disables is set for similar reasons.

Fix this by allowing the wmi module to still load and also register
the class and bus instances since some exported functions like
wmi_driver_register() rely on these being valid.

Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/platform/wmi/core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/wmi/core.c b/drivers/platform/wmi/core.c
index 529825dcfbfe..412f2e23b01d 100644
--- a/drivers/platform/wmi/core.c
+++ b/drivers/platform/wmi/core.c
@@ -1573,9 +1573,6 @@ static int __init acpi_wmi_init(void)
 {
 	int error;
 
-	if (acpi_disabled)
-		return -ENODEV;
-
 	error = class_register(&wmi_bus_class);
 	if (error)
 		return error;
@@ -1584,6 +1581,9 @@ static int __init acpi_wmi_init(void)
 	if (error)
 		goto err_unreg_class;
 
+	if (acpi_disabled)
+		return 0;
+
 	error = platform_driver_register(&acpi_wmi_driver);
 	if (error) {
 		pr_err("Error loading mapper\n");
@@ -1603,7 +1603,8 @@ static int __init acpi_wmi_init(void)
 
 static void __exit acpi_wmi_exit(void)
 {
-	platform_driver_unregister(&acpi_wmi_driver);
+	if (!acpi_disabled)
+		platform_driver_unregister(&acpi_wmi_driver);
 	bus_unregister(&wmi_bus_type);
 	class_unregister(&wmi_bus_class);
 }
-- 
2.56.0

