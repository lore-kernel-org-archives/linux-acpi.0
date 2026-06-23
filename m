Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF053D6472
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 14:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782226361; cv=none; b=uY1gN5mGJymDt0MAmiSczfTwuzCAeGzkn9RmtGTsCaOCrTyOD7Nhh2YChBVoGtfXl4h0n6OIVvOv/DOmbZMAllTDRXEpzjyk8oOasTOKcA/Ny4hfq+NTcgGAqenWzYAVYDUZNVjSs/y9HMoHvKXp34XDzlChLLwahHDFoyFKKfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782226361; c=relaxed/simple;
	bh=CADuPPHBFTGamZXiLDVwfcLPxeezA49Zbw+re0HVbOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RS1Hj6WUSfALxPZEKVUQ8V6ek3hpeLBNbRhKh9SCJC7k+FB8aVJ7NJiH5kGZLa/3ojz9DQ0TXghyTuterPTlnA+6GQTrIQRXx2Qhm00s0iUM/JUZiJLaewmWt5eflz12+lAZ5Jsg9ubtUhze2Y3znYI2aH9lI/3m07MNJP/gIlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HLwOCHlm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aCkni6Wo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HLwOCHlm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aCkni6Wo"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NDG4nw273254
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 14:52:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=B0ZrDubUMv3
	UsfDfx0OoaWw1HQVC6S6Wq7xyx/eBxqU=; b=HLwOCHlmT0pbctt3AL2B4KECHEQ
	z96FH19Yupn/8HcDB6GeB3eXnyFaMGwi6N8bB5k6xClW5CECYyF/NQMH3JIkVlR1
	gzfkY9lCq7iv6eAQx9hlCNbJCoh/guJmGx64+vcKzJAch5gd/htA0lGUhbz63F4S
	ZO6BOPNCU+9/e5COQ0IiG7f53GfeVmwvB0Nfx1jRxDMOBQeLw32KZD6br02NS168
	0dqWIIMC1kD/YC148Oaagg/wO0Cc/3rokwys9bXWAHhh7RB2UwodpiPskui3dcG9
	lnfZNV0SlH3tF8NZAt9ghefIOvEJRHBoTxbqFT0H8piATX1wvn/SLH1yNDA==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eytvh0f7j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 14:52:39 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-967109471dfso3350081241.2
        for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 07:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782226359; x=1782831159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0ZrDubUMv3UsfDfx0OoaWw1HQVC6S6Wq7xyx/eBxqU=;
        b=aCkni6Wowpnyv70PEFDJ0DioLdG/4w5YDT1kGSYVPqtocTORXrfN785nwRVlTxEvGv
         jXCuSRlPCeLPOhfJNYPIdvOowa/rvcyGwNKIm093qh7b2pV+0eozVIMoXX4oBFFv7qi5
         bcU+zO4yFWI3v6fzPRlrsdagx0fL5LR+nyCM5IqJKBM7VAum+un9BeXBeXyHfJyBHRyJ
         RSPOxj1rjR6355DKkV4WYCb/4JwcDnwtVIaOTXcVyTb3D7COsCg54WKQiSlztMKZlKmh
         974WalAUSgvZBK60xl8B5YOmn8ZwAifv4NqxoL+F2NAqvR15usvCR65q26YSiUjA98gm
         cBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782226359; x=1782831159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B0ZrDubUMv3UsfDfx0OoaWw1HQVC6S6Wq7xyx/eBxqU=;
        b=HektlUh3FsVTtWDeka2RQu+daQxWZbhJjUplKw8L0YbuhCZXdj4CAW9AmzNHsf/7Y1
         z0TJrfu+X3++1sSPs1yH2IOL71HRv5tHGmSCf2oA2U0L/oyXijwX6IGNCw2CycKdbbWM
         U/25JE3AUXLrg4F6R8eyHcB43L9bfggL0nU8mEROr5BaYHoaWpr0uZ4V6RokzcrfbyoU
         FsvyVj/X1QVV4ysa+/v8CME6p359v34lDFinlXMvIB0zOxo3cvn+CTDxl3EIkGokBztN
         /sy0HJZKFJB83vxGrNvl8vfJ/5W3oXAh5S/JssrN0n+d/GvzBLeWfT+JwvJJO+LCSejI
         Tj5g==
X-Forwarded-Encrypted: i=1; AFNElJ8T7WrYtediOL20r1hEbRENS04iGOJXjHbYTE3Iml17JOGhMQlxn0T5QOcD+/+02+0R30Z4w61qfaLP@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzn3oOjqp/a7T501K2WoDBQSWYtGgW9NYaFJSlFmN0pD4lcyaB
	whcbhv/336NrGU0JOeYwUY4xyVnO11vy4GRV07pGzVAZYitTIcSjCrLHHh0JyoJsQcTSfGFR78A
	FYAMgOLfp+LuUKPGuYxlxfYC37AAZFxK5Me3TNNs0BSWJxiH60h6FqAh2lyfZdYVG
X-Gm-Gg: AfdE7cmh/wPzCHq1Ze0NVLanXIaqkpiDTj76dkXbs5cd33NZYTBPgV5VFD3veMcCVCg
	89bEP1H1PYeGgsnE98ZuSYQcPTwXztTXRJ43DVcYtSwbxEA0TpL/U5Ju6D+eGl6UipLdrAT/e+L
	PvsAQnI61PwZl1FZSO0SXF6hLkY3/g9s6HE4K/2qVTT/Aax8blSVrHkoSUxIcxwT3C5mRD+x391
	v2gmBNUO1PFCJ1O8RoqBQgWstMlFwTF+jKm0cz8wKXoRUFt1K704xHO4S9lPfFqBI1/5tFOO6cn
	mhZX6En9rq1YYzcdcCc0IYx5ebWXOBdPvAm2QB7T7UkP85cP+3ea0vrd+nxIqsdY3pnyrNUhYEP
	LjJjF4FzBWI7yq4o6zFlx8FGtnxcZ02JHRNQYhgbyYEEQVVQ1+KTw1DzH6Tflt3HLfbk11+OaCv
	g8ZdXYpQNae9EUTNEVyXEl+pNl7Q==
X-Received: by 2002:a05:6102:685d:b0:72b:a25a:60bb with SMTP id ada2fe7eead31-72ba25a669fmr6040802137.10.1782226358865;
        Tue, 23 Jun 2026 07:52:38 -0700 (PDT)
X-Received: by 2002:a05:6102:685d:b0:72b:a25a:60bb with SMTP id ada2fe7eead31-72ba25a669fmr6040778137.10.1782226358197;
        Tue, 23 Jun 2026 07:52:38 -0700 (PDT)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c60aca46csm534042666b.36.2026.06.23.07.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 07:52:36 -0700 (PDT)
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
Subject: [RFC 06/12] ACPI: scan: Retry acpi_device_notify() in DT-ACPI hybrid mode
Date: Tue, 23 Jun 2026 16:52:19 +0200
Message-ID: <20260623145225.143218-7-johannes.goede@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEyMiBTYWx0ZWRfXyI8PwCaI+3ej
 co1jtmlFG33CTfZQKEBoXe9c5uYNYyGhwaXIAnDM7Hado8ee7Pd1tvcwow2i/fzA0NEDTZbK0ph
 1c014FjCJS/OMVYmC17ke+Vr7mTYf4h1DwWPBXXJNmqHhEVSICUJjmphmsVzPz9bo9TghXuRyoL
 s7p/lXouqiUyyQcX7T/xbwjc3gNeIWlTvL8okyRj98NNB+fTFvMc8g4IH7HSU3ijpgPrYR5Vf3J
 1mBPjfRon4iafKCzcRM3l7U++FQ2EXTwuGiv6SnjTNFebH2G3V/lXo7qdSbOuAJp0hkQPX8ib7j
 zfuuRLtbmkj8iL7gJjpSxqWQLhvdK97pKMDro1BXr51fSZfGbWui6wW0PKVu1oK7ENg2Vkddzwk
 ZxYH+mlMLoKLrGfpSTTNYhg2WjiBgWsjjptziYUcxU1+8Y0sClqeCNpZbnVa8jf4PaYN0cj1tnb
 T0yD9jInWsBlDtdG4Gw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEyMiBTYWx0ZWRfXz0MQZNQYj59s
 3V+Pdbbt21tNl0Gt1UN2mZrQ4WIL4WTr3zbFglCAYYsz/0Z1w9+3BpyJ7wSK3iekU+nlZFn+y3j
 ogqrlPfCfmXSTjR4Dzfs6zfPzmAgXnY=
X-Proofpoint-GUID: eJOaqajZ2ViDO7HcSoBPbnc9KPTVPdBi
X-Authority-Analysis: v=2.4 cv=AJDhMgPs c=1 sm=1 tr=0 ts=6a3a9db7 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=wPdX0GlK9JqYqbOWQHgA:9
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-ORIG-GUID: eJOaqajZ2ViDO7HcSoBPbnc9KPTVPdBi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1015 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230122

of_platform_default_populate_init creates DT platform devices from
an arch_initcall(), so before acpi_scan_init() runs this causing
acpi_device_notify() to be unable to honor "acpi-path" properties
in DT-ACPI hybrid mode.

Re-call acpi_device_notify() at the end of scanning ACPI devices to
fix this up.

Note this relies on the driver which may use the bound ACPI fwnode
to only register after subsys_initcall(acpi_init) has run.

TODO: It is probably better to add an acpi_platform_device_pre_probe()
function and call that from drivers/base/platform.c:platform_probe() and
dot the setting of the secondary fwnode for platform-devices with
an "acpi-path" property there. Basically moving the "if (acpi_dt_hybrid)"
block in acpi_device_notify() to a new acpi_platform_device_pre_probe().

Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/acpi/scan.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 4836286968e8..b305c03e8504 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -21,6 +21,7 @@
 #include <linux/dmi.h>
 #include <linux/dma-map-ops.h>
 #include <linux/platform_data/x86/apple.h>
+#include <linux/platform_device.h>
 #include <linux/pgtable.h>
 #include <linux/crc32.h>
 #include <linux/dma-direct.h>
@@ -2818,6 +2819,22 @@ static void __init acpi_get_spcr_uart_addr(void)
 	acpi_put_table((struct acpi_table_header *)spcr_ptr);
 }
 
+static int acpi_scan_retry_of_acpi_binding(struct device *dev, void *data)
+{
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
+	const char *acpi_path;
+
+	/* Check primary fwnode is OF and secondary fwnode is not yet ACPI */
+	if (!is_of_node(fwnode) || is_acpi_device_node(fwnode->secondary))
+		return 0;
+
+	/* If there is an "acpi-path" property retry binding ACPI fwnode */
+	if (of_property_read_string(dev->of_node, "acpi-path", &acpi_path) == 0)
+		acpi_device_notify(dev);
+
+	return 0;
+}
+
 static bool acpi_scan_initialized;
 
 void __init acpi_scan_init(void)
@@ -2881,6 +2898,18 @@ void __init acpi_scan_init(void)
 	if (!acpi_gbl_reduced_hardware)
 		acpi_bus_scan_fixed();
 
+	/*
+	 * of_platform_default_populate_init creates DT platform devices from
+	 * an arch_initcall(), so before acpi_scan_init() runs this causing
+	 * acpi_device_notify() to be unable to honor "acpi-path" properties
+	 * in DT-ACPI hybrid mode. Re-call acpi_device_notify() to fix this up.
+	 * Note this relies on the driver which may use the bound ACPI fwnode
+	 * to only register after subsys_initcall(acpi_init) has run.
+	 */
+	if (acpi_dt_hybrid)
+		bus_for_each_dev(&platform_bus_type, NULL, NULL,
+				 acpi_scan_retry_of_acpi_binding);
+
 	acpi_turn_off_unused_power_resources();
 
 	acpi_scan_initialized = true;
-- 
2.54.0

