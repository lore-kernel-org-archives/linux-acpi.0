Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824275;
	b=F2GNEPwlZ851QGB08iMk/1Hkuh/B7xF2pLMWO0GTDYfR2d6RSogTWd5YFfSf4SsTrP3s
	 fthqLc+u+etFovQXL06G1sUbXRh74jTRSQQW4EsIpGrqHJlNyr1BUUvl8dOkdTeZ03avs
	 OLdNvKoLBc/bJHeVOivdDoe7ed7OgAO+WnKN5Ixhy9CVqpHHseLUoaBTpuYWe8K7sITGC
	 gL4scr/XrPJ8a1Jm21tx58tPz1eGNOu/6NO3ZTMh+/ZM9qIrG7IAc1Z/nNsg2Jix1hYOp
	 sWNrG6c6MoW8gU46utu6YrHa06w+jusHJz10Vx25ENe1O4OzPORBptNZ+WGrmduhDyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824275;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=hGOBieZk2PtXxfkkGYUG5/AE/vrxqMd+djOufADWUKk=;
	b=AOeZaP7zwIYCoIEDb3Foyo0l/d1W8SMRqAYXjgWw1zUDv37PFCtN3TGnXb5CdTmSiHsu
	 g6Hl02C/C3NfO9TXNaFfRjHg84R4BjPHSyxSjUV1tDmVSgaXjDEGgOxA2IYE7DHAs5cgp
	 thsS29aXKJ12JRXrpFou8teODD7VcF9TNMqlJhIUMhbjJQ6VXPMujZkmpPwIUc0894Ovy
	 r6ullXvJqHc+WQk3TV/2sUPDBRPy8Khi/+mlFarFrdvYeO1QnTZoWPNJG7X832oFU5xUu
	 0i66qTo89mM42Ehc5hcvMVs887elB91M8TgDu+l+0kxHZx8uKvFKmlDtVQ656KdKKUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oJJqTyt2;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZIVNo0y4;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2497E606A8A0
	for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 10:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2497E606A8A0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oJJqTyt2;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZIVNo0y4
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGA4LMR1228044
	for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 10:17:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=hGOBieZk2Pt
	XxfkkGYUG5/AE/vrxqMd+djOufADWUKk=; b=oJJqTyt2MsWhalXFA4l/sayAUlO
	a3GjfoiwrVP7bIZoswt+6hslnBuBTvBC/oU6VzQnRdEqoYi7vGXdJrgXBzh4ZGH1
	5CixyqUKhsqfxt4K7FdRE9olU1D6Bp9HQCvJLL/vdK3zyqi0k9zDsgAVw2PYZI0j
	VOnRK1lATMS+65UeZm4cCtaN+wJj8m7jmXiMfvGBSFJo4HWcj60LmlQOZd4rQwN5
	jZ0ek7EOeYZFvUGZdYjfysq99BulcVqojxTn/l/OrGraDds7yqySHlT2fR9+Bs0A
	dLXCdM8LDsZ282xIraj4TYBwYSrnwjoAR7J0qvnA9xYXmKiehyNrCQpiyjg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyyrqg1kv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 10:17:54 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-94975041698so235194285a.0
        for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 02:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794824274; x=1795429074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hGOBieZk2PtXxfkkGYUG5/AE/vrxqMd+djOufADWUKk=;
        b=ZIVNo0y4hfS4BB2+62yqMfFiWgeRn55XToEAP2iTqs2pgslQwPXIh6mOL49IicuRAx
         pk/0tn5heHSgopi+SBdnIylTOtqxzc/xMB1wMiu4/IBpA3cVQergKZ/hOvNpJARCo7dG
         A8S8i5NvC4iApgP2+I/GJ8B8HIEnM8oQZlYxGwzwdJeN/iXM6xXIlWfWWNcoEzfH+M5d
         AMZnlkWAIvCkm1fb9zBJiEDxVLbhGhs8DKEnvO9bBL/UShtHxLm1odY7OJgtwmcsjjHx
         Kz3kSP0gKSZBn6S5gyRKRUSunR6OjUtZV3J117gtFjTQGdmKcfHxNXAWgvpmqpaIEQm4
         wVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794824274; x=1795429074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hGOBieZk2PtXxfkkGYUG5/AE/vrxqMd+djOufADWUKk=;
        b=iNtdTlZSRBe3jZeGt8Kh9QPnfHNH4aK3r9MPj9yn+CEkKO3K4xhODjYJTKuASg33TI
         uB9mK6InKAl39pMfnNUTQsCHNcWe3mErQaYJ2fts5Ad+qQjm81hU1H4WbujS9rcuQvYz
         oUKgFROByb5cUrwNTlndVDQ182cfEpVzlM2lnkDvnOYEpd6KEMBw9DMdrtuoDk29+bJW
         ezXvZ0sLCZNte+b39NfU6BZ8ENmtPwjGg1r+S4DtrYVkLNCx5AfoQOCs28lIIM/Za5Vo
         l9NTUh98s9MEChh8o+j9PavX7OWjmJRXejqpPCQ6KXwc9xO95aZnvhL3uIU11Zg6gCmA
         KH0Q==
X-Forwarded-Encrypted: i=1; AL+hErF9Hohkdbws/T1UUhyGRPNmDXqjKoH0kX0l5uszZBpuuqCkSD8b1BnhynK/qKBGLaycHWstmKiHkqY6@vger.kernel.org
X-Gm-Message-State: APuU4Z/nGrvduFFF8OdyP1brZWYiFwHgFS3BPkmzEkRngELeYVW251Nk
	K0Um8QnKHKcEj77Y80T+cxSR2prrTndDPf4dd35SBAAGYi5BWVXz+dixXLUNQiJuobdK6A8M4oF
	xhu3Y0XvnCIUwr4ukf/wy8zjWO1THPe2n65XYXyn7RapHQLyPSOkgM6QDeZgmWPvI
X-Gm-Gg: AYBFou2+qbIhX8A7EOifNRGSUY9T6QkRUe15uhlbhbkvsvcqq/XVxN9CUA2ry9Lt6YG
	dFBZ4rDGYLNjOzUulWQvHLjYnih4DLk02272EOI7cpIqHiYNJSVD7EJMZ1tJwV1tp10IY4GtVUP
	DyB7zIa0KPB0RGnmYfwXLUh9pUfdkOy8la5s1YYpQYdDJtifaIQ/TdZykXgccuh2i7XBiv+dKVE
	fTZCwKR4ZY5VO0YtaTo8QplIOJpnQDihqpazRJTrZlb8wfnv1/z+fxKAhIQGkRc7NKXF9m983qG
	vntivKzauojNuSc1KR4SzEtLw7yfEWzueBFBhtz6R5aRNcNlD507tVU4b3nhIPkO6jYAKH1sxoG
	1DTG3ovJwEfU6maFnge4XrqFb8FW1DrGOIs8iFzecdZHacbriOKuZLSB8t9nl4qL4q6Xb0bKV2W
	lR2MQoiHqUcWFp7TC9voSnqQ==
X-Received: by 2002:a05:620a:4046:b0:93f:5a85:cf9 with SMTP id af79cd13be357-9493301e743mr2007576585a.7.1794824273618;
        Mon, 16 Nov 2026 02:17:53 -0800 (PST)
X-Received: by 2002:a05:620a:4046:b0:93f:5a85:cf9 with SMTP id af79cd13be357-9493301e743mr2007574985a.7.1794824273227;
        Mon, 16 Nov 2026 02:17:53 -0800 (PST)
Received: from t14s (195-200-21-10.mclarenap.oninferno.net. [195.200.21.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55acdccfsm290351955e9.8.2026.11.16.02.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 02:17:52 -0800 (PST)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH 2/3] ACPI: GED: Refactor acpi_ged_request_interrupt()
Date: Mon, 16 Nov 2026 11:17:41 +0100
Message-ID: <20261116101742.13702-3-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261116101742.13702-1-johannes.goede@oss.qualcomm.com>
References: <20261116101742.13702-1-johannes.goede@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=VcJir1p9 c=1 sm=1 tr=0 ts=6afad852 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=LwtOfSRbDNzKn4Mtwg6Q5A==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=8UAG5Gx70bQiPTbmVrQA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: CbJqTiGc5hU1lHpDXf5KQZ8zx951zE3q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzOSBTYWx0ZWRfXyOwzIp9MH2WJ
 2RzhFvm+WwIOkDRO9zpdyLvUUQ1mUj3oSBzZSYX9waJfqXVIVtWK2VV+u0+6XsSDmI8FaLwEOPI
 3INj5GUXF4osnfePoyEcLAM7UBbvK2p+FpFtF8EEWtx/g0b3Rh7AFjGT1OM/fQbqlmfGLdIR0kR
 3EIzaNCw171l2/cCi3cxNB3RKbijvm+R/+n44hODpoRL3JriFVu6cWtvUChXMWr0SmSyhzxJcCv
 5QXdo2ajwOwC/Lre3oClnpfSxdey+BN0ZG9iOfT9ndRHyewwC2clVX4eXZliZOfSTQm9Pg5fhP7
 5CJ4Xg5ZqF8iucgDJvuYE9iU23Ux3VtJPy9tfKWpwYDmsWFwKW7BCPNbUNyJ7c2OdE+40ylHG4/
 0awvVt6XQ/FZrrtryPCnjbzGKBTcEMMmif/qYWEozTjhOLpnZuEGtjzwzmzdY+Sj4pss2XA3cmP
 gQg8mOHUUoDbqHHEkow==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzOSBTYWx0ZWRfX5nBGyLa7kn1d
 DvszyTANc3VAhAkq/piiIgoqgPvEuF4IADqcVZoK6FlTkV9BqLy4CDtzSEHPtgj7zmDysDAOv8a
 +JISQx9y7QoxZcJNfYTEecSi9O4RDLk=
X-Proofpoint-GUID: CbJqTiGc5hU1lHpDXf5KQZ8zx951zE3q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160039

Refactor acpi_ged_request_interrupt to use a switch-case on ares->type.

This is a preparation patch for adding support for GpioInt() resources.

Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/acpi/evged.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/evged.c b/drivers/acpi/evged.c
index de0db6782afe..f08b3b14215a 100644
--- a/drivers/acpi/evged.c
+++ b/drivers/acpi/evged.c
@@ -88,22 +88,31 @@ static acpi_status acpi_ged_request_interrupt(struct acpi_resource *ares,
 	u8 trigger;
 	int ret;
 
-	if (ares->type == ACPI_RESOURCE_TYPE_END_TAG)
+	switch (ares->type) {
+	case ACPI_RESOURCE_TYPE_IRQ:
+	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
+		if (!acpi_dev_resource_interrupt(ares, 0, &r)) {
+			dev_err(dev, "unable to parse IRQ resource\n");
+			return AE_ERROR;
+		}
+		if (ares->type == ACPI_RESOURCE_TYPE_IRQ) {
+			gsi = p->interrupts[0];
+			trigger = p->triggering;
+		} else {
+			gsi = pext->interrupts[0];
+			trigger = pext->triggering;
+		}
+
+		irq = r.start;
+		break;
+
+	case ACPI_RESOURCE_TYPE_END_TAG:
 		return AE_OK;
 
-	if (!acpi_dev_resource_interrupt(ares, 0, &r)) {
-		dev_err(dev, "unable to parse IRQ resource\n");
+	default:
+		dev_err(dev, "unknown IRQ resource type %u\n", ares->type);
 		return AE_ERROR;
 	}
-	if (ares->type == ACPI_RESOURCE_TYPE_IRQ) {
-		gsi = p->interrupts[0];
-		trigger = p->triggering;
-	} else {
-		gsi = pext->interrupts[0];
-		trigger = pext->triggering;
-	}
-
-	irq = r.start;
 
 	switch (gsi) {
 	case 0 ... 255:
-- 
2.56.0

