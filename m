Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824815;
	b=w9eu1NN9AlHAB+zBTeTzLueQMK6ZeaeF+PO3w4Xc+4+8bLg82gp+C/s5wXofl808H79f
	 JVeHOrzx0jxLydkjMz4pNYdQv1Kgp2lcqFqa83E09ULlmdxGJyzMjCBSLGKIq9/btheBO
	 v5PPSwqpQ0n8dP2LwEAdBUAfSgG+mVOnnn2B6AyZ3XNueqRaM7tzwnJ3u8jtmAGMSwTKC
	 1/OWRp9K/7kAh5Qae73jKAHHoJrBUISzJ+jyuYZ3+PVyraue8d1gvbCMbYOpAwAq9X+iJ
	 snLwAx98k7x+5aYtZYXCZXIU8pVOoYkCmiuaBdwU62CIO9g99RvidBLS1tb0Gg/vNPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824815;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Lv88ScW+ouY37LQD63eZGhNen7oXNBfjhBtP+unAHtA=;
	b=f70gUx52bB0scZKdFyV4taw0Zv6hV/VDxxXOdygzE8aotJsvaEN+xndDU3c/T2QHS6Aj
	 NxeX7SiljkLtOpf6Il69/UZgGhyU1HKiEWebdPrbBgvf51fbUwdvoeUJhGwKwaDJY1sUZ
	 8L7VHreK48LwmSnbrxKPSK4Hi+1B1GOU0fAxPSuJlQ1A3ha92pzT1krO555/3hUX4+2aj
	 7ZsS7KFbv68Gqm504K0y/GZ596htN2Ptk1sNlimw4Srt3TgntPTWPGq0kX4zDFOT+7HY5
	 Jz4PW8zBofZugi5wPfZMd9byeWKp0Zg7/ZVMYLDKId2RyRFovPLxHo6zy5MAEDHw9PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NMy1VXxr;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d9X5Zduj;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C825A606A323
	for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 10:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C825A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NMy1VXxr;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d9X5Zduj
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGA1kRK273465
	for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 10:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Lv88ScW+ouY37LQD63eZGhNen7oXNBfjhBt
	P+unAHtA=; b=NMy1VXxrCcEMHTTyQ1QmmCt1Q6zOix+GHyQXAknGO+hAe0V2/Ek
	SVI9rOzNaBY5Lf3xte6cK+K8bN6yOHQOfmy0DW+49JMTrI5ffA0FqgGYEHgC+kBu
	C4jBzAicsINTNHSudArkH5YYyKekHIRvQF2G5EuSTALdNXVwbim3zrFb0SYGC3eP
	l1ZAqOQx1UJPMzUmI+T+2E629KhEbbuhplPnAwZtEAVjIa5K3yoT6SNr58YrCjfg
	PZ53lZLDzpHbAneTQwBqOfs4dlB6LR0wb6XjhhyfXxecVAjWnSwe/adisy65BtNu
	pUWlXz6b8ggeLWw1yRl8FqnSMA36NCWSrog==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyyqgg2w8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 10:26:54 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f5844cb60so616419985a.0
        for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 02:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794824813; x=1795429613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lv88ScW+ouY37LQD63eZGhNen7oXNBfjhBtP+unAHtA=;
        b=d9X5ZdujDNxIPPdU6Coas9lDIbyO4d/MBVDPnHNpnGACHae4yJWxw6aEaffW8aD+lO
         G9lBRjPFttE9Zmt4fHHIPTgObdG148i6jrTFzAztqwMw5d9apMIQQlTOmGtk71uuIhEj
         pybOV1sxdAwAwsC5uGr+dG/Yp3wd7g9y6hdr3lXk1cBRIq8+N+W47k/UyHiLkM+wmIgs
         cMEO0+imd7O9aemq4cUm4YS4gJYJPCZLwTAy3/zVvkmxfLVv1FR1Rp5YuJr6te1GhXzn
         2urwcBOmnXlcdWdrqDEVeJG1Jelv3pdsGkYozRdVIdeCn6cLDQcSY00DZ1hWDw82GLGz
         IDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794824813; x=1795429613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lv88ScW+ouY37LQD63eZGhNen7oXNBfjhBtP+unAHtA=;
        b=NWxYL87k8egh/X+Bu9/opFgpse+OxG7QxHlu0qts5DGjAv6kzDK8yiUODgeZBaZf/n
         DGWljHhMyE1LjpW2jGTh3cgHVEhSSxjTt8MuuYbRowH5bGQTCypNU20CDltE4a/Ku+7u
         LpD6V6jVJAjfe/tQ9BhGShV31e3/cMuJyyyYS34Ppc7jzbw2g5nb37xk2VAPlwPJ3ZYU
         DBOOm5htJJ2hUqr9ZgUiB6x1myIFBdSLNFmODiG94TWpHKkWPXovSbt2lwOlTiSDAVJ7
         7wwKtKblSJh6gUDf1o/V7GowQANZMpIfeeSno/NvbIDiiQr5QPjV/sorZq6JmTakY/jH
         H81A==
X-Forwarded-Encrypted: i=1; AL+hErE68O1XdNTmvQ9W8GWwmjSOdpC6Bfc5/e9I0CBIqi9/ljmgPrwmMbXk9uYsbgbQshcjROMEVfZMvcOV@vger.kernel.org
X-Gm-Message-State: APuU4Z8lHJnJODyXZOg5PwXteq4cr8vGbyL+9XYp9PeN/W6Xar36rbO8
	IUJHk81njvDNNJ55/QD3S9Mgaho/7jHfkR4uer9j5pPJ80FTTuQxgQpo8iyYeqa492uJmXnGJox
	9Hbw77GuOQMdF/kX99aw24kzlo4Qsn5y0lxQV7f5aFoV79A3idsoL4RPC935i1Ol8
X-Gm-Gg: AYBFou0GAA8q1fbEGTfCrrqouCjZE0rNSyHSelv0w/nbBYJAsqJGhrQjqJ4Ip606ZET
	d2M+UNxSQvXqC0rYiV835YuIYc00YYnj2qJRvMo6/8LJYXIEz/fz6bkYDC/FcL4/CJKwoATHW/d
	Rym+ELJ9UpFv3N2a2Zirw5gTYTCRZRQLaICwWZOoat9O31QsWzce/q4VWAVg+KnuSYe5dBGjC/l
	vIJKlIy56YBaGYRFPJVw9rHnttcYZf/Q4Z7V9qLAybZ0LL/+YVImgWSNUqJoIn0s2tjgoWo5QJE
	ensfUuqMGizsxGM1FonX0lEYavrzHApbVOc8xt98MahWjlVMqwu1l6Epd6XbmJ6Po6ek8D2FsLw
	7Fu8yD1sywO6+BhYo4axT2Gw3MtKGWGa0uc/XVd+hxAfWmjTjqStxMtv31L5nPN0yYgmEyDhf1z
	vnCLvXy31xSWrxj10famcDHw==
X-Received: by 2002:a05:620a:a911:b0:949:3cfa:8592 with SMTP id af79cd13be357-9493cfa8d6bmr1487250485a.17.1794824813143;
        Mon, 16 Nov 2026 02:26:53 -0800 (PST)
X-Received: by 2002:a05:620a:a911:b0:949:3cfa:8592 with SMTP id af79cd13be357-9493cfa8d6bmr1487249285a.17.1794824812738;
        Mon, 16 Nov 2026 02:26:52 -0800 (PST)
Received: from t14s (195-200-21-10.mclarenap.oninferno.net. [195.200.21.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5d03b104sm22128809f8f.6.2026.11.16.02.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 02:26:51 -0800 (PST)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: button: Remove unnecessary acpi_disabled check
Date: Mon, 16 Nov 2026 11:26:42 +0100
Message-ID: <20261116102642.15099-1-johannes.goede@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA0MSBTYWx0ZWRfX/c8IEoLBNA17
 5LW9dPlMLAKHm5Lt1DOd2X1qikR11J5nWlF6aps78s0kGxCWNz88iu97c20paKWyZp8WnCVUwLb
 yKgxhsya2uMpYPwCNT2rhOTxMNjN12A=
X-Authority-Analysis: v=2.4 cv=epRKXYpX c=1 sm=1 tr=0 ts=6afada6e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=LwtOfSRbDNzKn4Mtwg6Q5A==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=wi-P8OBA3d0dur3ChMAA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: M8qbtW4WxM1ULBQkozGrDSDCQTR1JlJ_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA0MSBTYWx0ZWRfX74GY60pc7lA3
 pgDV51ZFtFN7CdBNG/JY3vpO0kXKyeKNOZuOc9eABP5JgPXaFrhPiK/3GkyfQcQELnlnUfvUCDy
 zC2tARp+xCuXSn5NDO8jNHHqpZq3aFNOkwzycSoTbk1ytPAwzYGT7tjSnAdL7N++UizSLAztyEO
 QXu9RNNQJTHRr8UkkwMh5I6L3rLcRc9oDpd6l6JtS3kMv0ZYXmokV/xfIfFp0IdDIsEBqOTl8ot
 EHs5FUx5Yl2hWc8ROeOp5+grbXe/GspsZ49Fx6VF6dPlIsznqu+XXxJUAE2xHbM73eISJa6Ad7n
 eq0F2sPYkPp2OpzBBwYaXL5FBcAUjDWeACXSLoFdX375q0tTRtt91xGwi8R5UgPtMijMeQyEy/c
 pv0FsDbxHdFEVh++Zde6+t+arOOD/d+NrPf8owvO4c4oAPMllpXrVD45kZsBjUSQWq6hK1vtd0A
 ooIdN6EWEZgfRjt6U7A==
X-Proofpoint-GUID: M8qbtW4WxM1ULBQkozGrDSDCQTR1JlJ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160041

As the comment explains the acpi_disabled check was there to avoid
returning the error acpi_bus_register_driver() would return when
acpi_disabled is set.

But now that the ACPI button driver is a normal platform driver it calls
platform_driver_register() instead which works fine with acpi_disabled set.

Registering the platform driver when ACPI is disabled is not a problem
since no devices to which it binds will be created.

Fixes: 52d864019636 ("ACPI: button: Convert the driver to a platform one")
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/acpi/button.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 91a4e9698f7a..d8f3641b1a40 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -822,23 +822,12 @@ static int __init acpi_button_init(void)
 			lid_init_state = ACPI_BUTTON_LID_INIT_METHOD;
 	}
 
-	/*
-	 * Modules such as nouveau.ko and i915.ko have a link time dependency
-	 * on acpi_lid_open(), and would therefore not be loadable on ACPI
-	 * capable kernels booted in non-ACPI mode if the return value of
-	 * platform_driver_register() is returned from here with ACPI disabled
-	 * when this driver is built as a module.
-	 */
-	if (acpi_disabled)
-		return 0;
-
 	return platform_driver_register(&acpi_button_driver);
 }
 
 static void __exit acpi_button_exit(void)
 {
-	if (!acpi_disabled)
-		platform_driver_unregister(&acpi_button_driver);
+	platform_driver_unregister(&acpi_button_driver);
 }
 
 module_init(acpi_button_init);
-- 
2.56.0

