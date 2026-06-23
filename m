Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E723D47C5
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 14:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782226371; cv=none; b=imMOWIdSkMYNYNQfEuRUHjTlVb7aEQiLyET3DgZehpRunEHkC7Yx1tstb44Euxzl9+G0QkFHExzsvtTljdby8pujyGErkPtbcdC+EUfp3Ch6zxQhmx2ON4dFjinwaTKnfHD9GZqYRHtTEOglGcfuH3ZsN9fl5Jrzzlj92ss56sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782226371; c=relaxed/simple;
	bh=qz1R0fc4ZtSZbGixQFSfsZn1O76p2On6dZ7J6oiFRY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kkZmyDbdc1JLzrTtLCFixbwvaTCBO/7IeqGdEsjYnFHysscBFG79MFTM/V/NAy0BtYBb1uJ41MIeWEI0BXGriecey5RzmZbAxggaMtNuZ2KX0FZ0Q7gILNweUPy5+N2ISIh/dEA9Ji3vcbkXo8CziqQt94kFMUeB0VRQDdSbNDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l0q4Y1R3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JB+ONdzn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l0q4Y1R3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JB+ONdzn"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBZRSL4017477
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 14:52:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=zCrxoN3Ecrt
	yDTN0qwQ7dQRoeDYaqf80JwfgO7XBFYc=; b=l0q4Y1R3SlUmadE6Rar184Lg7iM
	xNrKLYtAbLZ2A0VD/jsRZj1e0r8OZTbJTiyAmqv1VigaPZrf+x5jj50r6dVMShH1
	sfBDEncV1S8ybsvKZgZAP0PdAwvVGLwHkRr3nZ3YbB/+q3w9wcLHKd4LuKwbfaNz
	HqXYDhlZ+kNlLC4xIW/NVf2TAH7/ZzrueOH6EbyLVlvHgyQEjzTEzaFyHhxIe3al
	JMfWvJVIsORxN2GAEAeAgn8GwuEA5fNyYWgpg4eVXoxeOtaq61od6QSlPI19eqx7
	PXxTR1nl6LVyEjDUGwQ5rNV0VliIExUosErpP887k4Pas+Sptxil9OxAFJg==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eygkjjw1j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 14:52:48 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-6c5794db0eeso7500087137.2
        for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 07:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782226368; x=1782831168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCrxoN3EcrtyDTN0qwQ7dQRoeDYaqf80JwfgO7XBFYc=;
        b=JB+ONdznmYnUYWScoOHE2w/Wocf4TqtjonYtm1y7CKD/H2pX+l1ZXixiVVRmKo/iI1
         T2PlDFSDno1GXJqDZRnjzjMfyH53wr382H4apbBx+rW6fF8IIz209ZxjxkFpzk8/NcXc
         jdOb1TCsKYlJdT4xtnt/PjXntzOx3v/MWNlPzl2pqUxEZsSZXFuJTxZ4a96LeyEAyhWB
         pmdkf1x1SoEA/YDhuet7zFYG7StrhGK16a4iEbnyw9QLfciyT17Z39q3EjWKRN0QfSF3
         2pD7yfduDHCZXCX08ik/bbeq73x1iYp4dKJfDccQSWgIZpS+aMLFJ7OwRP4tU2/pTlk6
         IPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782226368; x=1782831168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zCrxoN3EcrtyDTN0qwQ7dQRoeDYaqf80JwfgO7XBFYc=;
        b=OF8FQGUGZQeQij8VFumBriUl6wtSHwqAOqVhTZnaoR54vTy8i14hDoGOHuIYPzxjmk
         LZCFfTotljKawDkVvW29CpNbMk1ETByaTYKErfpY+SZamXfOBhbtlVZC+xhkBSK1tNJX
         TaTjgGpQp3XqUU24TEjnqfKZ9uKARKUIvgpPIfPp665xNCUh+KIG7ReTI0IW4Qhl5De7
         Wl2BbiawNk83jo9OZlQ0S2l/1aLcluH8Xe+fKILSUa/kouivG3A7VGkO6O0sX8XoiXHQ
         OBtsgwM6kzTkQz148N+i3x4AvtyvZWvYK4NaZ33avhsqOg561GsQ5en5dbG6Z57d3ocd
         NxCQ==
X-Forwarded-Encrypted: i=1; AFNElJ/k9mg+QlMTZ8YmI+5/V0o72aQgdoRE7anmEhcvYma3eoJYNeTQoRtKo3LUQkZlCVqPpyoLu56EPGNp@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6PPpVtq8NT+Q58G9FXobQj25GBmS49piJXXna57I28Gl4JJMY
	8Tt0cipEpcVk8XVAQwT84i8iynU9Te6pra2Ok9QiWXXz+kML71cT6zCgwVJ2czuNeSiY0DllWWx
	2NU1jgIoLXkmSfBZU6PgOEoObTgk5R7M6oVSC8ki9zU5WtPd2K6BuTCienBSLXEe2
X-Gm-Gg: AfdE7cnORkOqyXCQ9gYedfWroc37zVbbHWPdVRbE6+Ndu4g97PEaU3RSAJ9xIEICAEG
	Dv0Cbao7uakS12zCRkVI+U8lYeciJl1Ll5OZM2pZu0LNGH/O99WoXNB2jCs4D7eJILgSPq0ghiG
	aP+8hDDKrXVXmsvGdrXQ3+WrbdYvZwHCLP3MQaRd5XtrUUnwa7XaClEnNDNpLNvLE6V6La0WSdD
	YSxgaV6HBFEbeZXbQOfUJhWGyjm3DlrgDKSbp/+MOWmxGpX5pyYnOGbhzsX5hyDVVybzpG2r2UX
	ITc2KnDzQdLMc+HEAi8QA13NBuSr2tOoFPc3rpqUF9sUtqS8Zote1HJVQpb4JVRRm3D00fcFzaB
	3SfffZs4bPp6ACjwqxfyNisRpW2fo6cNPU8rKPjP1e5518paUmofucwNFeQXny4x5Lfc5QRDqih
	NYcaztiNB8dauPR5PudRbdciusmQ==
X-Received: by 2002:a05:6102:3ec4:b0:6c5:d55d:c093 with SMTP id ada2fe7eead31-72ff3f837f9mr1545300137.8.1782226367308;
        Tue, 23 Jun 2026 07:52:47 -0700 (PDT)
X-Received: by 2002:a05:6102:3ec4:b0:6c5:d55d:c093 with SMTP id ada2fe7eead31-72ff3f837f9mr1545276137.8.1782226366816;
        Tue, 23 Jun 2026 07:52:46 -0700 (PDT)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c60aca46csm534042666b.36.2026.06.23.07.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 07:52:45 -0700 (PDT)
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
Subject: [RFC 10/12] i2c: acpi: Also register ACPI i2c_clients for adapters with a secondary ACPI fwnode
Date: Tue, 23 Jun 2026 16:52:23 +0200
Message-ID: <20260623145225.143218-11-johannes.goede@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEyMiBTYWx0ZWRfX6g8vcE14vkvH
 9XIbPIZVFZUQMFSiJ2LSwXGCkOf4bNUdLm5omeykvj/rBho2ECSePYBAC/88EXgnwjCRYuNQGHo
 dmjX4GO9y0+Vh9Y4yBi/fHVCcvF/BMDPH1tqn3tzI3+irVyCnHH71RCAYqe2JJ6URT21md/UGq1
 sKYjcmSx89If1taf94PNJQDoroJDruClv4aEdhfF/JQTCY19wpNOlUlIJnx/f3Mn2ZxzcUT+WM0
 8c/CDe6fwzhMesyHvtJQD7SFR8kCLMg8y9Z+xsGK9q6tT3WhowStqk9rQvC2YybhKgRGGPCVSXQ
 lB2PJw/PIyytXa+cRGdbFfIoxPPPQzM3VaALxvgiB8ylrBLBwtldvdRrkYngvRhk3Vn0iP6ITWY
 dokDtX47vmZEeh7Wn56twttAg5/34pd+ecR3QdeAsS2EaCPEqXhHuuvnC6TYRBLj9qEg+SEGE1y
 R2ofc6IpsuClvEo9gmA==
X-Proofpoint-GUID: eg_F8EexVQrvxejEVDR1Lw-5exvYIWpn
X-Authority-Analysis: v=2.4 cv=SoKgLvO0 c=1 sm=1 tr=0 ts=6a3a9dc0 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=6UeluGelAAAA:8
 a=EkjFkVpK6-r5im3n5xMA:9 a=ODZdjJIeia2B_SHc_B0f:22 a=4zb3YkFaRy81KIeUJMwT:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEyMiBTYWx0ZWRfX4zRyxqo0oxHC
 awZJcmK2St0dfSCKCXPAjDohCn+HL1lw3Dw7PmwnLW+tTvKEJESW1kCnBt+JN2Hmkln6EcyDLJ1
 n0m9KDNm5hgLDkXPpAWIIOLUVPDxCCA=
X-Proofpoint-ORIG-GUID: eg_F8EexVQrvxejEVDR1Lw-5exvYIWpn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230122

In DT-ACPI hybrid mode the primary fwnode of an i2c_adapter will be a DT/of
node and the secondary fwnode may point to an ACPI fwnode.

i2c_acpi_register_devices() exits early if has_acpi_companion() returns
false and has_acpi_companion() only checks the primary fwnode. Switch to
is_acpi_device_node_any() to also check the secondary.

The rest of the code to register ACPI i2c_clients uses
device_match_acpi_handle() which already handles this correctly.

Also adjust i2c_acpi_find_bus_speed() to use to_acpi_device_node_any()
to als make it work in DT-ACPI hybrid mode.

Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/i2c/i2c-core-acpi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 28c0e4884a7f..995bd88ad09f 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -322,7 +322,7 @@ void i2c_acpi_register_devices(struct i2c_adapter *adap)
 	struct acpi_device *adev;
 	acpi_status status;
 
-	if (!has_acpi_companion(&adap->dev))
+	if (!is_acpi_device_node_any(adap->dev.fwnode))
 		return;
 
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
@@ -413,13 +413,15 @@ u32 i2c_acpi_find_bus_speed(struct device *dev)
 {
 	struct i2c_acpi_lookup lookup;
 	struct i2c_board_info dummy;
+	struct acpi_device *adev;
 	acpi_status status;
 
-	if (!has_acpi_companion(dev))
+	adev = to_acpi_device_node_any(dev->fwnode);
+	if (!adev)
 		return 0;
 
 	memset(&lookup, 0, sizeof(lookup));
-	lookup.search_handle = ACPI_HANDLE(dev);
+	lookup.search_handle = adev->handle;
 	lookup.min_speed = UINT_MAX;
 	lookup.info = &dummy;
 	lookup.index = -1;
-- 
2.54.0

