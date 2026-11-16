Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794830833;
	b=IfO7CavThauf57c9K9dd298o1GZlRKbQ2Oo7+3X7o3GgipsV+0AQHPm9/W+hkiyoX/G6
	 9GMVREOzRgEpXnQBwuAyJljUK4MjHPDwsrFNKJsG5HQknALwC3ZLUz7mBwvWdIOQAOiX3
	 B09akhSi31XcQ0bBgZeNRyE1PKRxZODc/H7aUzN9QIZrQEVNE/pF+Ao6IjRsCJcU4GD7f
	 hcfiKAqNuQGlnBHuKTmW7sHFkO4ilzTp0Xq52d9vUCK4IdENlMDic/54X8nsZ7Y69mQUs
	 m+E6GXLaBvKh8kMDyjpQSWLdr9Hztnp1mBaiUkpZ0GkhVKbx0+BCGdl6Jo0d206oa4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794830833;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=7W9UVaJAR8l8ahCPGGYHBojy004he9mjdhwFP9XSCrI=;
	b=y6l9pRkcnrFnKU64pkYf0iY9E8mGLQym/5Z01ZfLzuhdFmBE+A4m0nyjuunL64yFJUY8
	 tF7rPhHG1eYtShflKNrt6r9FnNK0z3j5bSxbl6W+Vm7QmbIDyuJnvLLbXMWn15/820d89
	 jojJJ1O7b/0Lxbwo1GUGBz1Q8+cgs40PZQNiRAPnB/rtasKnLj674oW8zE9ty0F0naSwW
	 YdMZSla7g/TItMLWQEy59b9RLZ6V8k4snwFfQ/GiKbq1pjVOyAePWx4sehjmN8pR8tA/S
	 3cllLZwFRxLnnZ0wXjpdn+jFB+dMYtJkTOe2aj6psOS60WdXWyTSs8KzIGtNjN4uUsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Q8xHSQjH;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D5skqRyU;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36709606A33E
	for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 12:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36709606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Q8xHSQjH;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D5skqRyU
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGC0ogS3770442
	for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 12:07:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=7W9UVaJAR8l8ahCPGGYHBojy004he9mjdhw
	FP9XSCrI=; b=Q8xHSQjHp/hmnNpSyiRKlVSHDpNZt1fwdsz9JxUAl1ggg6Qj883
	mG4bdqBuUfUwcsLM8B/buJydG88NiWLotQ0SU1MzOTwMd5pZrGFb6jYcrRU2NNfT
	qwiGotd+j2+p+MtwwXI8Oi1XZ8wF6Q5ZINk5mrXgVZnOJYHBun3g0K1eNcv58KaF
	JQrvcDVoUkrb9aBYwJucQJpmZeY5ues1n3lK/Hw3WkiaA6EcuQvhQU4auL//GI+R
	lBSJYFvQqY4ieBp3Z8woEVteRcMhEZpb8gmv4yIwtkfIqwvK8Jpj2D8/cB9NA0j+
	b9TRc2V3zuzsPhyfsYiQaKXy+jrORj1zl2g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyy6ggjap-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 12:07:11 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f37c94ceeso804669485a.1
        for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 04:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794830831; x=1795435631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7W9UVaJAR8l8ahCPGGYHBojy004he9mjdhwFP9XSCrI=;
        b=D5skqRyUJ+j8REqkC0IBBblP91hmLz1aycitq3J7h6IBRm2BEClCDXnQEppzqJPpY4
         THzO7m37q2XRxyVkuM8QoxFewS3GdofCYKgkUeGyHK/PlmzTFvftW9wcv9hvs+AYXplj
         X+9P6ohJ8C/pFzkd3Vbs+SxVnx1L1lBRcwZJ2eTNJ4UU74YZkFfQiGHdWkY7q5rI25V4
         x140P1zMa3tPov1mzm9GcM4ncoOhRvwbWN6PRRfF4ZTKccsF2bQKGZTVNBpQIu3oBoQq
         1EGjrqN5BGbt5Pz47oiKSVF8R6AH4dta6Nw0qSCzHc37PHn6/uHEaaHmTm2hRWa2WjPB
         PfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794830831; x=1795435631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7W9UVaJAR8l8ahCPGGYHBojy004he9mjdhwFP9XSCrI=;
        b=BIG1Tm82WTk75BDlmxnQ5fLg8h3L+Dp+9CiBCZVMy1Yn3rsoKE5wMyzuRMZmq87YLX
         P4IECE2Q0ItBjKiqkhUBQ5AbkobzZ5voHegsYVx24U+N2jllsnl/ntzZx07TjC8MZN6V
         1c4le2Swb2DnAfaMP9alYMRmiTZ3AOKRw23dlNTS6+wA6lYEpuw8OifDndfBtNunSK2d
         NjeGfQVC4s7YoLaBPmZ4/zREHT/MXQMDbGEAi6m1ykwTh45NErL2FJjYzMYCXG73IOKV
         81zDZwHY/tFOlQzdHF2saHZB9Lk9cH3ub0PoJ3aTdPPtIiu9wcypbaG9UwZJ6vVcoFbO
         BF4Q==
X-Forwarded-Encrypted: i=1; AL+hErFWFbK8NbjOADErcs5tEqVZw+4cUm8idKAvJ9xGDds8Ay8pLrAIpFSa7OCUPZJseeljiWtzR4g4o+Ys@vger.kernel.org
X-Gm-Message-State: APuU4Z/KWaYkjZ7VPdGd3fuk2oMdp7lFZLEFn8ChL4n3Do3jJik+sWYz
	H6Km6R28hjJ/+tJCCQYTMOk5GknWLw17A7+ThTOHkclt0XAP0mdy6/OVS2vMs58Fv5TVJZjj/Z8
	wDHM3FKYkVFugmKRQx3G2ukPIcO74woz9jZ0z5LrBZjEnTdzewCcn1QbIdvJWtpGo
X-Gm-Gg: AYBFou18ju366scUojZcHq1qXp41dQP+KfOJQXZ1qoBONYsc9tCosrugZHTexzuMv5M
	ipK/8DEuGPdqBPUV7to/douPpl6ub3SN+t0V+PhUEb3N0yVUEAO9usu6gJpBZ4oGqBJP19JxqOy
	sItWTbs60luYd8R+xyYRLr2hV7/UK2vJL5e2GoCf2pxzLj8T7JN8eDDsVJzWzE9yAvghGSmjM8h
	kvO/k3c8txylpIZFd4qcsNbiuIc0HSeXP7SCrc27BUKkwb2/qs3ykdVOiuUNPTxLZPNE/a6lTA2
	7eo/UoUnX+OrBAhZ9a2MIvfQvIYqcemXUSqsqmvuISDaXWkljMzuwV/KACVZxlYkZvYRKgZKuj+
	ki9Ct+9JUj9/vNMmI+9Jfkao4y74ak9PN7ANH9jDFGoUIQk9ztzZyYclovtuxHk2JCTrEKQXptm
	PcWY5dAjJtyZmst33POjcSvA==
X-Received: by 2002:a05:620a:470d:b0:93c:3863:ff7f with SMTP id af79cd13be357-94932adc85fmr2028555585a.0.1794830830989;
        Mon, 16 Nov 2026 04:07:10 -0800 (PST)
X-Received: by 2002:a05:620a:470d:b0:93c:3863:ff7f with SMTP id af79cd13be357-94932adc85fmr2028551585a.0.1794830830473;
        Mon, 16 Nov 2026 04:07:10 -0800 (PST)
Received: from t14s (195-200-21-10.mclarenap.oninferno.net. [195.200.21.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c69406640sm21564581f8f.12.2026.11.16.04.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 04:07:09 -0800 (PST)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Mika Westerberg <westeri@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>, linux-i2c@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v2] i2c: acpi: Add AttribRawBytes accessor-type support to OpRegion handler
Date: Mon, 16 Nov 2026 13:07:02 +0100
Message-ID: <20261116120702.6146-1-johannes.goede@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA0OCBTYWx0ZWRfX9hVXONp7LTCD
 2D4sMkVtbGMpSopRjgc33qTsUwZQkwyQf9k7A5qiVLdv3Q8chGbZ4T8uHzJAce7FwjKQB5fjagJ
 fD+pBlGJpFWxf4PSgrMornGPrdwq6Wxq55KXDqxP8/pdd7sjdQWnM1PrVbVePJ3ZX6ZEV9mpaju
 /Jhp12kxjOVXB9lWXz7FOdcXU+/Kd4Y2sUtB1SxJnzlymwHzSenv9uDkQEPK0yrX8BSPlEdKgjR
 eVzg14R489OAzWfrpgMGXOwh7nvPhvuHkJWzvRjrUdFTsY9BG+ThCiyD/1B+ahJr9ZTb9EnjzG4
 tx37XQ3MEfWRiEDcD+ZY1LHjsqGZt+aLS9ov4nIY2619Pm1kH2+2Z2zMREgpv2d/Wa54RawSIje
 H4jHHWs3vyjqU5bA1QEm5UtXlyWFxVqp3TCtQ3p6Nj8nSmrjApB61wrh0XlZRxvBJI4U66nCOfo
 0xQupuqz1ocWqlVGwtg==
X-Proofpoint-GUID: mObAuqxF_Asor54rUhQmzGS95_icHNEv
X-Proofpoint-ORIG-GUID: mObAuqxF_Asor54rUhQmzGS95_icHNEv
X-Authority-Analysis: v=2.4 cv=D/DSufRj c=1 sm=1 tr=0 ts=6afaf1ef cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=LwtOfSRbDNzKn4Mtwg6Q5A==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=JQQ7xCQNSWZi7JF5RkgA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA0OCBTYWx0ZWRfX0aIAsVHpo+ry
 eZKkPhDQ01uBaRJokcP+eCtVZngTOXduAoiddy72CZ8jHInIguB59zXG+Y5eV4YaL3+jrbMD3yl
 +dnnwTM4IZbJMRXbQ+hKASLNe850DV8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 clxscore=1015 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160048

Add AttribRawBytes accessor-type support to OpRegion handler, this is used
by the ACPI tables on a ThinkPad T14s gen6 Snapdragon laptop.

Looking at the AML it seems the expected behavior is to simply read or
write accessor-length bytes and this implementation allows successful
communication with the EC on a T14s gen6 Snapdragon laptop.

Acked-by: Mika Westerberg <westeri@kernel.org>
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
Changes in v2:
- Check the requested amount of bytes has been read/written
- On an error return from i2c_master_[send|recv] set gsb->len = 0
---
 drivers/i2c/i2c-core-acpi.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 84841ed13487..f4f7759c2bec 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -772,6 +772,20 @@ i2c_acpi_space_handler(u32 function, acpi_physical_address command,
 		}
 		break;
 
+	case ACPI_GSB_ACCESS_ATTRIB_RAW_BYTES:
+		if (action == ACPI_READ)
+			status = i2c_master_recv(client, gsb->data, info->access_length);
+		else
+			status = i2c_master_send(client, gsb->data, info->access_length);
+
+		if (status >= 0) {
+			gsb->len = status;
+			status = (status == info->access_length) ? 0 : -EIO;
+		} else {
+			gsb->len = 0;
+		}
+		break;
+
 	default:
 		dev_warn(&adapter->dev, "protocol 0x%02x not supported for client 0x%02x\n",
 			 accessor_type, client->addr);

base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
-- 
2.56.0

