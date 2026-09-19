Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A4023EA83
	for <linux-acpi@vger.kernel.org>; Sat, 19 Sep 2026 12:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789821106; cv=none; b=V4z2CBQxk0+EWDZHKm9xDEuc5bJm6Y9p+e42Y1xqw+OFCrLqNCJDduxDar8cCIggSbJ5Y0CUXSyl2BQTeIrjfCq8wI+ubwbUuGhvbw2lgfUfYDDeueA7/VpqVs6uE2Q9UV2avEWY/C1JE1O5ufFPVbNP437DMUCrHdmnMjawyUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789821106; c=relaxed/simple;
	bh=VoSYcv4mHQ+QKswfuW0haNSDpNy0S5fzI3WpVcQ5qK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aS5z659TJwvuSrjkHzYQ8f1w5o7u/CNHCl7EaWLj/7u+QtssVpLOionD9cMxWPr+i8I9jhLt4gfzFVw4OZJmkwuGX/nuGWX1kKxnBXAYd81hgTE9ncv4ab9jajei0lza1TKY7CJSTCD+ZlbWd9L+NT3MuFR4YjZFUyvyOX9mJB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a31WA0zd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RtUO9eMx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a31WA0zd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RtUO9eMx"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68J9toQb2720012
	for <linux-acpi@vger.kernel.org>; Sat, 19 Sep 2026 12:31:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=5vq6+I1z24sKKfZcdiK2ow
	RX19Ju+aG5uDVOXA5Ey1M=; b=a31WA0zdVB/bI5vjkfSxnaI+bbgveE8odB+OZQ
	EF9P3F7jRdpPeG1Cw7gb5QzDKYSJzxTI02kLcNRN0eDn48K+mNsK9c61Td5lkac9
	EtOiG8y9TvTwY1VoJGFTJ7lI+BYFRxxvPXlu9tgA9dk80diNNs51thPvZ9hPijUN
	+gFJXwi1K/kAGuy21hQnlrZkUEO4YBoK3h1x267nuFjMisnMPqlCHB5CZhco1DP6
	ofrb6j9h1AhdHC/gdC1aRH7UjxMNsBl6vnEyGRHwIubd/pJse/tPu2gE7SaVVD2w
	sn2WAz3HlOk+/YAFwMoxya4ZduwpBK5UDdDoTk5ypdNavgQg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gsjs80u8u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Sat, 19 Sep 2026 12:31:34 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-78f4d6af128so428858137.1
        for <linux-acpi@vger.kernel.org>; Sat, 19 Sep 2026 05:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789821094; x=1790425894; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5vq6+I1z24sKKfZcdiK2owRX19Ju+aG5uDVOXA5Ey1M=;
        b=RtUO9eMxSZukYQDB15BnPRJY7wIrlMWzoWlPz3Yn2XiUkjWgvjl8geAxg1Om2yRTvh
         vqUFjxMbwzEZTKxB/x9hKdF6gjna2QNXp0dQ+9MRFt5dnSflfG2G57QvbgyVT4Mh9Yml
         xmbcXNv5LIRkhkoQMiImFWfFMQLNSibK4oM6RlwV3DlKVzCnK72y8OPUOVq1/sKgWgcJ
         r0wKC7xMp99dtnGIWWlW5smolBHiqgeTQBjQoMo0kTxr+vrNX5aAFxSS7MSdFrPmggyA
         Knk/eMfph9ocSz4/HYHPA0OJKAjTbW7vjD63f4Lebg/AWUO5T5RCtkFu5Yw6kmAHNavi
         Ibng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789821094; x=1790425894;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5vq6+I1z24sKKfZcdiK2owRX19Ju+aG5uDVOXA5Ey1M=;
        b=loqQmzT8m1F173Gi5stM/7qMxiGPedjf43sDlhX3XYgap0+rngWeCp3jhXrhzpLXi1
         Bhy+2hcUFP97qXGo0fcpPzFJ6uKWSkW+4gpSxGKGryQBhjJwyK+2Q59N745X8awJtgJH
         J7O8FRIgoy0qADVrql3/34Ax7N8O7bDk8HhnYiZoTs6A54EjEoIVD1TnnLAlUuqNrytH
         uIOzz/J0CU+OrcAvYfgDMZb3F1bDI0wIBSNCLU4JBzBjAMLraOKWIcqElf15G2x0PRRa
         8KoU8Lx0mubtPfXtF68nDi505sLk9t/ad6s5I9UrF0iD8O/IG8UTfywX2W9rQZbAtP81
         2W6g==
X-Forwarded-Encrypted: i=1; AKwUvByfRY+BNAs/FKOs0TYpaSgzlFcI8ogInVuBsZvafj24YTYdYPqgJpClkogziUML4h8elrvh2wEggyP/@vger.kernel.org
X-Gm-Message-State: AFuF++kQbwhNd9a/vb0yMnTiWpLIjAN3kTlyLZjaFRCFdjdQMl0+cTnJ
	WoY9S+/ejwNF0dp7sMQ2b/5oEsxhHImv2AZa40niFz2tyopjIKjble7OGkhOePHKY+dvW18D6tX
	kdyeJuAVd3h36KlCycgcgagOyCeaBb6EEEtk41gV5ZcYNKHVL/jnNuczjKUd+PgO6
X-Gm-Gg: AYBFou3e9JTxbM4BuGcmCbpmFdJBH0Aswo/xK13zGPTNf1BjjXmzitJUf6El/tBz9bU
	pJc9ySFz3+dO51FOe7P4xdHYMd5fY4bVvKvojH0gpQb+qdI5JRvPEC5LSLE8W61oPSmM+yD/lA+
	ud4pgoNJP1PNV+n3Y4wgPtbDxRUCbS0UJGXUYMBeMruMBEKXyQ+IVYETXJzbbx2aZELtyZKtVJ8
	IL28PGWMYlfSf3MmEQObICT4bpUvnxYd0tQn+8GAw4kEqqWOxclZKxOiseneYlxScl5trSS02RL
	uLwHcc3j6zcG0GqdzBlw4U/6O8dETZefXwpB9Hb/6YAEjXLl8JleNpZWQqNHIiuk7q+kndqJ03x
	2OzU8Mli78okH/my8GpB3ymrY/Agfuj1k7b/S4HqsPPq/X1vDwPBwX0HGrCj07Yr3Cy0HhwMGFe
	HOhM81L7o3D2RENZk=
X-Received: by 2002:a05:6102:8093:b0:7a6:d3f5:3553 with SMTP id ada2fe7eead31-7a6d3f5410bmr505007137.8.1789821093939;
        Sat, 19 Sep 2026 05:31:33 -0700 (PDT)
X-Received: by 2002:a05:6102:8093:b0:7a6:d3f5:3553 with SMTP id ada2fe7eead31-7a6d3f5410bmr504986137.8.1789821093324;
        Sat, 19 Sep 2026 05:31:33 -0700 (PDT)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a358868e1sm79462966b.47.2026.09.19.05.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 05:31:32 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH] =?UTF-8?q?ACPI:=20thermal:=20Fix=20acpi=5Fthermal=5Fguess?= =?UTF-8?q?=5Foffset()=20for=20device=20with=20a=20273.0=C2=B0K=20offset?=
Date: Sat, 19 Sep 2026 14:31:31 +0200
Message-ID: <20260919123131.11443-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: HHrF2FpdQYyvWy86FGUTjF0gE4uUiueO
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE5MDE4MSBTYWx0ZWRfX3Lz5yrJtJsff
 DBoN2cx/xLpNgV+KHPOF+YTr90rdru4eELpKK8Wkn9TG7EmkBiESt/p97tC89DJnaEDMGvL8M0V
 Vv4efoVCPDXpSn1tc2zEWXtlFtfp9Pk=
X-Authority-Analysis: v=2.4 cv=YqWa1IYX c=1 sm=1 tr=0 ts=6aae80a6 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=5KLPUuaC_9wA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=5wEc44i2t-Q4rbfqtFUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE5MDE4MSBTYWx0ZWRfX5qcGbyVElTyL
 IhBeq86eGpextxnE8udtOee95HtRH8X4YfhcJaVmampAWEBCSpS9LnfvHACfigQMAfaZlXDb2cv
 wU4e1B9e+FqqqcRnkZ3qiE75kGNypErZ0ZFJZk7fYk/xR4nM5eK2DY4IvkvaCPfG+Zv9a5nwcuA
 I2qFdaPRUX7MfGqSgZhdPmKm7pcTYRbxySDB1ed1GOrlJ8e9Zj9Iz6N9J1+a5doUWSps0ovBbTA
 Ln/WPJGCFd5hB0yMlX+saBmRRVBG8wfKCXWc7W7n+RIjng9WpoPUnFtauDDllegy5QKk4fjWnDa
 SgHBjb1bfLQNCX/xPrOANv6x/Mwb3X/DvD0+7wxlwI6fG2jOU+5/TrudPlQWR1SipEfPk0+pe6j
 jde2CGhEeMj3i0U4+3VNuurLDgMsz0kejeGxeruNFnQ8QhBXe9Ji3WtjJSQLyz3VpfN4Ykf9b1r
 8XBtloZud+5Ige/rtHw==
X-Proofpoint-GUID: HHrF2FpdQYyvWy86FGUTjF0gE4uUiueO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-19_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609190181

Some devices round the 273.15° offset between Kelvin and Celsius to
273.0 instead of 273.1 or 273.2.

Make acpi_thermal_guess_offset() check for this value too, fixing e.g.
all zones reporting x.8°C to them reporting y.0°C instead.

Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/acpi/thermal.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index dd7666c176a0..3fdc832c11a3 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -738,7 +738,9 @@ static void acpi_thermal_aml_dependency_fix(struct acpi_thermal *tz)
  */
 static void acpi_thermal_guess_offset(struct acpi_thermal *tz, long crit_temp)
 {
-	if (crit_temp != THERMAL_TEMP_INVALID && crit_temp % 5 == 1)
+	if (crit_temp != THERMAL_TEMP_INVALID && crit_temp % 5 == 0)
+		tz->kelvin_offset = 273000;
+	else if (crit_temp != THERMAL_TEMP_INVALID && crit_temp % 5 == 1)
 		tz->kelvin_offset = 273100;
 	else
 		tz->kelvin_offset = 273200;
-- 
2.55.0

