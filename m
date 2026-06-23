Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE673D1CC1
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 14:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782226365; cv=none; b=N9TjtYGEG2NjaAFvOKs9YslC+Do7eGjttLLs2YsNOZE0Vn+5/o47hOhLMhDjT1rClZ87/OgWW89u8ehqH64o57Na/D2N7YyHmhx56zKiBxaDOm5g/oafYm493i0nIa38+qMOOyIVAbc4q4S6Cf3P8NBTJj+g8qw6qTsjixDXn3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782226365; c=relaxed/simple;
	bh=ZInW5BeuvtKt7WQjVviDvn0AZGfWJ5zHlxLDGSfpHNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HbIUUzZRgeRvz87oK9hAV+9+0AvC8D2YL/sTnva+NAxKC5bOlbZdGINj2Lm+iJ1TTBffJU8Y9GRi4afAYWhe2PnynW+DX78KouoG/R3lTDigshij34EbhT/4QUjz7H9GOUc0kJIzkcAququmPld87vAgAXoIR+1wpbgdnyI2Cvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W9s4bgpb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ev64GTJI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W9s4bgpb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ev64GTJI"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBZlQS4052888
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 14:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=z/hxETDnXsC
	raHrXPssAhfCHbQlGbo8HPXOtzZsYNVQ=; b=W9s4bgpbLDsFB3yz0AYq4TU2AEV
	XhrGPGaKIOEhxj/XhfZ0L7CxS4gfx20iYodnmRt9WKHe8hp8UFfcEx4VbNb9GO/Y
	2z7PH9WAuvN2Ac8NbNzRZJU9w2gRHveHX9LI1OqsoPyFT3FqVRDW2MqBXM3Rrntw
	hYDvi1ofVjyKx94pa0btKCDv+1mJEE+YJ1iePOiqNn4oVgY5rd65fGNETAua7t+w
	TSrKrZ28SxVBvWAzbrXH9AFugfxwYRTPpOv1Yeso12o2G4+N/acMHxhnkppErKG0
	ZITjy2i677Dv7f5AiZaV9RGtfit5OIwgVdcdbJkjuLAKK3UuLeSjuPmo8/w==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyr9ys3a2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 14:52:42 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-966cf5e2a48so2794418241.3
        for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 07:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782226362; x=1782831162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/hxETDnXsCraHrXPssAhfCHbQlGbo8HPXOtzZsYNVQ=;
        b=ev64GTJIsT89zaBPqJHzzaCzhct85i/x2RdYokzzM5Dsh82ITsvQDFniZW12FIJ3Xm
         Xtb5jctDNVaE8ZmM3IwJA+/cnla16F0A/Ds6tMt0jsmzZQPpuGqIB1b9ulWK8OvQCZuf
         v7nYwpfXjLvsLjr++z1kJnlJv4rHcgOyzW0+rlgtvBG3f/2oDsgODi9uDSa0LGlxRVS2
         NNv9dEltpsep9gevLrZuB53ElFDAoKJoeupkNA+LoX2JQFsxKMC0QhhJPI40hHgtHsA5
         0Wj2e8dTzkaVvCw88L7nhlxyJEEM6C7KcD8iZ6CvOim6+C0LooYeKh4Os4hFFT9mKX23
         /Hug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782226362; x=1782831162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z/hxETDnXsCraHrXPssAhfCHbQlGbo8HPXOtzZsYNVQ=;
        b=D1cnF2Q42wdYCnY46MQ3L9XyQIw+EDGJXdVz8Sqv95pJxC2CBTpFjwi9gmdKtbyTfb
         tLp2827tjDyeg0CcpB98s3jltOO5JlaoN6xWIzcTlaT3RsXMTn5uowJwkl8ikkTkEj0R
         CcaV04IFC1/7sD0lNicGOG7cPFatjAkRClM0kBo7CrFhKgky89oGHIH9febQolzGrsHe
         1rs9nWHbwbtcsZqPb2YI4e+18bWd6UiwWgetgUsT8Gdc8Xcd7VOWkfmM/c2ZgzfLLq07
         bv+FnB/MOzmbAREzMTzZfMNfPnIGyNthCy+0AXRfB6FdXcVMFsTK2e3cx28Jbn8cjPR7
         Y+2A==
X-Forwarded-Encrypted: i=1; AFNElJ/6j6OykEJSN3kNiCsj24cTxi9HBz32jo+a5CgDCZUonCaVcnhRPOt9gNZ1qRqsoGcUZsiBpnuykZXu@vger.kernel.org
X-Gm-Message-State: AOJu0YypjFuW9pbRwggZCasw5rSMnvldj8oGXVpSL4knLW4Jb7hJFinV
	twmQ0CK2B0f+jXXYFw8R0ckfMu/kgveHxi/cDEzjDUepyrJL/Gn1+SjcddpMFVG7otVWDACh60C
	XP3Ra7tQbf/RUgDwaRHnfj1JbFuvkYQfb2/ioWleq7lTFNhcwK5H1ngd3nW7/2G2u
X-Gm-Gg: AfdE7cnO1M1gM5LxTC31g7N/T+OsSAusgOAZuk9y1uqKFAjHVBIeYghlJjJl6F5XEfK
	2UvTmZej9ntAoRVHDqaQMr1SUR0gstkygDebzzKLNIPNS28syGzakBmQixE0cV70o9Qo7ttKQqX
	9JCo4Wb2MaXwlWw7wFXfZWdAbEc4rgxxRoA5oqDkb0vaS6QtF/afKeNuN6fvXaflLDiNfmPd9GN
	pl39PNRvN8gyJVWEefYgbYB4PqL877LfWWenk18P6sRvugU4/zfzJJjVxmyamOwDWCpbZoTM7Rx
	mEvWd51VN0kG5FyVSi+pHXhWz8jzT+GAC50ksxxa0+zau3otYhtA9x7Hj7TefYHJEULeNqhBB7m
	8YkRn4HRH2KdZkzTyxHuoZW7FNdyyUnRa/OMK97lIGLAZ2DIH9aeLZt5F4IHkW8+Po58g692ZLq
	7u6v09rbehwdmNHmbc5NY6jSCBXQ==
X-Received: by 2002:a05:6102:956:b0:650:94b2:3839 with SMTP id ada2fe7eead31-72ff476b12fmr1406001137.7.1782226362408;
        Tue, 23 Jun 2026 07:52:42 -0700 (PDT)
X-Received: by 2002:a05:6102:956:b0:650:94b2:3839 with SMTP id ada2fe7eead31-72ff476b12fmr1405980137.7.1782226361847;
        Tue, 23 Jun 2026 07:52:41 -0700 (PDT)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c60aca46csm534042666b.36.2026.06.23.07.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 07:52:39 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [RFC 07/12] ACPI: Make device_match_acpi_handle() also check the secondary fwnode
Date: Tue, 23 Jun 2026 16:52:20 +0200
Message-ID: <20260623145225.143218-8-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623145225.143218-1-johannes.goede@oss.qualcomm.com>
References: <20260623145225.143218-1-johannes.goede@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JYSMa0KV c=1 sm=1 tr=0 ts=6a3a9dba cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=Z_5jWvXtYKhrpjqL7kIA:9
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-GUID: DqWIH2ts242qGWyeUF6J5z811O6eXxKu
X-Proofpoint-ORIG-GUID: DqWIH2ts242qGWyeUF6J5z811O6eXxKu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEyMiBTYWx0ZWRfX922CkmeYEhfI
 OYMW2hiKt8AQVJHSF0R+JptoRtBBYdFGPR9XuFp+f895MPtTEKjqDieI+L41HqJPj8nRoVHpGeu
 dlMmRuVi/87P1TdqsjzP71TroPKfPr8melS0HfEZ9iZftu9TFabrrhyWUutwF2INNBFIjQQZELJ
 nsIIsHXIzW0XBrRn7d0KI0Hxj6HGrttjxixfdkB46oNlpGTlAE2PYYfCjvBEieV139Gqh8ksvR0
 2WKJF+CTmyQnvXg3IXCqYOlLAR7ipKuYor8XvouDVxA4aNEGpLy3GpYHywUbIFsCl7c6OEFQGLX
 +Ulvd1vQdBNwFilk1s9lQ87TESO8SupaHgDFuHDhdokY7dHDYgt9XCz1GMNkmkIkZxNktHE/X4L
 GEmwT9oESPIT9EaevcFmvW9evMM27Ltl3LRV9xpE02Y/Jf703BQJOyrH+2UW2782lmUKHtG7fUB
 TD+IIFiz1bRdn9MPWew==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEyMiBTYWx0ZWRfX/6zSfD4jGxjv
 TUg9XfBmwJEcMxa/cwiNfMjz1JzUo6qcWLuvkU2Z3JtbN9+H5CcMA7dYxG12T0LnT6EPKc3G9Qm
 7YcpsND/7uH/57yJ9vfC/7fCAFblQpY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230122

In DT-ACPI hybrid mode the secondary fwnode of a device may point to
an ACPI fwnode instead of the primary.

device_match_acpi_handle() is used to find parent GPIO/I2C/SPI controllers
when resolving ACPI device resources from (_CRS) in this case we always
want to also check the secondary fwnode to help find the parent.

Modify the existing device_match_acpi_handle() function to also check
the secondary fwnode.

Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/base/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index bd2ddf2aab50..2573253f5815 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -5357,7 +5357,9 @@ EXPORT_SYMBOL(device_match_acpi_dev);
 
 int device_match_acpi_handle(struct device *dev, const void *handle)
 {
-	return handle && ACPI_HANDLE(dev) == handle;
+	struct acpi_device *adev = to_acpi_device_node_any(dev->fwnode);
+
+	return handle && adev && adev->handle == handle;
 }
 EXPORT_SYMBOL(device_match_acpi_handle);
 
-- 
2.54.0

