Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907E73D34B5
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782226355; cv=none; b=L2no+ZnurUZ8jUlT0W7bn8SF2UfLr0UabG6Oqi7Do17awCisnNHe2v24fXFTJvHnrJW2LFluZZ49HvaLeMzGhnJmwoBvhhpRVZXfT4VJ8rx8RRdkfHiic5CjYFh1zy1ekdqSI79qZm80xc7GW5tO0Pu8r9tCHj3Lfq3tZvZkTYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782226355; c=relaxed/simple;
	bh=h7T7xhP7YLAGw7hzAM+n2xON3UAZSlyQMOe106aKDIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pv9WKwidROZu252FAGqUHpGGmxJuHNRpHY2PEvbKhU80IDIpSlauORk2lGxCWHLIldEtT+pSiwF0+yy8q0dwikq/9sHeCbxW7nlvj3ADdVQOnEXFuu8hDehYp95Ek91e//NbZbsefNxds94FtNM/YPKoFikI/by/k8m8a1iiTD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AldcuCTO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gvQbqpiy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AldcuCTO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gvQbqpiy"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NDFrHt271190
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 14:52:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=PNzW3v/qAEl
	CEj/K9kV1a7nB67SEvzFBq019ospcWl0=; b=AldcuCTOeBTXq/xBZoxqlo6XkTZ
	/lJ0hnLBj7GmoYVKTkt0dvNqLDTImW81YFe8fLR5rRFdrXNc2PIx+bQ47uhaAEKF
	fJm/h5OULBfFVK9VRMKIP7kbDsxbYG5xO2pRVqKmx+4BEyrABJyAJXLtX8feMncv
	Qx3KAE4AUN/TOLVh2CyRiirhgXYb0kJoJ1MUxeTe1WKm4M6WTpSy0euo6OUkVFbW
	PNcr1oqEHcVUbYFA2LM5Zy6OgUspE1N1f+AbzE3SJXz2L6CZfiJoO3Ff/sS0Ys4I
	pI7/bXPEF5wRgKiBNl53POWVFnDqrh9WOMUwLBsXQfXtXdBCBF9RUcyOHfQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eytvh0f6q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 14:52:32 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-726d05f883cso3771606137.1
        for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 07:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782226352; x=1782831152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNzW3v/qAElCEj/K9kV1a7nB67SEvzFBq019ospcWl0=;
        b=gvQbqpiyTUpRgBAeJGPHRlqf32DWW/FW67EjFhgDi4lrhyr8krn41B2rdCMfQ3w6LL
         KY7TNq2qIvw/ZbuIOSrR+ZWH154JPXK3Url55YFjqehWvDCcHypplDOxyTu51IW8vjAv
         TDHQ9gVUJeRK4w/EP5tsPSgTr1Ns7PTSfPJcAEfmhk8Ru+JqUlg//jKxsXFD/MLmvCmx
         OR8n+n6+1rJ/zJjekg4KzOuX1FWo7Q+/yXqDmfRtk2RyqvBLGKmkwXCpwsukfCC/rylo
         h7kq3zLq5nFN0XjwzElldfEo+mPiuIQqmZRRXL3f/u3thGDSxnzB7jV6nAnKB9cRg3CK
         PUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782226352; x=1782831152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PNzW3v/qAElCEj/K9kV1a7nB67SEvzFBq019ospcWl0=;
        b=BifkA5gQZ17H+MvprVgr+6GWcsqC05UlgWZPg6jKoQYrsfIR7ak2X1WqmzqUq9pEf2
         gm1AXsJt4glPjB9pfgHMVXET8CVuqUsir7tFkjAJPJMOYrl8tXAQWjKudvQujnKbkJNh
         eUys5d2lSekgxKJdHYLmxGtl3onLNqo7YxAsWFhPRC42o/EHgLoYWzCFGRO90SiNwJTA
         wlxXGszoS5JNNMXbOfa5H/Fwq8ITWGDsnUHEWQeoxLQtU1QQqt8TmLHlEYS+4CAbAtOq
         Zirb0icwqmaAep2AypG+IheULAws/MZoHHjh8hbA/XTujgt0+sJza7xUOVdRNBOdH0w/
         rxjw==
X-Forwarded-Encrypted: i=1; AFNElJ84xSO3h5gvGGWOQwVWxPgQvHnnUgYmbtodx3MHcYPL0c9ryqFP/1W66sqefcJHSXBqgt7cwbuH6CHH@vger.kernel.org
X-Gm-Message-State: AOJu0YwidPSpefAkEI6NmtSaL9pr3r8AkprrCnb2e9JK1pPx/wny2Aff
	eh2iqalKXYOcsSudUWWwqLlJmOPtkMeprZxtGuIPxcB9NklsKxLBfNU+O7L/VyM8kY534TxHEP2
	er7ZbF9HSAm6Dshhf/eOYAWTUhl82LX6M3qKqVqN439aZlK7C3PUDdWPjBuJ9TvYc
X-Gm-Gg: AfdE7cmePGLdrCn8gQGn2i8urlGg5Bw4swMcUx2jFkZwTekUub+HiNWGX4mZlIWEoPe
	P9oYmB4be18sTw08NIehcqjRMBUkUnXvKoJhZTynXWTxVsp+dxbeNktnbWzyJLy+rlWL0gG698e
	unclnTyld1f2qQw4Zjsn/tZ/4IJLKeN8IK+8vYX3PcFhVILaaM9VwjB+KU+Q8MMhQJXi6gHQ14x
	ANZgbqiDrHPi3FyMtcJ8Ldq2orp4rlW82x5eTUUkBcJGLjrbhKqGY3aYCiv+pIOk3rpLx8lfAWp
	oZAevav23U3NSzhy0YT+g+6WjH53ugkNYjddKiVeD8WJwO56TQ7O1wYzxPl+88thAwyRVywiYwe
	3AA5QekKES5b2S6YdxTGm5OtWkvTC11pJziU4SkAA3XmI2pKLS4NpGLGqxvTY3eslLvYBWkOO/H
	1lnrHqdloGP980OxFbFRmALI9F1g==
X-Received: by 2002:a05:6102:54a6:b0:71e:1c56:e78e with SMTP id ada2fe7eead31-72b669d49d3mr7811742137.17.1782226351884;
        Tue, 23 Jun 2026 07:52:31 -0700 (PDT)
X-Received: by 2002:a05:6102:54a6:b0:71e:1c56:e78e with SMTP id ada2fe7eead31-72b669d49d3mr7811711137.17.1782226351375;
        Tue, 23 Jun 2026 07:52:31 -0700 (PDT)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c60aca46csm534042666b.36.2026.06.23.07.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 07:52:30 -0700 (PDT)
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
Subject: [RFC 02/12] arm64: acpi: Cleanup acpi=[on|off|force] handling
Date: Tue, 23 Jun 2026 16:52:15 +0200
Message-ID: <20260623145225.143218-3-johannes.goede@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEyMiBTYWx0ZWRfX7f3Sz3+tfiag
 QBkDXNOOInnYjDwjkAkxvbyqf7d4OAgleBLlaR9AQBYysRjC1CXMUXRVL8Cu491J2LkXshjysuR
 IpVH+odaDpJQAxKL2MwQuMLHdZgx0vfJCrbkJDiUiDkRMKDTPt8NmM8uaJfZxtibZPtnkkX1SM8
 nrEVjEGspDnR+OWN0D1aJW+CbFdX/rKv9Ow9D2Zuy04K5rqt385FhLXeYKPKRNw2a2+nAmzuSzr
 j1340qlj+Xsn76GC5/Mcst4Rpb49hyyc5uFx6FaVT0IFrh+P/7mCqdQAXaIjmXJjhqo7E5t1ABF
 6aPhxOHBRdht9p7oe2BgrWFV2FYWM1DnQhGN2+qOTi7lLolugYpuH/2JlL5GbZoAldYlNW442uW
 aXJk0QA3B+ELo1v87pwM1FhyURzSMYxflzCnkLv1/f7Zsn00VLw3uQO0wGZyHDQyTp0rLWsRNBN
 xyckOk1EOpCHYry/bUg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEyMiBTYWx0ZWRfXyAVkA9vwgaz9
 P8NlABfGBTCRyDgUaMWrOJcg15eI07PZOV92TPvI0hfwGK/AUN57356UhXPnoVlRQFaP4696yUb
 7MuBnqpZ/+OPtTiLbx+22XphzyAqDp4=
X-Proofpoint-GUID: TYDe4Upd3q9x2mwa1yBeXe2rK5uKeb3m
X-Authority-Analysis: v=2.4 cv=AJDhMgPs c=1 sm=1 tr=0 ts=6a3a9db0 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=1Ljy8mEZPninxW07_PMA:9
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: TYDe4Upd3q9x2mwa1yBeXe2rK5uKeb3m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1015 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230122

acpi=[on|off|force] are 3 values of a single "should ACPI be enabled"
setting. Instead of storing these in 3 separate booleans, introduce a new
acpi_mode_t enum for this and store these in a single param varialable.

This is a preparation patch for adding acpi=hybrid support to enable the
new DT-ACPI hybrid mode, which makes the kernel booting in DT mode still
load and parse the ACPI tables, without taking any further actions.

Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 arch/arm64/kernel/acpi.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index 5891f92c2035..06ab3a9da64b 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -43,9 +43,14 @@ EXPORT_SYMBOL(acpi_disabled);
 int acpi_pci_disabled = 1;	/* skip ACPI PCI scan and IRQ initialization */
 EXPORT_SYMBOL(acpi_pci_disabled);
 
-static bool param_acpi_off __initdata;
-static bool param_acpi_on __initdata;
-static bool param_acpi_force __initdata;
+enum acpi_mode_t {
+	acpi_mode_unset,
+	acpi_mode_off,
+	acpi_mode_on,
+	acpi_mode_force,
+};
+
+static enum acpi_mode_t param_acpi_mode __initdata;
 static bool param_acpi_nospcr __initdata;
 
 static int __init parse_acpi(char *arg)
@@ -55,11 +60,11 @@ static int __init parse_acpi(char *arg)
 
 	/* "acpi=off" disables both ACPI table parsing and interpreter */
 	if (strcmp(arg, "off") == 0)
-		param_acpi_off = true;
+		param_acpi_mode = acpi_mode_off;
 	else if (strcmp(arg, "on") == 0) /* prefer ACPI over DT */
-		param_acpi_on = true;
+		param_acpi_mode = acpi_mode_on;
 	else if (strcmp(arg, "force") == 0) /* force ACPI to be enabled */
-		param_acpi_force = true;
+		param_acpi_mode = acpi_mode_force;
 	else if (strcmp(arg, "nospcr") == 0) /* disable SPCR as default console */
 		param_acpi_nospcr = true;
 	else
@@ -198,14 +203,14 @@ static int __init acpi_fadt_sanity_check(void)
 void __init acpi_boot_table_init(void)
 {
 	/*
-	 * Enable ACPI instead of device tree unless
-	 * - ACPI has been disabled explicitly (acpi=off), or
-	 * - the device tree is not empty (it has more than just a /chosen node,
-	 *   and a /hypervisor node when running on Xen)
-	 *   and ACPI has not been [force] enabled (acpi=on|force)
+	 * When no ACPI mode (acpi=off|on|force) has been specified,
+	 * enable ACPI if the device tree is empty (it only has a /chosen
+	 * node, and a /hypervisor node when running on Xen).
 	 */
-	if (param_acpi_off ||
-	    (!param_acpi_on && !param_acpi_force && !dt_is_stub()))
+	if (!param_acpi_mode)
+		param_acpi_mode = dt_is_stub() ? acpi_mode_on : acpi_mode_off;
+
+	if (param_acpi_mode == acpi_mode_off)
 		goto done;
 
 	/*
@@ -223,7 +228,7 @@ void __init acpi_boot_table_init(void)
 	 */
 	if (acpi_table_init() || acpi_fadt_sanity_check()) {
 		pr_err("Failed to init ACPI tables\n");
-		if (!param_acpi_force)
+		if (param_acpi_mode != acpi_mode_force)
 			disable_acpi();
 	}
 
-- 
2.54.0

