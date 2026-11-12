Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794491349;
	b=cj5t/5QcHnQYypJkupKvm2dt0B4vNi0Y7ZzZuyqU3iBoMjU871mgLvfi1v1+qSeb4dO1
	 soNn5hF5Sih74rVMd5MTKIplbhJ9N7A/rdLzOBH1kuMcGuTAgk+UR7Z5idPwsJKIn2xlx
	 o9tUxATUVSoYKuneDQE1gKxokrEOOGpCNPaX3N7sM80W463UgJ1l8YlEY9pCe2lEaTijp
	 miVdmjE+mVFghYNSA3eLONRAGb6trHQ2wGDO5h7xJwUKpOocg0gnZFHrkCWzsIjSlUvZl
	 Yg8rP5fLj7MygYBLXiQQbEeV0X6fN9WDBVjpRmZfl7YrzAukBU83qSb4ALFk9RebP6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794491349;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=UWCRboaEh8ibRoIvLn+DX1286L/MuxfRB559M1PwhJ8=;
	b=kqDjKisAGgz0aQLIn2fhUe/5lZe9ZpGjeT0+ISxhXvfNwwo85UBExHihLs5sAKZLqxGi
	 NQEz4LhQ+bxoVdzuycTP9c+e1/IY3/Jf89e5JNzCKcQ6mIqMDwMbdnbrJ5DNh2V0/Vtzk
	 U8678OK2DLhljvWdy/Tqqv8wnvPZV8Grqn28TAskx+jNIH+TBn2zfFryU7NF49XscNyTU
	 nheYibMCiwJGOZU0R7teGeFzGar2D0YZpn8fPV3Bj7t167otrT4R8chZgiFqMwp0/zzdS
	 2bcdlemXNBxsdJx3XoognuQLX73Iy3oNmLmknKzEel5c9k1goQDic/n3eB0CBJ8UM4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TIT2BLD6;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Rf5hns9p;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53958606A887
	for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2026 13:49:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53958606A887
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TIT2BLD6;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Rf5hns9p
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC9Dsue4092512
	for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2026 13:49:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=UWCRboaEh8ibRoIvLn+DX1286L/MuxfRB55
	9M1PwhJ8=; b=TIT2BLD6/nm6h/H0lPjW5FUasIWvkTvrnJDKH1DhjdvMF76yo4r
	WKLJMR0Bknd00v1QUidurARJxQDfCROsoMZmBof/DJLiv2W0R9ziL2Lj4ZtrPWjA
	87QrQ4NU+MtQlYF4SYmhXk4AToPCwXmsBeneUkD09FdxY7BntaMkIfClsGN4jMiR
	+W3dk1rAeUzeqPxvvTAP9mTHRcPmguHeKZyTHqkY262ZNUGSLCmpGuncsyQ7CHIi
	Z07/jneBEEG3b3HbnPMGKhVreAiaspULP73DCpGpl2NoaupPBeruberuRfooTwld
	SNCXn0+04mMdkA+WD4KOYLwI5SLN3FIsvBw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw0m8k2tm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2026 13:49:08 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-948d83322f6so273527285a.1
        for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2026 05:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794491348; x=1795096148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UWCRboaEh8ibRoIvLn+DX1286L/MuxfRB559M1PwhJ8=;
        b=Rf5hns9pI76uqfLWO7IPCWDV92+FygCLxdbP2iRnCF+Egy69reTpE6VyXKiE3SsA9S
         AjEWdI+NOlTXIW3KZXfdBU4o78HqCaLRd4wjO16N0HxJS1BtbtQWUil+6g9u3CJcj5ta
         6DEjkfgPt3eNRDO0goPn+51Pe1PfvPrZhnbEHeM5bb1q1FzFUv+NYkIXvZksdMReuELJ
         niFl+e3unI/gTBPWB8MZ6IgCrFWBbCmW5lCXkQLsNJ4BIOoyF+cEV1vy9ipgGGnwUfQm
         8PkjzUli1yY2e6UeKoo2UhLKRibDscaeHWzyQG2Tld9Nqd5pt8LfeRjjeV2iB3Hk+py3
         rJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794491348; x=1795096148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UWCRboaEh8ibRoIvLn+DX1286L/MuxfRB559M1PwhJ8=;
        b=deYa4nvWZlSYzf7/dlEJvzdeleLh73iqqGzGF9J/e8P171eupH0+f4c/yzJSwIyTGh
         iFSs/S53UcysRJww6DNMRejzxm2WRNk+0hNAbHTcw8t/AWkMMOxAJXq9ic9WMbqKsSlH
         IjGzJa2JYG2LnIz9lmQunLD38uZJ61w1XXyDrT9TYdLUwfzkA0ojNKNQDSxk5/WX3Txz
         +zcMpFDuMKi3tP3yDU5uwQR+186GMPetGrraI3FfiRKOjbvquXnb7o/pI6nzXwINBwip
         18dWIOzPCM33I4Iq/TPeAcrQAs7ujCkXeDf+XwlfdB9jy4bhn6xGvLCcc1pThDPTemHF
         vItQ==
X-Forwarded-Encrypted: i=1; AL+hErFf8H1bHKqsEEvLHdC/c9FaSZcef9wY8piYDeFvQVDARporiOVx4Q0w6GFeibQ4DXrVBgQBfcBy4+mV@vger.kernel.org
X-Gm-Message-State: APuU4Z+KqMoYDSiH+jQpcHXrNHOWH/8qkmsarnwt19DBxEcOKlP9N/G+
	pxdWS5WM5kjSK+HT/JBCtuVRrHeS6ISLCvexurwytZT+OScUrlXxtYyEseZVawmpE6k1XS13Uy3
	ctdTVAvwkF1SDSEKvxwzZTFAtS/Sva1vYoiWExMk7fx0gK8O98y0rzAoLLbtb+guV
X-Gm-Gg: AYBFou0VCPWTE0gmlx9567C+HUOpkU0uKe/Biih8MIHn7lzy6tGQqSupMbuW7S8WKkj
	3AP1fC5qmYnpjKMDQL5Z4sNaWUOjnfbAH9FkABOkvQi/joXAO9bqcA2AWmTPT/WUlJBNjimICpt
	iokehvkdwiPD1bHQ5a3ec2R91LiLxRVWbN2kxh27ojrlOsbicbirLxOMABkl1VUC5HUYQXbe/bu
	NH+6BGjcCW33uC6HBNleKM6E1O0kElijzZrtyca1t+/EkLKMPwceg/GZab48fr+ZkgArY7Vs5vl
	B9+xtzQOGmGA9bgXw6hQucmRCDE8ubrkL+GCUIL6w7BPA/XRCEBxx2SiEDqUPZfk/Vk69SDlfcM
	Ma52SwfTsHgLGvoP95ow+1fa/ieaMYpYndpL+tTqCthTqM2tGYkZbBmH2Os/B0ehcAZgf6H/PT9
	PMMJ3bWA9cxNYYoRtJk3ffzX0UDzpd02/zymtcJMJi5vhMgiP7m6AGJo8B4pUA
X-Received: by 2002:a05:620a:390b:b0:93f:3646:7a53 with SMTP id af79cd13be357-947b008b8d5mr977310085a.83.1794491347535;
        Thu, 12 Nov 2026 05:49:07 -0800 (PST)
X-Received: by 2002:a05:620a:390b:b0:93f:3646:7a53 with SMTP id af79cd13be357-947b008b8d5mr977306285a.83.1794491346974;
        Thu, 12 Nov 2026 05:49:06 -0800 (PST)
Received: from t14s (2001-1c00-0c32-7800-07d4-cca3-ec08-7ac7.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:7d4:cca3:ec08:7ac7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a643f12sm352641666b.62.2026.11.12.05.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 05:49:06 -0800 (PST)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Armin Wolf <W_Armin@gmx.de>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Han Gao <gaohan@iscas.ac.cn>, Han Gao <rabenda.cn@gmail.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2] platform/wmi: Allow wmi module to load when acpi_disabled is set
Date: Thu, 12 Nov 2026 14:49:05 +0100
Message-ID: <20261112134905.6100-1-johannes.goede@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1NCBTYWx0ZWRfX1rzTRjvyo9oF
 do6Z7azwiqQYNnF89nceKrNIITq5O5s0qEA2J1tiURmaE2zStVPh+28+b/5eMJYT4QtsYuA49RB
 xhFs3xVte/Dthwdy1q2q2TBptqsGn44=
X-Proofpoint-GUID: g2a4SzqARjPrKEagN5Lvrki-cWsxEdiE
X-Proofpoint-ORIG-GUID: g2a4SzqARjPrKEagN5Lvrki-cWsxEdiE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1NCBTYWx0ZWRfX4Q8sgD0xjF7L
 3LggQ5cSXMjUCEJCSPseOrCVbCZgLy92jcL4PdDGye9lOEy4XDZrkA0OxY/Cu/9wAyR6RA1kH3b
 0EMUVMDuYe9kObmIHhzHp4LISX0EN6SSuL/QCtqQjhQ/XnSkZUJ9dkcrhcwupclVtZVv96Q6SGZ
 JmjokUDLVh5fCOiPvmwxOa5svw7FfLkbCdaIBDM4UCEKcl59oOHs/3cx1D4PZxucLkwu0NCFt1C
 gDbZkKP0ibfzgiclxMafhNMNQNPNff7Cl1aTPpYd4jEvjRbPxCaZz9G+dWmdKC8OLZPSBn3nai/
 JAQdlCYqDGHzVafyQUryVpo2PxdI0kWrwLNJZ6GQ/idyG0QrYqEjEHkLzT4xl5CQs6ET6XGc/Ua
 ZORjjy3Ts9XB7PnEIANSsHHIY/d9ekl/rbE7Cc0jrHz9EVCma9JiD4IRbu7Jfn2nHx4GClXyz0Z
 T63lnHczhv7txkg9Vjw==
X-Authority-Analysis: v=2.4 cv=Q9dHcI2a c=1 sm=1 tr=0 ts=6af5c3d4 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=zogTTYgQR-khBHg7lYcA:9
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120054

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

Fixes: e2c1b56f3dfa ("platform/x86: wmi: Move WMI core code into a separate directory")
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
Changes in v2:
- Add Reviewed-by + Fixes tags
---
 drivers/platform/wmi/core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/wmi/core.c b/drivers/platform/wmi/core.c
index a99da9b7039d..ec1a51f08e02 100644
--- a/drivers/platform/wmi/core.c
+++ b/drivers/platform/wmi/core.c
@@ -1598,9 +1598,6 @@ static int __init acpi_wmi_init(void)
 {
 	int error;
 
-	if (acpi_disabled)
-		return -ENODEV;
-
 	error = class_register(&wmi_bus_class);
 	if (error)
 		return error;
@@ -1609,6 +1606,9 @@ static int __init acpi_wmi_init(void)
 	if (error)
 		goto err_unreg_class;
 
+	if (acpi_disabled)
+		return 0;
+
 	error = platform_driver_register(&acpi_wmi_driver);
 	if (error) {
 		pr_err("Error loading mapper\n");
@@ -1628,7 +1628,8 @@ static int __init acpi_wmi_init(void)
 
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

