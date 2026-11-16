Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824277;
	b=c2lSowDQjIh3vbDUg5v+LOB8QaneZwNrPuHqUKWgAVVw518aKebFtvdZXDLFXMbAo0kY
	 0TN/jvq2XTx40/HKb1mLR+gAeJU5xuFhznH1jDTndu8ITzbjdgWu/n0ztZBUfQPzSAl4g
	 NbDH5njm69ByH2YZ0IngsMfS2WNalbLOkMlTcLQzf/Wp08qM2YpZw8CcB/5ZmyAh28C5Z
	 8vl2jyyZ5o0XUF0ZZpDTmRgND9bxPyZwwzO0lUF/1Ab8BbvGEr0ankV34fZpzsRw/UCdi
	 cF/TIHz2zBd1qi7+DBgr5bP597Q3UnxQQDhlx0HCBAqAVtrgTC0ekJJadzXSeACizug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824277;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=otgFbkrxXUk0zUwmFuOQAdurXkHSM6a/Dkf08klVLho=;
	b=Pj0LqFpLHMDe0JH8E0FD16/wCKlRgMTNv8MCJSJ/dFxmliNGhKfYs1GKH4W6y2VHLn9k
	 ZStF02r/H6/uGhH1baaXcJytdkRk7+K1FNmSdUYzr15o42XHAGbh5USyKhVIR6cS92G3z
	 jn6Rl7PnnNyFT8nk66OETeIg+b4Kqc885CrwFTaldcJ9t2D4TtxzHNVGr17n2M4LpQuN+
	 VpFS/BADE+7YYDqhV159Xfl3AY12HAM5XCMfOae/T6mOF264R1aGyj3ibOY4mbhDQBD5C
	 j+k/eBW7ngi6I7kqFQoFXgrVYPVtyX4ZkSJNy8NKOscluHsxU9iMBjCkZow41QBAedw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Obw8zmSt;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=b6HcdSuE;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69F0606A32A
	for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 10:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D69F0606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Obw8zmSt;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=b6HcdSuE
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG7f0S83488812
	for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 10:17:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=otgFbkrxXUk
	0zUwmFuOQAdurXkHSM6a/Dkf08klVLho=; b=Obw8zmSt/N3eV/uooy/xGGsBLw5
	EjYTgWQ53LsI+5WlMn8c3j8BbYTOfu8/rpHUhiWLH/chrepnd11jvNRVhGdYhv1w
	ViTN9yWhp/sEM+LFh1bMy8BYjb2gpWiluamgtPGi82+We4PH6U5IRvysbH0hLwhk
	OfM4GxxJWLItTY6+vBhzVI04SaavDuuzKid/kYjfk2FESl4YMX+7+ydH7lcYnzRR
	ZsSZPucB7XDsbXtI5vFJOdHGdaBpnZsk3ZQ1Sps/v+WaXp7BJHSfT6utvnbPAXwR
	Uga7cGcewJmGpV4hD+G+MpgAh39Ync8FSPorzqQv5VWsiFDKuhBsdQ9nwFQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhmcdwc3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 10:17:56 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f5844e383so588022585a.1
        for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 02:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794824275; x=1795429075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=otgFbkrxXUk0zUwmFuOQAdurXkHSM6a/Dkf08klVLho=;
        b=b6HcdSuEdItaT9m2YiCrWj/xpVt5EPC/0qp7g9dAPHHE1ZDAM5GYItpVf+peNEFFdv
         JAHqFoOxNp8xjWTWAtUh40WESE5KDnfZqenfUzo+clmP5ufVi6zzByUWP3CtnfF1ZQ61
         Q8NF5slRbhfvIm0f+yOBl1ileCI2rPbi2C3ZgZZseZF3C0ljaIl53a+67XQrIy5sVGnX
         au6cRii5wPnsEjRS9CMdQHjKZBHMUu7mIaynPaOSQSKY4BoajaSvb4jRarVyM7ACsxR3
         4p09zN9vZyYBpHdDBLI7dgHmvnXIkbYjp3vt//JUbbqT6DY0cvI8esJtVsyOIbZttAnq
         bxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794824275; x=1795429075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=otgFbkrxXUk0zUwmFuOQAdurXkHSM6a/Dkf08klVLho=;
        b=Ywb5irWEitMH2Kl70OhKT/WOvkaDhn+nKgvgVu+WRDVDdpgqxwfIbOYGleL/qWIsDo
         p8vOlv/K7raIPELPUnJ1uYnwS8UvsLyrGh3ZZMK2nLuw3WwEl40WdofSp3dgxGUGltdM
         pchKID1yAyQcoAdZkWjEvShCJ672MPPWV8Fhk1JnaWOJ//sH4tQW/+vHjwTM9qSTkjis
         ZRuXOzE0trOaSrdF+0nYxqw6+sZN6KjQ4T2subDxOORFJT5F1GlCxp909umiskhd78If
         C10Nsl3aWba4VIXDL42A9lsIOJA6VBzAyGJI/97bYwZRj03VB1vri/n+QAft6ZocLe6P
         W9CQ==
X-Forwarded-Encrypted: i=1; AL+hErH1Q5PCVIf7PcSLIZfWilxVEr1u5BFoBn7nxpC12dAKw1jJgHNi0J6yHwEbvzJeOnW9LPIyO7OImXUI@vger.kernel.org
X-Gm-Message-State: APuU4Z8RDflfGeHg251HQntd4HHEiPhvDaREajDv6O5qISgr0/1andKw
	kTK+RTDw6jCqJUTLg+ME42iYPHR9J3a8cx8W7f+vnWW8qa5bqJjrHw1PSrML5eRIouA637KUt+a
	sEvhGfsawoe9ac3OKxXkxHozOiDbOZwCBdurG4LJtuauqfmMZinrWN1Ly/Ri6jiKm+M5cIdksp5
	c=
X-Gm-Gg: AYBFou0q24hlVbsztZ93Ry3CZnipgmfwTbJ40U9k4cipotJS8LeqnBvR1Ta4maoh31J
	ygCgz+xIZ/SLwP04WeU4hD8QnHBiTdpHXyRKyWwn49gMvNCGm/cxSwmHptoMMCdFu+5pHmizyxE
	uSG5JG0SwYX5iP85pKOWtjQ5PkNitlSHuAxgZ3m4Hk8i2FTwVcuZyQD7aVmXNWLo4ynymtZT08n
	Pr7ycPRq+9h/+hz1RStENupNC854tOqHDA0L79v3f2hMUP+LZaQRpL9pBsHBzoQjPMTA23ekrtD
	koxoPVOUO4KEQuP6ucNssyiL+4BYUp91cjtLrf2+Ssa21eXIOc1WqjnMJucOOjWDDbyDLKr/nCo
	zmtOXgA+yjS/EuYWRoOuW0pV0N7hh3fqCcTtKPsn68ATz3zish0J55vS0Ip0yWKVgt0WUwunV3L
	1G9nfYzsF8hA17dtcoIEanXA==
X-Received: by 2002:a05:620a:44d2:b0:949:6ece:8af9 with SMTP id af79cd13be357-9496ecea78emr843754485a.34.1794824275241;
        Mon, 16 Nov 2026 02:17:55 -0800 (PST)
X-Received: by 2002:a05:620a:44d2:b0:949:6ece:8af9 with SMTP id af79cd13be357-9496ecea78emr843751985a.34.1794824274797;
        Mon, 16 Nov 2026 02:17:54 -0800 (PST)
Received: from t14s (195-200-21-10.mclarenap.oninferno.net. [195.200.21.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55acdccfsm290351955e9.8.2026.11.16.02.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 02:17:54 -0800 (PST)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH 3/3] ACPI: GED: Add support for GpioInt() resources
Date: Mon, 16 Nov 2026 11:17:42 +0100
Message-ID: <20261116101742.13702-4-johannes.goede@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA0MCBTYWx0ZWRfX0JpIYmTJoyD/
 ddzrkDU0Q+Q7O5+lFQFIw6VclPPNjjUc15vNSb/vwv1Jm+UyPWvxZn13wx99Cj9ulIyEzeljG1H
 DNJ0fReyf9fTbv+X3mhPKJvlVDcLE64=
X-Proofpoint-ORIG-GUID: F2U0_rUlQECuYWUov01DpJQOtOlJrrf4
X-Proofpoint-GUID: F2U0_rUlQECuYWUov01DpJQOtOlJrrf4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA0MCBTYWx0ZWRfX/QKwH4Rh513d
 VKa59r//wRbXBESIhtrNwdf6MAKCwyK/vDe0tNkSW/ef3oukKcR1PzGo1mYDdvkE9Tu+blx6lW+
 HauN9yjcwvGebkzStQtumL5Y65kak+TdU1QnAjFQ0giWxHk/6bzwez20N9SKsORAglFKhZPRS1N
 kPnS00al68pa2cHnCYdQFw1oao5tSbtQj4WEP+LWgiCl/0pCOI1tQ8ppUW7Ht7KAqty9t9TqMY0
 t4WzLb0D4RAhkKu71IZgnAnlrvbVyMsWI1FAUlHxSIJXqWN05HZrtKDyBCTna/UThAaQD0Cd/R/
 oMjW8QQyqXCTP7gVSjOlMLOHNO5YAjNil+kzFI++zqwDKarct91QxSxm/Tc2LkoemREplTAuSAj
 NXI8Ewxpp3cymYmGnDNiuXqpIP5ABhQkNH3ljhUzpaaW27WE7ULg0T/wTD8/pJiH5ithToMkrFD
 FJ9IZREDSXNT35vTN+A==
X-Authority-Analysis: v=2.4 cv=Vpy2kO2n c=1 sm=1 tr=0 ts=6afad854 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=LwtOfSRbDNzKn4Mtwg6Q5A==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=bolT9gIKxD14ojXYf8kA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160040

Some arm64 devices use an ACPI-GED (HID: ACPI0013) ACPI device with
GpioInt() resources in their _CRS resource-list to handle GPIO events.

This is done instead of the more standard way of using a _AEI resource-list
with GpioInt() resources inside the ACPI device describing the GPIO chip.

Support GpioInt() resources in the evged driver to handle this case.

Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/acpi/evged.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/acpi/evged.c b/drivers/acpi/evged.c
index f08b3b14215a..a01fd229f4fe 100644
--- a/drivers/acpi/evged.c
+++ b/drivers/acpi/evged.c
@@ -84,6 +84,7 @@ static acpi_status acpi_ged_request_interrupt(struct acpi_resource *ares,
 	struct resource r;
 	struct acpi_resource_irq *p = &ares->data.irq;
 	struct acpi_resource_extended_irq *pext = &ares->data.extended_irq;
+	struct acpi_resource_gpio *agpio = &ares->data.gpio;
 	char ev_name[5];
 	u8 trigger;
 	int ret;
@@ -106,6 +107,18 @@ static acpi_status acpi_ged_request_interrupt(struct acpi_resource *ares,
 		irq = r.start;
 		break;
 
+	case ACPI_RESOURCE_TYPE_GPIO:
+		ret = acpi_dev_gpio_irq_get(ACPI_COMPANION(dev), 0);
+		if (ret < 0) {
+			dev_err_probe(dev, ret, "getting GpioInt IRQ\n");
+			context->error = ret;
+			return AE_ERROR;
+		}
+
+		irq = ret;
+		gsi = agpio->pin_table[0];
+		break;
+
 	case ACPI_RESOURCE_TYPE_END_TAG:
 		return AE_OK;
 
-- 
2.56.0

