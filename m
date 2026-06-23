Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B953D4119
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 14:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782226371; cv=none; b=AdvNszYJbF1jhvwlJYWTICQ2PzWptInbDP20jW7IgqXduzOd5awlqZtztzDg/GD0Ve4kU8TKCZhDTuyeNduYxykxmge2jbMcmFspJ7V7X8XnuX8jwfiyf3budg8W+MkhDerkVOhT8AtVNU5HUT5OcPUPN89O1DA7x8NcBhdeI/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782226371; c=relaxed/simple;
	bh=jk4R28uvXSQqop1k+QCaNKg5KB45fYcvAdlsM/pEbt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uuIc5b4brM8k3spZMJO2eTObHldlkAIQEXyH4OzWFbw4lD1jetwUOniYT0g0Q3YM972uquYvgs+sEZkI1JUJrmwDYlyCU4lt3zfmjt3j2WBRbHiy75YlOhV5TRHzbjrtgbAnVTZRv+ml5VAOlAuQ2p09mNRRP6v69tHxqhW8xkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o2z7e8J9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c7wOrpxV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o2z7e8J9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c7wOrpxV"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBZeGx4052488
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 14:52:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=1zp4v9I3As9
	YSSPlxKI4iiJuA8JmYN0Hz1Nxzf/1u0c=; b=o2z7e8J9azfbhqDRSzGPXA5q9hT
	kCTUoPNbFevxPnpU8jxf/J8tahuGILguBwg89f211D6D6cItyC4icbmPL46Ua9R6
	jRUSv61iZyTwmIyF9Ag+B+UqFeBCB/ufd3yy4eNCnav832o3TJZG0vj/zOEETzRt
	tTL8SfWR3zPnL3EmvAX63TbfenHPo9T4Dkl7TylhpTGRCiCs68uuabmnO8Uj9Exs
	eh17kky2w+0n0aiWQPLrACWfIDZz95ARMhNDvHg4nVve1i97nOBLf0HMOAoHU2SV
	J40PIZPxFjYLdfaM48es1XZ8XbBzz/7WPS5IpO6y+i2oj1wPdh53vH9y9RA==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyr9ys3aw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 14:52:49 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-966a61478ceso2912820241.2
        for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 07:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782226369; x=1782831169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1zp4v9I3As9YSSPlxKI4iiJuA8JmYN0Hz1Nxzf/1u0c=;
        b=c7wOrpxVhFFl5W/VLMCdPeGnZD0Hu0fkyNaPVfGiwZHrsLBWjrciG9cOwHCtofk0af
         uExqhlpFFH2fZLLlvAqY4RKFU+HhSXiOeq/1bgIXoMgoHjKm8HHa9E/ZZqh3Wbyoi4qR
         uyPS3puWkttiIiga4uaG/XpAGDvpnG4RaHgGwU4TX00BAQ5Teo2yS5Lfz3jEZCa7LlYQ
         3TBek4rmjKc4Edn8RVUYsFI4sqZBclt/a7V8SRA1POMiGBzpLHt8g2FkkWcbr1fA6sye
         F2NgNGXlrYeYxF4OsxbOY08AiogTA7f4ykdQg5VMnHfx1MM+r5gZMXYsItiTd0i/IUpq
         gllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782226369; x=1782831169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1zp4v9I3As9YSSPlxKI4iiJuA8JmYN0Hz1Nxzf/1u0c=;
        b=js675bXvoMcrTRPrBKu3/vNxrv9iyDeJ7vUnySx7JJYW3fpZlscq7jAjyrIjobfR0d
         LxH0ezFIDK1kBlWjKC1I/lm8PIa/edv40eVsPyeNc12ENDJ4/wkH2521jegWJF9gVx+7
         NodA87dIGUSVhl/floY3ehG5Q7me+L8/vevg6PPTlbFj/Cxi7MWSxU+W8dsIDyPvjy0D
         HOpNC1B6pyer1wZodqATlkhqqZOGzws2tFHMtV+PMaUPB/QyVWYY80JI4t5V5QWx6iGM
         W9B6jcJn2y9AYGgPHOoVH1ehiWpDlBdQIpme/1oue45pYyI1fc9n286JGxyUtgOAjkjU
         TZtg==
X-Forwarded-Encrypted: i=1; AFNElJ9z5vHRNgojKd5Qu8b/8/i5XGleCXLPSbc0lPTwpecofVDWmcV/KW78h1KFOYm4fys3IzbwZNENIemQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwABWlCAvRlXYUjAS60u9bkhXZuTieE6VaUIoAbaP8CEu03eAoe
	YCkpL2r5z5V7p51iAvWoif5DaSOvqoPKqIgIrVdXlWVl8iDTIKc/fIrhAncatB4Pg63PyAVI0Tq
	s+pE7zjPRUlHlAn5R8aZygXF5b/ngKLRCDwIG08p6lDsL/bSnUQWyzWHCMjFZbasx
X-Gm-Gg: AfdE7clZ3K6Qz0UnpgRGqkRIMrUjQ0MvJx07DVu5poA5FyYlBCmd852WZSJr5N83Dqm
	wOUZi19RcohsabK7KTXSyNRW7VQm7RgKMBaftKV3LX+ukLl299ygVO7IhWoREIjUSiPAiW+3b1d
	cjv1B8hAdBPZDNHmT8qjiZFqjG1MJ8+JzQR6RGIDNLa/68876TFqh0lkA02MAhfY2051CZzH2U1
	PPWAFICKPnmext27ggflF5qSLxJFq3rBxkQKkp9XZlpfR6oLy3aMtT5KomdFdAkyLloAZnLFRCg
	YH68gdOIvbd9OyGSjde2emQy9r8h09+k+oXSqb+ZfsJR1mbWR75At9/vugjutot6OfkgDAcxA2o
	vyQnjUVx2taiEsW6+UCVOt4NoW42XGCsrsLKj4Y6/gZGc8hgTW8+tXE3LRm3vhEIEtHUGczk8Kf
	ydA+RuGEmjkb7T4QdE8AKcdjstrg==
X-Received: by 2002:a05:6102:e09:b0:631:26f6:7016 with SMTP id ada2fe7eead31-72ff5b88ac9mr1736724137.28.1782226369131;
        Tue, 23 Jun 2026 07:52:49 -0700 (PDT)
X-Received: by 2002:a05:6102:e09:b0:631:26f6:7016 with SMTP id ada2fe7eead31-72ff5b88ac9mr1736696137.28.1782226368762;
        Tue, 23 Jun 2026 07:52:48 -0700 (PDT)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c60aca46csm534042666b.36.2026.06.23.07.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 07:52:47 -0700 (PDT)
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
Subject: [RFC 11/12] i2c: qcom-geni: Fall back to i2c_acpi_find_bus_speed()
Date: Tue, 23 Jun 2026 16:52:24 +0200
Message-ID: <20260623145225.143218-12-johannes.goede@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=JYSMa0KV c=1 sm=1 tr=0 ts=6a3a9dc1 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=ebSNtY053JYnNN3LUkkA:9
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-GUID: KvXeUyG-Bam362HZI2OJt1Zi-sRWT0np
X-Proofpoint-ORIG-GUID: KvXeUyG-Bam362HZI2OJt1Zi-sRWT0np
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEyMiBTYWx0ZWRfX1/cG1k98/z70
 7yLUO1aDccAGigVCwwff09oh1o6YlLDq2vHMgNBmv50YUEpN76i5zZxTbNjcvRC+1SsGpaclY9N
 Q11pMJEnesfSPhVNY3R/7UubF0nOQmtwKPXcV67A+Jzyq4jn4Abeg/d3X52WTR6D4UBz9pNX4J6
 idMQnizzjJJV4ra/zC+ZTqVD4JkxHR1Z1SjCVq0X9S4eThNDu53ss0OWrJFDSy13zVCSL54mGhZ
 Wz8XzWKarpLkSOsZVdfjuzcme+NdczYIfjQYOMTnfFRA7pNpcyDRIrXINloirRAGI2MqdrqJcqr
 FFUMplrjZpM5oUmPRH0a43Ll2Gy0sPtaTa+SPc3VfYJlXQ/5FaaoTkyrSGriRwYzJ2wNFiHndga
 WVtjilRrVBmblDT6LhpPXunHMveVu8CUdgdmWVLbiy5UJl1ZuTAdTwJI/Yg603xJxj2/Eg6VVav
 Hdd9x+Xk6ZFZfBvTanA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEyMiBTYWx0ZWRfX9EzI5IEY093C
 hEyzHuHHePo3r3njgcPjPYtsHjjEmsepLh1Q1Z+TmqhFhVTjv5vQXpBW/hFAM6N0pDU04Z8PECW
 WcN0EoDlgTzt8r3ZcOFXq2e9cn0u1UY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230122

Fall back to i2c_acpi_find_bus_speed() to get the bus-frequency if there
is no "clock-frequency" property to get the bus-frequency from ACPI if
available there.

Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 2138fcffdaf3..97a538cd9455 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -1024,8 +1024,14 @@ static int geni_i2c_probe(struct platform_device *pdev)
 	ret = device_property_read_u32(dev, "clock-frequency",
 				       &gi2c->clk_freq_out);
 	if (ret) {
-		dev_info(dev, "Bus frequency not specified, default to 100kHz.\n");
-		gi2c->clk_freq_out = I2C_MAX_STANDARD_MODE_FREQ;
+		ret = i2c_acpi_find_bus_speed(dev);
+		if (ret) {
+			dev_info(dev, "Using ACPI Bus frequency: %d\n", ret);
+			gi2c->clk_freq_out = ret;
+		} else {
+			dev_info(dev, "Bus frequency not specified, default to 100kHz.\n");
+			gi2c->clk_freq_out = I2C_MAX_STANDARD_MODE_FREQ;
+		}
 	}
 
 	gi2c->irq = platform_get_irq(pdev, 0);
-- 
2.54.0

