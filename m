Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ABD347500
	for <linux-acpi@vger.kernel.org>; Mon, 13 Apr 2026 09:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776072666; cv=none; b=Tqyrtp7sZCWbdxrAStZKUGrICro8YPxxSxDl6W7O2glzgKxDeiK+Dl/Ma771WpLrblL+8CgiGSXXDynsDHG85wvykoGFwOLbTyQE+B4Nkb7ra3DunhHmnpuKAC5U/tI8Q8lQ0AevhGJP0tdMMvbpi//rdk1v/YPvyRZ2q5alkjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776072666; c=relaxed/simple;
	bh=DvH2QkXGUpTln6JaEKA4JpAbHrO6WY2u/6yCjnApF0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fholxOewLpsO3EglhzlueCeMt4SLrep2p3hRyJZMJAHGumNTauySL6sk+y0BPvhnbo9P2H9ntSsAw1QMUrmB0F9/eLTkqwSS1xqAaAx/fP+39MkHrYBAb3mvayLCfHGOBrDPxuqwyXQDOK6nFbi00Mbx8REI0Uc/sYKysMZOzSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PP/UHYuW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eUm2AV13; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PP/UHYuW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eUm2AV13"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63D4n0sT3561249
	for <linux-acpi@vger.kernel.org>; Mon, 13 Apr 2026 09:31:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=qyYaSHq/MYwYNzvwBcnUiad2AYsRIpc4P9N
	sAezIEJY=; b=PP/UHYuWbeObbiD4aOY/x/kTZNDNJqq6jAYrxQD7JMSt/TV+SMF
	W5VRAJNbNEe0z/Vz0A9PM6uQ53pv8mQY2mjJHbif0MSy+0lC3+thvRfNvMqRjNhH
	SX+T9AbqBpN+wniKI7z5AVTjqBNnZeijrITUXq+tnJbiWNmSUARwoYwD7b0vV4SQ
	73+7oAjMWmPlZSaCJ4Neg3nnT1mdTJWUBxWUb6RAvm/NwRrco25iqB5mNcPgkRiq
	kwiZIyH5T1NxgINueihco1RZG6R5fCGaEOa5hy5nFPg9z82XHwRiZrXc6+Tmb75f
	hjKktiuSRv13NAKvPARaayz8xS/90u7WGhw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dffb0mmva-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 13 Apr 2026 09:31:03 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50b4661881eso2216821cf.0
        for <linux-acpi@vger.kernel.org>; Mon, 13 Apr 2026 02:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776072663; x=1776677463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qyYaSHq/MYwYNzvwBcnUiad2AYsRIpc4P9NsAezIEJY=;
        b=eUm2AV13tjbHQOJmiJJI5tNkkR2OXQ5D5IDw6syml7+cpu7qZUxfjjCN8oWd9RWFwr
         4m74QuFI70wVe5qSFTzQQiSIZN/43JqYbTZg2VFr5fmnJyWhd6PEzToY4/l9uGUEZk3k
         vGvFGE6JILvSq5G2EI+NDiFnOV2zdXnSdr/p1KSaHY96v0/V/WYOzWRa5693cQkE0nrd
         co6QMAGwdfYQfmcml8AAwOOqsszj35lS8duP+6u4gmp+nOQcSP5bxKye29U6WRG0biwe
         VTYXG3VhPFD0ZkLNrOr+den8FDiGc21G5Indv3wfPPtgFMAlYKozFvobdMNwDbwKdver
         khTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776072663; x=1776677463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qyYaSHq/MYwYNzvwBcnUiad2AYsRIpc4P9NsAezIEJY=;
        b=lPymq8uKUL1zXUlyw3oBy08km66PsAkoLGYzUFBtFY8/PWPLVaHeP+ao6rBd1tIPB9
         kkuki8oPbx6/+qMxck47au7MBL6nuJMoZgQg+zHIXr9oq2AWIjENQ2mhWRbTZ+pyWb5m
         cc+xP1RzOachv8BekDUecOLP+n0URm4c+djhRVxakTRBOBt9QpNujt5y1NgGmtGXNfBy
         MMMkhX4rAM5fGzDl/lj9mclBlTDLf9HN3pRnjCVJFKJHt9djEvxrcKbN0zHVn0Fmr+d7
         EfgavI5X42w+7FpmuVZZTbnSM/QQ7flOkfwAxTsif6LCmAWSknekAzXtw0KKj3BEh/fc
         nKDg==
X-Forwarded-Encrypted: i=1; AFNElJ+7Vgpt3bmho8NkK1HPkKM3GyISl7nzg0+z6CJro1AIn89MDkLX5p1JZcHakjnoAh8lQdjLuBd6nYHd@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8mx+JnJV6zu2Dxcd8PkrH+6T5YoKftlSlFmCV3q2GNamYH0eJ
	p54ZiV5siRk5hql3bmoZS/JfPOWHzsPRL2X5o/5eP3Ekc26fw9CHqf43UhEPiooCFZImGEP1a3j
	I27sePiV9NnhGy5f7lCw1bsdZ/bHTXgVKNQGF0/EB8apF99Lbc78J0J9+rUHfOzu3W/HjhTgV
X-Gm-Gg: AeBDievrhV0AS/HMc65SsRf11mb3C4zOpyw/aJ2tDdxwkP1EihmRSGs4XEH6RaPYzdh
	oABw372h3P/vLsk48lW2AW75DC6d9+rLjT/FXquk34+A/sudym3GKjgD1Jiejcsw7U5FOzJAdCw
	EyOu7Y6GCN15NRT7SqV1xEGLAgV4u1GePxbvKYpXICUShSeJoyuqKU4cUE/K6NiexHF75U5wmVL
	e4itlApZkGVbGtC0chYQaYeQGOhTGpGqry0CM9tm0KvWPVAX1ocZyBxG3zPElWv3e0sAF2aMcdr
	dE28iHB5mfGNpFeoG7WDjwJyy1rJCTS5govSoh5ydlu2t2XfTxUB0RohEI51BGNeeLrgkbcvQn0
	E8tBM+Yqvv08nyNLmOzozgrCtgo6Es18iqyXhucMePuZjQdrPmg==
X-Received: by 2002:ac8:5f51:0:b0:50d:cd5a:577b with SMTP id d75a77b69052e-50dd5b9aacdmr194391971cf.35.1776072662643;
        Mon, 13 Apr 2026 02:31:02 -0700 (PDT)
X-Received: by 2002:ac8:5f51:0:b0:50d:cd5a:577b with SMTP id d75a77b69052e-50dd5b9aacdmr194391711cf.35.1776072662064;
        Mon, 13 Apr 2026 02:31:02 -0700 (PDT)
Received: from t14s.vakwerkhuis.com ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6dfd88c9sm304772366b.23.2026.04.13.02.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 02:31:01 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        linux-acpi@vger.kernel.org,
        "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH] ACPI: video: Move Lenovo Legion S7 15ACH6 quirk to the right section
Date: Mon, 13 Apr 2026 11:31:00 +0200
Message-ID: <20260413093100.24993-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YfmNIQRf c=1 sm=1 tr=0 ts=69dcb7d7 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=rrvG0T/C2D967D07Ol03YQ==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=e5mUnYsNAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=47JQPLBqiqdZw2NC8zEA:9
 a=uxP6HrT_eTzRwkO_Te1X:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDA5MyBTYWx0ZWRfX9HvTVEy8tJ5v
 paXT/f7/0Ogc8cPpDi0Oa089Ca5GikrBOUf7E6vCcdUCSlReAAdHx/Ic7+gaBpMntqQbBbdtTyb
 TUbsTBPZG1S+0b9qQ0W0llrb0muO59bMA8Z2k4NHUFcZ9AR7wLDoAQiblGsHbEO4YkRigR567L8
 waSYe3M/Pa6+RSMcZ8xoxizU5ToolDOCwQxCkHayI3AtPmhFkH3f/6tMjClJJWMvNh/crXzoyOt
 7g20zBz0ltD5I+wTBvmPWqgp0X3CvsV79IveOR4H5x4sgAljNK3KNz0g6+qGSxUkII9Qn6am4oU
 0WjgX8VBNonv8dwCeKeEwB+sEdVv3MTpqJcE9X8nQprQ+TnD2SKvEBL+lHsZpoPfT/hSbsl/OXs
 1NpL/bx53pIOm9mnJYTrvi9qEyWL6urtJ8E3Gh3emUmeDMy8xp53TbaEoCjeDQepz7AfQ7WxZEW
 6lTgppKf11hBn06Tavw==
X-Proofpoint-ORIG-GUID: NraoNCBJaTyI5XgihZlfvISUsiTGnVL2
X-Proofpoint-GUID: NraoNCBJaTyI5XgihZlfvISUsiTGnVL2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0
 spamscore=0 suspectscore=0 clxscore=1011 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130093

The video_detect_dmi_table[] quirk table has different sections for
different types of problems.

The Lenovo Legion S7 15ACH6 quirk deals with a non working nvidia_wmi_ec
backlight, move it to the section with the other models with this problem.

While at it also add a comment with the laptop model name to the quirk.

Fixes: f144bc21befd ("ACPI: video: force native for Lenovo 82K8")
Cc: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/acpi/video_detect.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 4cf74f173c78..f9519187f99c 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -899,6 +899,15 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 15 3535"),
 		},
 	},
+	{
+	 /* https://gitlab.freedesktop.org/drm/amd/-/issues/4512 */
+	 .callback = video_detect_force_native,
+	 /* Lenovo Legion S7 15ACH6 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "82K8"),
+		},
+	},
 
 	/*
 	 * x86 android tablets which directly control the backlight through
@@ -948,14 +957,6 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Mipad2"),
 		},
 	},
-	/* https://gitlab.freedesktop.org/drm/amd/-/issues/4512 */
-	{
-	 .callback = video_detect_force_native,
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "82K8"),
-		},
-	},
 	{ },
 };
 
-- 
2.53.0

