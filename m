Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7683CC32B
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 14:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782226378; cv=none; b=d0ZjKPgpRueB4lsZcjVhd77iCKS78qC9rR/iJ9sK6IMTc1PR3yhSkgfmJdzjhA3FA7lj8OC8R7By9SpE+yNnvi8phVzZENTTZLdRx9QFy6c8ez7VVicPSVYwiwkRmun56qIrj6l2BMo3RYtzzs2MAduPWw1p+r7bgaZ9FsvYZ9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782226378; c=relaxed/simple;
	bh=kOb03Jdyp29jPgRmKn/Ve3iixRKc3a10Zbfid+x8L0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FkHDViyCvOrnbIhIqlCVZFJ/2rFegj3fIzb6yaWZoi1kVzV8xlqSTFPI5xh4RJrKifH2P/Vzxczj4JgV/SbNTimkjWTD6eXoUHKbGrxBOQVmsIf2BooL1lTvZCSJCBWQGvs7q+hWgfDWGL78hWxgF8wEWIjzFyGbyxsW0nhaQJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bqb1tqFW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i3kriyzk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bqb1tqFW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i3kriyzk"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBYtqh113975
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 14:52:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Upnj1dro5no
	76AJPF0WGep4IipqFATA6uaE79gGmLzs=; b=Bqb1tqFWVDfqCUwUh6nbw769zFR
	FpeoXqJ4vsR9soJ1IPCy322RRwAW9N1kcKe8mNBegteoswSYMR3WTrU1TckGYQaw
	TANtLdXbeomiqxP4GTY98J1TXfoUosDHOHkoRLUnCmnI9HzI/LRUpI0fM/6vqSxG
	bvDDBNyricU0G7Se/B5u+M6zXuAEgvlnt35Igajnb/+Wewy53sj+z9mB+Ifz24JB
	UmVcEnNnxzWO0ThSb7FbdM3312mPA0/6ssr5TAwbKqNpi69zOktJ3FAlAzOayCJn
	f7fVcsUMKV6KVmWFOwJ2Pom2+lzWXAyMk0PeSeq7cgiherVWy80nLfLzxrg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eymnvt3b7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 14:52:56 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-728f9ecd022so6639992137.1
        for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 07:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782226375; x=1782831175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Upnj1dro5no76AJPF0WGep4IipqFATA6uaE79gGmLzs=;
        b=i3kriyzkwfjiEat7ja03NzfHvR7W5A7sZkP6v8dzblg93bdu5ILMXyRwRx3CTnku3S
         6HqSXt9WZPTX4+vgP2EkP5A8xgeZDycgEDI5B+AJbjgBOqrCXxDzhstFop+wbGlPxxHu
         5v8cBcEFBdLPey1gkYPUOVuFTgNoibF0gW4QoXEXkSOFUlbOKQFin+kgM5G+D0SppE+H
         Ti7IdJH4EdgRL6kXhp4jOwgMsr5LyxMpabG4jbxC642NIV1AMHbRjhsljOYU7XGX2v3r
         anbkzOr7TlhkSn49IS85iMHutbIZEVnX4y2UJe6UWr2SQX3WJuwopH1CM/MPPPgNmbD8
         SegQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782226375; x=1782831175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Upnj1dro5no76AJPF0WGep4IipqFATA6uaE79gGmLzs=;
        b=XrG7htUN9IOlTXOiXUb03BuIBu6Dh3p3NqPBhGbVbCASbyy2ppWRO18BhJjLpkzS5i
         WWFYdWVY07lkvYEm783TbF2HjzKPkGAmhAnP0vhS7ehcv+oCzU+LlKz5IYBdrIZCrLpD
         sOOiqrR8+fAa1LTFlZ0xA3BedTRIjRHB8mtragBapVekYI/dn0NDV0GhbyC37ZcvJCi3
         fEJ+tlhhpJTpHSUCUdbn2zxR4Kmx8g8OZ81db0S3fenDi5YebbS8Mc7LY6dqVqfzRrKU
         kj7SOfYz04pDz7D/gXkXdQ3e337JBSIIE2JVOxNrKsVYO2bddA5oZud8IHFvYZ9YYYrW
         0gtw==
X-Forwarded-Encrypted: i=1; AFNElJ8YuMp/fQKGLd6+SG/GMQjmCYlWQEKgm+QM9AY8OrRdMtBwXhKaCKUt6iaW496QPdkK67H59S1OSsiI@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc7ySEHzvZo303eUl2rg+BFrGqk9wrQ1giFznoc60HOt71qdIy
	4Py2n+aSRa7TTx7kJc9VLDEM2yg/G158Rw4cgB6eIBqIm1kYC84HyKsjCNBdUVVVG73pnb4AOly
	CMB5KzVqehUyUHgEUWNN7/0VcIb21WX3dYj3Jmjkxm9VEgxRUKtoNEzFEwQ6m2Ni2
X-Gm-Gg: AfdE7cnXgEt3kdkzPcaeXoHuMGBfDeK1aDiiiXreLZ+r+R6FVHw1m7Bh5pCudpZs8Zt
	YRYLRr7DdhE5IyisG37d18nP1BWl5Phn1zM0STU9ZM1KRS4tNf1KYROddn6tE4XTSYvuMlc13u1
	jnWLo5iPz/lnUpfDro7C2S0HeN/W2U5VjujdzQmi14pWuh2Fc0aBcDCMPcCCavPPx5U2FZ8rc/9
	bpXQXgPBomJDki2UiDQ3CnA3oMR/rqv0pfzPdzP0LRYWInsQ66BCre1BjBjtOR8Y7Bus8LNzK+q
	Gt21gSdo4PbN6Y4QKK+LyDqFasd34EtvgDzHQc/Tvn9RiPBF8mI9Kg16ZJ+wozqDR4aVknQbrdw
	EIOQ6jZlcNu7ZsYBZb55cyaw6T3k1GmVInvPl2BZMyhY8bIpxK1zjE33fcllBU2zjNQSG6Ra9De
	GWV0GTJ92JAcVFBk87iFEGi/RCxg==
X-Received: by 2002:a05:6102:390e:b0:6ef:f681:d914 with SMTP id ada2fe7eead31-72ff628e831mr1646133137.22.1782226375611;
        Tue, 23 Jun 2026 07:52:55 -0700 (PDT)
X-Received: by 2002:a05:6102:390e:b0:6ef:f681:d914 with SMTP id ada2fe7eead31-72ff628e831mr1645870137.22.1782226370419;
        Tue, 23 Jun 2026 07:52:50 -0700 (PDT)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c60aca46csm534042666b.36.2026.06.23.07.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 07:52:49 -0700 (PDT)
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
Subject: [RFC 12/12] arm64: dts: qcom: x1e78100-thinkpad-t14s: Move keyb and touchpad to ACPI enumeration
Date: Tue, 23 Jun 2026 16:52:25 +0200
Message-ID: <20260623145225.143218-13-johannes.goede@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=dOWWXuZb c=1 sm=1 tr=0 ts=6a3a9dc8 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=yFha0hQGoAcqzG6e0GgA:9 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEyMiBTYWx0ZWRfXx4CaSJBV/VbP
 qJlQWibfwAFiM1KpLZf3k8MLPbccCqrhZyDJcfxt9+ypMceDVMp3FzA+vMuSlbOMc9wP0uNHirx
 42Mbpprd8KvFEu2Yqipl7x2XjttPtRE=
X-Proofpoint-ORIG-GUID: LTeWYh-_Htg8gVQchx_X4J-gNEQYiaQE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEyMiBTYWx0ZWRfX9go41fS5aUhv
 2qTnsxws9k0efjpNUIk54DYKaItpKkWampJbWGRxxxE4T2xrQ87cMfr8iaADnNAuRppbsER80UK
 WXjjAAl+CeET9DTrs9p8NEjEl4/+Dt5vZw5+xuTHbgMdREv+OiftAwFb9rnbA1jtC9d+vxK6eII
 vcCej1hJY/XEPb3wjrld5CaqxwZYZbUcu53qVQptpu33b9bgXaM3t15WeJV4NHpsGN+aHJL9ZBH
 bnUZfTrWaNGmACrhCYOQgw8LUDri5+Z/lgbySqdh71wjw9wAPakm8rBaCLLdgA4YO2t1P05K8wV
 aNEDPX7w4DxckRCJY/6WFlyP4Rt8D/snxQP5Eqhder03CGIcaZB/cdsE4H3OuPoN+Xb19KYWsIr
 Yo5l8mqjLesyVY/uFH+7UbZnmnHHPf2D0mPLtkrDS4j91yOIKwU4EbQUCFg9Vf9U3ZzzrLH0kEg
 qTvBVZGxufTc2Px+nDw==
X-Proofpoint-GUID: LTeWYh-_Htg8gVQchx_X4J-gNEQYiaQE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230122

Add acpi-path properties for DT-ACPI hybrid mode and remove the keyboard
and touchpad description switching to relying on ACPI to enumerate these.

Also drop the clock-frequency this is also provided by ACPI now.

FIXME: Needs DT-bindings patch as pre-req

Note this depends on these 2 patch-series for working PDC support on Hamoa:
https://lore.kernel.org/linux-arm-msm/20260410184124.1068210-1-mukesh.ojha@oss.qualcomm.com/
https://lore.kernel.org/linux-arm-msm/20260616-hamoa_pdc_v3-v3-0-4d8e1504ea75@oss.qualcomm.com/

Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 .../qcom/x1e78100-lenovo-thinkpad-t14s.dtsi   | 59 +------------------
 1 file changed, 3 insertions(+), 56 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
index 2fc01e8e8c04..a73576ec238d 100644
--- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
@@ -1017,57 +1017,8 @@ &gpu_zap_shader {
 };
 
 &i2c0 {
-	clock-frequency = <400000>;
-
-	pinctrl-0 = <&qup_i2c0_data_clk>, <&tpad_default>;
-	pinctrl-names = "default";
-
+	acpi-path = "\\_SB.I2C1";
 	status = "okay";
-
-	/* ELAN06E2 or ELAN06E3 */
-	touchpad@15 {
-		compatible = "hid-over-i2c";
-		reg = <0x15>;
-
-		hid-descr-addr = <0x1>;
-		interrupts-extended = <&tlmm 3 IRQ_TYPE_LEVEL_LOW>;
-
-		vdd-supply = <&vreg_misc_3p3>;
-		vddl-supply = <&vreg_l12b_1p2>;
-
-		wakeup-source;
-	};
-
-	/* SYNA8022 or SYNA8024 */
-	touchpad@2c {
-		compatible = "hid-over-i2c";
-		reg = <0x2c>;
-
-		hid-descr-addr = <0x20>;
-		interrupts-extended = <&tlmm 3 IRQ_TYPE_LEVEL_LOW>;
-
-		vdd-supply = <&vreg_misc_3p3>;
-		vddl-supply = <&vreg_l12b_1p2>;
-
-		wakeup-source;
-	};
-
-	/* ELAN06F1 or SYNA06F2 */
-	keyboard@3a {
-		compatible = "hid-over-i2c";
-		reg = <0x3a>;
-
-		hid-descr-addr = <0x1>;
-		interrupts-extended = <&tlmm 67 IRQ_TYPE_LEVEL_LOW>;
-
-		vdd-supply = <&vreg_misc_3p3>;
-		vddl-supply = <&vreg_l15b_1p8>;
-
-		pinctrl-0 = <&kybd_default>;
-		pinctrl-names = "default";
-
-		wakeup-source;
-	};
 };
 
 &i2c3 {
@@ -1598,6 +1549,8 @@ wcd_tx: codec@0,3 {
 };
 
 &tlmm {
+	acpi-path = "\\_SB.GIO0";
+
 	gpio-reserved-ranges = <34 2>, /* Unused */
 			       <44 4>, /* SPI (TPM) */
 			       <72 2>, /* Secure EC I2C connection (?) */
@@ -1655,12 +1608,6 @@ hdmi_hpd_default: hdmi-hpd-default-state {
 		bias-disable;
 	};
 
-	tpad_default: tpad-default-state {
-		pins = "gpio3";
-		function = "gpio";
-		bias-pull-up;
-	};
-
 	nvme_reg_en: nvme-reg-en-state {
 		pins = "gpio18";
 		function = "gpio";
-- 
2.54.0

